package ru.kpfu.travel_service2.controllers;

import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import ru.kpfu.travel_service2.dto.UpdateProfileDto;
import ru.kpfu.travel_service2.dto.ChangePasswordDto;
import ru.kpfu.travel_service2.entity.User;
import ru.kpfu.travel_service2.repository.UserRepository;
import ru.kpfu.travel_service2.services.CustomUserDetailsService;
import ru.kpfu.travel_service2.services.UserService;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class ProfileController {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private CustomUserDetailsService userDetailsService;

    @Autowired
    private UserService userService;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @GetMapping("/profile")
    public String showProfile(Model model, Authentication authentication, @RequestParam(required = false) Boolean success) {
        if (authentication == null || !authentication.isAuthenticated()) {
            return "redirect:/login";
        }

        String username = authentication.getName();
        User user = userRepository.findByUsername(username)
                .orElseThrow(() -> new RuntimeException("Пользователь не найден"));

        model.addAttribute("user", user);
        
        if (success != null && success) {
            model.addAttribute("successMessage", "Пароль успешно изменен");
        }
        
        return "profile";
    }

    @PostMapping("/profile/delete")
    public String deleteAccount(Authentication authentication) {
        if (authentication == null || !authentication.isAuthenticated()) {
            return "redirect:/login";
        }

        String username = authentication.getName();
        userService.deleteUser(username);
        SecurityContextHolder.clearContext();
        return "redirect:/home";
    }

    @GetMapping("/profile/update")
    public String showUpdateForm(Model model, Authentication authentication) {
        String username = authentication.getName();
        User user = userRepository.findByUsername(username)
                .orElseThrow(() -> new RuntimeException("Пользователь не найден"));

        UpdateProfileDto updateProfileDto = new UpdateProfileDto();
        updateProfileDto.setUsername(user.getUsername());
        updateProfileDto.setEmail(user.getEmail());

        model.addAttribute("updateProfileDto", updateProfileDto);
        return "update-profile";
    }

    @PostMapping("/profile/update")
    public String updateProfile(@Valid UpdateProfileDto updateProfileDto,
                              BindingResult bindingResult,
                              Authentication authentication,
                              RedirectAttributes redirectAttributes,
                              Model model) {
        if (bindingResult.hasErrors()) {
            return "update-profile";
        }

        String currentUsername = authentication.getName();
        User currentUser = userRepository.findByUsername(currentUsername)
                .orElseThrow(() -> new RuntimeException("Пользователь не найден"));

        
        User userWithUsername = userRepository.findByUsername(updateProfileDto.getUsername())
                .orElse(null);
        if (userWithUsername != null && !userWithUsername.getUserId().equals(currentUser.getUserId())) {
            model.addAttribute("usernameError", "Такое имя пользователя уже занято");
            return "update-profile";
        }

        User userWithEmail = userRepository.findByEmail(updateProfileDto.getEmail())
                .orElse(null);
        if (userWithEmail != null && !userWithEmail.getUserId().equals(currentUser.getUserId())) {
            model.addAttribute("emailError", "Такая почта уже занята");
            return "update-profile";
        }

        try {
            currentUser.setUsername(updateProfileDto.getUsername());
            currentUser.setEmail(updateProfileDto.getEmail());
            userRepository.save(currentUser);

            UserDetails updatedUserDetails = userDetailsService.loadUserByUsername(updateProfileDto.getUsername());
            Authentication newAuth = new UsernamePasswordAuthenticationToken(
                updatedUserDetails,
                authentication.getCredentials(),
                updatedUserDetails.getAuthorities()
            );
            SecurityContextHolder.getContext().setAuthentication(newAuth);

            redirectAttributes.addFlashAttribute("success", "Профиль успешно обновлен");
            return "redirect:/profile";
        } catch (Exception e) {
            model.addAttribute("error", "Произошла ошибка при обновлении профиля");
            return "update-profile";
        }
    }

    @GetMapping("/profile/password")
    public String showChangePasswordForm(Model model) {
        model.addAttribute("changePasswordDto", new ChangePasswordDto());
        return "change-password";
    }

    @PostMapping("/profile/password")
    public String changePassword(@Valid ChangePasswordDto changePasswordDto,
                               BindingResult bindingResult,
                               Model model,
                               Authentication authentication) {
        if (bindingResult.hasErrors()) {
            return "change-password";
        }

        String username = authentication.getName();
        User user = userRepository.findByUsername(username)
                .orElseThrow(() -> new RuntimeException("Пользователь не найден"));

        if (!passwordEncoder.matches(changePasswordDto.getCurrentPassword(), user.getPassword())) {
            model.addAttribute("errorMessage", "Неправильно введен старый пароль");
            return "change-password";
        }

        if (!changePasswordDto.getNewPassword().equals(changePasswordDto.getConfirmPassword())) {
            model.addAttribute("errorMessage", "Пароли не совпадают");
            return "change-password";
        }

        userService.updatePassword(user, changePasswordDto.getNewPassword());
        return "redirect:/profile?success=true";
    }
} 