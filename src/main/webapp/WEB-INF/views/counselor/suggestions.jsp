<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Job Suggestions - HireZa Counselor</title>
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
                        <a class="nav-link" href="/counselor/cv-reviews">
                            <i class="fas fa-file-text me-1"></i>CV Reviews
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="/counselor/suggestions">
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
                <i class="fas fa-lightbulb text-success me-2"></i>
                Job Suggestions
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

        <div class="row">
            <!-- Suggest Job Form -->
            <div class="col-lg-4">
                <div class="card shadow">
                    <div class="card-header py-3">
                        <h6 class="m-0 font-weight-bold text-success">
                            <i class="fas fa-paper-plane me-2"></i>Send Job Suggestion
                        </h6>
                    </div>
                    <div class="card-body">
                        <form action="/counselor/suggest-job" method="post" id="suggestionForm">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                            
                            <!-- Select User -->
                            <div class="mb-3">
                                <label for="userId" class="form-label">
                                    <i class="fas fa-user me-1"></i>Select User
                                </label>
                                <select class="form-select" id="userId" name="userId" required>
                                    <option value="">Choose a user...</option>
                                    <c:forEach var="user" items="${users}">
                                        <option value="${user.id}" ${param.userId == user.id ? 'selected' : ''}>
                                            ${user.fullName} (${user.email})
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>

                            <!-- Select Job -->
                            <div class="mb-3">
                                <label for="jobId" class="form-label">
                                    <i class="fas fa-briefcase me-1"></i>Select Job
                                </label>
                                <select class="form-select" id="jobId" name="jobId" required>
                                    <option value="">Choose a job...</option>
                                    <c:forEach var="job" items="${jobs}">
                                        <option value="${job.id}" data-job='${job.title}' data-company='${job.company}' data-location='${job.location}'>
                                            ${job.title} - ${job.company} (${job.location})
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>

                            <!-- Job Preview -->
                            <div id="jobPreview" class="mb-3" style="display: none;">
                                <div class="card bg-light">
                                    <div class="card-body py-2">
                                        <h6 class="card-title mb-1" id="previewTitle"></h6>
                                        <p class="card-text mb-0">
                                            <small class="text-muted">
                                                <i class="fas fa-building me-1"></i><span id="previewCompany"></span> |
                                                <i class="fas fa-map-marker-alt me-1"></i><span id="previewLocation"></span>
                                            </small>
                                        </p>
                                    </div>
                                </div>
                            </div>

                            <!-- Message -->
                            <div class="mb-3">
                                <label for="message" class="form-label">
                                    <i class="fas fa-comment me-1"></i>Personal Message
                                </label>
                                <textarea class="form-control" 
                                          id="message" 
                                          name="message" 
                                          rows="4" 
                                          placeholder="Write a personalized message explaining why this job might be a good fit..."
                                          required></textarea>
                                <div class="form-text">
                                    Explain why you think this job is suitable for the candidate.
                                </div>
                            </div>

                            <!-- Submit Button -->
                            <div class="d-grid">
                                <button type="submit" class="btn btn-success">
                                    <i class="fas fa-paper-plane me-2"></i>Send Suggestion
                                </button>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- Quick Stats -->
                <div class="card shadow mt-4">
                    <div class="card-header py-3">
                        <h6 class="m-0 font-weight-bold text-info">
                            <i class="fas fa-chart-bar me-2"></i>Quick Stats
                        </h6>
                    </div>
                    <div class="card-body">
                        <div class="row text-center">
                            <div class="col-6">
                                <div class="border-end">
                                    <div class="h4 text-primary">${users.size()}</div>
                                    <div class="small text-muted">Active Users</div>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="h4 text-success">${jobs.size()}</div>
                                <div class="small text-muted">Available Jobs</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Available Jobs List -->
            <div class="col-lg-8">
                <div class="card shadow">
                    <div class="card-header py-3">
                        <h6 class="m-0 font-weight-bold text-success">
                            Available Jobs
                            <span class="badge bg-secondary ms-2">${jobs.size()} jobs</span>
                        </h6>
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${not empty jobs}">
                                <div class="row">
                                    <c:forEach var="job" items="${jobs}">
                                        <div class="col-lg-6 mb-3">
                                            <div class="card border-start border-success border-4 h-100">
                                                <div class="card-body">
                                                    <div class="d-flex justify-content-between align-items-start mb-2">
                                                        <h6 class="card-title mb-0 text-primary">${job.title}</h6>
                                                        <span class="badge bg-primary">${job.jobType}</span>
                                                    </div>
                                                    
                                                    <p class="card-text mb-2">
                                                        <i class="fas fa-building me-1 text-muted"></i>
                                                        <strong>${job.company}</strong>
                                                    </p>
                                                    
                                                    <p class="card-text mb-2">
                                                        <i class="fas fa-map-marker-alt me-1 text-muted"></i>
                                                        ${job.location}
                                                    </p>
                                                    
                                                    <c:if test="${not empty job.salaryRange}">
                                                        <p class="card-text mb-2">
                                                            <i class="fas fa-dollar-sign me-1 text-muted"></i>
                                                            ${job.salaryRange}
                                                        </p>
                                                    </c:if>
                                                    
                                                    <p class="card-text mb-2">
                                                        <i class="fas fa-tag me-1 text-muted"></i>
                                                        <span class="badge bg-light text-dark">${job.category}</span>
                                                    </p>
                                                    
                                                    <div class="card-text">
                                                        <small class="text-muted">
                                                            <i class="fas fa-calendar me-1"></i>
                                                            Posted: ${job.createdAt}
                                                        </small>
                                                    </div>
                                                    
                                                    <div class="mt-3">
                                                        <button type="button" 
                                                                class="btn btn-outline-success btn-sm select-job-btn" 
                                                                data-job-id="${job.id}"
                                                                data-job-title="${job.title}"
                                                                data-job-company="${job.company}"
                                                                data-job-location="${job.location}">
                                                            <i class="fas fa-plus me-1"></i>Select for Suggestion
                                                        </button>
                                                        <a href="/jobs/${job.id}" class="btn btn-outline-info btn-sm" target="_blank">
                                                            <i class="fas fa-eye me-1"></i>View Details
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
                                    <i class="fas fa-briefcase fa-3x text-muted mb-3"></i>
                                    <h5 class="text-muted">No Jobs Available</h5>
                                    <p class="text-muted">There are no active jobs available for suggestion at this time.</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>

        <!-- Previous Suggestions (TODO: Implement when JobSuggestionService is ready) -->
        <div class="row mt-4">
            <div class="col-12">
                <div class="card shadow">
                    <div class="card-header py-3">
                        <h6 class="m-0 font-weight-bold text-info">
                            <i class="fas fa-history me-2"></i>Recent Suggestions
                        </h6>
                    </div>
                    <div class="card-body">
                        <div class="text-center py-3">
                            <i class="fas fa-clock fa-2x text-muted mb-2"></i>
                            <p class="text-muted">Job suggestion history will be displayed here once the feature is fully implemented.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Job selection and preview
        document.getElementById('jobId').addEventListener('change', function() {
            const selectedOption = this.options[this.selectedIndex];
            const preview = document.getElementById('jobPreview');
            
            if (selectedOption.value) {
                document.getElementById('previewTitle').textContent = selectedOption.dataset.job;
                document.getElementById('previewCompany').textContent = selectedOption.dataset.company;
                document.getElementById('previewLocation').textContent = selectedOption.dataset.location;
                preview.style.display = 'block';
            } else {
                preview.style.display = 'none';
            }
        });

        // Select job from list
        document.querySelectorAll('.select-job-btn').forEach(button => {
            button.addEventListener('click', function() {
                const jobId = this.dataset.jobId;
                const jobSelect = document.getElementById('jobId');
                jobSelect.value = jobId;
                jobSelect.dispatchEvent(new Event('change'));
                
                // Scroll to form
                document.getElementById('suggestionForm').scrollIntoView({ behavior: 'smooth' });
                
                // Highlight the form briefly
                const formCard = document.querySelector('#suggestionForm').closest('.card');
                formCard.style.boxShadow = '0 0 20px rgba(25, 135, 84, 0.3)';
                setTimeout(() => {
                    formCard.style.boxShadow = '';
                }, 2000);
            });
        });

        // Form validation
        document.getElementById('suggestionForm').addEventListener('submit', function(e) {
            const userId = document.getElementById('userId').value;
            const jobId = document.getElementById('jobId').value;
            const message = document.getElementById('message').value.trim();
            
            if (!userId || !jobId || !message) {
                e.preventDefault();
                alert('Please fill in all required fields.');
                return;
            }
            
            if (message.length < 20) {
                e.preventDefault();
                alert('Please provide a more detailed message (at least 20 characters).');
                return;
            }
            
            if (!confirm('Are you sure you want to send this job suggestion?')) {
                e.preventDefault();
            }
        });

        // Auto-populate message template when job is selected
        document.getElementById('jobId').addEventListener('change', function() {
            const messageField = document.getElementById('message');
            const selectedOption = this.options[this.selectedIndex];
            
            if (selectedOption.value && messageField.value.trim() === '') {
                const jobTitle = selectedOption.dataset.job;
                const company = selectedOption.dataset.company;
                const template = `Hi! I came across this ${jobTitle} position at ${company} and thought it might be a great fit for your skills and career goals. 

This role offers excellent opportunities for professional growth and aligns well with your background. I encourage you to review the job details and consider applying.

Feel free to reach out if you have any questions about the position or need assistance with your application.

Best regards!`;
                
                messageField.value = template;
            }
        });
    </script>
</body>
</html>