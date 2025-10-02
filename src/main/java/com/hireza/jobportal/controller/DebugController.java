package com.hireza.jobportal.controller;

import com.hireza.jobportal.model.User;
import com.hireza.jobportal.model.CV;
import com.hireza.jobportal.service.UserService;
import com.hireza.jobportal.service.CVService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/debug")
public class DebugController {

    @Autowired
    private UserService userService;

    @Autowired
    private CVService cvService;

    @GetMapping("/data-count")
    public Map<String, Object> getDataCount() {
        Map<String, Object> result = new HashMap<>();
        
        try {
            // Get all users
            List<User> allUsers = userService.getAllUsers();
            result.put("totalUsers", allUsers.size());
            result.put("users", allUsers.stream().map(u -> 
                Map.of("id", u.getId(), "email", u.getEmail(), "fullName", u.getFullName(), "role", u.getRole())
            ).toList());
            
            // Get all CVs
            List<CV> allCVs = cvService.getAllCVs();
            result.put("totalCVs", allCVs.size());
            result.put("cvs", allCVs.stream().map(cv -> 
                Map.of("id", cv.getId(), "fileName", cv.getFileName(), "status", cv.getStatus(), 
                       "userEmail", cv.getUser().getEmail(), "submittedAt", cv.getSubmittedAt())
            ).toList());
            
            result.put("status", "success");
        } catch (Exception e) {
            result.put("status", "error");
            result.put("error", e.getMessage());
            e.printStackTrace();
        }
        
        return result;
    }
}