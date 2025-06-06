package ru.kpfu.travel_service2.handlers;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;
import ru.kpfu.travel_service2.dto.MessageDto;

import java.util.HashMap;
import java.util.Map;

@Component
public class WebSocketMessagesHandler extends TextWebSocketHandler {

    private static final Map<String, WebSocketSession> sessions = new HashMap<>(); // ключ - айди страницы, значение - привязанная сессия к этой странице

    @Autowired
    private ObjectMapper objectMapper;

    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage jsonMessage) throws Exception {
        MessageDto message = objectMapper.readValue(jsonMessage.getPayload(), MessageDto.class);//переконвертировали в джава объект

        // смотрю, не запоминал ли я еще такую сессию с такой id страницы
        if (!sessions.containsKey(message.getFrom())) {
            sessions.put(message.getFrom(), session);
        }

        //пробегаюсь по всем сессиям и в каждую сессию отправляю это сообщение
        for (WebSocketSession currentSession : sessions.values()) {
            currentSession.sendMessage(jsonMessage);
        }
    }
}

