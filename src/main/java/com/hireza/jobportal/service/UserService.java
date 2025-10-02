package com.hireza.jobportal.service;

import com.hireza.jobportal.model.User;
import com.hireza.jobportal.model.Role;
import com.hireza.jobportal.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class UserService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    public User createUser(User user) {
        if (userRepository.existsByEmail(user.getEmail())) {
            throw new RuntimeException("Email already exists");
        }
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        return userRepository.save(user);
    }

    public User updateUser(User user) {
        return userRepository.save(user);
    }

    public Optional<User> findByEmail(String email) {
        return userRepository.findByEmail(email);
    }

    public Optional<User> findById(Long id) {
        return userRepository.findById(id);
    }

    public List<User> findByRole(Role role) {
        return userRepository.findByRole(role);
    }

    public List<User> findActiveUsersByRole(Role role) {
        return userRepository.findActiveUsersByRole(role);
    }

    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    public List<User> getActiveUsers() {
        return userRepository.findByEnabledTrue();
    }

    public void deleteUser(Long id) {
        userRepository.deleteById(id);
    }

    public void toggleUserStatus(Long id) {
        Optional<User> userOpt = userRepository.findById(id);
        if (userOpt.isPresent()) {
            User user = userOpt.get();
            user.setEnabled(!user.getEnabled());
            userRepository.save(user);
        }
    }

    public long getUserCountByRole(Role role) {
        return userRepository.countByRole(role);
    }

    public boolean emailExists(String email) {
        return userRepository.existsByEmail(email);
    }

    public List<User> searchUsers(String searchTerm) {
        return userRepository.findByFullNameContainingIgnoreCaseOrEmailContainingIgnoreCase(
                searchTerm, searchTerm);
    }

    public List<User> getCounselors() {
        return findActiveUsersByRole(Role.COUNSELOR);
    }

    public List<User> getUsersByRole(Role role) {
        return userRepository.findByRole(role);
    }

    // Admin methods
    public long getTotalUserCount() {
        return userRepository.count();
    }

    public java.util.Map<Role, Long> getUsersByRole() {
        java.util.Map<Role, Long> roleMap = new java.util.HashMap<>();
        roleMap.put(Role.USER, userRepository.countByRole(Role.USER));
        roleMap.put(Role.COUNSELOR, userRepository.countByRole(Role.COUNSELOR));
        roleMap.put(Role.ADMIN, userRepository.countByRole(Role.ADMIN));
        return roleMap;
    }
}