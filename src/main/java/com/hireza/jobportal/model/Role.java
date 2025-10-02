package com.hireza.jobportal.model;

public enum Role {
    USER("User"),
    COUNSELOR("Counselor"),
    ADMIN("Admin");
    
    private final String displayName;
    
    Role(String displayName) {
        this.displayName = displayName;
    }
    
    public String getDisplayName() {
        return displayName;
    }
}