package ru.kpfu.travel_service2.handlers;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import com.fasterxml.jackson.databind.SerializationFeature;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;
import ru.kpfu.travel_service2.dto.ChatMessageDto;
import ru.kpfu.travel_service2.dto.ChatMessageDto.MessageType;
import ru.kpfu.travel_service2.services.ChatMessageService;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ConcurrentHashMap;

@Component
public class ChatWebSocketHandler extends TextWebSocketHandler {
    
    private static final Logger logger = LoggerFactory.getLogger(ChatWebSocketHandler.class);
    private final ObjectMapper objectMapper;
    private final ConcurrentHashMap<String, WebSocketSession> sessions = new ConcurrentHashMap<>();
    private final ChatMessageService chatMessageService;

    public ChatWebSocketHandler(ChatMessageService chatMessageService) {
        this.chatMessageService = chatMessageService;
        this.objectMapper = new ObjectMapper();
        this.objectMapper.registerModule(new JavaTimeModule());
        this.objectMapper.configure(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS, false);
    }

    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        String username = (String) session.getAttributes().get("username");
        sessions.put(username, session);

        try {
            // Отправляем историю сообщений новому пользователю
            List<ChatMessageDto> recentMessages = chatMessageService.getRecentMessages();
            for (ChatMessageDto message : recentMessages) {
                sendMessageToSession(session, message);
                Thread.sleep(50); // Небольшая задержка между сообщениями
            }

            // Отправляем всем сообщение о подключении нового пользователя
            ChatMessageDto joinMessage = new ChatMessageDto();
            joinMessage.setType(MessageType.JOIN);
            joinMessage.setSender(username);
            joinMessage.setTimestamp(LocalDateTime.now());
            joinMessage.setContent(username + " присоединился к чату");
            joinMessage.setUserList(new ArrayList<>(sessions.keySet())); // Добавляем актуальный список пользователей
            
            broadcastMessage(joinMessage);
            chatMessageService.saveMessage(joinMessage);
        } catch (Exception e) {
            logger.error("Ошибка при инициализации подключения для пользователя {}: {}", username, e.getMessage());
            session.close(CloseStatus.SERVER_ERROR);
        }
    }

    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage textMessage) throws Exception {
        try {
            String payload = textMessage.getPayload();
            ChatMessageDto message = objectMapper.readValue(payload, ChatMessageDto.class);
            message.setTimestamp(LocalDateTime.now());
            
            String username = (String) session.getAttributes().get("username");
            message.setSender(username);
            
            chatMessageService.saveMessage(message);
            broadcastMessage(message);
        } catch (Exception e) {
            logger.error("Ошибка при обработке сообщения: {}", e.getMessage());
        }
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        String username = (String) session.getAttributes().get("username");
        sessions.remove(username);

        try {
            ChatMessageDto message = new ChatMessageDto();
            message.setType(MessageType.LEAVE);
            message.setSender(username);
            message.setTimestamp(LocalDateTime.now());
            message.setContent(username + " покинул чат");
            message.setUserList(new ArrayList<>(sessions.keySet())); // Добавляем актуальный список пользователей
            
            chatMessageService.saveMessage(message);
            broadcastMessage(message);
        } catch (Exception e) {
            logger.error("Ошибка при закрытии соединения для пользователя {}: {}", username, e.getMessage());
        }
    }

    private void sendMessageToSession(WebSocketSession session, ChatMessageDto message) throws IOException {
        if (session.isOpen()) {
            String messageJson = objectMapper.writeValueAsString(message);
            synchronized (session) {
                session.sendMessage(new TextMessage(messageJson));
            }
        }
    }

    private void broadcastMessage(ChatMessageDto message) {
        String messageJson;
        try {
            messageJson = objectMapper.writeValueAsString(message);
            TextMessage textMessage = new TextMessage(messageJson);

            // Отправляем сообщение всем подключенным пользователям
            for (WebSocketSession userSession : sessions.values()) {
                if (userSession.isOpen()) {
                    synchronized (userSession) {
                        userSession.sendMessage(textMessage);
                    }
                }
            }
        } catch (IOException e) {
            logger.error("Ошибка при отправке сообщения: {}", e.getMessage());
        }
    }
} 