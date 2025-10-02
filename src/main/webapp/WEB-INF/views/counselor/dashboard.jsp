<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Counselor Dashboard - HireZa Job Portal</title>
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
                        <a class="nav-link active" href="/counselor/dashboard">
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
            <div class="col-12">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h1 class="h3 mb-0">
                        <i class="fas fa-user-tie text-success me-2"></i>
                        Counselor Dashboard
                    </h1>
                    <div class="text-muted">
                        <i class="fas fa-clock me-1"></i>
                        <span id="currentTime"></span>
                    </div>
                </div>
            </div>
        </div>

        <!-- Statistics Cards -->
        <div class="row mb-4">
            <div class="col-xl-3 col-md-6 mb-4">
                <div class="card border-left-success shadow h-100 py-2">
                    <div class="card-body">
                        <div class="row no-gutters align-items-center">
                            <div class="col mr-2">
                                <div class="text-xs font-weight-bold text-success text-uppercase mb-1">
                                    My Sessions
                                </div>
                                <div class="h5 mb-0 font-weight-bold text-gray-800">${totalSessions}</div>
                            </div>
                            <div class="col-auto">
                                <i class="fas fa-calendar-alt fa-2x text-gray-300"></i>
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
                                    Job Suggestions
                                </div>
                                <div class="h5 mb-0 font-weight-bold text-gray-800">${totalSuggestions}</div>
                            </div>
                            <div class="col-auto">
                                <i class="fas fa-lightbulb fa-2x text-gray-300"></i>
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
                                    Pending Sessions
                                </div>
                                <div class="h5 mb-0 font-weight-bold text-gray-800">${pendingSessions}</div>
                            </div>
                            <div class="col-auto">
                                <i class="fas fa-clock fa-2x text-gray-300"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-xl-3 col-md-6 mb-4">
                <div class="card border-left-primary shadow h-100 py-2">
                    <div class="card-body">
                        <div class="row no-gutters align-items-center">
                            <div class="col mr-2">
                                <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                    Active Users
                                </div>
                                <div class="h5 mb-0 font-weight-bold text-gray-800">${activeUsers}</div>
                            </div>
                            <div class="col-auto">
                                <i class="fas fa-users fa-2x text-gray-300"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Main Content Area -->
        <div class="row">
            <div class="col-lg-8">
                <!-- Upcoming Sessions -->
                <div class="card shadow mb-4">
                    <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                        <h6 class="m-0 font-weight-bold text-primary">Upcoming Sessions</h6>
                        <a href="/counselor/sessions" class="btn btn-sm btn-success">View All</a>
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${not empty upcomingSessions}">
                                <div class="table-responsive">
                                    <table class="table table-hover">
                                        <thead class="table-light">
                                            <tr>
                                                <th>User</th>
                                                <th>Date & Time</th>
                                                <th>Status</th>
                                                <th>Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="session" items="${upcomingSessions}">
                                                <tr>
                                                    <td>
                                                        <div class="fw-bold">${session.user.fullName}</div>
                                                        <small class="text-muted">${session.user.email}</small>
                                                    </td>
                                                    <td>
                                                        <div class="fw-bold">${session.sessionDateTime}</div>
                                                    </td>
                                                    <td>
                                                        <span class="badge bg-info">${session.status}</span>
                                                    </td>
                                                    <td>
                                                        <a href="/counselor/sessions/${session.id}" class="btn btn-sm btn-outline-success">
                                                            <i class="fas fa-eye"></i>
                                                        </a>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="text-center py-4">
                                    <i class="fas fa-calendar-alt fa-3x text-muted mb-3"></i>
                                    <p class="text-muted">No upcoming sessions scheduled.</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- Recent Job Suggestions -->
                <div class="card shadow mb-4">
                    <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                        <h6 class="m-0 font-weight-bold text-primary">Recent Job Suggestions</h6>
                        <a href="/counselor/suggestions" class="btn btn-sm btn-success">View All</a>
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${not empty recentSuggestions}">
                                <div class="list-group list-group-flush">
                                    <c:forEach var="suggestion" items="${recentSuggestions}">
                                        <div class="list-group-item">
                                            <div class="d-flex w-100 justify-content-between">
                                                <h6 class="mb-1">${suggestion.job.title}</h6>
                                                <small class="text-muted">${suggestion.suggestedAt}</small>
                                            </div>
                                            <p class="mb-1">Suggested to: <strong>${suggestion.user.fullName}</strong></p>
                                            <small class="text-muted">${suggestion.message}</small>
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="text-center py-4">
                                    <i class="fas fa-lightbulb fa-3x text-muted mb-3"></i>
                                    <p class="text-muted">No job suggestions made yet.</p>
                                    <a href="/counselor/suggestions/new" class="btn btn-success">Make Suggestion</a>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>

            <div class="col-lg-4">
                <!-- Quick Actions -->
                <div class="card shadow mb-4">
                    <div class="card-header py-3">
                        <h6 class="m-0 font-weight-bold text-primary">Quick Actions</h6>
                    </div>
                    <div class="card-body">
                        <div class="d-grid gap-2">
                            <a href="/counselor/sessions/new" class="btn btn-outline-success">
                                <i class="fas fa-plus me-2"></i>Schedule Session
                            </a>
                            <a href="/counselor/suggestions/new" class="btn btn-outline-info">
                                <i class="fas fa-lightbulb me-2"></i>Job Suggestion
                            </a>
                            <a href="/counselor/messages" class="btn btn-outline-warning">
                                <i class="fas fa-envelope me-2"></i>Send Message
                            </a>
                            <a href="/jobs" class="btn btn-outline-primary">
                                <i class="fas fa-search me-2"></i>Browse Jobs
                            </a>
                        </div>
                    </div>
                </div>

                <!-- Today's Schedule -->
                <div class="card shadow mb-4">
                    <div class="card-header py-3">
                        <h6 class="m-0 font-weight-bold text-primary">Today's Schedule</h6>
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${not empty todaySessions}">
                                <c:forEach var="session" items="${todaySessions}">
                                    <div class="d-flex align-items-center mb-3">
                                        <div class="flex-shrink-0">
                                            <div class="badge bg-success rounded-pill">${session.sessionDateTime}</div>
                                        </div>
                                        <div class="flex-grow-1 ms-3">
                                            <h6 class="mb-0">${session.user.fullName}</h6>
                                            <small class="text-muted">${session.status}</small>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="text-center py-3">
                                    <i class="fas fa-calendar-check fa-2x text-muted mb-2"></i>
                                    <p class="text-muted mb-0">No sessions scheduled for today.</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- Performance Stats -->
                <div class="card shadow">
                    <div class="card-header py-3">
                        <h6 class="m-0 font-weight-bold text-primary">This Month</h6>
                    </div>
                    <div class="card-body">
                        <div class="row text-center">
                            <div class="col-6">
                                <div class="border-end">
                                    <div class="h4 mb-0 text-success">${completedSessions}</div>
                                    <small class="text-muted">Completed Sessions</small>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="h4 mb-0 text-info">${suggestionsMade}</div>
                                <small class="text-muted">Suggestions Made</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Update current time
        function updateTime() {
            const now = new Date();
            const timeString = now.toLocaleString();
            document.getElementById('currentTime').textContent = timeString;
        }
        
        updateTime();
        setInterval(updateTime, 1000);
    </script>
</body>
</html>