package ru.kpfu.travel_service2.services;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import jakarta.persistence.criteria.CriteriaBuilder;
import jakarta.persistence.criteria.CriteriaQuery;
import jakarta.persistence.criteria.Predicate;
import jakarta.persistence.criteria.Root;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import ru.kpfu.travel_service2.entity.Trip;
import ru.kpfu.travel_service2.repository.TripRepository;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class TripService {

    private final TripRepository tripRepository;
    private final EntityManager entityManager;

    public TripService(TripRepository tripRepository, EntityManager entityManager) {
        this.tripRepository = tripRepository;
        this.entityManager = entityManager;
    }

    public List<Trip> getAllTrips() {
        return tripRepository.findAll();
    }

    public Optional<Trip> getTripById(Long id) {
        return tripRepository.findById(id);
    }

    @Transactional
    public Trip saveTrip(Trip trip) {
        return tripRepository.save(trip);
    }

    @Transactional
    public void deleteTrip(Long id) {
        tripRepository.deleteById(id);
    }

    public List<Trip> searchTrips(String country, String city) {
        CriteriaBuilder cb = entityManager.getCriteriaBuilder();
        CriteriaQuery<Trip> query = cb.createQuery(Trip.class);
        Root<Trip> trip = query.from(Trip.class);

        List<Predicate> predicates = new ArrayList<>();

        if (country != null && !country.trim().isEmpty()) {
            predicates.add(cb.like(cb.lower(trip.get("country")), "%" + country.toLowerCase() + "%"));
        }

        if (city != null && !city.trim().isEmpty()) {
            predicates.add(cb.like(cb.lower(trip.get("city")), "%" + city.toLowerCase() + "%"));
        }

        if (!predicates.isEmpty()) {
            query.where(cb.and(predicates.toArray(new Predicate[0])));
        }

        TypedQuery<Trip> typedQuery = entityManager.createQuery(query);
        return typedQuery.getResultList();
    }
} 