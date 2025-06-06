package ru.kpfu.travel_service2.services;

import org.springframework.stereotype.Component;
import ru.kpfu.travel_service2.dto.TripDto;
import ru.kpfu.travel_service2.entity.Trip;

@Component
public class TripMapper {
    
    public TripDto toDto(Trip trip) {
        if (trip == null) {
            return null;
        }

        TripDto dto = new TripDto();
        dto.setId(trip.getId());
        dto.setName(trip.getName());
        dto.setDescription(trip.getDescription());
        dto.setCountry(trip.getCountry());
        dto.setCity(trip.getCity());
        dto.setStartDate(trip.getStartDate());
        dto.setEndDate(trip.getEndDate());
        dto.setPrice(trip.getPrice());
        dto.setImageUrl(trip.getImageUrl());
        return dto;
    }

    public Trip toEntity(TripDto dto) {
        if (dto == null) {
            return null;
        }

        Trip trip = new Trip();
        trip.setId(dto.getId());
        trip.setName(dto.getName());
        trip.setDescription(dto.getDescription());
        trip.setCountry(dto.getCountry());
        trip.setCity(dto.getCity());
        trip.setStartDate(dto.getStartDate());
        trip.setEndDate(dto.getEndDate());
        trip.setPrice(dto.getPrice());
        trip.setImageUrl(dto.getImageUrl());
        return trip;
    }

    public void updateEntityFromDto(TripDto dto, Trip trip) {
        if (dto == null || trip == null) {
            return;
        }

        trip.setName(dto.getName());
        trip.setDescription(dto.getDescription());
        trip.setCountry(dto.getCountry());
        trip.setCity(dto.getCity());
        trip.setStartDate(dto.getStartDate());
        trip.setEndDate(dto.getEndDate());
        trip.setPrice(dto.getPrice());
        if (dto.getImageUrl() != null) {
            trip.setImageUrl(dto.getImageUrl());
        }
    }
} 