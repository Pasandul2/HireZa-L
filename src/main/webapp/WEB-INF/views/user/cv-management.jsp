<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CV Management - HireZa</title>
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
                        <a class="nav-link active" href="/user/cv">
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
                <!-- Header -->
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h1 class="h3 mb-0">
                        <i class="fas fa-file-text text-primary me-2"></i>
                        My CVs
                    </h1>
                    <c:if test="${!hasSubmittedCV}">
                        <a href="/user/submit-cv" class="btn btn-primary">
                            <i class="fas fa-upload me-2"></i>Upload New CV
                        </a>
                    </c:if>
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

                <!-- CV Upload Instructions -->
                <c:if test="${empty cvs}">
                    <div class="card shadow mb-4">
                        <div class="card-body text-center py-5">
                            <i class="fas fa-file-upload fa-4x text-muted mb-3"></i>
                            <h4 class="text-muted">No CVs Uploaded Yet</h4>
                            <p class="text-muted mb-4">
                                Upload your CV to start applying for jobs. Our counselors will review it and provide feedback.
                            </p>
                            <div class="row justify-content-center">
                                <div class="col-md-8">
                                    <div class="alert alert-info">
                                        <h6 class="alert-heading">
                                            <i class="fas fa-info-circle me-2"></i>CV Guidelines
                                        </h6>
                                        <ul class="mb-0 text-start">
                                            <li>Accepted formats: PDF, DOC, DOCX</li>
                                            <li>Maximum file size: 5MB</li>
                                            <li>Include your contact information</li>
                                            <li>List your education and experience clearly</li>
                                            <li>Use professional language and formatting</li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <a href="/user/submit-cv" class="btn btn-primary btn-lg">
                                <i class="fas fa-upload me-2"></i>Upload Your First CV
                            </a>
                        </div>
                    </div>
                </c:if>

                <!-- CVs List -->
                <c:if test="${not empty cvs}">
                    <div class="row">
                        <c:forEach var="cv" items="${cvs}">
                            <div class="col-md-6 col-lg-4 mb-4">
                                <div class="card shadow h-100">
                                    <div class="card-body">
                                        <div class="d-flex justify-content-between align-items-start mb-3">
                                            <h5 class="card-title mb-0">
                                                <i class="fas fa-file-pdf text-danger me-2"></i>
                                                ${cv.fileName}
                                            </h5>
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

                                        <div class="mb-3">
                                            <small class="text-muted">
                                                <i class="fas fa-calendar me-1"></i>
                                                Uploaded: ${cv.submittedAt}
                                            </small>
                                        </div>

                                        <c:if test="${not empty cv.reviewedAt}">
                                            <div class="mb-3">
                                                <small class="text-muted">
                                                    <i class="fas fa-check-circle me-1"></i>
                                                    Reviewed: ${cv.reviewedAt}
                                                </small>
                                            </div>
                                        </c:if>

                        <c:if test="${not empty cv.coverLetter}">
                            <div class="mb-3">
                                <h6 class="text-info">
                                    <i class="fas fa-envelope me-1"></i>Cover Letter:
                                </h6>
                                <div class="card bg-light">
                                    <div class="card-body py-2">
                                        <p class="small mb-0" style="white-space: pre-wrap;">${cv.coverLetter}</p>
                                    </div>
                                </div>
                            </div>
                        </c:if>

                        <c:if test="${not empty cv.feedback}">
                            <div class="mb-3">
                                <h6 class="text-primary">
                                    <i class="fas fa-comment me-1"></i>Feedback:
                                </h6>
                                <p class="small text-muted">${cv.feedback}</p>
                            </div>
                        </c:if>                                        <div class="mb-3">
                                            <small class="text-muted">
                                                <i class="fas fa-file me-1"></i>
                                                Size: <fmt:formatNumber value="${cv.fileSize / 1024}" maxFractionDigits="1" /> KB
                                            </small>
                                        </div>
                                    </div>

                                    <div class="card-footer bg-transparent">
                                        <div class="btn-group w-100" role="group">
                                            <a href="/user/cv/download/${cv.id}" class="btn btn-outline-primary btn-sm">
                                                <i class="fas fa-download me-1"></i>Download
                                            </a>
                                            <a href="/user/cv/${cv.id}" class="btn btn-outline-info btn-sm">
                                                <i class="fas fa-eye me-1"></i>View Details
                                            </a>
                                            <c:if test="${cv.status == 'SUBMITTED'}">
                                                <button type="button" class="btn btn-outline-danger btn-sm" 
                                                        data-bs-toggle="modal" data-bs-target="#deleteModal${cv.id}">
                                                    <i class="fas fa-trash me-1"></i>Delete
                                                </button>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Delete Confirmation Modal -->
                            <c:if test="${cv.status == 'SUBMITTED'}">
                                <div class="modal fade" id="deleteModal${cv.id}" tabindex="-1" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title">
                                                    <i class="fas fa-exclamation-triangle text-warning me-2"></i>
                                                    Confirm Delete
                                                </h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                            </div>
                                            <div class="modal-body">
                                                <p>Are you sure you want to delete this CV?</p>
                                                <div class="alert alert-warning">
                                                    <strong>File:</strong> ${cv.fileName}<br>
                                                    <small class="text-muted">This action cannot be undone.</small>
                                                </div>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                                <form action="/user/cv/delete/${cv.id}" method="post" style="display: inline;">
                                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                                    <button type="submit" class="btn btn-danger">
                                                        <i class="fas fa-trash me-2"></i>Delete CV
                                                    </button>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                        </c:forEach>
                    </div>

                    <!-- Upload New CV Section -->
                    <c:if test="${!hasSubmittedCV}">
                        <div class="card shadow mt-4">
                            <div class="card-body text-center">
                                <h5 class="card-title text-primary">
                                    <i class="fas fa-plus-circle me-2"></i>Upload Another CV
                                </h5>
                                <p class="text-muted">You can upload a new CV once your current submission has been reviewed.</p>
                                <a href="/user/submit-cv" class="btn btn-primary">
                                    <i class="fas fa-upload me-2"></i>Upload New CV
                                </a>
                            </div>
                        </div>
                    </c:if>
                </c:if>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>