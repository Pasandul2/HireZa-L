<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${job.title} - HireZa</title>
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
                        <a class="nav-link active" href="/user/jobs">
                            <i class="fas fa-search me-1"></i>Browse Jobs
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/user/cv">
                            <i class="fas fa-file-text me-1"></i>My CVs
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/user/applications">
                            <i class="fas fa-paper-plane me-1"></i>My Applications
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
                            <li><a class="dropdown-item" href="/profile"><i class="fas fa-user-cog me-2"></i>Profile</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li>
                                <form action="/logout" method="post" style="display: inline;">
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
        <div class="row">
            <div class="col-12">
                <!-- Back Button -->
                <div class="mb-3">
                    <a href="/user/jobs" class="btn btn-outline-secondary">
                        <i class="fas fa-arrow-left me-2"></i>Back to Jobs
                    </a>
                </div>

                <!-- Flash Messages -->
                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-circle me-2"></i>${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
                <c:if test="${not empty success}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="fas fa-check-circle me-2"></i>${success}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <!-- Job Details Card -->
                <div class="card shadow">
                    <div class="card-header py-3">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h4 class="mb-1 text-primary">${job.title}</h4>
                                <p class="mb-0 text-muted">
                                    <i class="fas fa-building me-1"></i>${job.company}
                                    <span class="mx-2">•</span>
                                    <i class="fas fa-map-marker-alt me-1"></i>${job.location}
                                </p>
                            </div>
                            <div class="text-end">
                                <c:choose>
                                    <c:when test="${job.active}">
                                        <span class="badge bg-success fs-6">
                                            <i class="fas fa-check-circle me-1"></i>Active
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-secondary fs-6">
                                            <i class="fas fa-pause-circle me-1"></i>Inactive
                                        </span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                    <div class="card-body">
                        <!-- Job Meta Information -->
                        <div class="row mb-4">
                            <div class="col-md-3">
                                <div class="d-flex align-items-center">
                                    <i class="fas fa-tag text-primary me-2"></i>
                                    <div>
                                        <small class="text-muted d-block">Category</small>
                                        <strong>${job.category}</strong>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="d-flex align-items-center">
                                    <i class="fas fa-clock text-primary me-2"></i>
                                    <div>
                                        <small class="text-muted d-block">Job Type</small>
                                        <strong>
                                            <c:choose>
                                                <c:when test="${job.jobType == 'FULL_TIME'}">Full Time</c:when>
                                                <c:when test="${job.jobType == 'PART_TIME'}">Part Time</c:when>
                                                <c:when test="${job.jobType == 'CONTRACT'}">Contract</c:when>
                                                <c:when test="${job.jobType == 'FREELANCE'}">Freelance</c:when>
                                                <c:otherwise>Internship</c:otherwise>
                                            </c:choose>
                                        </strong>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="d-flex align-items-center">
                                    <i class="fas fa-dollar-sign text-primary me-2"></i>
                                    <div>
                                        <small class="text-muted d-block">Salary</small>
                                        <strong>
                                            <c:choose>
                                                <c:when test="${not empty job.salaryRange}">${job.salaryRange}</c:when>
                                                <c:otherwise>Negotiable</c:otherwise>
                                            </c:choose>
                                        </strong>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="d-flex align-items-center">
                                    <i class="fas fa-calendar text-primary me-2"></i>
                                    <div>
                                        <small class="text-muted d-block">Posted</small>
                                        <strong>
                                            ${job.createdAt}
                                        </strong>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Job Description -->
                        <div class="mb-4">
                            <h5 class="text-primary mb-3">
                                <i class="fas fa-info-circle me-2"></i>Job Description
                            </h5>
                            <div class="bg-light p-3 rounded">
                                <p class="mb-0" style="white-space: pre-line;">${job.description}</p>
                            </div>
                        </div>

                        <!-- Requirements -->
                        <c:if test="${not empty job.requirements}">
                            <div class="mb-4">
                                <h5 class="text-primary mb-3">
                                    <i class="fas fa-list-check me-2"></i>Requirements
                                </h5>
                                <div class="bg-light p-3 rounded">
                                    <p class="mb-0" style="white-space: pre-line;">${job.requirements}</p>
                                </div>
                            </div>
                        </c:if>

                        <!-- Benefits -->
                        <c:if test="${not empty job.benefits}">
                            <div class="mb-4">
                                <h5 class="text-primary mb-3">
                                    <i class="fas fa-gift me-2"></i>Benefits & Perks
                                </h5>
                                <div class="bg-light p-3 rounded">
                                    <p class="mb-0" style="white-space: pre-line;">${job.benefits}</p>
                                </div>
                            </div>
                        </c:if>

                        <!-- Apply Section -->
                        <c:if test="${job.active}">
                            <div class="text-center py-4 border-top">
                                <h5 class="mb-3">Ready to Apply?</h5>
                                <p class="text-muted mb-4">
                                    Make sure you have an approved CV before applying for this position.
                                </p>
                                <div class="d-flex justify-content-center gap-3">
                                    <form action="/user/job/${job.id}/apply" method="post" style="display: inline;">
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                        <button type="submit" class="btn btn-success btn-lg">
                                            <i class="fas fa-paper-plane me-2"></i>Apply Now
                                        </button>
                                    </form>
                                    <a href="/user/cv" class="btn btn-outline-info btn-lg">
                                        <i class="fas fa-file-text me-2"></i>Check My CVs
                                    </a>
                                </div>
                            </div>
                        </c:if>
                        <c:if test="${!job.active}">
                            <div class="text-center py-4 border-top">
                                <div class="alert alert-warning">
                                    <i class="fas fa-exclamation-triangle me-2"></i>
                                    This job posting is currently inactive and not accepting applications.
                                </div>
                            </div>
                        </c:if>
                    </div>
                </div>

                <!-- Similar Jobs Section -->
                <div class="card shadow mt-4">
                    <div class="card-header py-3">
                        <h5 class="mb-0 text-primary">
                            <i class="fas fa-search me-2"></i>More Jobs You Might Like
                        </h5>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="d-flex align-items-center">
                                    <i class="fas fa-tag fa-2x text-primary me-3"></i>
                                    <div>
                                        <h6 class="mb-1">Browse by Category</h6>
                                        <p class="text-muted mb-0">Find more jobs in ${job.category}</p>
                                    </div>
                                </div>
                                <div class="mt-2">
                                    <a href="/user/jobs?category=${job.category}" class="btn btn-outline-primary">
                                        <i class="fas fa-search me-2"></i>View ${job.category} Jobs
                                    </a>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="d-flex align-items-center">
                                    <i class="fas fa-building fa-2x text-info me-3"></i>
                                    <div>
                                        <h6 class="mb-1">Browse All Jobs</h6>
                                        <p class="text-muted mb-0">Explore all available opportunities</p>
                                    </div>
                                </div>
                                <div class="mt-2">
                                    <a href="/user/jobs" class="btn btn-outline-info">
                                        <i class="fas fa-list me-2"></i>View All Jobs
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>