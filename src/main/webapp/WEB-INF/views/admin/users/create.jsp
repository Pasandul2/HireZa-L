<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create User - HireZa Admin</title>
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
                        <a class="nav-link active" href="/admin/users">
                            <i class="fas fa-users me-1"></i>Manage Users
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/admin/cvs">
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
    <div class="container mt-4">
        <div class="row">
            <div class="col-12">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h1 class="h3 mb-0">
                        <i class="fas fa-user-plus text-primary me-2"></i>
                        Create New User
                    </h1>
                    <a href="/admin/users" class="btn btn-secondary">
                        <i class="fas fa-arrow-left me-2"></i>Back to Users
                    </a>
                </div>

                <!-- Flash Messages -->
                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-circle me-2"></i>${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <!-- User Creation Form -->
                <div class="card shadow">
                    <div class="card-header py-3">
                        <h6 class="m-0 font-weight-bold text-primary">User Information</h6>
                    </div>
                    <div class="card-body">
                        <form:form modelAttribute="user" method="post" action="/admin/users/create">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="mb-3">
                                        <label for="fullName" class="form-label">Full Name <span class="text-danger">*</span></label>
                                        <form:input path="fullName" class="form-control" id="fullName" placeholder="Enter full name"/>
                                        <form:errors path="fullName" class="text-danger small"/>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="email" class="form-label">Email Address <span class="text-danger">*</span></label>
                                        <form:input path="email" type="email" class="form-control" id="email" placeholder="Enter email address"/>
                                        <form:errors path="email" class="text-danger small"/>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="phone" class="form-label">Phone Number</label>
                                        <form:input path="phone" class="form-control" id="phone" placeholder="Enter phone number"/>
                                        <form:errors path="phone" class="text-danger small"/>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="password" class="form-label">Password <span class="text-danger">*</span></label>
                                        <div class="input-group">
                                            <form:password path="password" class="form-control" id="password" placeholder="Enter password"/>
                                            <button class="btn btn-outline-secondary" type="button" id="togglePassword">
                                                <i class="fas fa-eye"></i>
                                            </button>
                                        </div>
                                        <form:errors path="password" class="text-danger small"/>
                                        <div class="form-text">Password must be at least 6 characters long.</div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="confirmPassword" class="form-label">Confirm Password <span class="text-danger">*</span></label>
                                        <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="Confirm password"/>
                                        <div id="passwordMismatch" class="text-danger small" style="display: none;">Passwords do not match.</div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="role" class="form-label">Role <span class="text-danger">*</span></label>
                                        <form:select path="role" class="form-select" id="role">
                                            <form:option value="">Select Role</form:option>
                                            <form:option value="USER">Job Seeker</form:option>
                                            <form:option value="COUNSELOR">Counselor</form:option>
                                            <form:option value="ADMIN">Administrator</form:option>
                                        </form:select>
                                        <form:errors path="role" class="text-danger small"/>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="enabled" class="form-label">Account Status</label>
                                        <form:select path="enabled" class="form-select" id="enabled">
                                            <form:option value="true">Active</form:option>
                                            <form:option value="false">Inactive</form:option>
                                        </form:select>
                                    </div>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="address" class="form-label">Address</label>
                                <form:textarea path="address" class="form-control" id="address" rows="3" 
                                               placeholder="Enter complete address"/>
                                <form:errors path="address" class="text-danger small"/>
                            </div>

                            <div class="mb-3">
                                <label for="bio" class="form-label">Bio / About</label>
                                <form:textarea path="bio" class="form-control" id="bio" rows="4" 
                                               placeholder="Enter user bio or about information"/>
                                <form:errors path="bio" class="text-danger small"/>
                            </div>

                            <!-- Role-specific fields -->
                            <div id="counselorFields" style="display: none;">
                                <div class="card bg-light mb-3">
                                    <div class="card-body">
                                        <h6 class="card-title text-primary">
                                            <i class="fas fa-user-tie me-2"></i>Counselor Specific Information
                                        </h6>
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label for="specialization" class="form-label">Specialization</label>
                                                    <input type="text" class="form-control" id="specialization" name="specialization" 
                                                           placeholder="e.g. Career Guidance, IT Consulting"/>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label for="experience" class="form-label">Years of Experience</label>
                                                    <input type="number" class="form-control" id="experience" name="experience" 
                                                           placeholder="e.g. 5" min="0"/>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div id="userFields" style="display: none;">
                                <div class="card bg-light mb-3">
                                    <div class="card-body">
                                        <h6 class="card-title text-primary">
                                            <i class="fas fa-search me-2"></i>Job Seeker Specific Information
                                        </h6>
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label for="desiredJobTitle" class="form-label">Desired Job Title</label>
                                                    <input type="text" class="form-control" id="desiredJobTitle" name="desiredJobTitle" 
                                                           placeholder="e.g. Software Engineer"/>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label for="skills" class="form-label">Skills</label>
                                                    <input type="text" class="form-control" id="skills" name="skills" 
                                                           placeholder="e.g. Java, Python, JavaScript"/>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                <a href="/admin/users" class="btn btn-secondary">Cancel</a>
                                <button type="submit" class="btn btn-primary" id="submitBtn">
                                    <i class="fas fa-save me-2"></i>Create User
                                </button>
                            </div>
                        </form:form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Toggle password visibility
        document.getElementById('togglePassword').addEventListener('click', function() {
            const password = document.getElementById('password');
            const icon = this.querySelector('i');
            
            if (password.type === 'password') {
                password.type = 'text';
                icon.classList.remove('fa-eye');
                icon.classList.add('fa-eye-slash');
            } else {
                password.type = 'password';
                icon.classList.remove('fa-eye-slash');
                icon.classList.add('fa-eye');
            }
        });

        // Password confirmation validation
        function validatePasswords() {
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            const mismatchDiv = document.getElementById('passwordMismatch');
            const submitBtn = document.getElementById('submitBtn');
            
            if (password !== confirmPassword && confirmPassword !== '') {
                mismatchDiv.style.display = 'block';
                submitBtn.disabled = true;
                return false;
            } else {
                mismatchDiv.style.display = 'none';
                submitBtn.disabled = false;
                return true;
            }
        }

        document.getElementById('password').addEventListener('input', validatePasswords);
        document.getElementById('confirmPassword').addEventListener('input', validatePasswords);

        // Show/hide role-specific fields
        document.getElementById('role').addEventListener('change', function() {
            const role = this.value;
            const counselorFields = document.getElementById('counselorFields');
            const userFields = document.getElementById('userFields');
            
            // Hide all role-specific fields
            counselorFields.style.display = 'none';
            userFields.style.display = 'none';
            
            // Show relevant fields based on role
            if (role === 'COUNSELOR') {
                counselorFields.style.display = 'block';
            } else if (role === 'USER') {
                userFields.style.display = 'block';
            }
        });

        // Form submission validation
        document.querySelector('form').addEventListener('submit', function(e) {
            if (!validatePasswords()) {
                e.preventDefault();
                alert('Please ensure passwords match before submitting.');
            }
        });
    </script>
</body>
</html>