package com.hireza.jobportal.repository;

import com.hireza.jobportal.model.Job;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface JobRepository extends JpaRepository<Job, Long> {
    
    List<Job> findByActiveTrue();
    
    List<Job> findByActiveTrueOrderByCreatedAtDesc();
    
    List<Job> findByCategory(String category);
    
    List<Job> findByCategoryAndActiveTrue(String category);
    
    @Query("SELECT DISTINCT j.category FROM Job j WHERE j.active = true ORDER BY j.category")
    List<String> findDistinctCategories();
    
    @Query("SELECT j FROM Job j WHERE j.active = true AND " +
           "(LOWER(j.title) LIKE LOWER(CONCAT('%', :keyword, '%')) OR " +
           "LOWER(j.description) LIKE LOWER(CONCAT('%', :keyword, '%')) OR " +
           "LOWER(j.category) LIKE LOWER(CONCAT('%', :keyword, '%')))")
    List<Job> searchActiveJobs(@Param("keyword") String keyword);
    
    @Query("SELECT j FROM Job j WHERE j.active = true AND j.category = :category AND " +
           "(LOWER(j.title) LIKE LOWER(CONCAT('%', :keyword, '%')) OR " +
           "LOWER(j.description) LIKE LOWER(CONCAT('%', :keyword, '%')))")
    List<Job> searchActiveJobsByCategory(@Param("category") String category, @Param("keyword") String keyword);
    
    long countByActiveTrue();
    
    long countByCategoryAndActiveTrue(String category);
}