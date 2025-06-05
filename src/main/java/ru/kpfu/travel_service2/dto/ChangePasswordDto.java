package ru.kpfu.travel_service2.dto;

import jakarta.validation.constraints.NotBlank;
import lombok.Data;

@Data
public class ChangePasswordDto {
    @NotBlank(message = "Введите текущий пароль")
    private String currentPassword;

    @NotBlank(message = "Введите новый пароль")
    private String newPassword;

    @NotBlank(message = "Повторите новый пароль")
    private String confirmPassword;
} 