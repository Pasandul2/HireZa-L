package com.hireza.jobportal.repository;

import com.hireza.jobportal.model.Message;
import com.hireza.jobportal.model.MessageType;
import com.hireza.jobportal.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MessageRepository extends JpaRepository<Message, Long> {
    
    List<Message> findByUserOrderBySentAtDesc(User user);
    
    List<Message> findByUserAndIsReadFalseOrderBySentAtDesc(User user);
    
    List<Message> findBySenderOrderBySentAtDesc(User sender);
    
    List<Message> findByUserAndMessageTypeOrderBySentAtDesc(User user, MessageType messageType);
    
    @Query("SELECT COUNT(m) FROM Message m WHERE m.user = :user AND m.isRead = false")
    long countUnreadMessagesByUser(@Param("user") User user);
    
    @Query("SELECT m FROM Message m WHERE m.user = :user AND m.isRead = :isRead ORDER BY m.sentAt DESC")
    List<Message> findByUserAndIsReadOrderBySentAtDesc(@Param("user") User user, @Param("isRead") Boolean isRead);
    
    @Query("SELECT m FROM Message m WHERE m.sender = :sender AND m.user = :user ORDER BY m.sentAt DESC")
    List<Message> findBySenderAndUserOrderBySentAtDesc(@Param("sender") User sender, @Param("user") User user);
}