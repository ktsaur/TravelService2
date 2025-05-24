package ru.kpfu.travel_service2.controllers;

import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import ru.kpfu.travel_service2.dto.UserLoginDto;
import ru.kpfu.travel_service2.dto.UserRegisterDto;
import ru.kpfu.travel_service2.services.UserService;

@Controller
public class AuthController {
    @Autowired
    private UserService userService;

    @Autowired
    private AuthenticationManager authenticationManager;

    @GetMapping("/registration")
    public String showRegistrationForm(Model model) {
        model.addAttribute("userRegisterDto", new UserRegisterDto());
        return "registration";
    }

    @PostMapping("/registration")
    public String registerUser(@Valid UserRegisterDto userDto, BindingResult result, Model model) {
        if (result.hasErrors()) {
            model.addAttribute("userRegisterDto", userDto);
            return "registration";
        }
        try {
            System.out.println("Registering user: " + userDto.getUsername());
            userService.saveUser(userDto);
            return "redirect:/login";
        } catch (Exception e) {
            System.err.println("Registration error: " + e.getMessage());
            model.addAttribute("message", e.getMessage());
            model.addAttribute("userRegisterDto", userDto);
            return "registration";
        }
    }

    @GetMapping("/login")
    public String login(Model model, @RequestParam(value = "error", required = false) String error) {
        model.addAttribute("userLoginDto", new UserLoginDto());
        if (error != null) {
            model.addAttribute("message", "Неверное имя пользователя или пароль, или аккаунт не активирован.");
        }
        return "login";
    }

    @GetMapping("/activation")
    public String activation() {
        return "activation-success";
    }

    @GetMapping("/confirmation-send")
    public String confirmationSend() {
        return "confirmation-send";
    }
}
