<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Applications - HireZa</title>
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
                            <i class="fas fa-search me-1"></i>Browse Jobs
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/user/cv">
                            <i class="fas fa-file-text me-1"></i>My CVs
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="/user/applications">
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
                <!-- Header -->
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h1 class="h3 mb-0">
                        <i class="fas fa-paper-plane text-primary me-2"></i>
                        My Job Applications
                    </h1>
                    <a href="/user/jobs" class="btn btn-primary">
                        <i class="fas fa-search me-2"></i>Browse Jobs
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

                <!-- Statistics Cards -->
                <div class="row mb-4">
                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card border-left-primary shadow h-100 py-2">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                            Total Applications
                                        </div>
                                        <div class="h5 mb-0 font-weight-bold text-gray-800">${totalApplications}</div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-paper-plane fa-2x text-gray-300"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card border-left-warning shadow h-100 py-2">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">
                                            Pending Review
                                        </div>
                                        <div class="h5 mb-0 font-weight-bold text-gray-800">${pendingApplications}</div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-clock fa-2x text-gray-300"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card border-left-success shadow h-100 py-2">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-xs font-weight-bold text-success text-uppercase mb-1">
                                            Accepted
                                        </div>
                                        <div class="h5 mb-0 font-weight-bold text-gray-800">${acceptedApplications}</div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-check-circle fa-2x text-gray-300"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card border-left-danger shadow h-100 py-2">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-xs font-weight-bold text-danger text-uppercase mb-1">
                                            Rejected
                                        </div>
                                        <div class="h5 mb-0 font-weight-bold text-gray-800">${rejectedApplications}</div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-times-circle fa-2x text-gray-300"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Applications List -->
                <c:choose>
                    <c:when test="${empty applications}">
                        <!-- No Applications Yet -->
                        <div class="card shadow">
                            <div class="card-body text-center py-5">
                                <i class="fas fa-paper-plane fa-4x text-muted mb-3"></i>
                                <h4 class="text-muted">No Applications Yet</h4>
                                <p class="text-muted mb-4">
                                    You haven't applied for any jobs yet. Start browsing available positions and apply for jobs that match your skills.
                                </p>
                                
                                <div class="row justify-content-center">
                                    <div class="col-md-8">
                                        <div class="alert alert-info">
                                            <h6 class="alert-heading">
                                                <i class="fas fa-info-circle me-2"></i>Before You Apply
                                            </h6>
                                            <ul class="mb-0 text-start">
                                                <li>Make sure you have an approved CV</li>
                                                <li>Read job descriptions carefully</li>
                                                <li>Check if you meet the requirements</li>
                                                <li>Tailor your application to each position</li>
                                                <li>Follow up on your applications</li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="d-flex justify-content-center gap-3">
                                    <a href="/user/jobs" class="btn btn-primary btn-lg">
                                        <i class="fas fa-search me-2"></i>Browse Available Jobs
                                    </a>
                                    <a href="/user/cv" class="btn btn-outline-secondary btn-lg">
                                        <i class="fas fa-file-text me-2"></i>Manage My CVs
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <!-- Applications Table -->
                        <div class="card shadow">
                            <div class="card-header py-3">
                                <h6 class="m-0 font-weight-bold text-primary">
                                    Applications History
                                    <span class="badge bg-secondary ms-2">${applications.size()} applications</span>
                                </h6>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-bordered table-hover">
                                        <thead class="table-primary">
                                            <tr>
                                                <th>Job Title</th>
                                                <th>Company</th>
                                                <th>Applied Date</th>
                                                <th>Status</th>
                                                <th>Last Updated</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="application" items="${applications}">
                                                <tr>
                                                    <td>
                                                        <strong>${application.job.title}</strong>
                                                        <br><small class="text-muted">${application.job.location}</small>
                                                    </td>
                                                    <td>${application.job.company}</td>
                                                    <td>
                                                        <fmt:formatDate value="${application.appliedDate}" pattern="MMM dd, yyyy" />
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${application.status == 'PENDING'}">
                                                                <span class="badge bg-warning text-dark">
                                                                    <i class="fas fa-clock me-1"></i>Pending
                                                                </span>
                                                            </c:when>
                                                            <c:when test="${application.status == 'UNDER_REVIEW'}">
                                                                <span class="badge bg-info">
                                                                    <i class="fas fa-eye me-1"></i>Under Review
                                                                </span>
                                                            </c:when>
                                                            <c:when test="${application.status == 'ACCEPTED'}">
                                                                <span class="badge bg-success">
                                                                    <i class="fas fa-check me-1"></i>Accepted
                                                                </span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="badge bg-danger">
                                                                    <i class="fas fa-times me-1"></i>Rejected
                                                                </span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <fmt:formatDate value="${application.lastUpdated}" pattern="MMM dd, yyyy" />
                                                    </td>
                                                    <td>
                                                        <div class="btn-group" role="group">
                                                            <a href="/user/job/${application.job.id}" class="btn btn-sm btn-outline-primary" 
                                                               title="View Job Details">
                                                                <i class="fas fa-eye"></i>
                                                            </a>
                                                            <a href="/user/applications/${application.id}" class="btn btn-sm btn-outline-info" 
                                                               title="View Application">
                                                                <i class="fas fa-file-text"></i>
                                                            </a>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>

                <!-- Quick Actions -->
                <div class="row mt-4">
                    <div class="col-md-6">
                        <div class="card shadow">
                            <div class="card-body text-center">
                                <i class="fas fa-search fa-2x text-primary mb-3"></i>
                                <h5 class="card-title">Find More Jobs</h5>
                                <p class="text-muted">Browse through our latest job postings and find opportunities that match your skills.</p>
                                <a href="/user/jobs" class="btn btn-primary">
                                    <i class="fas fa-search me-2"></i>Browse Jobs
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="card shadow">
                            <div class="card-body text-center">
                                <i class="fas fa-file-text fa-2x text-info mb-3"></i>
                                <h5 class="card-title">Update Your CV</h5>
                                <p class="text-muted">Keep your CV updated with latest skills and experience to increase your chances.</p>
                                <a href="/user/cv" class="btn btn-info">
                                    <i class="fas fa-file-text me-2"></i>Manage CVs
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <style>
        .border-left-primary {
            border-left: 0.25rem solid #4e73df !important;
        }
        
        .border-left-success {
            border-left: 0.25rem solid #1cc88a !important;
        }
        
        .border-left-warning {
            border-left: 0.25rem solid #f6c23e !important;
        }
        
        .border-left-danger {
            border-left: 0.25rem solid #e74a3b !important;
        }
    </style>
</body>
</html>