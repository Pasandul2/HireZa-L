<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Counseling Sessions - HireZa Counselor</title>
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
                        <a class="nav-link" href="/counselor/dashboard">
                            <i class="fas fa-tachometer-alt me-1"></i>Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/counselor/cv-reviews">
                            <i class="fas fa-file-text me-1"></i>CV Reviews
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/counselor/suggestions">
                            <i class="fas fa-lightbulb me-1"></i>Job Suggestions
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="/counselor/sessions">
                            <i class="fas fa-calendar-alt me-1"></i>Sessions
                        </a>
                    </li>
                </ul>
                <ul class="navbar-nav">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown">
                            <i class="fas fa-user me-1"></i>
                            <sec:authentication property="principal.username"/>
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
        <c:if test="${not empty successMessage}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="fas fa-check-circle me-2"></i>${successMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fas fa-exclamation-circle me-2"></i>${errorMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <!-- Page Header -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h1 class="h3 mb-0 text-gray-800">Counseling Sessions</h1>
                <p class="text-muted">Manage your counseling sessions and appointments</p>
            </div>
            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#scheduleSessionModal">
                <i class="fas fa-plus me-2"></i>Schedule Session
            </button>
        </div>

        <!-- Statistics Cards -->
        <div class="row mb-4">
            <div class="col-xl-3 col-md-6 mb-4">
                <div class="card border-left-primary shadow h-100 py-2">
                    <div class="card-body">
                        <div class="row no-gutters align-items-center">
                            <div class="col mr-2">
                                <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                    Total Sessions
                                </div>
                                <div class="h5 mb-0 font-weight-bold text-gray-800">${totalSessions}</div>
                            </div>
                            <div class="col-auto">
                                <i class="fas fa-calendar fa-2x text-gray-300"></i>
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
                                    Scheduled
                                </div>
                                <div class="h5 mb-0 font-weight-bold text-gray-800">${scheduledSessions}</div>
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
                                    Completed
                                </div>
                                <div class="h5 mb-0 font-weight-bold text-gray-800">${completedSessions}</div>
                            </div>
                            <div class="col-auto">
                                <i class="fas fa-check fa-2x text-gray-300"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xl-3 col-md-6 mb-4">
                <div class="card border-left-info shadow h-100 py-2">
                    <div class="card-body">
                        <div class="row no-gutters align-items-center">
                            <div class="col mr-2">
                                <div class="text-xs font-weight-bold text-info text-uppercase mb-1">
                                    This Week
                                </div>
                                <div class="h5 mb-0 font-weight-bold text-gray-800">${thisWeekSessions}</div>
                            </div>
                            <div class="col-auto">
                                <i class="fas fa-calendar-week fa-2x text-gray-300"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Filter and Search -->
        <div class="card mb-4">
            <div class="card-header">
                <h5 class="mb-0">Filter Sessions</h5>
            </div>
            <div class="card-body">
                <form method="get" action="/counselor/sessions" class="row g-3">
                    <div class="col-md-3">
                        <label for="status" class="form-label">Status</label>
                        <select name="status" id="status" class="form-select">
                            <option value="">All Status</option>
                            <option value="SCHEDULED" ${param.status == 'SCHEDULED' ? 'selected' : ''}>Scheduled</option>
                            <option value="IN_PROGRESS" ${param.status == 'IN_PROGRESS' ? 'selected' : ''}>In Progress</option>
                            <option value="COMPLETED" ${param.status == 'COMPLETED' ? 'selected' : ''}>Completed</option>
                            <option value="CANCELLED" ${param.status == 'CANCELLED' ? 'selected' : ''}>Cancelled</option>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <label for="dateFrom" class="form-label">From Date</label>
                        <input type="date" name="dateFrom" id="dateFrom" class="form-control" value="${param.dateFrom}">
                    </div>
                    <div class="col-md-3">
                        <label for="dateTo" class="form-label">To Date</label>
                        <input type="date" name="dateTo" id="dateTo" class="form-control" value="${param.dateTo}">
                    </div>
                    <div class="col-md-3">
                        <label for="search" class="form-label">Search</label>
                        <input type="text" name="search" id="search" class="form-control" 
                               value="${param.search}" placeholder="Search by client name...">
                    </div>
                    <div class="col-12">
                        <button type="submit" class="btn btn-primary me-2">
                            <i class="fas fa-search me-1"></i>Filter
                        </button>
                        <a href="/counselor/sessions" class="btn btn-outline-secondary">
                            <i class="fas fa-times me-1"></i>Clear
                        </a>
                    </div>
                </form>
            </div>
        </div>

        <!-- Sessions List -->
        <div class="card">
            <div class="card-header d-flex justify-content-between align-items-center">
                <h5 class="mb-0">Sessions</h5>
                <span class="badge bg-primary">${sessions.size()} sessions</span>
            </div>
            <div class="card-body">
                <c:choose>
                    <c:when test="${empty sessions}">
                        <div class="text-center py-5">
                            <i class="fas fa-calendar-alt fa-3x text-muted mb-3"></i>
                            <h5 class="text-muted">No sessions found</h5>
                            <p class="text-muted">Schedule your first counseling session to get started.</p>
                            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#scheduleSessionModal">
                                <i class="fas fa-plus me-2"></i>Schedule Session
                            </button>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>Client</th>
                                        <th>Date & Time</th>
                                        <th>Duration</th>
                                        <th>Type</th>
                                        <th>Status</th>
                                        <th>Notes</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="session" items="${sessions}">
                                        <tr>
                                            <td>
                                                <div class="d-flex align-items-center">
                                                    <div class="avatar avatar-sm me-3">
                                                        <div class="avatar-title bg-primary rounded-circle">
                                                            ${session.user.fullName.substring(0, 1).toUpperCase()}
                                                        </div>
                                                    </div>
                                                    <div>
                                                        <div class="fw-bold">${session.user.fullName}</div>
                                                        <small class="text-muted">${session.user.email}</small>
                                                    </div>
                                                </div>
                                            </td>
                                            <td>
                                                <div>${session.scheduledDateTime}</div>
                                                <small class="text-muted">
                                                    <i class="fas fa-clock me-1"></i>
                                                    ${session.scheduledDateTime}
                                                </small>
                                            </td>
                                            <td>
                                                <span class="badge bg-light text-dark">${session.duration} min</span>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${session.sessionType == 'RESUME_REVIEW'}">
                                                        <span class="badge bg-info">Resume Review</span>
                                                    </c:when>
                                                    <c:when test="${session.sessionType == 'CAREER_GUIDANCE'}">
                                                        <span class="badge bg-success">Career Guidance</span>
                                                    </c:when>
                                                    <c:when test="${session.sessionType == 'INTERVIEW_PREP'}">
                                                        <span class="badge bg-warning">Interview Prep</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-secondary">General</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${session.status == 'SCHEDULED'}">
                                                        <span class="badge bg-warning text-dark">
                                                            <i class="fas fa-clock me-1"></i>Scheduled
                                                        </span>
                                                    </c:when>
                                                    <c:when test="${session.status == 'IN_PROGRESS'}">
                                                        <span class="badge bg-info">
                                                            <i class="fas fa-play me-1"></i>In Progress
                                                        </span>
                                                    </c:when>
                                                    <c:when test="${session.status == 'COMPLETED'}">
                                                        <span class="badge bg-success">
                                                            <i class="fas fa-check me-1"></i>Completed
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-danger">
                                                            <i class="fas fa-times me-1"></i>Cancelled
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty session.notes and session.notes.length() > 50}">
                                                        <span title="${session.notes}">
                                                            ${session.notes.substring(0, 50)}...
                                                        </span>
                                                    </c:when>
                                                    <c:when test="${not empty session.notes}">
                                                        ${session.notes}
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-muted">No notes</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <div class="btn-group" role="group">
                                                    <button type="button" class="btn btn-sm btn-outline-primary" 
                                                            onclick="viewSession(${session.id})" title="View Details">
                                                        <i class="fas fa-eye"></i>
                                                    </button>
                                                    <c:if test="${session.status == 'SCHEDULED'}">
                                                        <button type="button" class="btn btn-sm btn-outline-success" 
                                                                onclick="startSession(${session.id})" title="Start Session">
                                                            <i class="fas fa-play"></i>
                                                        </button>
                                                        <button type="button" class="btn btn-sm btn-outline-warning" 
                                                                onclick="editSession(${session.id})" title="Edit Session">
                                                            <i class="fas fa-edit"></i>
                                                        </button>
                                                        <button type="button" class="btn btn-sm btn-outline-danger" 
                                                                onclick="cancelSession(${session.id})" title="Cancel Session">
                                                            <i class="fas fa-times"></i>
                                                        </button>
                                                    </c:if>
                                                    <c:if test="${session.status == 'IN_PROGRESS'}">
                                                        <button type="button" class="btn btn-sm btn-outline-success" 
                                                                onclick="completeSession(${session.id})" title="Complete Session">
                                                            <i class="fas fa-check"></i>
                                                        </button>
                                                    </c:if>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <!-- Schedule Session Modal -->
    <div class="modal fade" id="scheduleSessionModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Schedule New Session</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form action="/counselor/sessions/schedule" method="post">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="userId" class="form-label">Client</label>
                            <select name="userId" id="userId" class="form-select" required>
                                <option value="">Select a client...</option>
                                <c:forEach var="user" items="${users}">
                                    <option value="${user.id}">${user.fullName} (${user.email})</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="sessionType" class="form-label">Session Type</label>
                            <select name="sessionType" id="sessionType" class="form-select" required>
                                <option value="RESUME_REVIEW">Resume Review</option>
                                <option value="CAREER_GUIDANCE">Career Guidance</option>
                                <option value="INTERVIEW_PREP">Interview Preparation</option>
                                <option value="GENERAL">General Counseling</option>
                            </select>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="sessionDate" class="form-label">Date</label>
                                    <input type="date" name="sessionDate" id="sessionDate" class="form-control" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="sessionTime" class="form-label">Time</label>
                                    <input type="time" name="sessionTime" id="sessionTime" class="form-control" required>
                                </div>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label for="duration" class="form-label">Duration (minutes)</label>
                            <select name="duration" id="duration" class="form-select" required>
                                <option value="30">30 minutes</option>
                                <option value="45">45 minutes</option>
                                <option value="60" selected>60 minutes</option>
                                <option value="90">90 minutes</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="notes" class="form-label">Notes (Optional)</label>
                            <textarea name="notes" id="notes" class="form-control" rows="3" 
                                      placeholder="Add any notes about this session..."></textarea>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary">Schedule Session</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Set minimum date to today
        document.getElementById('sessionDate').min = new Date().toISOString().split('T')[0];
        
        function viewSession(sessionId) {
            window.location.href = '/counselor/sessions/' + sessionId;
        }
        
        function startSession(sessionId) {
            if (confirm('Start this counseling session?')) {
                fetch('/counselor/sessions/' + sessionId + '/start', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                        'X-CSRF-TOKEN': document.querySelector('meta[name="_csrf"]').getAttribute('content')
                    }
                }).then(response => {
                    if (response.ok) {
                        location.reload();
                    } else {
                        alert('Error starting session');
                    }
                });
            }
        }
        
        function completeSession(sessionId) {
            if (confirm('Mark this session as completed?')) {
                fetch('/counselor/sessions/' + sessionId + '/complete', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                        'X-CSRF-TOKEN': document.querySelector('meta[name="_csrf"]').getAttribute('content')
                    }
                }).then(response => {
                    if (response.ok) {
                        location.reload();
                    } else {
                        alert('Error completing session');
                    }
                });
            }
        }
        
        function cancelSession(sessionId) {
            if (confirm('Cancel this session? This action cannot be undone.')) {
                fetch('/counselor/sessions/' + sessionId + '/cancel', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                        'X-CSRF-TOKEN': document.querySelector('meta[name="_csrf"]').getAttribute('content')
                    }
                }).then(response => {
                    if (response.ok) {
                        location.reload();
                    } else {
                        alert('Error cancelling session');
                    }
                });
            }
        }
        
        function editSession(sessionId) {
            // Redirect to edit page
            window.location.href = '/counselor/sessions/' + sessionId + '/edit';
        }
    </script>
</body>
</html>