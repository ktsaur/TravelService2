package ru.kpfu.travel_service2.services;

import org.springframework.stereotype.Service;
import ru.kpfu.travel_service2.dto.ChatMessageDto;
import ru.kpfu.travel_service2.entity.ChatMessage;
import ru.kpfu.travel_service2.repository.ChatMessageRepository;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class ChatMessageService {
    
    private final ChatMessageRepository chatMessageRepository;

    public ChatMessageService(ChatMessageRepository chatMessageRepository) {
        this.chatMessageRepository = chatMessageRepository;
    }

    public void saveMessage(ChatMessageDto messageDto) {
        if (messageDto.getType() == ChatMessageDto.MessageType.USER_LIST) {
            return;
        }

        ChatMessage message = new ChatMessage();
        message.setContent(messageDto.getContent());
        message.setSender(messageDto.getSender());
        message.setTimestamp(messageDto.getTimestamp());
        message.setType(ChatMessage.MessageType.valueOf(messageDto.getType().name()));
        
        chatMessageRepository.save(message);
    }

    public List<ChatMessageDto> getRecentMessages() {
        return chatMessageRepository.findTop100ByOrderByTimestampDesc()
                .stream()
                .map(this::convertToDto)
                .sorted((m1, m2) -> m1.getTimestamp().compareTo(m2.getTimestamp()))
                .collect(Collectors.toList());
    }

    private ChatMessageDto convertToDto(ChatMessage message) {
        ChatMessageDto dto = new ChatMessageDto();
        dto.setContent(message.getContent());
        dto.setSender(message.getSender());
        dto.setTimestamp(message.getTimestamp());
        dto.setType(ChatMessageDto.MessageType.valueOf(message.getType().name()));
        return dto;
    }
} 