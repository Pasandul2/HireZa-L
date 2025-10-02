package com.hireza.jobportal.model;

public enum MessageType {
    GENERAL("General"),
    CV_ACCEPTED("CV Accepted"),
    CV_REJECTED("CV Rejected"),
    JOB_SUGGESTION("Job Suggestion"),
    SESSION_REMINDER("Session Reminder");
    
    private final String displayName;
    
    MessageType(String displayName) {
        this.displayName = displayName;
    }
    
    public String getDisplayName() {
        return displayName;
    }
}