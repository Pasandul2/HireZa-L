package com.hireza.jobportal.controller;

import com.hireza.jobportal.model.Job;
import com.hireza.jobportal.model.JobType;
import com.hireza.jobportal.model.User;
import com.hireza.jobportal.model.Role;
import com.hireza.jobportal.service.JobService;
import com.hireza.jobportal.service.UserService;
import com.hireza.jobportal.service.CVService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.Optional;
import java.util.List;

@Controller
@RequestMapping("/admin")
@PreAuthorize("hasRole('ADMIN')")
public class AdminController {

    @Autowired
    private JobService jobService;

    @Autowired
    private UserService userService;

    @Autowired
    private CVService cvService;

    @GetMapping("/dashboard")
    public String dashboard(Model model) {
        model.addAttribute("totalJobs", jobService.getActiveJobCount());
        model.addAttribute("totalUsers", userService.getUserCountByRole(Role.USER));
        model.addAttribute("totalCounselors", userService.getUserCountByRole(Role.COUNSELOR));
        model.addAttribute("totalCVs", cvService.getTotalCVCount());
        model.addAttribute("pendingCVs", cvService.getPendingCVCount());
        model.addAttribute("recentJobs", jobService.getActiveJobsOrderedByDate());
        return "admin/dashboard";
    }

    // Job Management
    @GetMapping("/jobs/list")
    public String listJobs(Model model) {
        model.addAttribute("jobs", jobService.getAllJobs());
        return "admin/jobs/list";
    }

    @GetMapping("/jobs/create")
    public String createJobForm(Model model) {
        model.addAttribute("job", new Job());
        model.addAttribute("jobTypes", JobType.values());
        return "admin/jobs/create";
    }

    @PostMapping("/jobs/create")
    public String createJob(@Valid @ModelAttribute("job") Job job,
                           BindingResult result,
                           RedirectAttributes redirectAttributes,
                           Model model) {
        if (result.hasErrors()) {
            model.addAttribute("jobTypes", JobType.values());
            return "admin/jobs/create";
        }

        try {
            jobService.createJob(job);
            redirectAttributes.addFlashAttribute("success", "Job created successfully!");
            return "redirect:/admin/jobs/list";
        } catch (Exception e) {
            model.addAttribute("error", "Failed to create job: " + e.getMessage());
            model.addAttribute("jobTypes", JobType.values());
            return "admin/jobs/create";
        }
    }

    @GetMapping("/jobs/edit/{id}")
    public String editJobForm(@PathVariable Long id, Model model, RedirectAttributes redirectAttributes) {
        Optional<Job> jobOpt = jobService.findById(id);
        if (jobOpt.isPresent()) {
            model.addAttribute("job", jobOpt.get());
            model.addAttribute("jobTypes", JobType.values());
            return "admin/jobs/edit";
        } else {
            redirectAttributes.addFlashAttribute("error", "Job not found!");
            return "redirect:/admin/jobs/list";
        }
    }

    @PostMapping("/jobs/edit/{id}")
    public String editJob(@PathVariable Long id,
                         @Valid @ModelAttribute("job") Job job,
                         BindingResult result,
                         RedirectAttributes redirectAttributes,
                         Model model) {
        if (result.hasErrors()) {
            model.addAttribute("jobTypes", JobType.values());
            return "admin/jobs/edit";
        }

        try {
            job.setId(id);
            jobService.updateJob(job);
            redirectAttributes.addFlashAttribute("success", "Job updated successfully!");
            return "redirect:/admin/jobs/list";
        } catch (Exception e) {
            model.addAttribute("error", "Failed to update job: " + e.getMessage());
            model.addAttribute("jobTypes", JobType.values());
            return "admin/jobs/edit";
        }
    }

