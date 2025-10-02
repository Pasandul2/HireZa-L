package com.hireza.jobportal.controller;

import com.hireza.jobportal.model.*;
import com.hireza.jobportal.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.Optional;

@Controller
@RequestMapping("/user")
@PreAuthorize("hasRole('USER')")
public class UserController {

    @Autowired
    private CVService cvService;

    @Autowired
    private JobService jobService;

    @Autowired
    private UserService userService;
    
    @Autowired
    private MessageService messageService;
    
    @Autowired
    private JobSuggestionService jobSuggestionService;

    @GetMapping("/dashboard")
    public String dashboard(Authentication authentication, Model model) {
        String email = authentication.getName();
        Optional<User> userOpt = userService.findByEmail(email);
        
        if (userOpt.isPresent()) {
            User user = userOpt.get();
            model.addAttribute("user", user);
            model.addAttribute("cvs", cvService.getCVsByUser(user));
            model.addAttribute("hasSubmittedCV", cvService.hasUserSubmittedCV(user));
            model.addAttribute("recentJobs", jobService.getActiveJobsOrderedByDate());
            model.addAttribute("recommendedJobs", jobService.getActiveJobsOrderedByDate());
            model.addAttribute("availableJobs", jobService.getActiveJobCount());
            model.addAttribute("cvStatus", cvService.hasUserSubmittedCV(user) ? "SUBMITTED" : null);
            model.addAttribute("upcomingSessions", 0); // TODO: Implement session service
            model.addAttribute("unreadMessages", messageService.getUnreadMessageCount(user));
            model.addAttribute("recentMessages", messageService.getMessagesByUser(user));
            model.addAttribute("jobSuggestions", jobSuggestionService.getSuggestionsByUser(user));
            model.addAttribute("totalSuggestions", jobSuggestionService.getSuggestionCountByUser(user));
            model.addAttribute("upcomingSessionsList", java.util.Collections.emptyList()); // TODO: Implement session service
        }
        
        return "user/dashboard";
    }

    @GetMapping("/submit-cv")
    public String submitCVForm(Model model) {
        return "user/submit-cv";
    }

    @PostMapping("/submit-cv")
    public String submitCV(@RequestParam("cvFile") MultipartFile file,
                          @RequestParam(value = "coverLetter", required = false) String coverLetter,
                          Authentication authentication,
                          RedirectAttributes redirectAttributes) {
        try {
            String email = authentication.getName();
            Optional<User> userOpt = userService.findByEmail(email);
            
            if (userOpt.isPresent()) {
                User user = userOpt.get();
                
                // Check if user already has a pending CV
                if (cvService.hasUserSubmittedCV(user)) {
                    redirectAttributes.addFlashAttribute("error", 
                        "You already have a CV under review. Please wait for the current review to complete.");
                    return "redirect:/user/cv";
                }
                
                cvService.uploadCV(file, user, coverLetter);
                redirectAttributes.addFlashAttribute("success", 
                    "CV uploaded successfully! It will be reviewed by our counselors within 2-3 business days.");
                return "redirect:/user/cv";
            } else {
                redirectAttributes.addFlashAttribute("error", "User not found!");
                return "redirect:/user/cv";
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", 
                "Failed to upload CV: " + e.getMessage());
            return "redirect:/user/submit-cv";
        }
    }

