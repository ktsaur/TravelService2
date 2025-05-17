package ru.kpfu.travel_service2.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import ru.kpfu.travel_service2.dto.UserRegisterDto;
import ru.kpfu.travel_service2.services.UserService;

@Controller
public class AuthController {
    @Autowired
    private UserService userService;

    @GetMapping("/registration")
    public String showRegistrationForm() {
        return "/registration";
    }

    @PostMapping("/registration")
    public String registerUser(@RequestParam("username") String username, @RequestParam("email") String email, @RequestParam("password") String password) throws Exception {
        UserRegisterDto userDto = new UserRegisterDto();
        userDto.setUsername(username);
        userDto.setEmail(email);
        userDto.setPassword(password);
        userService.saveUser(userDto);
        return "redirect:/login";
    }

    @GetMapping("/login")
    public String login() {
        return "login";
    }

    @GetMapping("/activation")
    public String activation() {
        return "activation";
    }

    @GetMapping("/confirmation-send")
    public String confirmationSend() {
        return "confirmation-send";
    }
}
