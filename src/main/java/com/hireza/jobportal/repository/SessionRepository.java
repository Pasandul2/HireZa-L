package com.hireza.jobportal.repository;

import com.hireza.jobportal.model.Session;
import com.hireza.jobportal.model.SessionStatus;
import com.hireza.jobportal.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface SessionRepository extends JpaRepository<Session, Long> {
    
    List<Session> findByUserOrderBySessionDateTimeDesc(User user);
    
    List<Session> findByCounselorOrderBySessionDateTimeDesc(User counselor);
    
    List<Session> findByStatus(SessionStatus status);
    
    @Query("SELECT s FROM Session s WHERE s.user = :user AND s.status = :status ORDER BY s.sessionDateTime DESC")
    List<Session> findByUserAndStatusOrderBySessionDateTimeDesc(
            @Param("user") User user, @Param("status") SessionStatus status);
    
    @Query("SELECT s FROM Session s WHERE s.counselor = :counselor AND s.status = :status ORDER BY s.sessionDateTime DESC")
    List<Session> findByCounselorAndStatusOrderBySessionDateTimeDesc(
            @Param("counselor") User counselor, @Param("status") SessionStatus status);
    
    @Query("SELECT s FROM Session s WHERE (s.user = :user OR s.counselor = :user) AND s.sessionDateTime >= :fromDate ORDER BY s.sessionDateTime ASC")
    List<Session> findUpcomingSessionsForUser(@Param("user") User user, @Param("fromDate") LocalDateTime fromDate);
    
    @Query("SELECT s FROM Session s WHERE s.sessionDateTime BETWEEN :startDate AND :endDate ORDER BY s.sessionDateTime ASC")
    List<Session> findSessionsBetweenDates(@Param("startDate") LocalDateTime startDate, @Param("endDate") LocalDateTime endDate);
    
    @Query("SELECT COUNT(s) FROM Session s WHERE s.counselor = :counselor AND s.status = :status")
    long countByCounselorAndStatus(@Param("counselor") User counselor, @Param("status") SessionStatus status);
}