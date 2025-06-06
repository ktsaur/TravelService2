package ru.kpfu.travel_service2.dto;

import java.time.LocalDateTime;
import java.util.List;

public class ChatMessageDto {
    private String content;
    private String sender;
    private String senderRole;
    private LocalDateTime timestamp;
    private MessageType type;
    private List<String> userList;

    public enum MessageType {
        CHAT,
        JOIN,
        LEAVE,
        SYSTEM,
        USER_LIST
    }

    // Геттеры и сеттеры
    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getSender() {
        return sender;
    }

    public void setSender(String sender) {
        this.sender = sender;
    }

    public LocalDateTime getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(LocalDateTime timestamp) {
        this.timestamp = timestamp;
    }

    public MessageType getType() {
        return type;
    }

    public void setType(MessageType type) {
        this.type = type;
    }

    public List<String> getUserList() {
        return userList;
    }

    public void setUserList(List<String> userList) {
        this.userList = userList;
    }
} 