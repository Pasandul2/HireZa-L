<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Job Suggestions - HireZa</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="/css/custom.css" rel="stylesheet">
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container">
            <a class="navbar-brand" href="/">
                <i class="fas fa-briefcase me-2"></i>HireZa
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="/user/dashboard">
                            <i class="fas fa-tachometer-alt me-1"></i>Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/user/jobs">
                            <i class="fas fa-briefcase me-1"></i>Browse Jobs
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/user/cv">
                            <i class="fas fa-file-text me-1"></i>My CV
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/user/messages">
                            <i class="fas fa-envelope me-1"></i>Messages
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="/user/suggestions">
                            <i class="fas fa-lightbulb me-1"></i>Job Suggestions
                            <c:if test="${totalSuggestions > 0}">
                                <span class="badge bg-success">${totalSuggestions}</span>
                            </c:if>
                        </a>
                    </li>
                </ul>
                <ul class="navbar-nav">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown">
                            <i class="fas fa-user me-1"></i>
                            <sec:authentication property="principal.username" />
                        </a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="/profile"><i class="fas fa-user me-2"></i>Profile</a></li>
                            <li><a class="dropdown-item" href="/settings"><i class="fas fa-cog me-2"></i>Settings</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li>
                                <form action="/logout" method="post" class="d-inline">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                    <button type="submit" class="dropdown-item">
                                        <i class="fas fa-sign-out-alt me-2"></i>Logout
                                    </button>
                                </form>
                            </li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container mt-4">
        <!-- Flash Messages -->
        <c:if test="${not empty success}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="fas fa-check-circle me-2"></i>${success}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fas fa-exclamation-circle me-2"></i>${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <!-- Page Header -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h1 class="h3 mb-0 text-gray-800">Job Suggestions</h1>
                <p class="text-muted">Jobs recommended by your career counselors</p>
            </div>
            <div class="text-end">
                <span class="badge bg-primary">${totalSuggestions} suggestions</span>
            </div>
        </div>

        <!-- Job Suggestions -->
        <c:choose>
            <c:when test="${empty suggestions}">
                <div class="card">
                    <div class="card-body text-center py-5">
                        <i class="fas fa-lightbulb fa-3x text-muted mb-3"></i>
                        <h5 class="text-muted">No job suggestions yet</h5>
                        <p class="text-muted">Your career counselors will suggest jobs that match your profile and interests.</p>
                        <a href="/user/jobs" class="btn btn-primary">
                            <i class="fas fa-briefcase me-2"></i>Browse Available Jobs
                        </a>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <div class="row">
                    <c:forEach var="suggestion" items="${suggestions}">
                        <div class="col-lg-6 col-xl-4 mb-4">
                            <div class="card h-100 shadow-sm">
                                <div class="card-body">
                                    <!-- Job Title -->
                                    <h5 class="card-title text-primary mb-2">
                                        <i class="fas fa-briefcase me-2"></i>
                                        ${suggestion.job.title}
                                    </h5>
                                    
                                    <!-- Company Info -->
                                    <div class="mb-2">
                                        <c:if test="${not empty suggestion.job.company}">
                                            <span class="badge bg-light text-dark">
                                                <i class="fas fa-building me-1"></i>${suggestion.job.company}
                                            </span>
                                        </c:if>
                                        <c:if test="${not empty suggestion.job.location}">
                                            <span class="badge bg-light text-dark">
                                                <i class="fas fa-map-marker-alt me-1"></i>${suggestion.job.location}
                                            </span>
                                        </c:if>
                                        <span class="badge bg-info">
                                            ${suggestion.job.jobType}
                                        </span>
                                    </div>
                                    
                                    <!-- Job Description -->
                                    <p class="card-text text-muted mb-3">
                                        <c:choose>
                                            <c:when test="${suggestion.job.description.length() > 150}">
                                                ${suggestion.job.description.substring(0, 150)}...
                                            </c:when>
                                            <c:otherwise>
                                                ${suggestion.job.description}
                                            </c:otherwise>
                                        </c:choose>
                                    </p>
                                    
                                    <!-- Counselor Message -->
                                    <div class="bg-light p-3 rounded mb-3">
                                        <h6 class="text-primary mb-2">
                                            <i class="fas fa-user-tie me-2"></i>
                                            Counselor's Note:
                                        </h6>
                                        <p class="mb-1 text-dark">${suggestion.message}</p>
                                        <small class="text-muted">
                                            - ${suggestion.counselor.fullName} on ${suggestion.suggestedAt}
                                        </small>
                                    </div>
                                    
                                    <!-- Requirements -->
                                    <c:if test="${not empty suggestion.job.requirements}">
                                        <div class="mb-3">
                                            <h6 class="text-secondary">Requirements:</h6>
                                            <p class="small text-muted">
                                                <c:choose>
                                                    <c:when test="${suggestion.job.requirements.length() > 100}">
                                                        ${suggestion.job.requirements.substring(0, 100)}...
                                                    </c:when>
                                                    <c:otherwise>
                                                        ${suggestion.job.requirements}
                                                    </c:otherwise>
                                                </c:choose>
                                            </p>
                                        </div>
                                    </c:if>
                                    
                                    <!-- Salary Range -->
                                    <c:if test="${not empty suggestion.job.salaryRange}">
                                        <div class="mb-3">
                                            <span class="badge bg-success">
                                                <i class="fas fa-dollar-sign me-1"></i>${suggestion.job.salaryRange}
                                            </span>
                                        </div>
                                    </c:if>
                                </div>
                                
                                <div class="card-footer">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <small class="text-muted">
                                            Suggested ${suggestion.suggestedAt}
                                        </small>
                                        <div>
                                            <a href="/jobs/${suggestion.job.id}" class="btn btn-outline-primary btn-sm me-2">
                                                <i class="fas fa-eye me-1"></i>View Details
                                            </a>
                                            <a href="/user/jobs/${suggestion.job.id}/apply" class="btn btn-primary btn-sm">
                                                <i class="fas fa-paper-plane me-1"></i>Apply Now
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>