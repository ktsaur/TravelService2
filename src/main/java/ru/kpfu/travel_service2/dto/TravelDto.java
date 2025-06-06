package ru.kpfu.travel_service2.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import java.util.Date;

@Data
@NoArgsConstructor
@Schema(description = "Информация о путешествии")
public class TravelDto {
    @Schema(description = "Идентификатор путешествия", example = "1")
    private Integer travelId;

    @Schema(description = "Название путешествия", example = "Путешествие в Париж")
    @NotBlank(message = "Название путешествия не может быть пустым")
    private String nameTravel;

    @Schema(description = "Описание путешествия", example = "Незабываемое путешествие в столицу Франции")
    @NotBlank(message = "Описание не может быть пустым")
    private String description;

    @Schema(description = "Дата начала путешествия", example = "2024-04-01")
    @NotNull(message = "Дата начала не может быть пустой")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date startDate;

    @Schema(description = "Дата окончания путешествия", example = "2024-04-15")
    @NotNull(message = "Дата окончания не может быть пустой")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date endDate;

    @Schema(description = "Транспорт", example = "Самолет")
    private String transport;

    @Schema(description = "Список вещей", example = "Паспорт, билеты, одежда")
    private String listOfThings;

    @Schema(description = "Заметки", example = "Не забыть посетить Эйфелеву башню")
    private String notes;

    @Schema(description = "URL фотографии путешествия", example = "https://example.com/paris.jpg")
    private String travelUrl;

    @Schema(description = "Статус завершения путешествия", example = "false")
    private boolean isOver;

    @Schema(description = "Фотография путешествия (для загрузки)")
    private MultipartFile photo;
} 