package com.hireza.jobportal.service;

import com.hireza.jobportal.model.*;
import com.hireza.jobportal.repository.JobSuggestionRepository;
import com.hireza.jobportal.repository.MessageRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;

@Service
@Transactional
public class JobSuggestionService {

    @Autowired
    private JobSuggestionRepository jobSuggestionRepository;

    @Autowired
    private MessageRepository messageRepository;

    public JobSuggestion createSuggestion(User counselor, User user, Job job, String message) {
        // Create job suggestion
        JobSuggestion suggestion = new JobSuggestion();
        suggestion.setMessage(message);
        suggestion.setUser(user);
        suggestion.setJob(job);
        suggestion.setCounselor(counselor);
        suggestion.setSuggestedAt(LocalDateTime.now());
        
        JobSuggestion savedSuggestion = jobSuggestionRepository.save(suggestion);
        
        // Create notification message for the user
        Message notification = new Message();
        notification.setSubject("New Job Suggestion from " + counselor.getFullName());
        notification.setContent(String.format(
            "You have received a new job suggestion:\n\n" +
            "Job Title: %s\n" +
            "Company: %s\n" +
            "Location: %s\n" +
            "Job Type: %s\n\n" +
            "Counselor's Message:\n%s\n\n" +
            "You can view the full job details in your dashboard.",
            job.getTitle(),
            job.getCompany() != null ? job.getCompany() : "Not specified",
            job.getLocation() != null ? job.getLocation() : "Not specified",
            job.getJobType().name(),
            message
        ));
        notification.setMessageType(MessageType.JOB_SUGGESTION);
        notification.setSender(counselor);
        notification.setUser(user);
        notification.setSentAt(LocalDateTime.now());
        notification.setIsRead(false);
        
        messageRepository.save(notification);
        
        return savedSuggestion;
    }

    public List<JobSuggestion> getSuggestionsByCounselor(User counselor) {
        return jobSuggestionRepository.findByCounselorOrderBySuggestedAtDesc(counselor);
    }

    public List<JobSuggestion> getSuggestionsByUser(User user) {
        return jobSuggestionRepository.findByUserOrderBySuggestedAtDesc(user);
    }

    public List<JobSuggestion> getAllSuggestions() {
        return jobSuggestionRepository.findAllByOrderBySuggestedAtDesc();
    }

    public long getTotalSuggestionCount() {
        return jobSuggestionRepository.count();
    }

    public long getSuggestionCountByCounselor(User counselor) {
        return jobSuggestionRepository.countByCounselor(counselor);
    }

    public long getSuggestionCountByUser(User user) {
        return jobSuggestionRepository.countByUser(user);
    }
}