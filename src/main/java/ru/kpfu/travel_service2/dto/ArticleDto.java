package ru.kpfu.travel_service2.dto;

import jakarta.validation.constraints.NotBlank;
import lombok.Data;

@Data
public class ArticleDto {
    @NotBlank(message = "Заголовок не может быть пустым")
    private String title;

    @NotBlank(message = "Содержание статьи не может быть пустым")
    private String content;

    @NotBlank(message = "Категория не может быть пустой")
    private String category;
} 