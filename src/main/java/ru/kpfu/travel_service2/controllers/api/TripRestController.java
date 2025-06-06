package ru.kpfu.travel_service2.controllers.api;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import ru.kpfu.travel_service2.dto.TripDto;
import ru.kpfu.travel_service2.entity.Trip;
import ru.kpfu.travel_service2.services.TripMapper;
import ru.kpfu.travel_service2.services.TripService;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/v1/trips")
@Tag(name = "Trips API", description = "API для работы с путешествиями")
public class TripRestController {

    private final TripService tripService;
    private final TripMapper tripMapper;

    public TripRestController(TripService tripService, TripMapper tripMapper) {
        this.tripService = tripService;
        this.tripMapper = tripMapper;
    }

    @GetMapping
    @Operation(summary = "Получить все путешествия", description = "Возвращает список всех доступных путешествий")
    public ResponseEntity<List<TripDto>> getAllTrips() {
        List<TripDto> trips = tripService.getAllTrips().stream()
                .map(tripMapper::toDto)
                .collect(Collectors.toList());
        return ResponseEntity.ok(trips);
    }

    @GetMapping("/{id}")
    @Operation(summary = "Получить путешествие по ID", description = "Возвращает путешествие по его идентификатору")
    public ResponseEntity<TripDto> getTripById(
            @Parameter(description = "ID путешествия") @PathVariable Long id) {
        return tripService.getTripById(id)
                .map(tripMapper::toDto)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    @Operation(summary = "Создать новое путешествие", description = "Создает новое путешествие")
    public ResponseEntity<TripDto> createTrip(
            @Parameter(description = "Данные путешествия") @Valid @RequestBody TripDto tripDto) {
        Trip trip = tripMapper.toEntity(tripDto);
        Trip savedTrip = tripService.saveTrip(trip);
        return new ResponseEntity<>(tripMapper.toDto(savedTrip), HttpStatus.CREATED);
    }

    @PutMapping("/{id}")
    @Operation(summary = "Обновить путешествие", description = "Обновляет существующее путешествие по его ID")
    public ResponseEntity<TripDto> updateTrip(
            @Parameter(description = "ID путешествия") @PathVariable Long id,
            @Parameter(description = "Обновленные данные путешествия") @Valid @RequestBody TripDto tripDto) {
        return tripService.getTripById(id)
                .map(existingTrip -> {
                    tripMapper.updateEntityFromDto(tripDto, existingTrip);
                    Trip updatedTrip = tripService.saveTrip(existingTrip);
                    return ResponseEntity.ok(tripMapper.toDto(updatedTrip));
                })
                .orElse(ResponseEntity.notFound().build());
    }

    @DeleteMapping("/{id}")
    @Operation(summary = "Удалить путешествие", description = "Удаляет путешествие по его ID")
    public ResponseEntity<Void> deleteTrip(
            @Parameter(description = "ID путешествия") @PathVariable Long id) {
        if (tripService.getTripById(id).isPresent()) {
            tripService.deleteTrip(id);
            return ResponseEntity.noContent().build();
        }
        return ResponseEntity.notFound().build();
    }

    @GetMapping("/search")
    @Operation(summary = "Поиск путешествий", description = "Поиск путешествий по стране и городу")
    public ResponseEntity<List<TripDto>> searchTrips(
            @Parameter(description = "Страна") @RequestParam(required = false) String country,
            @Parameter(description = "Город") @RequestParam(required = false) String city) {
        List<TripDto> trips = tripService.searchTrips(country, city).stream()
                .map(tripMapper::toDto)
                .collect(Collectors.toList());
        return ResponseEntity.ok(trips);
    }
} 