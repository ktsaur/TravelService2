package ru.kpfu.travel_service2.dto;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotEmpty;
import lombok.Data;
import org.springframework.web.multipart.MultipartFile;

@Data
public class UpdateProfileDto {
    @NotEmpty(message = "Имя пользователя не может быть пустым")
    private String username;

    @NotEmpty(message = "Email не может быть пустым")
    @Email(message = "Некорректный формат email")
    private String email;

    private MultipartFile photo;
} 