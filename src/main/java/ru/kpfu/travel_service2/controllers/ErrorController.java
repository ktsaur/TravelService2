package ru.kpfu.travel_service2.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/error")
public class ErrorController implements org.springframework.boot.web.servlet.error.ErrorController {

    @GetMapping("/404")
    public String handleNotFound() {
        return "error/404";
    }

    @GetMapping("/500")
    public String handleInternalError() {
        return "error/500";
    }
} 