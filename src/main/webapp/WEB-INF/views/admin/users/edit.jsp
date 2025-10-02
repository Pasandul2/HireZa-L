<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit User - HireZa Admin</title>
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
                        <i class="fas fa-user-edit text-primary me-2"></i>
                        Edit User
                    </h1>
                    <div>
                        <a href="/admin/users" class="btn btn-secondary me-2">
                            <i class="fas fa-arrow-left me-2"></i>Back to Users
                        </a>
                        <c:if test="${user.role != 'ADMIN'}">
                            <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#deleteModal">
                                <i class="fas fa-trash me-2"></i>Delete User
                            </button>
                        </c:if>
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

                <!-- User Profile Summary -->
                <div class="card shadow mb-4">
                    <div class="card-body">
                        <div class="row align-items-center">
                            <div class="col-md-2">
                                <div class="avatar-circle bg-primary text-white mx-auto" style="width: 80px; height: 80px; font-size: 28px;">
                                    ${user.fullName.substring(0,1).toUpperCase()}
                                </div>
                            </div>
                            <div class="col-md-6">
                                <h4 class="mb-1">${user.fullName}</h4>
                                <p class="text-muted mb-1">${user.email}</p>
                                <div class="d-flex gap-2">
                                    <c:choose>
                                        <c:when test="${user.role == 'ADMIN'}">
                                            <span class="badge bg-danger">${user.role}</span>
                                        </c:when>
                                        <c:when test="${user.role == 'COUNSELOR'}">
                                            <span class="badge bg-warning text-dark">${user.role}</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-info">${user.role}</span>
                                        </c:otherwise>
                                    </c:choose>
                                    <c:choose>
                                        <c:when test="${user.enabled}">
                                            <span class="badge bg-success">Active</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-secondary">Inactive</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                            <div class="col-md-4 text-end">
                                <small class="text-muted">
                                    <strong>Joined:</strong> ${user.createdAt}<br>
                                    <strong>Last Updated:</strong> 
                                    <c:choose>
                                        <c:when test="${not empty user.updatedAt}">
                                            ${user.updatedAt}
                                        </c:when>
                                        <c:otherwise>
                                            Never
                                        </c:otherwise>
                                    </c:choose>
                                </small>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- User Edit Form -->
                <div class="card shadow">
                    <div class="card-header py-3">
                        <h6 class="m-0 font-weight-bold text-primary">User Information</h6>
                    </div>
                    <div class="card-body">
                        <form:form modelAttribute="user" method="post" action="/admin/users/${user.id}/edit">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="mb-3">
                                        <label for="fullName" class="form-label">Full Name <span class="text-danger">*</span></label>
                                        <form:input path="fullName" class="form-control" id="fullName"/>
                                        <form:errors path="fullName" class="text-danger small"/>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="email" class="form-label">Email Address <span class="text-danger">*</span></label>
                                        <form:input path="email" type="email" class="form-control" id="email"/>
                                        <form:errors path="email" class="text-danger small"/>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="phone" class="form-label">Phone Number</label>
                                        <form:input path="phone" class="form-control" id="phone"/>
                                        <form:errors path="phone" class="text-danger small"/>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="role" class="form-label">Role <span class="text-danger">*</span></label>
                                        <c:choose>
                                            <c:when test="${user.role == 'ADMIN'}">
                                                <form:select path="role" class="form-select" id="role" disabled="true">
                                                    <form:option value="ADMIN">Administrator</form:option>
                                                </form:select>
                                                <form:hidden path="role"/>
                                                <div class="form-text text-warning">
                                                    <i class="fas fa-info-circle me-1"></i>
                                                    Admin role cannot be changed for security reasons.
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <form:select path="role" class="form-select" id="role">
                                                    <form:option value="USER">Job Seeker</form:option>
                                                    <form:option value="COUNSELOR">Counselor</form:option>
                                                    <form:option value="ADMIN">Administrator</form:option>
                                                </form:select>
                                            </c:otherwise>
                                        </c:choose>
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
                                <form:textarea path="address" class="form-control" id="address" rows="3"/>
                                <form:errors path="address" class="text-danger small"/>
                            </div>

                            <div class="mb-3">
                                <label for="bio" class="form-label">Bio / About</label>
                                <form:textarea path="bio" class="form-control" id="bio" rows="4"/>
                                <form:errors path="bio" class="text-danger small"/>
                            </div>

                            <!-- Password Reset Section -->
                            <div class="card bg-light mb-3">
                                <div class="card-body">
                                    <h6 class="card-title text-primary">
                                        <i class="fas fa-key me-2"></i>Password Management
                                    </h6>
                                    <div class="form-check mb-3">
                                        <input class="form-check-input" type="checkbox" id="resetPassword" name="resetPassword">
                                        <label class="form-check-label" for="resetPassword">
                                            Reset user password
                                        </label>
                                        <div class="form-text">Check this box to reset the user's password. They will be required to change it on next login.</div>
                                    </div>
                                    
                                    <div id="passwordSection" style="display: none;">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label for="newPassword" class="form-label">New Password</label>
                                                    <div class="input-group">
                                                        <input type="password" class="form-control" id="newPassword" name="newPassword" placeholder="Enter new password"/>
                                                        <button class="btn btn-outline-secondary" type="button" id="togglePassword">
                                                            <i class="fas fa-eye"></i>
                                                        </button>
                                                    </div>
                                                    <div class="form-text">Leave blank to generate a random password.</div>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label class="form-label">&nbsp;</label>
                                                    <div>
                                                        <button type="button" class="btn btn-outline-info" id="generatePassword">
                                                            <i class="fas fa-random me-2"></i>Generate Random Password
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                <a href="/admin/users" class="btn btn-secondary">Cancel</a>
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save me-2"></i>Update User
                                </button>
                            </div>
                        </form:form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Delete Confirmation Modal -->
    <c:if test="${user.role != 'ADMIN'}">
        <div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="deleteModalLabel">
                            <i class="fas fa-exclamation-triangle text-warning me-2"></i>
                            Confirm Delete
                        </h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to delete this user account?</p>
                        <div class="alert alert-warning">
                            <strong>User:</strong> ${user.fullName}<br>
                            <strong>Email:</strong> ${user.email}<br>
                            <strong>Role:</strong> ${user.role}<br>
                            <small class="text-muted">This action cannot be undone and will permanently delete all user data.</small>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <form action="/admin/users/${user.id}/delete" method="post" style="display: inline;">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                            <button type="submit" class="btn btn-danger">
                                <i class="fas fa-trash me-2"></i>Delete User
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </c:if>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Toggle password visibility
        document.getElementById('togglePassword').addEventListener('click', function() {
            const password = document.getElementById('newPassword');
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

        // Show/hide password section
        document.getElementById('resetPassword').addEventListener('change', function() {
            const passwordSection = document.getElementById('passwordSection');
            if (this.checked) {
                passwordSection.style.display = 'block';
            } else {
                passwordSection.style.display = 'none';
                document.getElementById('newPassword').value = '';
            }
        });

        // Generate random password
        document.getElementById('generatePassword').addEventListener('click', function() {
            const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789@#$%&*';
            let password = '';
            for (let i = 0; i < 12; i++) {
                password += chars.charAt(Math.floor(Math.random() * chars.length));
            }
            document.getElementById('newPassword').value = password;
            
            // Show the generated password
            document.getElementById('newPassword').type = 'text';
            document.getElementById('togglePassword').querySelector('i').classList.remove('fa-eye');
            document.getElementById('togglePassword').querySelector('i').classList.add('fa-eye-slash');
            
            // Show success message
            const btn = this;
            const originalText = btn.innerHTML;
            btn.innerHTML = '<i class="fas fa-check me-2"></i>Password Generated!';
            btn.classList.remove('btn-outline-info');
            btn.classList.add('btn-success');
            
            setTimeout(() => {
                btn.innerHTML = originalText;
                btn.classList.remove('btn-success');
                btn.classList.add('btn-outline-info');
            }, 2000);
        });
    </script>
    
    <style>
        .avatar-circle {
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
        }
    </style>
</body>
</html>