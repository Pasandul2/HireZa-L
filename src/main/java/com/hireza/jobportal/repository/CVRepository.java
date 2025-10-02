package com.hireza.jobportal.repository;

import com.hireza.jobportal.model.CV;
import com.hireza.jobportal.model.CVStatus;
import com.hireza.jobportal.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface CVRepository extends JpaRepository<CV, Long> {
    
    List<CV> findByUser(User user);
    
    List<CV> findByUserOrderBySubmittedAtDesc(User user);
    
    List<CV> findByStatus(CVStatus status);
    
    List<CV> findByStatusOrderBySubmittedAtDesc(CVStatus status);
    
    @Query("SELECT cv FROM CV cv WHERE cv.status IN :statuses ORDER BY cv.submittedAt DESC")
    List<CV> findByStatusInOrderBySubmittedAtDesc(@Param("statuses") List<CVStatus> statuses);
    
    Optional<CV> findByUserAndId(User user, Long id);
    
    @Query("SELECT COUNT(cv) FROM CV cv WHERE cv.status = :status")
    long countByStatus(@Param("status") CVStatus status);
    
    @Query("SELECT cv FROM CV cv WHERE cv.reviewedBy = :counselor ORDER BY cv.reviewedAt DESC")
    List<CV> findByReviewedByOrderByReviewedAtDesc(@Param("counselor") User counselor);
    
    boolean existsByUserAndStatus(User user, CVStatus status);
    
    List<CV> findAllByOrderBySubmittedAtDesc();
}