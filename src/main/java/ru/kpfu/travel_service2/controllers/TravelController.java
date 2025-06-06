package ru.kpfu.travel_service2.controllers;

import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import ru.kpfu.travel_service2.dto.TravelDto;
import ru.kpfu.travel_service2.entity.Travel;
import ru.kpfu.travel_service2.entity.User;
import ru.kpfu.travel_service2.repository.UserRepository;
import ru.kpfu.travel_service2.services.TravelService;

@Controller
public class TravelController {

    @Autowired
    private TravelService travelService;

    @Autowired
    private UserRepository userRepository;

    @GetMapping("/travels")
    public String showUserTravels(Model model, Authentication authentication) {
        if (authentication == null || !authentication.isAuthenticated()) {
            return "redirect:/login";
        }

        String username = authentication.getName();
        User user = userRepository.findByUsername(username)
                .orElseThrow(() -> new RuntimeException("Пользователь не найден"));

        model.addAttribute("user", user);
        model.addAttribute("travels", travelService.getUserTravels(user));
        return "travels";
    }

    @GetMapping("/create/travel")
    public String showCreateTravelForm(Model model, Authentication authentication) {
        if (authentication == null || !authentication.isAuthenticated()) {
            return "redirect:/login";
        }
        String username = authentication.getName();
        User user = userRepository.findByUsername(username)
                .orElseThrow(() -> new RuntimeException("Пользователь не найден"));
                
        model.addAttribute("user", user);
        model.addAttribute("travelDto", new TravelDto());
        return "create-travel";
    }

    @PostMapping("/create/travel")
    public String createTravel(@Valid TravelDto travelDto,
                             BindingResult bindingResult,
                             Authentication authentication,
                             RedirectAttributes redirectAttributes) {
        if (authentication == null || !authentication.isAuthenticated()) {
            return "redirect:/login";
        }

        if (bindingResult.hasErrors()) {
            return "create-travel";
        }

        String username = authentication.getName();
        User user = userRepository.findByUsername(username)
                .orElseThrow(() -> new RuntimeException("Пользователь не найден"));

        travelService.createTravel(travelDto, user);
        redirectAttributes.addFlashAttribute("success", "Путешествие успешно создано");
        return "redirect:/travels";
    }

    @GetMapping("/travel/detail/{id}")
    public String showTravelDetail(@PathVariable("id") Integer travelId,
                                 Model model,
                                 Authentication authentication) {
        if (authentication == null || !authentication.isAuthenticated()) {
            return "redirect:/login";
        }

        String username = authentication.getName();
        User user = userRepository.findByUsername(username)
                .orElseThrow(() -> new RuntimeException("Пользователь не найден"));

        Travel travel = travelService.getTravelById(travelId);
        
        if (!travelService.isUserOwner(user, travelId)) {
            return "redirect:/travels";
        }

        model.addAttribute("user", user);
        model.addAttribute("travel", travel);
        return "travel-detail";
    }

    @GetMapping("/travel/update/{id}")
    public String showUpdateTravelForm(@PathVariable("id") Integer travelId,
                                     Model model,
                                     Authentication authentication) {
        if (authentication == null || !authentication.isAuthenticated()) {
            return "redirect:/login";
        }

        String username = authentication.getName();
        User user = userRepository.findByUsername(username)
                .orElseThrow(() -> new RuntimeException("Пользователь не найден"));

        if (!travelService.isUserOwner(user, travelId)) {
            return "redirect:/travels";
        }

        Travel travel = travelService.getTravelById(travelId);
        TravelDto travelDto = new TravelDto();
        travelDto.setNameTravel(travel.getNameTravel());
        travelDto.setDescription(travel.getDescription());
        travelDto.setStartDate(travel.getStartDate());
        travelDto.setEndDate(travel.getEndDate());
        travelDto.setTransport(travel.getTransport());
        travelDto.setListOfThings(travel.getListOfThings());
        travelDto.setNotes(travel.getNotes());

        model.addAttribute("user", user);
        model.addAttribute("travelId", travelId);
        model.addAttribute("travelDto", travelDto);
        return "update-travel";
    }

    @PostMapping("/travel/update/{id}")
    public String updateTravel(@PathVariable("id") Integer travelId,
                             @Valid TravelDto travelDto,
                             BindingResult bindingResult,
                             Authentication authentication,
                             RedirectAttributes redirectAttributes) {
        if (authentication == null || !authentication.isAuthenticated()) {
            return "redirect:/login";
        }

        String username = authentication.getName();
        User user = userRepository.findByUsername(username)
                .orElseThrow(() -> new RuntimeException("Пользователь не найден"));

        if (!travelService.isUserOwner(user, travelId)) {
            return "redirect:/travels";
        }

        if (bindingResult.hasErrors()) {
            return "update-travel";
        }

        travelService.updateTravel(travelId, travelDto);
        redirectAttributes.addFlashAttribute("success", "Путешествие успешно обновлено");
        return "redirect:/travel/detail/" + travelId;
    }

    @PostMapping("/travel/delete/{id}")
    public String deleteTravel(@PathVariable("id") Integer travelId,
                             Authentication authentication,
                             RedirectAttributes redirectAttributes) {
        if (authentication == null || !authentication.isAuthenticated()) {
            return "redirect:/login";
        }

        String username = authentication.getName();
        User user = userRepository.findByUsername(username)
                .orElseThrow(() -> new RuntimeException("Пользователь не найден"));

        if (!travelService.isUserOwner(user, travelId)) {
            return "redirect:/travels";
        }

        travelService.deleteTravel(travelId);
        redirectAttributes.addFlashAttribute("success", "Путешествие успешно удалено");
        return "redirect:/travels";
    }
} 