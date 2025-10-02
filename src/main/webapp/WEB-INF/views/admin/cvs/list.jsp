<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CV Reviews - HireZa Admin</title>
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
    <div class="container-fluid mt-4">
        <div class="row">
            <div class="col-12">
                <!-- Header -->
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h1 class="h3 mb-0">
                        <i class="fas fa-file-text text-primary me-2"></i>
                        CV Reviews
                    </h1>
                    <div>
                        <button type="button" class="btn btn-success me-2" onclick="bulkAction('approve')" id="bulkApproveBtn" disabled>
                            <i class="fas fa-check me-2"></i>Bulk Approve
                        </button>
                        <button type="button" class="btn btn-danger" onclick="bulkAction('reject')" id="bulkRejectBtn" disabled>
                            <i class="fas fa-times me-2"></i>Bulk Reject
                        </button>
                    </div>
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
                        <div class="card border-left-info shadow h-100 py-2">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-xs font-weight-bold text-info text-uppercase mb-1">
                                            Total CVs
                                        </div>
                                        <div class="h5 mb-0 font-weight-bold text-gray-800">${totalCVs}</div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-file-text fa-2x text-gray-300"></i>
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
                                        <div class="h5 mb-0 font-weight-bold text-gray-800">${pendingCVs}</div>
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
                                            Approved
                                        </div>
                                        <div class="h5 mb-0 font-weight-bold text-gray-800">${approvedCVs}</div>
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
                                        <div class="h5 mb-0 font-weight-bold text-gray-800">${rejectedCVs}</div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-times-circle fa-2x text-gray-300"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Filters -->
                <div class="card shadow mb-4">
                    <div class="card-body">
                        <form method="get" action="/admin/cvs" class="row g-3">
                            <div class="col-md-3">
                                <label for="status" class="form-label">Filter by Status</label>
                                <select name="status" id="status" class="form-select">
                                    <option value="">All Status</option>
                                    <option value="SUBMITTED" ${param.status == 'SUBMITTED' ? 'selected' : ''}>Submitted</option>
                                    <option value="UNDER_REVIEW" ${param.status == 'UNDER_REVIEW' ? 'selected' : ''}>Under Review</option>
                                    <option value="ACCEPTED" ${param.status == 'ACCEPTED' ? 'selected' : ''}>Accepted</option>
                                    <option value="REJECTED" ${param.status == 'REJECTED' ? 'selected' : ''}>Rejected</option>
                                </select>
                            </div>
                            <div class="col-md-4">
                                <label for="search" class="form-label">Search CVs</label>
                                <input type="text" name="search" id="search" class="form-control" 
                                       value="${param.search}" placeholder="Search by user name or filename...">
                            </div>
                            <div class="col-md-3">
                                <label for="sortBy" class="form-label">Sort by</label>
                                <select name="sortBy" id="sortBy" class="form-select">
                                    <option value="submittedAt" ${param.sortBy == 'submittedAt' ? 'selected' : ''}>Upload Date</option>
                                    <option value="reviewedAt" ${param.sortBy == 'reviewedAt' ? 'selected' : ''}>Review Date</option>
                                    <option value="userName" ${param.sortBy == 'userName' ? 'selected' : ''}>User Name</option>
                                    <option value="status" ${param.sortBy == 'status' ? 'selected' : ''}>Status</option>
                                </select>
                            </div>
                            <div class="col-md-2">
                                <label class="form-label">&nbsp;</label>
                                <div class="d-grid">
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fas fa-search me-1"></i>Filter
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- CVs Table -->
                <div class="card shadow">
                    <div class="card-header py-3">
                        <div class="d-flex justify-content-between align-items-center">
                            <h6 class="m-0 font-weight-bold text-primary">
                                CV List
                                <span class="badge bg-secondary ms-2">${cvs.size()} CVs found</span>
                            </h6>
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="selectAll">
                                <label class="form-check-label" for="selectAll">
                                    Select All
                                </label>
                            </div>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-bordered table-hover">
                                <thead class="table-primary">
                                    <tr>
                                        <th width="40px">
                                            <input type="checkbox" id="selectAllHeader" onchange="toggleSelectAll()">
                                        </th>
                                        <th>User</th>
                                        <th>CV File</th>
                                        <th>Upload Date</th>
                                        <th>Status</th>
                                        <th>Reviewed By</th>
                                        <th>Review Date</th>
                                        <th>Comments</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="cv" items="${cvs}">
                                        <tr>
                                            <td>
                                                <input type="checkbox" class="cv-checkbox" value="${cv.id}" onchange="updateBulkButtons()">
                                            </td>
                                            <td>
                                                <div class="d-flex align-items-center">
                                                    <div class="avatar-circle bg-primary text-white me-2">
                                                        ${cv.user.fullName.substring(0,1).toUpperCase()}
                                                    </div>
                                                    <div>
                                                        <strong>${cv.user.fullName}</strong>
                                                        <br><small class="text-muted">${cv.user.email}</small>
                                                    </div>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="d-flex align-items-center">
                                                    <i class="fas fa-file-pdf text-danger me-2"></i>
                                                    <div>
                                                        <a href="/admin/cvs/${cv.id}/download" class="text-decoration-none" target="_blank">
                                                            ${cv.fileName}
                                                        </a>
                                                        <br><small class="text-muted">${cv.fileSize} bytes</small>
                                                    </div>
                                                </div>
                                            </td>
                                            <td>
                                                ${cv.submittedAt}
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${cv.status == 'SUBMITTED'}">
                                                        <span class="badge bg-warning text-dark">
                                                            <i class="fas fa-clock me-1"></i>Submitted
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
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty cv.reviewedBy}">
                                                        ${cv.reviewedBy.fullName}
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-muted">-</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty cv.reviewedAt}">
                                                        ${cv.reviewedAt}
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-muted">-</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty cv.feedback}">
                                                        <span class="text-truncate d-inline-block" style="max-width: 150px;" 
                                                              title="${cv.feedback}">
                                                            ${cv.feedback}
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-muted">-</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <div class="btn-group" role="group">
                                                    <c:if test="${not empty cv.coverLetter}">
                                                        <button type="button" class="btn btn-sm btn-outline-info" title="View Cover Letter"
                                                                data-bs-toggle="modal" data-bs-target="#detailsModal${cv.id}">
                                                            <i class="fas fa-envelope"></i>
                                                        </button>
                                                    </c:if>
                                                    <a href="/admin/cvs/${cv.id}/review" class="btn btn-sm btn-outline-primary" title="Review CV">
                                                        <i class="fas fa-eye"></i>
                                                    </a>
                                                    <a href="/admin/cvs/${cv.id}/download" class="btn btn-sm btn-outline-info" title="Download CV" target="_blank">
                                                        <i class="fas fa-download"></i>
                                                    </a>
                                                    <c:if test="${cv.status == 'SUBMITTED' || cv.status == 'UNDER_REVIEW'}">
                                                        <form action="/admin/cvs/${cv.id}/approve" method="post" style="display: inline;">
                                                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                                            <button type="submit" class="btn btn-sm btn-outline-success" title="Approve CV">
                                                                <i class="fas fa-check"></i>
                                                            </button>
                                                        </form>
                                                        <form action="/admin/cvs/${cv.id}/reject" method="post" style="display: inline;">
                                                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                                            <button type="submit" class="btn btn-sm btn-outline-danger" title="Reject CV">
                                                                <i class="fas fa-times"></i>
                                                            </button>
                                                        </form>
                                                    </c:if>
                                                    <button type="button" class="btn btn-sm btn-outline-danger" 
                                                            data-bs-toggle="modal" data-bs-target="#deleteModal${cv.id}" title="Delete CV">
                                                        <i class="fas fa-trash"></i>
                                                    </button>
                                                </div>
                                            </td>
                                        </tr>

                                        <!-- Delete Confirmation Modal for each CV -->
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

                                        <!-- CV Details Modal for each CV with cover letter -->
                                        <c:if test="${not empty cv.coverLetter}">
                                            <div class="modal fade" id="detailsModal${cv.id}" tabindex="-1" aria-hidden="true">
                                                <div class="modal-dialog modal-lg">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title">
                                                                <i class="fas fa-envelope text-info me-2"></i>
                                                                CV Details - ${cv.user.fullName}
                                                            </h5>
                                                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                                        </div>
                                                        <div class="modal-body">
                                                            <div class="row mb-3">
                                                                <div class="col-md-6">
                                                                    <strong><i class="fas fa-file me-2"></i>File Name:</strong><br>
                                                                    <span class="text-muted">${cv.fileName}</span>
                                                                </div>
                                                                <div class="col-md-6">
                                                                    <strong><i class="fas fa-calendar me-2"></i>Submitted:</strong><br>
                                                                    <span class="text-muted">
                                                                        ${cv.submittedAt}
                                                                    </span>
                                                                </div>
                                                            </div>
                                                            
                                                            <hr>
                                                            
                                                            <h6 class="text-info mb-3">
                                                                <i class="fas fa-envelope me-2"></i>Cover Letter
                                                            </h6>
                                                            <div class="card bg-light">
                                                                <div class="card-body">
                                                                    <p class="mb-0" style="white-space: pre-wrap;">${cv.coverLetter}</p>
                                                                </div>
                                                            </div>
                                                            
                                                            <c:if test="${not empty cv.feedback}">
                                                                <hr>
                                                                <h6 class="text-primary mb-3">
                                                                    <i class="fas fa-comment me-2"></i>Admin Feedback
                                                                </h6>
                                                                <div class="alert alert-info">
                                                                    <p class="mb-0">${cv.feedback}</p>
                                                                </div>
                                                            </c:if>
                                                        </div>
                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                            <a href="/admin/cvs/${cv.id}/download" class="btn btn-info" target="_blank">
                                                                <i class="fas fa-download me-2"></i>Download CV
                                                            </a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:if>
                                    </c:forEach>
                                </tbody>
                            </table>

                            <!-- Empty State -->
                            <c:if test="${empty cvs}">
                                <div class="text-center py-5">
                                    <i class="fas fa-file-text fa-3x text-muted mb-3"></i>
                                    <h5 class="text-muted">No CVs found</h5>
                                    <p class="text-muted">Try adjusting your search filters.</p>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Toggle select all functionality
        function toggleSelectAll() {
            const selectAllHeader = document.getElementById('selectAllHeader');
            const checkboxes = document.querySelectorAll('.cv-checkbox');
            
            checkboxes.forEach(checkbox => {
                checkbox.checked = selectAllHeader.checked;
            });
            
            updateBulkButtons();
        }

        // Update bulk action buttons based on selection
        function updateBulkButtons() {
            const checkedBoxes = document.querySelectorAll('.cv-checkbox:checked');
            const bulkApproveBtn = document.getElementById('bulkApproveBtn');
            const bulkRejectBtn = document.getElementById('bulkRejectBtn');
            
            if (checkedBoxes.length > 0) {
                bulkApproveBtn.disabled = false;
                bulkRejectBtn.disabled = false;
            } else {
                bulkApproveBtn.disabled = true;
                bulkRejectBtn.disabled = true;
            }
        }

        // Bulk action functionality
        function bulkAction(action) {
            const checkedBoxes = document.querySelectorAll('.cv-checkbox:checked');
            const cvIds = Array.from(checkedBoxes).map(cb => cb.value);
            
            if (cvIds.length === 0) {
                alert('Please select at least one CV.');
                return;
            }
            
            const actionText = action === 'approve' ? 'approve' : 'reject';
            const confirmMessage = `Are you sure you want to ${actionText} ${cvIds.length} CV(s)?`;
            
            if (confirm(confirmMessage)) {
                // Create form and submit
                const form = document.createElement('form');
                form.method = 'post';
                form.action = `/admin/cvs/bulk-${action}`;
                
                // Add CSRF token
                const csrfToken = document.querySelector('input[name="${_csrf.parameterName}"]').value;
                const csrfInput = document.createElement('input');
                csrfInput.type = 'hidden';
                csrfInput.name = '${_csrf.parameterName}';
                csrfInput.value = csrfToken;
                form.appendChild(csrfInput);
                
                // Add CV IDs
                cvIds.forEach(id => {
                    const input = document.createElement('input');
                    input.type = 'hidden';
                    input.name = 'cvIds';
                    input.value = id;
                    form.appendChild(input);
                });
                
                document.body.appendChild(form);
                form.submit();
            }
        }

        // Initialize
        document.addEventListener('DOMContentLoaded', function() {
            updateBulkButtons();
        });
    </script>
    
    <style>
        .avatar-circle {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            font-size: 14px;
        }
        
        .border-left-primary {
            border-left: 0.25rem solid #4e73df !important;
        }
        
        .border-left-success {
            border-left: 0.25rem solid #1cc88a !important;
        }
        
        .border-left-info {
            border-left: 0.25rem solid #36b9cc !important;
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