package com.hireza.jobportal.model;

public enum CVStatus {
    SUBMITTED("Submitted"),
    UNDER_REVIEW("Under Review"),
    ACCEPTED("Accepted"),
    REJECTED("Rejected");
    
    private final String displayName;
    
    CVStatus(String displayName) {
        this.displayName = displayName;
    }
    
    public String getDisplayName() {
        return displayName;
    }
}