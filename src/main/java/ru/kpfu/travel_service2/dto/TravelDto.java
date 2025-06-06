package ru.kpfu.travel_service2.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import java.util.Date;

@Data
public class TravelDto {
    @NotBlank(message = "Название путешествия не может быть пустым")
    private String nameTravel;

    @NotBlank(message = "Описание не может быть пустым")
    private String description;

    @NotNull(message = "Дата начала не может быть пустой")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date startDate;

    @NotNull(message = "Дата окончания не может быть пустой")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date endDate;

    @NotBlank(message = "Транспорт не может быть пустым")
    private String transport;

    private String listOfThings;
    
    private String notes;

    private MultipartFile photo;
} 