<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Dashboard - HireZa Job Portal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="/css/custom.css" rel="stylesheet">
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-info">
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
                        <a class="nav-link active" href="/user/dashboard">
                            <i class="fas fa-tachometer-alt me-1"></i>Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/jobs">
                            <i class="fas fa-search me-1"></i>Find Jobs
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/user/applications">
                            <i class="fas fa-file-text me-1"></i>My Applications
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/user/cv">
                            <i class="fas fa-upload me-1"></i>Upload CV
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/user/sessions">
                            <i class="fas fa-calendar-alt me-1"></i>Sessions
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/user/messages">
                            <i class="fas fa-envelope me-1"></i>Messages
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
                        <i class="fas fa-user text-info me-2"></i>
                        Welcome back, ${user.fullName}!
                    </h1>
                    <div class="text-muted">
                        <i class="fas fa-clock me-1"></i>
                        <span id="currentTime"></span>
                    </div>
                </div>
            </div>
        </div>

        <!-- Quick Stats -->
        <div class="row mb-4">
            <div class="col-xl-3 col-md-6 mb-4">
                <div class="card border-left-primary shadow h-100 py-2">
                    <div class="card-body">
                        <div class="row no-gutters align-items-center">
                            <div class="col mr-2">
                                <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                    Available Jobs
                                </div>
                                <div class="h5 mb-0 font-weight-bold text-gray-800">${availableJobs}</div>
                            </div>
                            <div class="col-auto">
                                <i class="fas fa-briefcase fa-2x text-gray-300"></i>
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
                                    CV Status
                                </div>
                                <div class="h5 mb-0 font-weight-bold text-gray-800">
                                    <c:choose>
                                        <c:when test="${cvStatus != null}">
                                            <span class="badge bg-${cvStatus == 'ACCEPTED' ? 'success' : (cvStatus == 'REJECTED' ? 'danger' : 'warning')}">${cvStatus}</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-secondary">Not Uploaded</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                            <div class="col-auto">
                                <i class="fas fa-file-text fa-2x text-gray-300"></i>
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
                                    Upcoming Sessions
                                </div>
                                <div class="h5 mb-0 font-weight-bold text-gray-800">${upcomingSessions}</div>
                            </div>
                            <div class="col-auto">
                                <i class="fas fa-calendar-alt fa-2x text-gray-300"></i>
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
                                    New Messages
                                </div>
                                <div class="h5 mb-0 font-weight-bold text-gray-800">${unreadMessages}</div>
                            </div>
                            <div class="col-auto">
                                <i class="fas fa-envelope fa-2x text-gray-300"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Main Content Area -->
        <div class="row">
            <div class="col-lg-8">
                <!-- Job Recommendations -->
                <div class="card shadow mb-4">
                    <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                        <h6 class="m-0 font-weight-bold text-primary">Recommended Jobs</h6>
                        <a href="/jobs" class="btn btn-sm btn-info">View All Jobs</a>
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${not empty recommendedJobs}">
                                <div class="row">
                                    <c:forEach var="job" items="${recommendedJobs}">
                                        <div class="col-md-6 mb-3">
                                            <div class="card h-100">
                                                <div class="card-body">
                                                    <h6 class="card-title">${job.title}</h6>
                                                    <p class="card-text">
                                                        <small class="text-muted">
                                                            <i class="fas fa-building me-1"></i>${job.company}<br>
                                                            <i class="fas fa-map-marker-alt me-1"></i>${job.location}<br>
                                                            <i class="fas fa-money-bill-wave me-1"></i>${job.salaryRange}
                                                        </small>
                                                    </p>
                                                    <p class="card-text">${job.description}</p>
                                                    <a href="/jobs/${job.id}" class="btn btn-sm btn-outline-info">View Details</a>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="text-center py-4">
                                    <i class="fas fa-search fa-3x text-muted mb-3"></i>
                                    <p class="text-muted">No job recommendations available yet.</p>
                                    <a href="/jobs" class="btn btn-info">Browse All Jobs</a>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- Recent Messages -->
                <div class="card shadow mb-4">
                    <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                        <h6 class="m-0 font-weight-bold text-primary">Recent Messages</h6>
                        <a href="/user/messages" class="btn btn-sm btn-info">View All</a>
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${not empty recentMessages}">
                                <div class="list-group list-group-flush">
                                    <c:forEach var="message" items="${recentMessages}">
                                        <div class="list-group-item ${!message.read ? 'list-group-item-light' : ''}">
                                            <div class="d-flex w-100 justify-content-between">
                                                <h6 class="mb-1">
                                                    ${message.subject}
                                                    <c:if test="${!message.read}">
                                                        <span class="badge bg-warning">New</span>
                                                    </c:if>
                                                </h6>
                                                <small class="text-muted">${message.sentAt}</small>
                                            </div>
                                            <p class="mb-1">${message.content}</p>
                                            <small class="text-muted">From: System</small>
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="text-center py-4">
                                    <i class="fas fa-envelope-open fa-3x text-muted mb-3"></i>
                                    <p class="text-muted">No messages yet.</p>
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
                            <c:choose>
                                <c:when test="${cvStatus == null}">
                                    <a href="/user/cv" class="btn btn-outline-success">
                                        <i class="fas fa-upload me-2"></i>Upload CV
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <a href="/user/cv" class="btn btn-outline-info">
                                        <i class="fas fa-edit me-2"></i>Update CV
                                    </a>
                                </c:otherwise>
                            </c:choose>
                            <a href="/jobs" class="btn btn-outline-primary">
                                <i class="fas fa-search me-2"></i>Search Jobs
                            </a>
                            <a href="/user/sessions/book" class="btn btn-outline-warning">
                                <i class="fas fa-calendar-plus me-2"></i>Book Session
                            </a>
                            <a href="/profile" class="btn btn-outline-secondary">
                                <i class="fas fa-user-edit me-2"></i>Update Profile
                            </a>
                        </div>
                    </div>
                </div>

                <!-- CV Status Card -->
                <div class="card shadow mb-4">
                    <div class="card-header py-3">
                        <h6 class="m-0 font-weight-bold text-primary">CV Status</h6>
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${cvStatus != null}">
                                <div class="text-center">
                                    <c:choose>
                                        <c:when test="${cvStatus == 'ACCEPTED'}">
                                            <i class="fas fa-check-circle fa-3x text-success mb-3"></i>
                                            <h5 class="text-success">CV Approved</h5>
                                            <p class="text-muted">Your CV has been approved and is ready for job applications.</p>
                                        </c:when>
                                        <c:when test="${cvStatus == 'REJECTED'}">
                                            <i class="fas fa-times-circle fa-3x text-danger mb-3"></i>
                                            <h5 class="text-danger">CV Needs Improvement</h5>
                                            <p class="text-muted">Please review the feedback and resubmit your CV.</p>
                                            <c:if test="${cvFeedback != null}">
                                                <div class="alert alert-warning">
                                                    <strong>Feedback:</strong> ${cvFeedback}
                                                </div>
                                            </c:if>
                                        </c:when>
                                        <c:otherwise>
                                            <i class="fas fa-clock fa-3x text-warning mb-3"></i>
                                            <h5 class="text-warning">Under Review</h5>
                                            <p class="text-muted">Your CV is currently being reviewed by our team.</p>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="text-center py-3">
                                    <i class="fas fa-upload fa-3x text-muted mb-3"></i>
                                    <h5 class="text-muted">No CV Uploaded</h5>
                                    <p class="text-muted">Upload your CV to get started with job applications.</p>
                                    <a href="/user/cv" class="btn btn-success">Upload Now</a>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- Upcoming Sessions -->
                <div class="card shadow">
                    <div class="card-header py-3">
                        <h6 class="m-0 font-weight-bold text-primary">Upcoming Sessions</h6>
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${not empty upcomingSessionsList}">
                                <c:forEach var="session" items="${upcomingSessionsList}">
                                    <div class="d-flex align-items-center mb-3">
                                        <div class="flex-shrink-0">
                                            <div class="badge bg-info rounded-pill">${session.sessionDateTime}</div>
                                        </div>
                                        <div class="flex-grow-1 ms-3">
                                            <h6 class="mb-0">Career Counseling</h6>
                                            <small class="text-muted">With ${session.counselor.fullName}</small>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="text-center py-3">
                                    <i class="fas fa-calendar-plus fa-2x text-muted mb-2"></i>
                                    <p class="text-muted mb-0">No upcoming sessions.</p>
                                    <a href="/user/sessions/book" class="btn btn-sm btn-info mt-2">Book Session</a>
                                </div>
                            </c:otherwise>
                        </c:choose>
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