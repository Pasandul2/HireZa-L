<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>HireZa - Job Portal</title>
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
                        <a class="nav-link" href="/">Home</a>
                    </li>
                    <sec:authorize access="hasRole('USER')">
                        <li class="nav-item">
                            <a class="nav-link" href="/user/jobs">Browse Jobs</a>
                        </li>
                    </sec:authorize>
                </ul>
                <ul class="navbar-nav">
                    <sec:authorize access="isAnonymous()">
                        <li class="nav-item">
                            <a class="nav-link" href="/login">Login</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="/register">Register</a>
                        </li>
                    </sec:authorize>
                    <sec:authorize access="isAuthenticated()">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
                                <i class="fas fa-user me-1"></i>
                                <sec:authentication property="principal.username"/>
                            </a>
                            <ul class="dropdown-menu">
                                <sec:authorize access="hasRole('ADMIN')">
                                    <li><a class="dropdown-item" href="/admin/dashboard">Admin Dashboard</a></li>
                                </sec:authorize>
                                <sec:authorize access="hasRole('COUNSELOR')">
                                    <li><a class="dropdown-item" href="/counselor/dashboard">Counselor Dashboard</a></li>
                                </sec:authorize>
                                <sec:authorize access="hasRole('USER')">
                                    <li><a class="dropdown-item" href="/user/dashboard">My Dashboard</a></li>
                                </sec:authorize>
                                <li><hr class="dropdown-divider"></li>
                                <li>
                                    <form action="/logout" method="post" class="d-inline">
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                        <button type="submit" class="dropdown-item">
                                            <i class="fas fa-sign-out-alt me-1"></i>Logout
                                        </button>
                                    </form>
                                </li>
                            </ul>
                        </li>
                    </sec:authorize>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <main class="container mt-4">
        <!-- Alert Messages -->
        <c:if test="${not empty success}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                ${success}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                ${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        <c:if test="${not empty message}">
            <div class="alert alert-info alert-dismissible fade show" role="alert">
                ${message}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <!-- Hero Section -->
        <div class="row mb-5">
            <div class="col-12">
                <div class="jumbotron bg-light p-5 rounded">
                    <h1 class="display-4">Find Your Dream Job</h1>
                    <p class="lead">Connect with top employers and advance your career with HireZa Job Portal</p>
                    <hr class="my-4">
                    <p>Join thousands of job seekers who have found their perfect match through our platform.</p>
                    <sec:authorize access="isAnonymous()">
                        <a class="btn btn-primary btn-lg me-3" href="/register" role="button">
                            <i class="fas fa-user-plus me-1"></i>Get Started
                        </a>
                        <a class="btn btn-outline-primary btn-lg" href="/login" role="button">
                            <i class="fas fa-sign-in-alt me-1"></i>Login
                        </a>
                    </sec:authorize>
                    <sec:authorize access="hasRole('USER')">
                        <a class="btn btn-primary btn-lg me-3" href="/user/jobs" role="button">
                            <i class="fas fa-search me-1"></i>Browse Jobs
                        </a>
                        <a class="btn btn-outline-primary btn-lg" href="/user/submit-cv" role="button">
                            <i class="fas fa-file-upload me-1"></i>Upload CV
                        </a>
                    </sec:authorize>
                </div>
            </div>
        </div>

        <!-- Statistics -->
        <div class="row mb-5">
            <div class="col-md-4">
                <div class="card text-center">
                    <div class="card-body">
                        <i class="fas fa-briefcase fa-3x text-primary mb-3"></i>
                        <h3>${totalJobs}</h3>
                        <p class="text-muted">Active Jobs</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card text-center">
                    <div class="card-body">
                        <i class="fas fa-users fa-3x text-success mb-3"></i>
                        <h3>1000+</h3>
                        <p class="text-muted">Job Seekers</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card text-center">
                    <div class="card-body">
                        <i class="fas fa-building fa-3x text-info mb-3"></i>
                        <h3>500+</h3>
                        <p class="text-muted">Companies</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Recent Jobs -->
        <c:if test="${not empty recentJobs}">
            <div class="row">
                <div class="col-12">
                    <h2 class="mb-4">Recent Job Postings</h2>
                    <div class="row">
                        <c:forEach items="${recentJobs}" var="job" end="5">
                            <div class="col-md-6 col-lg-4 mb-4">
                                <div class="card h-100">
                                    <div class="card-body">
                                        <h5 class="card-title">${job.title}</h5>
                                        <p class="card-text">
                                            <small class="text-muted">
                                                <i class="fas fa-building me-1"></i>${job.company}
                                                <br>
                                                <i class="fas fa-map-marker-alt me-1"></i>${job.location}
                                                <br>
                                                <i class="fas fa-tag me-1"></i>${job.category}
                                            </small>
                                        </p>
                                        <p class="card-text">${job.description.length() > 100 ? job.description.substring(0, 100) + '...' : job.description}</p>
                                    </div>
                                    <div class="card-footer">
                                        <sec:authorize access="hasRole('USER')">
                                            <a href="/user/job/${job.id}" class="btn btn-primary btn-sm">
                                                <i class="fas fa-eye me-1"></i>View Details
                                            </a>
                                        </sec:authorize>
                                        <small class="text-muted float-end">
                                            <i class="fas fa-clock me-1"></i>${job.createdAt}
                                        </small>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </c:if>
    </main>

    <!-- Footer -->
    <footer class="bg-dark text-light mt-5 py-4">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <h5>HireZa Job Portal</h5>
                    <p class="mb-0">Connecting talented individuals with amazing opportunities.</p>
                </div>
                <div class="col-md-6 text-md-end">
                    <p class="mb-0">&copy; 2024 HireZa. All rights reserved.</p>
                </div>
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="/js/custom.js"></script>
</body>
</html>