<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Messages - HireZa</title>
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
                            <i class="fas fa-briefcase me-1"></i>Browse Jobs
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/user/cv">
                            <i class="fas fa-file-text me-1"></i>My CV
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="/user/messages">
                            <i class="fas fa-envelope me-1"></i>Messages
                            <c:if test="${unreadMessages.size() > 0}">
                                <span class="badge bg-danger">${unreadMessages.size()}</span>
                            </c:if>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/user/suggestions">
                            <i class="fas fa-lightbulb me-1"></i>Job Suggestions
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

        <!-- Page Header -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h1 class="h3 mb-0 text-gray-800">My Messages</h1>
                <p class="text-muted">View your messages and notifications</p>
            </div>
            <div class="text-end">
                <span class="badge bg-primary">${totalMessages} total</span>
                <span class="badge bg-warning">${unreadMessages.size()} unread</span>
            </div>
        </div>

        <!-- Statistics Cards -->
        <div class="row mb-4">
            <div class="col-xl-3 col-md-6 mb-4">
                <div class="card border-left-primary shadow h-100 py-2">
                    <div class="card-body">
                        <div class="row no-gutters align-items-center">
                            <div class="col mr-2">
                                <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                    Total Messages
                                </div>
                                <div class="h5 mb-0 font-weight-bold text-gray-800">${totalMessages}</div>
                            </div>
                            <div class="col-auto">
                                <i class="fas fa-envelope fa-2x text-gray-300"></i>
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
                                    Unread Messages
                                </div>
                                <div class="h5 mb-0 font-weight-bold text-gray-800">${unreadMessages.size()}</div>
                            </div>
                            <div class="col-auto">
                                <i class="fas fa-exclamation-circle fa-2x text-gray-300"></i>
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
                                    Job Suggestions
                                </div>
                                <div class="h5 mb-0 font-weight-bold text-gray-800">${jobSuggestionMessages.size()}</div>
                            </div>
                            <div class="col-auto">
                                <i class="fas fa-lightbulb fa-2x text-gray-300"></i>
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
                                <div class="h5 mb-0 font-weight-bold text-gray-800">0</div>
                            </div>
                            <div class="col-auto">
                                <i class="fas fa-calendar-week fa-2x text-gray-300"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Messages List -->
        <div class="card">
            <div class="card-header">
                <h5 class="mb-0">All Messages</h5>
            </div>
            <div class="card-body">
                <c:choose>
                    <c:when test="${empty messages}">
                        <div class="text-center py-5">
                            <i class="fas fa-envelope fa-3x text-muted mb-3"></i>
                            <h5 class="text-muted">No messages yet</h5>
                            <p class="text-muted">Your messages and notifications will appear here.</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="list-group list-group-flush">
                            <c:forEach var="message" items="${messages}">
                                <div class="list-group-item ${message.isRead ? '' : 'bg-light border-left-primary'}">
                                    <div class="d-flex w-100 justify-content-between">
                                        <div class="flex-grow-1">
                                            <div class="d-flex justify-content-between align-items-start mb-2">
                                                <h6 class="mb-1 ${message.isRead ? '' : 'fw-bold'}">
                                                    <c:choose>
                                                        <c:when test="${message.messageType == 'JOB_SUGGESTION'}">
                                                            <i class="fas fa-lightbulb text-warning me-2"></i>
                                                        </c:when>
                                                        <c:when test="${message.messageType == 'CV_FEEDBACK'}">
                                                            <i class="fas fa-file-text text-info me-2"></i>
                                                        </c:when>
                                                        <c:when test="${message.messageType == 'SYSTEM'}">
                                                            <i class="fas fa-cog text-secondary me-2"></i>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <i class="fas fa-envelope text-primary me-2"></i>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    ${message.subject}
                                                </h6>
                                                <small class="text-muted">${message.sentAt}</small>
                                            </div>
                                            <p class="mb-2 text-muted">
                                                <c:choose>
                                                    <c:when test="${message.content.length() > 200}">
                                                        ${message.content.substring(0, 200)}...
                                                    </c:when>
                                                    <c:otherwise>
                                                        ${message.content}
                                                    </c:otherwise>
                                                </c:choose>
                                            </p>
                                            <div class="d-flex justify-content-between align-items-center">
                                                <small class="text-muted">
                                                    From: ${message.sender.fullName}
                                                    <span class="badge bg-secondary ms-2">${message.messageType}</span>
                                                </small>
                                                <div>
                                                    <c:if test="${!message.isRead}">
                                                        <form action="/user/messages/${message.id}/read" method="post" class="d-inline">
                                                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                                            <button type="submit" class="btn btn-sm btn-outline-primary">
                                                                <i class="fas fa-check me-1"></i>Mark as Read
                                                            </button>
                                                        </form>
                                                    </c:if>
                                                    <c:if test="${message.isRead}">
                                                        <span class="badge bg-success">
                                                            <i class="fas fa-check me-1"></i>Read
                                                        </span>
                                                    </c:if>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
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