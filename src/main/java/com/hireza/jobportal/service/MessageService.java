package com.hireza.jobportal.service;

import com.hireza.jobportal.model.Message;
import com.hireza.jobportal.model.MessageType;
import com.hireza.jobportal.model.User;
import com.hireza.jobportal.repository.MessageRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class MessageService {

    @Autowired
    private MessageRepository messageRepository;

    public Message sendMessage(User sender, User recipient, String subject, String content, MessageType messageType) {
        Message message = new Message();
        message.setSender(sender);
        message.setUser(recipient);
        message.setSubject(subject);
        message.setContent(content);
        message.setMessageType(messageType);
        message.setSentAt(LocalDateTime.now());
        message.setIsRead(false);
        
        return messageRepository.save(message);
    }

    public List<Message> getMessagesByUser(User user) {
        return messageRepository.findByUserOrderBySentAtDesc(user);
    }

    public List<Message> getUnreadMessagesByUser(User user) {
        return messageRepository.findByUserAndIsReadFalseOrderBySentAtDesc(user);
    }

    public List<Message> getMessagesBySender(User sender) {
        return messageRepository.findBySenderOrderBySentAtDesc(sender);
    }

    public Optional<Message> getMessageById(Long id) {
        return messageRepository.findById(id);
    }

    public Message markAsRead(Long messageId) {
        Optional<Message> messageOpt = messageRepository.findById(messageId);
        if (messageOpt.isPresent()) {
            Message message = messageOpt.get();
            message.setIsRead(true);
            message.setReadAt(LocalDateTime.now());
            return messageRepository.save(message);
        }
        return null;
    }

    public void deleteMessage(Long messageId) {
        messageRepository.deleteById(messageId);
    }

    public long getUnreadMessageCount(User user) {
        return messageRepository.countByUserAndIsReadFalse(user);
    }

    public long getTotalMessageCount(User user) {
        return messageRepository.countByUser(user);
    }

    public List<Message> getMessagesByType(User user, MessageType messageType) {
        return messageRepository.findByUserAndMessageTypeOrderBySentAtDesc(user, messageType);
    }
}