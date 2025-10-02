package com.hireza.jobportal.service;

import com.hireza.jobportal.model.CV;
import com.hireza.jobportal.model.CVStatus;
import com.hireza.jobportal.model.User;
import com.hireza.jobportal.repository.CVRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
@Transactional
public class CVService {

    @Autowired
    private CVRepository cvRepository;

    @Value("${app.upload.dir:uploads/cvs/}")
    private String uploadDir;

    private static final List<String> ALLOWED_CONTENT_TYPES = Arrays.asList(
            "application/pdf",
            "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
            "application/msword"
    );

    public CV uploadCV(MultipartFile file, User user) throws IOException {
        // Validate file
        if (file.isEmpty()) {
            throw new RuntimeException("Please select a file to upload");
        }

        if (!ALLOWED_CONTENT_TYPES.contains(file.getContentType())) {
            throw new RuntimeException("Only PDF and Word documents are allowed");
        }

        // Create upload directory if it doesn't exist
        Path uploadPath = Paths.get(uploadDir);
        if (!Files.exists(uploadPath)) {
            Files.createDirectories(uploadPath);
        }

        // Generate unique filename
        String originalFilename = file.getOriginalFilename();
        String extension = "";
        if (originalFilename != null && originalFilename.contains(".")) {
            extension = originalFilename.substring(originalFilename.lastIndexOf("."));
        }
        String uniqueFilename = UUID.randomUUID().toString() + extension;

        // Save file
        Path filePath = uploadPath.resolve(uniqueFilename);
        Files.copy(file.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);

        // Create CV entity
        CV cv = new CV();
        cv.setFileName(file.getOriginalFilename());
        cv.setFilePath(filePath.toString());
        cv.setFileSize(file.getSize());
        cv.setContentType(file.getContentType());
        cv.setUser(user);
        cv.setStatus(CVStatus.SUBMITTED);

        return cvRepository.save(cv);
    }

    public CV uploadCV(MultipartFile file, User user, String coverLetter) throws IOException {
        // Validate file
        if (file.isEmpty()) {
            throw new RuntimeException("Please select a file to upload");
        }

        if (!ALLOWED_CONTENT_TYPES.contains(file.getContentType())) {
            throw new RuntimeException("Only PDF and Word documents are allowed");
        }

        // Create upload directory if it doesn't exist
        Path uploadPath = Paths.get(uploadDir);
        if (!Files.exists(uploadPath)) {
            Files.createDirectories(uploadPath);
        }

        // Generate unique filename
        String originalFilename = file.getOriginalFilename();
        String extension = "";
        if (originalFilename != null && originalFilename.contains(".")) {
            extension = originalFilename.substring(originalFilename.lastIndexOf("."));
        }
        String uniqueFilename = UUID.randomUUID().toString() + extension;

        // Save file
        Path filePath = uploadPath.resolve(uniqueFilename);
        Files.copy(file.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);

        // Create CV entity
        CV cv = new CV();
        cv.setFileName(file.getOriginalFilename());
        cv.setFilePath(filePath.toString());
        cv.setFileSize(file.getSize());
        cv.setContentType(file.getContentType());
        cv.setUser(user);
        cv.setStatus(CVStatus.SUBMITTED);
        if (coverLetter != null && !coverLetter.trim().isEmpty()) {
            cv.setCoverLetter(coverLetter);
        }

        return cvRepository.save(cv);
    }

    public List<CV> getCVsByUser(User user) {
        return cvRepository.findByUserOrderBySubmittedAtDesc(user);
    }

    public List<CV> getCVsByStatus(CVStatus status) {
        return cvRepository.findByStatusOrderBySubmittedAtDesc(status);
    }

    public List<CV> getPendingCVs() {
        List<CVStatus> pendingStatuses = Arrays.asList(CVStatus.SUBMITTED, CVStatus.UNDER_REVIEW);
        return cvRepository.findByStatusInOrderBySubmittedAtDesc(pendingStatuses);
    }

    public Optional<CV> findById(Long id) {
        return cvRepository.findById(id);
    }

    public Optional<CV> findByUserAndId(User user, Long id) {
        return cvRepository.findByUserAndId(user, id);
    }

    public CV updateCVStatus(Long cvId, CVStatus status, String feedback, User reviewedBy) {
        Optional<CV> cvOpt = cvRepository.findById(cvId);
        if (cvOpt.isPresent()) {
            CV cv = cvOpt.get();
            cv.setStatus(status);
            cv.setFeedback(feedback);
            cv.setReviewedBy(reviewedBy);
            cv.setReviewedAt(LocalDateTime.now());
            return cvRepository.save(cv);
        }
        throw new RuntimeException("CV not found");
    }

    public long getCVCountByStatus(CVStatus status) {
        return cvRepository.countByStatus(status);
    }

