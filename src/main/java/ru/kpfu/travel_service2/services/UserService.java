package ru.kpfu.travel_service2.services;

import com.cloudinary.Cloudinary;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.expression.ExpressionException;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import ru.kpfu.travel_service2.dto.UserRegisterDto;
import ru.kpfu.travel_service2.dto.UpdateProfileDto;
import ru.kpfu.travel_service2.entity.User;
import ru.kpfu.travel_service2.repository.UserRepository;
import ru.kpfu.travel_service2.utils.CloudinaryUtil;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@Service
public class UserService {
    @Autowired
    private UserRepository userRepository;

    @Autowired
    private EmailService emailService;

    @Autowired
    private TokenService tokenService;

    @Autowired
    private CurrencyService currencyService;

    @Autowired
    private BCryptPasswordEncoder passwordEncoder;

    private final Cloudinary cloudinary = CloudinaryUtil.getInstance();

    @Transactional
    public void saveUser(UserRegisterDto userRegisterDto) throws Exception {
        if (userRepository.findByUsername(userRegisterDto.getUsername()).isPresent()) {
            throw new Exception("Пользователь с таким именем уже существует.");
        }
        if (userRepository.findByEmail(userRegisterDto.getEmail()).isPresent()) {
            throw new Exception("Пользователь с такой почтой уже существует.");
        }
        User user = new User();
        user.setUsername(userRegisterDto.getUsername());
        user.setPassword(passwordEncoder.encode(userRegisterDto.getPassword()));
        user.setEmail(userRegisterDto.getEmail());
        user.setEnabled(false);
        user.setActivated(false);
        user.setRole(User.Role.USER);

        String token = tokenService.generateToken();
        user.setActivationToken(token);

        userRepository.save(user);
        emailService.sendEMail(userRegisterDto.getEmail(), token);

        String exchangeRate = currencyService.getUsdToRubExchangeRate();
        emailService.sendEMail(userRegisterDto.getEmail(), exchangeRate);
    }

    @Transactional
    public User findByActivationToken(String token) {
        return userRepository.findByActivationToken(token)
                .orElseThrow(() -> new RuntimeException("Токен активации не найден"));
    }

    @Transactional
    public void activateUser(String token) {
        User user = userRepository.findByActivationToken(token)
                .orElseThrow(() -> new RuntimeException("Токен активации не найден"));
        user.setActivated(true);
        user.setEnabled(true);
        user.setActivationToken(null);
        userRepository.save(user);
    }

    public void deleteUser(String username) {
        User user = userRepository.findByUsername(username)
                .orElseThrow(() -> new RuntimeException("Пользователь не найден"));

        userRepository.delete(user);
    }

    public void updatePassword(User user, String newPassword) {
        user.setPassword(passwordEncoder.encode(newPassword));
        userRepository.save(user);
    }

    @Transactional
    public void updateProfile(User user, UpdateProfileDto updateProfileDto) {
        user.setUsername(updateProfileDto.getUsername());
        user.setEmail(updateProfileDto.getEmail());
        userRepository.save(user);
    }

    @Transactional
    public void updateProfilePhoto(User user, MultipartFile photo) throws IOException {
        if (photo != null && !photo.isEmpty()) {
            String photoUrl = uploadProfilePhoto(photo);
            user.setProfile_url(photoUrl);
            userRepository.save(user);
        }
    }

    private String uploadProfilePhoto(MultipartFile photo) throws IOException {
        Map<String, Object> options = new HashMap<>();
        options.put("folder", "profile_photos");
        options.put("resource_type", "auto");

        Map<String, Object> uploadResult = cloudinary.uploader().upload(
            photo.getBytes(),
            options
        );
        return (String) uploadResult.get("url");
    }
}