package ru.kpfu.travel_service2.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import ru.kpfu.travel_service2.entity.Travel;
import ru.kpfu.travel_service2.entity.User;

import java.util.List;

public interface TravelRepository extends JpaRepository<Travel, Integer> {
    List<Travel> findByUser(User user);
}
