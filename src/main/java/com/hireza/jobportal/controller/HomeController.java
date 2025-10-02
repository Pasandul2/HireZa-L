package com.hireza.jobportal.controller;

import com.hireza.jobportal.service.JobService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    @Autowired
    private JobService jobService;

    @GetMapping("/")
    public String home(Model model) {
        model.addAttribute("recentJobs", jobService.getActiveJobsOrderedByDate());
        model.addAttribute("categories", jobService.getAllCategories());
        model.addAttribute("totalJobs", jobService.getActiveJobCount());
        return "home";
    }

    @GetMapping("/home")
    public String homePage(Model model) {
        return home(model);
    }
}