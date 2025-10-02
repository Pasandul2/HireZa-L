<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Submit CV - HireZa</title>
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
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <!-- Header -->
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h1 class="h3 mb-0">
                        <i class="fas fa-upload text-primary me-2"></i>
                        Submit Your CV
                    </h1>
                    <a href="/user/cv" class="btn btn-outline-secondary">
                        <i class="fas fa-arrow-left me-2"></i>Back to My CVs
                    </a>
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

                <!-- CV Guidelines -->
                <div class="card shadow mb-4">
                    <div class="card-header py-3">
                        <h5 class="mb-0 text-primary">
                            <i class="fas fa-info-circle me-2"></i>CV Submission Guidelines
                        </h5>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6">
                                <h6 class="text-success">
                                    <i class="fas fa-check-circle me-2"></i>Accepted Formats
                                </h6>
                                <ul class="list-unstyled">
                                    <li><i class="fas fa-file-pdf text-danger me-2"></i>PDF (.pdf)</li>
                                    <li><i class="fas fa-file-word text-primary me-2"></i>Microsoft Word (.doc, .docx)</li>
                                </ul>
                            </div>
                            <div class="col-md-6">
                                <h6 class="text-info">
                                    <i class="fas fa-file-alt me-2"></i>File Requirements
                                </h6>
                                <ul class="list-unstyled">
                                    <li><i class="fas fa-weight-hanging me-2"></i>Maximum size: 5MB</li>
                                    <li><i class="fas fa-language me-2"></i>Professional language only</li>
                                </ul>
                            </div>
                        </div>
                        
                        <div class="mt-3">
                            <h6 class="text-warning">
                                <i class="fas fa-star me-2"></i>CV Best Practices
                            </h6>
                            <div class="row">
                                <div class="col-md-6">
                                    <ul class="mb-0">
                                        <li>Include your full contact information</li>
                                        <li>List your education and qualifications</li>
                                        <li>Detail your work experience</li>
                                        <li>Highlight relevant skills</li>
                                    </ul>
                                </div>
                                <div class="col-md-6">
                                    <ul class="mb-0">
                                        <li>Use clear, professional formatting</li>
                                        <li>Keep it concise (1-2 pages)</li>
                                        <li>Proofread for spelling and grammar</li>
                                        <li>Tailor it to your target roles</li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- CV Upload Form -->
                <div class="card shadow">
                    <div class="card-header py-3">
                        <h5 class="mb-0 text-primary">
                            <i class="fas fa-cloud-upload-alt me-2"></i>Upload Your CV
                        </h5>
                    </div>
                    <div class="card-body">
                        <form action="/user/submit-cv" method="post" enctype="multipart/form-data" id="cvUploadForm">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                            
                            <!-- File Upload Section -->
                            <div class="mb-4">
                                <label for="cvFile" class="form-label">
                                    <i class="fas fa-file me-2"></i>Select CV File <span class="text-danger">*</span>
                                </label>
                                <div class="position-relative">
                                    <input type="file" 
                                           class="form-control" 
                                           id="cvFile" 
                                           name="cvFile" 
                                           accept=".pdf,.doc,.docx"
                                           required>
                                    <div class="form-text">
                                        <i class="fas fa-info-circle text-muted me-1"></i>
                                        Choose a PDF or Word document (max 5MB)
                                    </div>
                                </div>
                            </div>

                            <!-- File Preview Section -->
                            <div id="filePreview" class="mb-4" style="display: none;">
                                <div class="card bg-light">
                                    <div class="card-body">
                                        <h6 class="card-title text-success">
                                            <i class="fas fa-check-circle me-2"></i>File Selected
                                        </h6>
                                        <div class="d-flex align-items-center">
                                            <div class="me-3">
                                                <i id="fileIcon" class="fas fa-file fa-2x text-primary"></i>
                                            </div>
                                            <div class="flex-grow-1">
                                                <div id="fileName" class="fw-bold"></div>
                                                <div id="fileSize" class="text-muted small"></div>
                                                <div id="fileType" class="text-muted small"></div>
                                            </div>
                                            <div>
                                                <button type="button" class="btn btn-sm btn-outline-danger" id="removeFile">
                                                    <i class="fas fa-times me-1"></i>Remove
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Additional Information -->
                            <div class="mb-4">
                                <label for="coverLetter" class="form-label">
                                    <i class="fas fa-comment me-2"></i>Cover Letter / Additional Notes (Optional)
                                </label>
                                <textarea class="form-control" 
                                          id="coverLetter" 
                                          name="coverLetter" 
                                          rows="4" 
                                          placeholder="Write a brief cover letter or any additional information you'd like to include with your CV submission..."></textarea>
                                <div class="form-text">
                                    This will help our counselors understand your background and career goals better.
                                </div>
                            </div>

                            <!-- Terms and Conditions -->
                            <div class="mb-4">
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" id="agreeTerms" required>
                                    <label class="form-check-label" for="agreeTerms">
                                        I agree that the information provided is accurate and I consent to having my CV reviewed by HireZa counselors. <span class="text-danger">*</span>
                                    </label>
                                </div>
                            </div>

                            <!-- Submit Button -->
                            <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                <a href="/user/cv" class="btn btn-secondary">
                                    <i class="fas fa-times me-2"></i>Cancel
                                </a>
                                <button type="submit" class="btn btn-success btn-lg" id="submitBtn">
                                    <i class="fas fa-upload me-2"></i>Submit CV for Review
                                </button>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- What Happens Next -->
                <div class="card shadow mt-4">
                    <div class="card-header py-3">
                        <h5 class="mb-0 text-primary">
                            <i class="fas fa-clock me-2"></i>What Happens Next?
                        </h5>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-4 text-center mb-3">
                                <div class="bg-primary text-white rounded-circle d-inline-flex align-items-center justify-content-center" style="width: 60px; height: 60px;">
                                    <i class="fas fa-upload fa-lg"></i>
                                </div>
                                <h6 class="mt-3 text-primary">1. Upload Complete</h6>
                                <p class="text-muted small">Your CV is safely uploaded to our system and waiting for review.</p>
                            </div>
                            <div class="col-md-4 text-center mb-3">
                                <div class="bg-info text-white rounded-circle d-inline-flex align-items-center justify-content-center" style="width: 60px; height: 60px;">
                                    <i class="fas fa-eye fa-lg"></i>
                                </div>
                                <h6 class="mt-3 text-info">2. Professional Review</h6>
                                <p class="text-muted small">Our experienced counselors will review your CV within 2-3 business days.</p>
                            </div>
                            <div class="col-md-4 text-center mb-3">
                                <div class="bg-success text-white rounded-circle d-inline-flex align-items-center justify-content-center" style="width: 60px; height: 60px;">
                                    <i class="fas fa-check fa-lg"></i>
                                </div>
                                <h6 class="mt-3 text-success">3. Feedback & Approval</h6>
                                <p class="text-muted small">You'll receive feedback and, if approved, can start applying for jobs!</p>
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
        // File upload handling
        document.getElementById('cvFile').addEventListener('change', function(e) {
            const file = e.target.files[0];
            const filePreview = document.getElementById('filePreview');
            const fileName = document.getElementById('fileName');
            const fileSize = document.getElementById('fileSize');
            const fileType = document.getElementById('fileType');
            const fileIcon = document.getElementById('fileIcon');
            const submitBtn = document.getElementById('submitBtn');
            
            if (file) {
                // Validate file size (5MB = 5 * 1024 * 1024 bytes)
                if (file.size > 5 * 1024 * 1024) {
                    alert('File size must be less than 5MB. Please choose a smaller file.');
                    e.target.value = '';
                    filePreview.style.display = 'none';
                    return;
                }
                
                // Validate file type
                const allowedTypes = ['.pdf', '.doc', '.docx'];
                const fileExtension = '.' + file.name.split('.').pop().toLowerCase();
                if (!allowedTypes.includes(fileExtension)) {
                    alert('Please upload only PDF or Word documents (.pdf, .doc, .docx)');
                    e.target.value = '';
                    filePreview.style.display = 'none';
                    return;
                }
                
                // Show file preview
                fileName.textContent = file.name;
                fileSize.textContent = 'Size: ' + (file.size / 1024 / 1024).toFixed(2) + ' MB';
                fileType.textContent = 'Type: ' + file.type;
                
                // Set appropriate icon
                if (file.type === 'application/pdf') {
                    fileIcon.className = 'fas fa-file-pdf fa-2x text-danger';
                } else {
                    fileIcon.className = 'fas fa-file-word fa-2x text-primary';
                }
                
                filePreview.style.display = 'block';
                submitBtn.disabled = false;
            } else {
                filePreview.style.display = 'none';
                submitBtn.disabled = true;
            }
        });
        
        // Remove file button
        document.getElementById('removeFile').addEventListener('click', function() {
            document.getElementById('cvFile').value = '';
            document.getElementById('filePreview').style.display = 'none';
            document.getElementById('submitBtn').disabled = true;
        });
        
        // Form validation
        document.getElementById('cvUploadForm').addEventListener('submit', function(e) {
            const file = document.getElementById('cvFile').files[0];
            const agreeTerms = document.getElementById('agreeTerms').checked;
            
            if (!file) {
                e.preventDefault();
                alert('Please select a CV file to upload.');
                return;
            }
            
            if (!agreeTerms) {
                e.preventDefault();
                alert('Please agree to the terms and conditions.');
                return;
            }
            
            // Show loading state
            const submitBtn = document.getElementById('submitBtn');
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Uploading...';
            submitBtn.disabled = true;
        });
        
        // Initialize submit button state
        document.getElementById('submitBtn').disabled = true;
    </script>
</body>
</html>