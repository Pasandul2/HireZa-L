package com.hireza.jobportal.repository;

import com.hireza.jobportal.model.User;
import com.hireza.jobportal.model.Role;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    
    Optional<User> findByEmail(String email);
    
    boolean existsByEmail(String email);
    
    List<User> findByRole(Role role);
    
    @Query("SELECT u FROM User u WHERE u.role = :role AND u.enabled = true")
    List<User> findActiveUsersByRole(@Param("role") Role role);
    
    @Query("SELECT COUNT(u) FROM User u WHERE u.role = :role")
    long countByRole(@Param("role") Role role);
    
    List<User> findByEnabledTrue();
    
    @Query("SELECT u FROM User u WHERE u.fullName LIKE %:name% OR u.email LIKE %:email%")
    List<User> findByFullNameContainingIgnoreCaseOrEmailContainingIgnoreCase(
            @Param("name") String name, @Param("email") String email);
}