    @PostMapping("/jobs/delete/{id}")
    public String deleteJob(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            jobService.deleteJob(id);
            redirectAttributes.addFlashAttribute("success", "Job deleted successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to delete job: " + e.getMessage());
        }
        return "redirect:/admin/jobs/list";
    }

    @PostMapping("/jobs/toggle/{id}")
    public String toggleJobStatus(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            jobService.toggleJobStatus(id);
            redirectAttributes.addFlashAttribute("success", "Job status updated successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to update job status: " + e.getMessage());
        }
        return "redirect:/admin/jobs/list";
    }

    // User Management
    @GetMapping("/users")
    public String listUsers(Model model) {
        model.addAttribute("users", userService.getAllUsers());
        return "admin/users/list";
    }

    @PostMapping("/users/toggle/{id}")
    public String toggleUserStatus(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            userService.toggleUserStatus(id);
            redirectAttributes.addFlashAttribute("success", "User status updated successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to update user status: " + e.getMessage());
        }
        return "redirect:/admin/users";
    }

    @GetMapping("/users/create")
    public String createUserForm(Model model) {
        model.addAttribute("user", new User());
        model.addAttribute("roles", Role.values());
        return "admin/users/create";
    }

    @PostMapping("/users/create")
    public String createUser(@Valid @ModelAttribute("user") User user,
                            BindingResult result,
                            RedirectAttributes redirectAttributes,
                            Model model) {
        if (result.hasErrors()) {
            model.addAttribute("roles", Role.values());
            return "admin/users/create";
        }

        try {
            userService.createUser(user);
            redirectAttributes.addFlashAttribute("success", "User created successfully!");
            return "redirect:/admin/users";
        } catch (Exception e) {
            model.addAttribute("error", "Failed to create user: " + e.getMessage());
            model.addAttribute("roles", Role.values());
            return "admin/users/create";
        }
    }

    @GetMapping("/users/edit/{id}")
    public String editUserForm(@PathVariable Long id, Model model, RedirectAttributes redirectAttributes) {
        Optional<User> userOpt = userService.findById(id);
        if (userOpt.isPresent()) {
            model.addAttribute("user", userOpt.get());
            model.addAttribute("roles", Role.values());
            return "admin/users/edit";
        } else {
            redirectAttributes.addFlashAttribute("error", "User not found!");
            return "redirect:/admin/users";
        }
    }

    @PostMapping("/users/edit/{id}")
    public String editUser(@PathVariable Long id,
                          @Valid @ModelAttribute("user") User user,
                          BindingResult result,
                          RedirectAttributes redirectAttributes,
                          Model model) {
        if (result.hasErrors()) {
            model.addAttribute("roles", Role.values());
            return "admin/users/edit";
        }

        try {
            user.setId(id);
            userService.updateUser(user);
            redirectAttributes.addFlashAttribute("success", "User updated successfully!");
            return "redirect:/admin/users";
        } catch (Exception e) {
            model.addAttribute("error", "Failed to update user: " + e.getMessage());
            model.addAttribute("roles", Role.values());
            return "admin/users/edit";
        }
    }

    @PostMapping("/users/delete/{id}")
    public String deleteUser(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            userService.deleteUser(id);
            redirectAttributes.addFlashAttribute("success", "User deleted successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to delete user: " + e.getMessage());
        }
        return "redirect:/admin/users";
    }

    // CV Management
    @GetMapping("/cvs")
    public String listCVs(Model model) {
        model.addAttribute("cvs", cvService.getAllCVs());
        return "admin/cvs/list";
    }

    @GetMapping("/cvs/review/{id}")
    public String reviewCV(@PathVariable Long id, Model model, RedirectAttributes redirectAttributes) {
        try {
            model.addAttribute("cv", cvService.findById(id));
            return "admin/cvs/review";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "CV not found!");
            return "redirect:/admin/cvs";
        }
    }

    @PostMapping("/cvs/review/{id}")
    public String submitCVReview(@PathVariable Long id,
                                @RequestParam String status,
                                @RequestParam(required = false) String feedback,
                                RedirectAttributes redirectAttributes) {
        try {
            cvService.reviewCV(id, status, feedback);
            redirectAttributes.addFlashAttribute("success", "CV review submitted successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to submit review: " + e.getMessage());
        }
        return "redirect:/admin/cvs";
    }

    // Job Management - additional endpoints
    @GetMapping("/jobs")
    public String manageJobs(Model model) {
        model.addAttribute("jobs", jobService.getAllJobs());
        return "admin/jobs/list";
    }

    @GetMapping("/jobs/new")
    public String newJobForm(Model model) {
        model.addAttribute("job", new Job());
        model.addAttribute("jobTypes", JobType.values());
        return "admin/jobs/create";
    }

    // Reports
    @GetMapping("/reports")
    public String reports(Model model) {
        model.addAttribute("totalUsers", userService.getTotalUserCount());
        model.addAttribute("totalJobs", jobService.getTotalJobCount());
        model.addAttribute("totalCVs", cvService.getTotalCVCount());
        model.addAttribute("activeJobs", jobService.getActiveJobCount());
        model.addAttribute("pendingCVs", cvService.getPendingCVCount());
        model.addAttribute("approvedCVs", cvService.getApprovedCVCount());
        model.addAttribute("rejectedCVs", cvService.getRejectedCVCount());
        model.addAttribute("usersByRole", userService.getUsersByRole());
        model.addAttribute("jobsByCategory", jobService.getJobsByCategory());
        model.addAttribute("cvsByStatus", cvService.getCVsByStatus());
        return "admin/reports";
    }

    // Settings
    @GetMapping("/settings")
    public String settings(Model model) {
        return "admin/settings";
    }

    @PostMapping("/settings")
    public String updateSettings(@RequestParam("siteName") String siteName,
                                @RequestParam("adminEmail") String adminEmail,
                                @RequestParam("maxFileSize") String maxFileSize,
                                RedirectAttributes redirectAttributes) {
        try {
            // TODO: Implement settings update logic
            redirectAttributes.addFlashAttribute("success", "Settings updated successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to update settings: " + e.getMessage());
        }
        return "redirect:/admin/settings";
    }
}