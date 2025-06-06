package ru.kpfu.travel_service2.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import ru.kpfu.travel_service2.services.UserService;

@Controller
public class TokenActivationController {

    @Autowired
    private UserService userService;

    @GetMapping("/activate")
    public String activateAccount(@RequestParam String token) {
        userService.activateUser(token);
        return "activation-success";
    }
}