<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View CV - HireZa Admin</title>
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
                        <a class="nav-link" href="/admin/dashboard">
                            <i class="fas fa-tachometer-alt me-1"></i>Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/admin/jobs">
                            <i class="fas fa-briefcase me-1"></i>Manage Jobs
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/admin/users">
                            <i class="fas fa-users me-1"></i>Manage Users
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="/admin/cvs">
                            <i class="fas fa-file-text me-1"></i>CV Reviews
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

        <!-- Breadcrumb -->
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="/admin/dashboard">Dashboard</a></li>
                <li class="breadcrumb-item"><a href="/admin/cvs">CV Reviews</a></li>
                <li class="breadcrumb-item active" aria-current="page">View CV</li>
            </ol>
        </nav>

        <!-- Page Header -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h1 class="h3 mb-0 text-gray-800">CV Details</h1>
                <p class="text-muted">Review CV submission details</p>
            </div>
            <div>
                <a href="/admin/cvs" class="btn btn-outline-secondary">
                    <i class="fas fa-arrow-left me-2"></i>Back to CV List
                </a>
                <a href="/admin/cvs/${cv.id}/download" class="btn btn-primary">
                    <i class="fas fa-download me-2"></i>Download CV
                </a>
            </div>
        </div>

        <div class="row">
            <!-- CV Information -->
            <div class="col-lg-8">
                <div class="card shadow mb-4">
                    <div class="card-header py-3">
                        <h6 class="m-0 font-weight-bold text-primary">
                            <i class="fas fa-file-text me-2"></i>CV Information
                        </h6>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label fw-bold">File Name:</label>
                                    <p class="form-control-plaintext">${cv.fileName}</p>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label fw-bold">File Type:</label>
                                    <p class="form-control-plaintext">
                                        <span class="badge bg-info">${cv.fileType}</span>
                                    </p>
                                </div>
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label fw-bold">Submitted Date:</label>
                                    <p class="form-control-plaintext">
                                        <fmt:formatDate value="${cv.submittedAt}" pattern="MMM dd, yyyy 'at' HH:mm" />
                                    </p>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label fw-bold">Status:</label>
                                    <p class="form-control-plaintext">
                                        <c:choose>
                                            <c:when test="${cv.status.name() == 'SUBMITTED'}">
                                                <span class="badge bg-secondary">
                                                    <i class="fas fa-clock me-1"></i>Submitted
                                                </span>
                                            </c:when>
                                            <c:when test="${cv.status.name() == 'UNDER_REVIEW'}">
                                                <span class="badge bg-warning">
                                                    <i class="fas fa-eye me-1"></i>Under Review
                                                </span>
                                            </c:when>
                                            <c:when test="${cv.status.name() == 'ACCEPTED'}">
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
                                    </p>
                                </div>
                            </div>
                        </div>

                        <c:if test="${not empty cv.coverLetter}">
                            <div class="mb-3">
                                <label class="form-label fw-bold">Cover Letter:</label>
                                <div class="form-control-plaintext border rounded p-3 bg-light">
                                    ${cv.coverLetter}
                                </div>
                            </div>
                        </c:if>

                        <c:if test="${not empty cv.feedback}">
                            <div class="mb-3">
                                <label class="form-label fw-bold">Review Feedback:</label>
                                <div class="form-control-plaintext border rounded p-3 bg-light">
                                    ${cv.feedback}
                                </div>
                            </div>
                        </c:if>

                        <c:if test="${not empty cv.reviewedAt}">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label class="form-label fw-bold">Reviewed By:</label>
                                        <p class="form-control-plaintext">
                                            <c:choose>
                                                <c:when test="${not empty cv.reviewedBy}">
                                                    ${cv.reviewedBy.fullName}
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-muted">System</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </p>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label class="form-label fw-bold">Reviewed Date:</label>
                                        <p class="form-control-plaintext">
                                            <fmt:formatDate value="${cv.reviewedAt}" pattern="MMM dd, yyyy 'at' HH:mm" />
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>

            <!-- User Information -->
            <div class="col-lg-4">
                <div class="card shadow mb-4">
                    <div class="card-header py-3">
                        <h6 class="m-0 font-weight-bold text-primary">
                            <i class="fas fa-user me-2"></i>User Information
                        </h6>
                    </div>
                    <div class="card-body">
                        <div class="mb-3">
                            <label class="form-label fw-bold">Full Name:</label>
                            <p class="form-control-plaintext">${cv.user.fullName}</p>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label fw-bold">Email:</label>
                            <p class="form-control-plaintext">
                                <a href="mailto:${cv.user.email}">${cv.user.email}</a>
                            </p>
                        </div>
                        
                        <c:if test="${not empty cv.user.phone}">
                            <div class="mb-3">
                                <label class="form-label fw-bold">Phone:</label>
                                <p class="form-control-plaintext">
                                    <a href="tel:${cv.user.phone}">${cv.user.phone}</a>
                                </p>
                            </div>
                        </c:if>
                        
                        <c:if test="${not empty cv.user.address}">
                            <div class="mb-3">
                                <label class="form-label fw-bold">Address:</label>
                                <p class="form-control-plaintext">${cv.user.address}</p>
                            </div>
                        </c:if>
                        
                        <div class="mb-3">
                            <label class="form-label fw-bold">Member Since:</label>
                            <p class="form-control-plaintext">
                                <fmt:formatDate value="${cv.user.createdAt}" pattern="MMM dd, yyyy" />
                            </p>
                        </div>
                    </div>
                </div>

                <!-- Actions -->
                <div class="card shadow">
                    <div class="card-header py-3">
                        <h6 class="m-0 font-weight-bold text-primary">
                            <i class="fas fa-cog me-2"></i>Actions
                        </h6>
                    </div>
                    <div class="card-body">
                        <c:if test="${cv.status.name() == 'SUBMITTED' || cv.status.name() == 'UNDER_REVIEW'}">
                            <form action="/admin/cvs/${cv.id}/approve" method="post" class="mb-2">
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                <button type="submit" class="btn btn-success btn-sm w-100">
                                    <i class="fas fa-check me-2"></i>Approve CV
                                </button>
                            </form>
                            
                            <form action="/admin/cvs/${cv.id}/reject" method="post" class="mb-2">
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                <button type="submit" class="btn btn-warning btn-sm w-100">
                                    <i class="fas fa-times me-2"></i>Reject CV
                                </button>
                            </form>
                        </c:if>
                        
                        <a href="/admin/cvs/${cv.id}/review" class="btn btn-primary btn-sm w-100 mb-2">
                            <i class="fas fa-edit me-2"></i>Detailed Review
                        </a>
                        
                        <button type="button" class="btn btn-danger btn-sm w-100" 
                                data-bs-toggle="modal" data-bs-target="#deleteModal">
                            <i class="fas fa-trash me-2"></i>Delete CV
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Delete Confirmation Modal -->
    <div class="modal fade" id="deleteModal" tabindex="-1" aria-hidden="true">
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
                        <strong>User:</strong> ${cv.user.fullName}<br>
                        <strong>File:</strong> ${cv.fileName}<br>
                        <small class="text-muted">This action cannot be undone.</small>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <form action="/admin/cvs/${cv.id}/delete" method="post" style="display: inline;">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        <button type="submit" class="btn btn-danger">
                            <i class="fas fa-trash me-2"></i>Delete CV
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>