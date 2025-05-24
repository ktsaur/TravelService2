package ru.kpfu.travel_service2.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.expression.ExpressionException;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import ru.kpfu.travel_service2.dto.UserRegisterDto;
import ru.kpfu.travel_service2.entity.User;
import ru.kpfu.travel_service2.repository.UserRepository;

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

}