    @GetMapping("/cv/{id}")
    public String viewCV(@PathVariable Long id,
                        Authentication authentication,
                        Model model,
                        RedirectAttributes redirectAttributes) {
        try {
            String email = authentication.getName();
            Optional<User> userOpt = userService.findByEmail(email);
            
            if (userOpt.isPresent()) {
                User user = userOpt.get();
                Optional<CV> cvOpt = cvService.findByUserAndId(user, id);
                
                if (cvOpt.isPresent()) {
                    model.addAttribute("cv", cvOpt.get());
                    return "user/cv-details";
                } else {
                    redirectAttributes.addFlashAttribute("error", "CV not found!");
                    return "redirect:/user/dashboard";
                }
            } else {
                redirectAttributes.addFlashAttribute("error", "User not found!");
                return "redirect:/user/dashboard";
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error viewing CV: " + e.getMessage());
            return "redirect:/user/dashboard";
        }
    }

    @GetMapping("/jobs")
    public String viewJobs(@RequestParam(value = "category", required = false) String category,
                          @RequestParam(value = "search", required = false) String search,
                          Model model) {
        if (search != null && !search.trim().isEmpty()) {
            if (category != null && !category.trim().isEmpty()) {
                model.addAttribute("jobs", jobService.searchJobsByCategory(category, search));
            } else {
                model.addAttribute("jobs", jobService.searchJobs(search));
            }
            model.addAttribute("search", search);
        } else if (category != null && !category.trim().isEmpty()) {
            model.addAttribute("jobs", jobService.getJobsByCategory(category));
        } else {
            model.addAttribute("jobs", jobService.getActiveJobs());
        }
        
        model.addAttribute("categories", jobService.getAllCategories());
        model.addAttribute("selectedCategory", category);
        
        return "user/jobs";
    }

    @GetMapping("/job/{id}")
    public String viewJobDetails(@PathVariable Long id, Model model, RedirectAttributes redirectAttributes) {
        Optional<Job> jobOpt = jobService.findById(id);
        if (jobOpt.isPresent()) {
            model.addAttribute("job", jobOpt.get());
            return "user/job-details";
        } else {
            redirectAttributes.addFlashAttribute("error", "Job not found!");
            return "redirect:/user/jobs";
        }
    }

    @GetMapping("/cv")
    public String manageCVs(Authentication authentication, Model model, RedirectAttributes redirectAttributes) {
        try {
            String email = authentication.getName();
            Optional<User> userOpt = userService.findByEmail(email);
            
            if (userOpt.isPresent()) {
                User user = userOpt.get();
                model.addAttribute("user", user);
                model.addAttribute("cvs", cvService.getCVsByUser(user));
                model.addAttribute("hasSubmittedCV", cvService.hasUserSubmittedCV(user));
                return "user/cv-management";
            } else {
                redirectAttributes.addFlashAttribute("error", "User not found!");
                return "redirect:/user/dashboard";
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error loading CVs: " + e.getMessage());
            return "redirect:/user/dashboard";
        }
    }

    @GetMapping("/cv/download/{id}")
    public String downloadCV(@PathVariable Long id,
                            Authentication authentication,
                            RedirectAttributes redirectAttributes) {
        try {
            String email = authentication.getName();
            Optional<User> userOpt = userService.findByEmail(email);
            
            if (userOpt.isPresent()) {
                User user = userOpt.get();
                Optional<CV> cvOpt = cvService.findByUserAndId(user, id);
                
                if (cvOpt.isPresent()) {
                    // In a real application, this would serve the file
                    // For now, redirect back with success message
                    redirectAttributes.addFlashAttribute("success", "CV download started!");
                    return "redirect:/user/cv";
                } else {
                    redirectAttributes.addFlashAttribute("error", "CV not found!");
                    return "redirect:/user/cv";
                }
            } else {
                redirectAttributes.addFlashAttribute("error", "User not found!");
                return "redirect:/user/dashboard";
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error downloading CV: " + e.getMessage());
            return "redirect:/user/cv";
        }
    }

    @PostMapping("/cv/delete/{id}")
    public String deleteCV(@PathVariable Long id,
                          Authentication authentication,
                          RedirectAttributes redirectAttributes) {
        try {
            String email = authentication.getName();
            Optional<User> userOpt = userService.findByEmail(email);
            
            if (userOpt.isPresent()) {
                User user = userOpt.get();
                Optional<CV> cvOpt = cvService.findByUserAndId(user, id);
                
                if (cvOpt.isPresent()) {
                    CV cv = cvOpt.get();
                    // Only allow deletion if CV is not under review
                    if (cv.getStatus().name().equals("SUBMITTED")) {
                        cvService.deleteCV(cv);
                        redirectAttributes.addFlashAttribute("success", "CV deleted successfully!");
                    } else {
                        redirectAttributes.addFlashAttribute("error", "Cannot delete CV that is under review or has been reviewed!");
                    }
                    return "redirect:/user/cv";
                } else {
                    redirectAttributes.addFlashAttribute("error", "CV not found!");
                    return "redirect:/user/cv";
                }
            } else {
                redirectAttributes.addFlashAttribute("error", "User not found!");
                return "redirect:/user/dashboard";
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error deleting CV: " + e.getMessage());
            return "redirect:/user/cv";
        }
    }

    @GetMapping("/applications")
    public String viewApplications(Authentication authentication, Model model, RedirectAttributes redirectAttributes) {
        try {
            String email = authentication.getName();
            Optional<User> userOpt = userService.findByEmail(email);
            
            if (userOpt.isPresent()) {
                User user = userOpt.get();
                model.addAttribute("user", user);
                // TODO: Implement job applications when JobApplication entity is created
                model.addAttribute("applications", java.util.Collections.emptyList());
                model.addAttribute("totalApplications", 0);
                model.addAttribute("pendingApplications", 0);
                model.addAttribute("acceptedApplications", 0);
                model.addAttribute("rejectedApplications", 0);
                return "user/applications";
            } else {
                redirectAttributes.addFlashAttribute("error", "User not found!");
                return "redirect:/user/dashboard";
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error loading applications: " + e.getMessage());
            return "redirect:/user/dashboard";
        }
    }

    @PostMapping("/job/{id}/apply")
    public String applyForJob(@PathVariable Long id,
                             Authentication authentication,
                             RedirectAttributes redirectAttributes) {
        try {
            String email = authentication.getName();
            Optional<User> userOpt = userService.findByEmail(email);
            Optional<Job> jobOpt = jobService.findById(id);
            
            if (userOpt.isPresent() && jobOpt.isPresent()) {
                User user = userOpt.get();
                Job job = jobOpt.get();
                
                // Check if user has an approved CV
                if (!cvService.hasUserApprovedCV(user)) {
                    redirectAttributes.addFlashAttribute("error", 
                        "You need to have an approved CV before applying for jobs. Please submit your CV for review first.");
                    return "redirect:/user/job/" + id;
                }
                
                // TODO: Create JobApplication entity and implement application logic
                // For now, just show success message
                redirectAttributes.addFlashAttribute("success", 
                    "Application submitted successfully for " + job.getTitle() + "!");
                return "redirect:/user/applications";
            } else {
                redirectAttributes.addFlashAttribute("error", "Job or user not found!");
                return "redirect:/user/jobs";
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error applying for job: " + e.getMessage());
            return "redirect:/user/jobs";
        }
    }
    
    @GetMapping("/messages")
    public String messages(Authentication authentication, Model model) {
        String email = authentication.getName();
        Optional<User> userOpt = userService.findByEmail(email);
        
        if (userOpt.isPresent()) {
            User user = userOpt.get();
            model.addAttribute("user", user);
            model.addAttribute("messages", messageService.getMessagesByUser(user));
            model.addAttribute("unreadMessages", messageService.getUnreadMessagesByUser(user));
            model.addAttribute("totalMessages", messageService.getTotalMessageCount(user));
            model.addAttribute("jobSuggestionMessages", messageService.getMessagesByType(user, MessageType.JOB_SUGGESTION));
        }
        
        return "user/messages";
    }
    
    @PostMapping("/messages/{id}/read")
    public String markMessageAsRead(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            messageService.markAsRead(id);
            redirectAttributes.addFlashAttribute("success", "Message marked as read.");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error marking message as read: " + e.getMessage());
        }
        return "redirect:/user/messages";
    }
    
    @GetMapping("/suggestions")
    public String suggestions(Authentication authentication, Model model) {
        String email = authentication.getName();
        Optional<User> userOpt = userService.findByEmail(email);
        
        if (userOpt.isPresent()) {
            User user = userOpt.get();
            model.addAttribute("user", user);
            model.addAttribute("suggestions", jobSuggestionService.getSuggestionsByUser(user));
            model.addAttribute("totalSuggestions", jobSuggestionService.getSuggestionCountByUser(user));
        }
        
        return "user/suggestions";
    }
}