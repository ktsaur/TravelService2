package ru.kpfu.travel_service2.services;

import com.cloudinary.Cloudinary;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import ru.kpfu.travel_service2.dto.TravelDto;
import ru.kpfu.travel_service2.entity.Travel;
import ru.kpfu.travel_service2.entity.User;
import ru.kpfu.travel_service2.repository.TravelRepository;
import ru.kpfu.travel_service2.utils.CloudinaryUtil;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class TravelService {
    @Autowired
    private TravelRepository travelRepository;

    private final Cloudinary cloudinary = CloudinaryUtil.getInstance();

    public List<Travel> getUserTravels(User user) {
        return travelRepository.findByUser(user);
    }

    public void createTravel(TravelDto travelDto, User user) {
        String photoUrl = null;
        if (travelDto.getPhoto() != null && !travelDto.getPhoto().isEmpty()) {
            try {
                photoUrl = uploadPhoto(travelDto.getPhoto());
            } catch (IOException e) {
                throw new RuntimeException("Ошибка при загрузке фотографии", e);
            }
        }

        Travel travel = new Travel(
            user,
            travelDto.getNameTravel(),
            travelDto.getDescription(),
            travelDto.getStartDate(),
            travelDto.getEndDate(),
            travelDto.getTransport(),
            travelDto.getListOfThings(),
            travelDto.getNotes(),
            photoUrl
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
        
        if (travelDto.getPhoto() != null && !travelDto.getPhoto().isEmpty()) {
            try {
                String photoUrl = uploadPhoto(travelDto.getPhoto());
                travel.setTravelUrl(photoUrl);
            } catch (IOException e) {
                throw new RuntimeException("Ошибка при загрузке фотографии", e);
            }
        }

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

    private String uploadPhoto(MultipartFile photo) throws IOException {
        Map<String, Object> options = new HashMap<>();
        options.put("folder", "travel_photos");
        options.put("resource_type", "auto");

        Map<String, Object> uploadResult = cloudinary.uploader().upload(
            photo.getBytes(),
            options
        );
        return (String) uploadResult.get("url");
    }
} 