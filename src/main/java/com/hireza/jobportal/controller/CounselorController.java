package com.hireza.jobportal.controller;

import com.hireza.jobportal.model.*;
import com.hireza.jobportal.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/counselor")
@PreAuthorize("hasRole('COUNSELOR')")
public class CounselorController {

    @Autowired
    private UserService userService;
    
    @Autowired
    private CVService cvService;
    
    @Autowired
    private JobService jobService;
    
    @Autowired
    private JobSuggestionService jobSuggestionService;

    @GetMapping("/dashboard")
    public String dashboard(Authentication authentication, Model model) {
        String email = authentication.getName();
        Optional<User> userOpt = userService.findByEmail(email);
        
        if (userOpt.isPresent()) {
            User counselor = userOpt.get();
            model.addAttribute("counselor", counselor);
            
            // CV Review Statistics
            List<CV> pendingCVs = cvService.getCVsByStatus(CVStatus.SUBMITTED);
            List<CV> underReviewCVs = cvService.getCVsByStatus(CVStatus.UNDER_REVIEW);
            List<CV> reviewedByCounselor = cvService.getCVsReviewedBy(counselor);
            
            model.addAttribute("pendingCVReviews", pendingCVs.size());
            model.addAttribute("underReviewCVs", underReviewCVs.size());
            model.addAttribute("totalCVsReviewed", reviewedByCounselor.size());
            model.addAttribute("recentCVs", pendingCVs.stream().limit(5).toList());
            
            // Job and User Statistics
            model.addAttribute("activeUsers", userService.getUserCountByRole(Role.USER));
            model.addAttribute("availableJobs", jobService.getActiveJobCount());
            
            // Placeholder for future features
            model.addAttribute("totalSessions", 0);
            model.addAttribute("totalSuggestions", 0);
            model.addAttribute("pendingSessions", 0);
            model.addAttribute("upcomingSessions", java.util.Collections.emptyList());
            model.addAttribute("recentSuggestions", java.util.Collections.emptyList());
            model.addAttribute("todaySessions", java.util.Collections.emptyList());
            model.addAttribute("completedSessions", 0);
            model.addAttribute("suggestionsMade", 0);
        }
        
        return "counselor/dashboard";
    }

    // ===== CV REVIEW MANAGEMENT =====
    
    @GetMapping("/cv-reviews")
    public String cvReviews(@RequestParam(defaultValue = "SUBMITTED") String status, Model model) {
        CVStatus cvStatus;
        try {
            cvStatus = CVStatus.valueOf(status);
        } catch (IllegalArgumentException e) {
            cvStatus = CVStatus.SUBMITTED;
        }
        
        List<CV> cvs = cvService.getCVsByStatus(cvStatus);
        model.addAttribute("cvs", cvs);
        model.addAttribute("currentStatus", cvStatus);
        
        return "counselor/cv-reviews";
    }
    
    @GetMapping("/cv/{id}/review")
    public String reviewCV(@PathVariable Long id, Model model, RedirectAttributes redirectAttributes) {
        Optional<CV> cvOpt = cvService.getCVById(id);
        if (cvOpt.isPresent()) {
            CV cv = cvOpt.get();
            model.addAttribute("cv", cv);
            model.addAttribute("user", cv.getUser());
            
            // Get available jobs for suggestion
            List<Job> availableJobs = jobService.getActiveJobs();
            model.addAttribute("availableJobs", availableJobs);
            
            return "counselor/cv-review-detail";
        } else {
            redirectAttributes.addFlashAttribute("error", "CV not found!");
            return "redirect:/counselor/cv-reviews";
        }
    }
    
