package ru.kpfu.travel_service2.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import ru.kpfu.travel_service2.entity.Favourites;
import ru.kpfu.travel_service2.entity.Travel;

import java.util.List;

public interface FavouritesRepository extends JpaRepository<Favourites, Integer> {
    public List<Favourites> findAll();
}
