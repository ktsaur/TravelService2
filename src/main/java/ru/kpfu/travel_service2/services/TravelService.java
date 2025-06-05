package ru.kpfu.travel_service2.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ru.kpfu.travel_service2.dto.TravelDto;
import ru.kpfu.travel_service2.entity.Travel;
import ru.kpfu.travel_service2.entity.User;
import ru.kpfu.travel_service2.repository.TravelRepository;

import java.util.List;

@Service
public class TravelService {
    @Autowired
    private TravelRepository travelRepository;

    public List<Travel> getUserTravels(User user) {
        return travelRepository.findByUser(user);
    }

    public void createTravel(TravelDto travelDto, User user) {
        Travel travel = new Travel(
            user,
            travelDto.getNameTravel(),
            travelDto.getDescription(),
            travelDto.getStartDate(),
            travelDto.getEndDate(),
            travelDto.getTransport(),
            travelDto.getListOfThings(),
            travelDto.getNotes(),
            null // travelUrl
        );
        travel.setIsOver(false);
        travelRepository.save(travel);
    }

    public Travel getTravelById(Integer travelId) {
        return travelRepository.findById(travelId)
                .orElseThrow(() -> new RuntimeException("Путешествие не найдено"));
    }

    public void updateTravel(Integer travelId, TravelDto travelDto) {
        Travel travel = getTravelById(travelId);
        travel.setNameTravel(travelDto.getNameTravel());
        travel.setDescription(travelDto.getDescription());
        travel.setStartDate(travelDto.getStartDate());
        travel.setEndDate(travelDto.getEndDate());
        travel.setTransport(travelDto.getTransport());
        travel.setListOfThings(travelDto.getListOfThings());
        travel.setNotes(travelDto.getNotes());
        travelRepository.save(travel);
    }

    public void deleteTravel(Integer travelId) {
        travelRepository.deleteById(travelId);
    }

    public boolean isUserOwner(User user, Integer travelId) {
        Travel travel = getTravelById(travelId);
        return travel.getUser().getUserId().equals(user.getUserId());
    }
} 