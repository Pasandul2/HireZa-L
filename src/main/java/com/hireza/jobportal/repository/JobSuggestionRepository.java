package com.hireza.jobportal.repository;

import com.hireza.jobportal.model.JobSuggestion;
import com.hireza.jobportal.model.User;
import com.hireza.jobportal.model.Job;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface JobSuggestionRepository extends JpaRepository<JobSuggestion, Long> {
    
    List<JobSuggestion> findByUserOrderBySuggestedAtDesc(User user);
    
    List<JobSuggestion> findByCounselorOrderBySuggestedAtDesc(User counselor);
    
    List<JobSuggestion> findByJobOrderBySuggestedAtDesc(Job job);
    
    @Query("SELECT js FROM JobSuggestion js WHERE js.user = :user AND js.job = :job")
    List<JobSuggestion> findByUserAndJob(@Param("user") User user, @Param("job") Job job);
    
    @Query("SELECT COUNT(js) FROM JobSuggestion js WHERE js.counselor = :counselor")
    long countByCounselor(@Param("counselor") User counselor);
    
    @Query("SELECT COUNT(js) FROM JobSuggestion js WHERE js.user = :user")
    long countByUser(@Param("user") User user);
}