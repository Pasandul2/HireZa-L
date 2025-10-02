<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Review CV - ${user.fullName} - HireZa Counselor</title>
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
        <div class="row">
            <div class="col-lg-8">
                <!-- Header -->
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h1 class="h3 mb-0">
                        <i class="fas fa-file-text text-success me-2"></i>
                        CV Review - ${user.fullName}
                    </h1>
                    <a href="/counselor/cv-reviews" class="btn btn-outline-secondary">
                        <i class="fas fa-arrow-left me-2"></i>Back to Reviews
                    </a>
                </div>

                <!-- CV Information -->
                <div class="card shadow mb-4">
                    <div class="card-header py-3">
                        <h6 class="m-0 font-weight-bold text-success">CV Information</h6>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <strong><i class="fas fa-user me-2"></i>Applicant:</strong><br>
                                    <span class="text-muted">${user.fullName}</span>
                                </div>
                                <div class="mb-3">
                                    <strong><i class="fas fa-envelope me-2"></i>Email:</strong><br>
                                    <span class="text-muted">${user.email}</span>
                                </div>
                                <c:if test="${not empty user.phone}">
                                    <div class="mb-3">
                                        <strong><i class="fas fa-phone me-2"></i>Phone:</strong><br>
                                        <span class="text-muted">${user.phone}</span>
                                    </div>
                                </c:if>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <strong><i class="fas fa-file me-2"></i>File Name:</strong><br>
                                    <span class="text-muted">${cv.fileName}</span>
                                </div>
                                <div class="mb-3">
                                    <strong><i class="fas fa-calendar me-2"></i>Submitted:</strong><br>
                                    <span class="text-muted">${cv.submittedAt}</span>
                                </div>
                                <div class="mb-3">
                                    <strong><i class="fas fa-info-circle me-2"></i>Status:</strong><br>
                                    <c:choose>
                                        <c:when test="${cv.status == 'SUBMITTED'}">
                                            <span class="badge bg-warning text-dark">
                                                <i class="fas fa-clock me-1"></i>Pending Review
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
                        </div>
                        
                        <!-- CV Actions -->
                        <div class="mt-3">
                            <a href="/admin/cvs/${cv.id}/download" class="btn btn-info" target="_blank">
                                <i class="fas fa-download me-2"></i>Download CV
                            </a>
                            <a href="/admin/cvs/${cv.id}/download" class="btn btn-outline-info" target="_blank">
                                <i class="fas fa-external-link-alt me-2"></i>View CV
                            </a>
                        </div>
                    </div>
                </div>

                <!-- Cover Letter -->
                <c:if test="${not empty cv.coverLetter}">
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-info">
                                <i class="fas fa-envelope me-2"></i>Cover Letter
                            </h6>
                        </div>
                        <div class="card-body">
                            <div class="card bg-light">
                                <div class="card-body">
                                    <p class="mb-0" style="white-space: pre-wrap;">${cv.coverLetter}</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:if>

                <!-- Previous Feedback -->
                <c:if test="${not empty cv.feedback}">
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-warning">
                                <i class="fas fa-comment-dots me-2"></i>Previous Feedback
                            </h6>
                        </div>
                        <div class="card-body">
                            <div class="alert alert-warning">
                                <p class="mb-0">${cv.feedback}</p>
                                <c:if test="${not empty cv.reviewedAt and not empty cv.reviewedBy}">
                                    <hr>
                                    <small class="text-muted">
                                        <i class="fas fa-user me-1"></i>Reviewed by: ${cv.reviewedBy.fullName}<br>
                                        <i class="fas fa-calendar me-1"></i>Date: ${cv.reviewedAt}
                                    </small>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </c:if>
            </div>

            <!-- Review Actions Panel -->
            <div class="col-lg-4">
                <div class="card shadow">
                    <div class="card-header py-3">
                        <h6 class="m-0 font-weight-bold text-success">
                            <i class="fas fa-clipboard-check me-2"></i>Review Actions
                        </h6>
                    </div>
                    <div class="card-body">
                        <form action="/counselor/cv/${cv.id}/review" method="post" id="reviewForm">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                            
                            <!-- Feedback -->
                            <div class="mb-3">
                                <label for="feedback" class="form-label">
                                    <i class="fas fa-comment me-1"></i>Feedback / Comments
                                </label>
                                <textarea class="form-control" 
                                          id="feedback" 
                                          name="feedback" 
                                          rows="6" 
                                          placeholder="Provide detailed feedback about the CV..."></textarea>
                                <div class="form-text">
                                    Provide constructive feedback to help the candidate improve their CV.
                                </div>
                            </div>

                            <!-- Review Actions -->
                            <div class="mb-3">
                                <label class="form-label">Action:</label>
                                <div class="d-grid gap-2">
                                    <button type="submit" name="action" value="approve" class="btn btn-success">
                                        <i class="fas fa-check me-2"></i>Approve CV
                                    </button>
                                    <button type="submit" name="action" value="reject" class="btn btn-danger">
                                        <i class="fas fa-times me-2"></i>Reject CV
                                    </button>
                                    <button type="submit" name="action" value="request_changes" class="btn btn-warning">
                                        <i class="fas fa-edit me-2"></i>Request Changes
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- Job Suggestion Panel -->
                <c:if test="${cv.status == 'ACCEPTED'}">
                    <div class="card shadow mt-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">
                                <i class="fas fa-lightbulb me-2"></i>Suggest Jobs
                            </h6>
                        </div>
                        <div class="card-body">
                            <p class="text-muted">Since this CV is approved, you can suggest relevant jobs to the candidate.</p>
                            <div class="d-grid">
                                <a href="/counselor/suggestions?userId=${user.id}" class="btn btn-primary">
                                    <i class="fas fa-paper-plane me-2"></i>Suggest Jobs
                                </a>
                            </div>
                        </div>
                    </div>
                </c:if>

                <!-- User History Panel -->
                <div class="card shadow mt-4">
                    <div class="card-header py-3">
                        <h6 class="m-0 font-weight-bold text-info">
                            <i class="fas fa-history me-2"></i>User Information
                        </h6>
                    </div>
                    <div class="card-body">
                        <div class="mb-2">
                            <strong>Full Name:</strong><br>
                            <small class="text-muted">${user.fullName}</small>
                        </div>
                        <div class="mb-2">
                            <strong>Email:</strong><br>
                            <small class="text-muted">${user.email}</small>
                        </div>
                        <c:if test="${not empty user.phone}">
                            <div class="mb-2">
                                <strong>Phone:</strong><br>
                                <small class="text-muted">${user.phone}</small>
                            </div>
                        </c:if>
                        <c:if test="${not empty user.address}">
                            <div class="mb-2">
                                <strong>Address:</strong><br>
                                <small class="text-muted">${user.address}</small>
                            </div>
                        </c:if>
                        <div class="mb-2">
                            <strong>Member Since:</strong><br>
                            <small class="text-muted">${user.createdAt}</small>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Form validation
        document.getElementById('reviewForm').addEventListener('submit', function(e) {
            const feedback = document.getElementById('feedback').value.trim();
            const action = e.submitter.value;
            
            if (action !== 'approve' && feedback === '') {
                e.preventDefault();
                alert('Please provide feedback when rejecting or requesting changes.');
                return;
            }
            
            // Confirmation dialogs
            let confirmMessage = '';
            if (action === 'approve') {
                confirmMessage = 'Are you sure you want to approve this CV?';
            } else if (action === 'reject') {
                confirmMessage = 'Are you sure you want to reject this CV?';
            } else if (action === 'request_changes') {
                confirmMessage = 'Are you sure you want to request changes to this CV?';
            }
            
            if (!confirm(confirmMessage)) {
                e.preventDefault();
            }
        });
    </script>
</body>
</html>