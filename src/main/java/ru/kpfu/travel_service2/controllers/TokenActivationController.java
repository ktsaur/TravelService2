package ru.kpfu.travel_service2.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import ru.kpfu.travel_service2.entity.User;
import ru.kpfu.travel_service2.repository.UserRepository;
import ru.kpfu.travel_service2.services.UserService;

@Controller
public class TokenActivationController {

    @Autowired
    private UserService userService;
    @Autowired
    private UserRepository userRepository;

    @GetMapping("/activate")
    public String activateAccount(@RequestParam String token) {
        User user = userService.findByActivationToken(token);


        user.setActivated(true);
        user.setActivationToken(null);

        userService.activateUser(token);
        return "activation-success";

    }
}