    @PostMapping("/cv/{id}/review")
    public String submitCVReview(@PathVariable Long id,
                                @RequestParam String action,
                                @RequestParam(required = false) String feedback,
                                Authentication authentication,
                                RedirectAttributes redirectAttributes) {
        try {
            String email = authentication.getName();
            Optional<User> counselorOpt = userService.findByEmail(email);
            
            if (counselorOpt.isPresent()) {
                User counselor = counselorOpt.get();
                
                if ("approve".equals(action)) {
                    cvService.approveCV(id, counselor, feedback);
                    redirectAttributes.addFlashAttribute("success", "CV approved successfully!");
                } else if ("reject".equals(action)) {
                    cvService.rejectCV(id, counselor, feedback);
                    redirectAttributes.addFlashAttribute("success", "CV rejected with feedback provided.");
                } else if ("request_changes".equals(action)) {
                    cvService.requestCVChanges(id, counselor, feedback);
                    redirectAttributes.addFlashAttribute("success", "Changes requested. User has been notified.");
                }
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to process CV review: " + e.getMessage());
        }
        
        return "redirect:/counselor/cv-reviews";
    }
    
    // ===== JOB SUGGESTIONS =====
    
    @GetMapping("/suggestions")
    public String suggestions(Model model, Authentication authentication) {
        String email = authentication.getName();
        Optional<User> counselorOpt = userService.findByEmail(email);
        
        if (counselorOpt.isPresent()) {
            User counselor = counselorOpt.get();
            List<JobSuggestion> mySuggestions = jobSuggestionService.getSuggestionsByCounselor(counselor);
            model.addAttribute("suggestions", mySuggestions);
            model.addAttribute("totalSuggestions", mySuggestions.size());
        } else {
            model.addAttribute("suggestions", java.util.Collections.emptyList());
            model.addAttribute("totalSuggestions", 0);
        }
        
        // Get all active users and jobs for suggestions
        List<User> users = userService.getUsersByRole(Role.USER);
        List<Job> jobs = jobService.getActiveJobs();
        
        model.addAttribute("users", users);
        model.addAttribute("jobs", jobs);
        
        return "counselor/suggestions";
    }
    
    @PostMapping("/suggest-job")
    public String suggestJob(@RequestParam Long userId,
                            @RequestParam Long jobId,
                            @RequestParam String message,
                            Authentication authentication,
                            RedirectAttributes redirectAttributes) {
        try {
            String email = authentication.getName();
            Optional<User> counselorOpt = userService.findByEmail(email);
            Optional<User> userOpt = userService.findById(userId);
            Optional<Job> jobOpt = jobService.getJobById(jobId);
            
            if (counselorOpt.isPresent() && userOpt.isPresent() && jobOpt.isPresent()) {
                jobSuggestionService.createSuggestion(counselorOpt.get(), userOpt.get(), jobOpt.get(), message);
                redirectAttributes.addFlashAttribute("success", "Job suggestion sent successfully! The user has been notified.");
            } else {
                redirectAttributes.addFlashAttribute("error", "Invalid user, job, or counselor!");
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to send job suggestion: " + e.getMessage());
        }
        
        return "redirect:/counselor/suggestions";
    }
    
    // ===== CAREER ADVICE & MESSAGING =====
    
    @GetMapping("/messages")
    public String messages(Model model) {
        // TODO: Implement messaging system
        model.addAttribute("messages", java.util.Collections.emptyList());
        return "counselor/messages";
    }
    
    @GetMapping("/sessions")
    public String sessions(Model model) {
        // TODO: Implement session management with actual Session entity
        model.addAttribute("sessions", java.util.Collections.emptyList());
        model.addAttribute("totalSessions", 0);
        model.addAttribute("scheduledSessions", 0);
        model.addAttribute("completedSessions", 0);
        model.addAttribute("thisWeekSessions", 0);
        model.addAttribute("users", userService.getUsersByRole(Role.USER));
        return "counselor/sessions";
    }

    @PostMapping("/sessions/schedule")
    public String scheduleSession(
            @RequestParam Long userId,
            @RequestParam String sessionType,
            @RequestParam String sessionDate,
            @RequestParam String sessionTime,
            @RequestParam Integer duration,
            @RequestParam(required = false) String notes,
            RedirectAttributes redirectAttributes) {
        
        try {
            // TODO: Implement actual session scheduling with Session entity
            // For now, just show success message
            redirectAttributes.addFlashAttribute("successMessage", 
                "Session scheduled successfully! (Note: This is a demo - actual session management requires Session entity implementation)");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", 
                "Error scheduling session: " + e.getMessage());
        }
        
        return "redirect:/counselor/sessions";
    }
}