    public List<CV> getCVsReviewedBy(User counselor) {
        return cvRepository.findByReviewedByOrderByReviewedAtDesc(counselor);
    }

    public boolean hasUserSubmittedCV(User user) {
        return cvRepository.existsByUserAndStatus(user, CVStatus.SUBMITTED) ||
               cvRepository.existsByUserAndStatus(user, CVStatus.UNDER_REVIEW);
    }

    public void deleteCV(Long id) throws IOException {
        Optional<CV> cvOpt = cvRepository.findById(id);
        if (cvOpt.isPresent()) {
            CV cv = cvOpt.get();
            // Delete file from filesystem
            Path filePath = Paths.get(cv.getFilePath());
            if (Files.exists(filePath)) {
                Files.delete(filePath);
            }
            // Delete from database
            cvRepository.deleteById(id);
        }
    }

    // Admin methods
    public List<CV> getAllCVs() {
        return cvRepository.findAllByOrderBySubmittedAtDesc();
    }

    public long getTotalCVCount() {
        return cvRepository.count();
    }

    public long getPendingCVCount() {
        return cvRepository.countByStatus(CVStatus.SUBMITTED) + 
               cvRepository.countByStatus(CVStatus.UNDER_REVIEW);
    }

    public long getApprovedCVCount() {
        return cvRepository.countByStatus(CVStatus.ACCEPTED);
    }

    public long getRejectedCVCount() {
        return cvRepository.countByStatus(CVStatus.REJECTED);
    }

    public void reviewCV(Long id, String status, String feedback) {
        Optional<CV> cvOpt = cvRepository.findById(id);
        if (cvOpt.isPresent()) {
            CV cv = cvOpt.get();
            cv.setStatus(CVStatus.valueOf(status));
            cv.setFeedback(feedback);
            cv.setReviewedAt(LocalDateTime.now());
            cvRepository.save(cv);
        } else {
            throw new RuntimeException("CV not found");
        }
    }

    public java.util.Map<CVStatus, Long> getCVsByStatus() {
        java.util.Map<CVStatus, Long> statusMap = new java.util.HashMap<>();
        statusMap.put(CVStatus.SUBMITTED, cvRepository.countByStatus(CVStatus.SUBMITTED));
        statusMap.put(CVStatus.UNDER_REVIEW, cvRepository.countByStatus(CVStatus.UNDER_REVIEW));
        statusMap.put(CVStatus.ACCEPTED, cvRepository.countByStatus(CVStatus.ACCEPTED));
        statusMap.put(CVStatus.REJECTED, cvRepository.countByStatus(CVStatus.REJECTED));
        return statusMap;
    }

    public void deleteCV(CV cv) {
        // Delete the physical file
        try {
            Path filePath = Paths.get(cv.getFilePath());
            if (Files.exists(filePath)) {
                Files.delete(filePath);
            }
        } catch (IOException e) {
            // Log the error but continue with database deletion
            System.err.println("Failed to delete physical file: " + e.getMessage());
        }
        
        // Delete from database
        cvRepository.delete(cv);
    }

    public boolean hasUserApprovedCV(User user) {
        return cvRepository.existsByUserAndStatus(user, CVStatus.ACCEPTED);
    }

    // Counselor-specific methods
    public Optional<CV> getCVById(Long id) {
        return cvRepository.findById(id);
    }

    public void approveCV(Long id, User counselor, String feedback) {
        Optional<CV> cvOpt = cvRepository.findById(id);
        if (cvOpt.isPresent()) {
            CV cv = cvOpt.get();
            cv.setStatus(CVStatus.ACCEPTED);
            cv.setFeedback(feedback);
            cv.setReviewedAt(LocalDateTime.now());
            cv.setReviewedBy(counselor);
            cvRepository.save(cv);
        } else {
            throw new RuntimeException("CV not found");
        }
    }

    public void rejectCV(Long id, User counselor, String feedback) {
        Optional<CV> cvOpt = cvRepository.findById(id);
        if (cvOpt.isPresent()) {
            CV cv = cvOpt.get();
            cv.setStatus(CVStatus.REJECTED);
            cv.setFeedback(feedback);
            cv.setReviewedAt(LocalDateTime.now());
            cv.setReviewedBy(counselor);
            cvRepository.save(cv);
        } else {
            throw new RuntimeException("CV not found");
        }
    }

    public void requestCVChanges(Long id, User counselor, String feedback) {
        Optional<CV> cvOpt = cvRepository.findById(id);
        if (cvOpt.isPresent()) {
            CV cv = cvOpt.get();
            cv.setStatus(CVStatus.REJECTED);
            cv.setFeedback("Changes Requested: " + feedback);
            cv.setReviewedAt(LocalDateTime.now());
            cv.setReviewedBy(counselor);
            cvRepository.save(cv);
        } else {
            throw new RuntimeException("CV not found");
        }
    }
}