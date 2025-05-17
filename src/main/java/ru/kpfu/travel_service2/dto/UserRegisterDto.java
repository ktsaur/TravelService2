package ru.kpfu.travel_service2.dto;

import lombok.Data;

@Data
public class UserRegisterDto {
    private String username;
    private String password;
    private String email;
}
