<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CV Reviews - HireZa Counselor</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="/css/custom.css" rel="stylesheet">
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-success">
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
                        <a class="nav-link" href="/counselor/dashboard">
                            <i class="fas fa-tachometer-alt me-1"></i>Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="/counselor/cv-reviews">
                            <i class="fas fa-file-text me-1"></i>CV Reviews
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/counselor/suggestions">
                            <i class="fas fa-lightbulb me-1"></i>Job Suggestions
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/counselor/messages">
                            <i class="fas fa-comments me-1"></i>Messages
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/counselor/sessions">
                            <i class="fas fa-calendar-alt me-1"></i>Sessions
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
        <!-- Header -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h1 class="h3 mb-0">
                <i class="fas fa-file-text text-success me-2"></i>
                CV Reviews
            </h1>
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

        <!-- Status Filter -->
        <div class="card shadow mb-4">
            <div class="card-header py-3">
                <h6 class="m-0 font-weight-bold text-success">Filter CVs by Status</h6>
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-12">
                        <div class="btn-group" role="group" aria-label="CV Status Filter">
                            <a href="/counselor/cv-reviews?status=SUBMITTED" 
                               class="btn ${currentStatus == 'SUBMITTED' ? 'btn-success' : 'btn-outline-success'}">
                                <i class="fas fa-clock me-1"></i>Pending Review
                            </a>
                            <a href="/counselor/cv-reviews?status=UNDER_REVIEW" 
                               class="btn ${currentStatus == 'UNDER_REVIEW' ? 'btn-success' : 'btn-outline-success'}">
                                <i class="fas fa-eye me-1"></i>Under Review
                            </a>
                            <a href="/counselor/cv-reviews?status=ACCEPTED" 
                               class="btn ${currentStatus == 'ACCEPTED' ? 'btn-success' : 'btn-outline-success'}">
                                <i class="fas fa-check me-1"></i>Approved
                            </a>
                            <a href="/counselor/cv-reviews?status=REJECTED" 
                               class="btn ${currentStatus == 'REJECTED' ? 'btn-success' : 'btn-outline-success'}">
                                <i class="fas fa-times me-1"></i>Rejected
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- CVs List -->
        <div class="card shadow">
            <div class="card-header py-3">
                <h6 class="m-0 font-weight-bold text-success">
                    CVs - ${currentStatus} Status
                    <span class="badge bg-secondary ms-2">${cvs.size()} CVs found</span>
                </h6>
            </div>
            <div class="card-body">
                <c:choose>
                    <c:when test="${not empty cvs}">
                        <div class="row">
                            <c:forEach var="cv" items="${cvs}">
                                <div class="col-lg-6 col-xl-4 mb-4">
                                    <div class="card h-100 shadow-sm">
                                        <div class="card-header">
                                            <div class="d-flex justify-content-between align-items-center">
                                                <h6 class="mb-0 text-primary">
                                                    <i class="fas fa-user me-1"></i>
                                                    ${cv.user.fullName}
                                                </h6>
                                                <c:choose>
                                                    <c:when test="${cv.status == 'SUBMITTED'}">
                                                        <span class="badge bg-warning text-dark">
                                                            <i class="fas fa-clock me-1"></i>Pending
                                                        </span>
                                                    </c:when>
                                                    <c:when test="${cv.status == 'UNDER_REVIEW'}">
                                                        <span class="badge bg-info">
                                                            <i class="fas fa-eye me-1"></i>Under Review
                                                        </span>
                                                    </c:when>
                                                    <c:when test="${cv.status == 'ACCEPTED'}">
                                                        <span class="badge bg-success">
                                                            <i class="fas fa-check me-1"></i>Approved
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-danger">
                                                            <i class="fas fa-times me-1"></i>Rejected
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                        <div class="card-body">
                                            <div class="mb-2">
                                                <strong><i class="fas fa-file me-1"></i>File:</strong><br>
                                                <small class="text-muted">${cv.fileName}</small>
                                            </div>
                                            
                                            <div class="mb-2">
                                                <strong><i class="fas fa-envelope me-1"></i>Email:</strong><br>
                                                <small class="text-muted">${cv.user.email}</small>
                                            </div>
                                            
                                            <div class="mb-2">
                                                <strong><i class="fas fa-calendar me-1"></i>Submitted:</strong><br>
                                                <small class="text-muted">${cv.submittedAt}</small>
                                            </div>
                                            
                                            <c:if test="${not empty cv.coverLetter}">
                                                <div class="mb-2">
                                                    <strong><i class="fas fa-comment me-1"></i>Cover Letter:</strong><br>
                                                    <small class="text-muted">
                                                        ${cv.coverLetter.length() > 100 ? cv.coverLetter.substring(0, 100).concat('...') : cv.coverLetter}
                                                    </small>
                                                </div>
                                            </c:if>
                                            
                                            <c:if test="${not empty cv.feedback}">
                                                <div class="mb-2">
                                                    <strong><i class="fas fa-comment-dots me-1"></i>Previous Feedback:</strong><br>
                                                    <small class="text-muted">
                                                        ${cv.feedback.length() > 100 ? cv.feedback.substring(0, 100).concat('...') : cv.feedback}
                                                    </small>
                                                </div>
                                            </c:if>
                                        </div>
                                        <div class="card-footer">
                                            <div class="d-grid gap-2">
                                                <a href="/counselor/cv/${cv.id}/review" class="btn btn-success btn-sm">
                                                    <i class="fas fa-eye me-1"></i>Review CV
                                                </a>
                                                <a href="/admin/cvs/${cv.id}/download" class="btn btn-outline-info btn-sm" target="_blank">
                                                    <i class="fas fa-download me-1"></i>Download CV
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="text-center py-5">
                            <i class="fas fa-file-text fa-3x text-muted mb-3"></i>
                            <h5 class="text-muted">No CVs Found</h5>
                            <p class="text-muted">There are no CVs with ${currentStatus} status at this time.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>