package ru.kpfu.travel_service2.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import ru.kpfu.travel_service2.entity.Trip;

import java.time.LocalDate;
import java.util.List;

public interface TripRepository extends JpaRepository<Trip, Long> {
    
    @Query("SELECT t FROM Trip t WHERE t.startDate >= :date")
    List<Trip> findUpcomingTrips(@Param("date") LocalDate date);

    @Query("SELECT t FROM Trip t WHERE LOWER(t.country) = LOWER(:country)")
    List<Trip> findByCountryIgnoreCase(@Param("country") String country);

    @Query("SELECT t FROM Trip t WHERE t.price <= :maxPrice")
    List<Trip> findByPriceLessThanEqual(@Param("maxPrice") Double maxPrice);

    @Query(value = "SELECT * FROM trips t WHERE t.start_date BETWEEN :startDate AND :endDate", nativeQuery = true)
    List<Trip> findTripsBetweenDates(@Param("startDate") LocalDate startDate, @Param("endDate") LocalDate endDate);
} 