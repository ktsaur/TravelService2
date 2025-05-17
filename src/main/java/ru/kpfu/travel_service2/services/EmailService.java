package ru.kpfu.travel_service2.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class EmailService {

    @Autowired
    private JavaMailSender mailSender;

    @Value("${spring.mail.username}")
    private String from;

    public void sendEMail(String to, String token) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setFrom(from);
        String subject = "Подтверждение регистрации";
        String activationLink = "http://localhost:8080/activate?token=" + token;
        String text = "Для подтверждения регистрации перейдите по ссылке:\n" + activationLink;
        message.setTo(to);
        message.setSubject(subject);
        message.setText(text);
        mailSender.send(message);
    }
}
