package ru.kpfu.travel_service2.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import ru.kpfu.travel_service2.entity.Travel;

public interface TravelRepository extends JpaRepository<Travel, Integer> {
}
