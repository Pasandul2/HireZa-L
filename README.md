# HireZa Job Portal

A comprehensive full-stack job portal system built with Spring Boot and JSP, featuring role-based dashboards for Admin, Users, and Counselors.

## Features

### Admin Panel
- Job posting management (Create, Read, Update, Delete)
- User management
- System statistics and analytics
- Role-based access control

### User Dashboard
- CV upload and management
- Job browsing and search
- Application status tracking
- Message inbox for counselor feedback

### Counselor Dashboard
- CV review and status updates
- Feedback provision to job seekers
- Job suggestions with personalized messages
- Session scheduling

### Core Features
- **Authentication & Authorization**: Spring Security with role-based access
- **File Upload**: CV upload with validation (PDF, DOC, DOCX)
- **Messaging System**: Communication between counselors and users
- **Session Scheduling**: Counseling appointment management
- **Responsive UI**: Bootstrap-based modern interface
- **Database**: MySQL with JPA/Hibernate

## Technology Stack

- **Backend**: Spring Boot 3.1.5, Spring Security, Spring Data JPA
- **Frontend**: JSP, Bootstrap 5, JavaScript
- **Database**: MySQL 8.0
- **Build Tool**: Maven
- **Java Version**: 17

## Prerequisites

- Java 17 or higher
- Maven 3.6+
- MySQL 8.0+
- IDE (VS Code, IntelliJ IDEA, Eclipse)

## Setup Instructions

### 1. Database Setup

Create a MySQL database:
```sql
CREATE DATABASE hireza_job_portal;
CREATE USER 'hireza_user'@'localhost' IDENTIFIED BY 'hireza_password';
GRANT ALL PRIVILEGES ON hireza_job_portal.* TO 'hireza_user'@'localhost';
FLUSH PRIVILEGES;
```

### 2. Configure Application Properties

Update `src/main/resources/application.properties`:
```properties
# Database Configuration
spring.datasource.url=jdbc:mysql://localhost:3306/hireza_job_portal?createDatabaseIfNotExist=true&useSSL=false&serverTimezone=UTC
spring.datasource.username=hireza_user
spring.datasource.password=hireza_password

# Email Configuration (Optional - for notifications)
spring.mail.host=smtp.gmail.com
spring.mail.port=587
spring.mail.username=your-email@gmail.com
spring.mail.password=your-app-password
```

### 3. Build and Run

```bash
# Clone the repository
git clone <repository-url>
cd hireza-job-portal

# Build the project
mvn clean install

# Run the application
mvn spring-boot:run
```

The application will start on `http://localhost:8080`

### 4. Access the Application

#### Demo Accounts
The application creates demo accounts automatically:

- **Admin**: admin@hireza.com / admin123
- **Counselor**: counselor@hireza.com / counselor123  
- **User**: user@hireza.com / user123

#### URLs
- **Home**: http://localhost:8080/
- **Login**: http://localhost:8080/login
- **Register**: http://localhost:8080/register
- **Admin Dashboard**: http://localhost:8080/admin/dashboard
- **Counselor Dashboard**: http://localhost:8080/counselor/dashboard
- **User Dashboard**: http://localhost:8080/user/dashboard

## Project Structure

```
src/
├── main/
│   ├── java/com/hireza/jobportal/
│   │   ├── config/           # Configuration classes
│   │   ├── controller/       # REST controllers
│   │   ├── model/           # Entity classes
│   │   ├── repository/      # Data access layer
│   │   ├── service/         # Business logic
│   │   └── JobPortalApplication.java
│   ├── resources/
│   │   ├── static/          # CSS, JS, images
│   │   └── application.properties
│   └── webapp/WEB-INF/views/ # JSP templates
└── test/                    # Test classes
```

## Database Schema

### Main Entities
- **Users**: System users with roles (ADMIN, COUNSELOR, USER)
- **Jobs**: Job postings with details and categories
- **CVs**: Uploaded resumes with status tracking
- **Messages**: Communication between counselors and users
- **Sessions**: Scheduled counseling appointments
- **JobSuggestions**: Job recommendations from counselors

## API Endpoints

### Authentication
- `GET /login` - Login page
- `POST /login` - Process login
- `GET /register` - Registration page
- `POST /register` - Process registration
- `POST /logout` - Logout

### Admin Endpoints
- `GET /admin/dashboard` - Admin dashboard
- `GET /admin/jobs/list` - List all jobs
- `GET /admin/jobs/create` - Create job form
- `POST /admin/jobs/create` - Process job creation
- `GET /admin/jobs/edit/{id}` - Edit job form
- `POST /admin/jobs/edit/{id}` - Process job update
- `POST /admin/jobs/delete/{id}` - Delete job

### User Endpoints
- `GET /user/dashboard` - User dashboard
- `GET /user/submit-cv` - CV upload form
- `POST /user/submit-cv` - Process CV upload
- `GET /user/jobs` - Browse jobs
- `GET /user/job/{id}` - Job details

### Counselor Endpoints
- `GET /counselor/dashboard` - Counselor dashboard
- `GET /counselor/review` - CV review list
- `POST /counselor/update-status` - Update CV status
- `POST /counselor/feedback` - Add feedback
- `POST /counselor/suggest-job` - Suggest job to user

## File Upload Configuration

- **Maximum file size**: 10MB
- **Allowed formats**: PDF, DOC, DOCX
- **Storage location**: `uploads/cvs/` (configurable)

## Security Features

- Password encryption using BCrypt
- CSRF protection
- Session management
- Role-based access control
- XSS protection

## Development

### Running in Development Mode
```bash
mvn spring-boot:run -Dspring.profiles.active=dev
```

### Testing
```bash
mvn test
```

### Building for Production
```bash
mvn clean package -Pprod
```

## Customization

### Adding New Roles
1. Update `Role` enum in `model/Role.java`
2. Add security configuration in `SecurityConfig.java`
3. Create appropriate controllers and views

### Extending User Profile
1. Add fields to `User` entity
2. Update registration form
3. Modify user dashboard

### Adding Email Notifications
1. Configure SMTP settings in `application.properties`
2. Use `EmailService` to send notifications
3. Create email templates

## Troubleshooting

### Common Issues

1. **Database Connection Error**
   - Verify MySQL is running
   - Check database credentials
   - Ensure database exists

2. **File Upload Issues**
   - Check file size limits
   - Verify upload directory permissions
   - Ensure allowed file types

3. **JSP Not Found**
   - Verify JSP files are in `WEB-INF/views/`
   - Check view resolver configuration

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make changes and add tests
4. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For support and questions:
- Create an issue on GitHub
- Email: support@hireza.com
- Documentation: [Project Wiki](wiki-link)