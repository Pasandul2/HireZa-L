package com.hireza.jobportal.service;

import com.hireza.jobportal.model.Job;
import com.hireza.jobportal.repository.JobRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class JobService {

    @Autowired
    private JobRepository jobRepository;

    public Job createJob(Job job) {
        return jobRepository.save(job);
    }

    public Job updateJob(Job job) {
        return jobRepository.save(job);
    }

    public Optional<Job> findById(Long id) {
        return jobRepository.findById(id);
    }

    public Optional<Job> getJobById(Long id) {
        return jobRepository.findById(id);
    }

    public List<Job> getAllJobs() {
        return jobRepository.findAll();
    }

    public List<Job> getActiveJobs() {
        return jobRepository.findByActiveTrue();
    }

    public List<Job> getActiveJobsOrderedByDate() {
        return jobRepository.findByActiveTrueOrderByCreatedAtDesc();
    }

    public List<Job> getJobsByCategory(String category) {
        return jobRepository.findByCategoryAndActiveTrue(category);
    }

    public List<String> getAllCategories() {
        return jobRepository.findDistinctCategories();
    }

    public List<Job> searchJobs(String keyword) {
        return jobRepository.searchActiveJobs(keyword);
    }

    public List<Job> searchJobsByCategory(String category, String keyword) {
        return jobRepository.searchActiveJobsByCategory(category, keyword);
    }

    public void deleteJob(Long id) {
        jobRepository.deleteById(id);
    }

    public void toggleJobStatus(Long id) {
        Optional<Job> jobOpt = jobRepository.findById(id);
        if (jobOpt.isPresent()) {
            Job job = jobOpt.get();
            job.setActive(!job.getActive());
            jobRepository.save(job);
        }
    }

    public long getActiveJobCount() {
        return jobRepository.countByActiveTrue();
    }

    // Admin methods
    public long getTotalJobCount() {
        return jobRepository.count();
    }

    public java.util.Map<String, Long> getJobsByCategory() {
        List<String> categories = getAllCategories();
        java.util.Map<String, Long> categoryMap = new java.util.HashMap<>();
        for (String category : categories) {
            categoryMap.put(category, jobRepository.countByCategoryAndActiveTrue(category));
        }
        return categoryMap;
    }
}