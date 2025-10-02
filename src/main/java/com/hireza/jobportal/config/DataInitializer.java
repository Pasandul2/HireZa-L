package com.hireza.jobportal.config;

import com.hireza.jobportal.model.User;
import com.hireza.jobportal.model.Role;
import com.hireza.jobportal.model.Job;
import com.hireza.jobportal.model.JobType;
import com.hireza.jobportal.service.UserService;
import com.hireza.jobportal.service.JobService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

@Component
public class DataInitializer implements CommandLineRunner {

    @Autowired
    private UserService userService;

    @Autowired
    private JobService jobService;

    @Override
    public void run(String... args) throws Exception {
        initializeUsers();
        initializeJobs();
    }

    private void initializeUsers() {
        // Create Admin user
        if (!userService.emailExists("admin@hireza.com")) {
            User admin = new User();
            admin.setFullName("System Administrator");
            admin.setEmail("admin@hireza.com");
            admin.setPassword("admin123");
            admin.setPhone("+1234567890");
            admin.setAddress("123 Admin Street, City");
            admin.setRole(Role.ADMIN);
            userService.createUser(admin);
            System.out.println("Admin user created: admin@hireza.com / admin123");
        }

        // Create Counselor user
        if (!userService.emailExists("counselor@hireza.com")) {
            User counselor = new User();
            counselor.setFullName("Career Counselor");
            counselor.setEmail("counselor@hireza.com");
            counselor.setPassword("counselor123");
            counselor.setPhone("+1234567891");
            counselor.setAddress("456 Counselor Avenue, City");
            counselor.setRole(Role.COUNSELOR);
            userService.createUser(counselor);
            System.out.println("Counselor user created: counselor@hireza.com / counselor123");
        }

        // Create Demo User
        if (!userService.emailExists("user@hireza.com")) {
            User user = new User();
            user.setFullName("John Doe");
            user.setEmail("user@hireza.com");
            user.setPassword("user123");
            user.setPhone("+1234567892");
            user.setAddress("789 User Lane, City");
            user.setRole(Role.USER);
            userService.createUser(user);
            System.out.println("Demo user created: user@hireza.com / user123");
        }
    }

    private void initializeJobs() {
        if (jobService.getActiveJobCount() == 0) {
            // Create sample jobs
            Job job1 = new Job();
            job1.setTitle("Software Developer");
            job1.setDescription("We are looking for a skilled Software Developer to join our dynamic team. The ideal candidate will have experience in Java, Spring Boot, and modern web technologies.");
            job1.setCategory("Technology");
            job1.setCompany("TechCorp Inc.");
            job1.setLocation("New York, NY");
            job1.setJobType(JobType.FULL_TIME);
            job1.setSalaryRange("$70,000 - $90,000");
            job1.setRequirements("Bachelor's degree in Computer Science, 2+ years experience with Java and Spring framework, knowledge of databases");
            job1.setBenefits("Health insurance, 401k, flexible working hours, remote work options");
            jobService.createJob(job1);

            Job job2 = new Job();
            job2.setTitle("Marketing Specialist");
            job2.setDescription("Join our marketing team to help drive brand awareness and customer engagement through innovative campaigns and strategies.");
            job2.setCategory("Marketing");
            job2.setCompany("BrandBoost LLC");
            job2.setLocation("Los Angeles, CA");
            job2.setJobType(JobType.FULL_TIME);
            job2.setSalaryRange("$50,000 - $65,000");
            job2.setRequirements("Bachelor's degree in Marketing or related field, experience with digital marketing tools, strong communication skills");
            job2.setBenefits("Health insurance, dental coverage, paid vacation, professional development opportunities");
            jobService.createJob(job2);

            Job job3 = new Job();
            job3.setTitle("Data Analyst");
            job3.setDescription("Analyze complex datasets to provide actionable insights that drive business decisions and improve operational efficiency.");
            job3.setCategory("Analytics");
            job3.setCompany("DataDriven Solutions");
            job3.setLocation("Chicago, IL");
            job3.setJobType(JobType.FULL_TIME);
            job3.setSalaryRange("$60,000 - $80,000");
            job3.setRequirements("Bachelor's degree in Statistics, Mathematics, or related field, proficiency in SQL and Python, experience with data visualization tools");
            job3.setBenefits("Competitive salary, health benefits, stock options, learning and development budget");
            jobService.createJob(job3);

            Job job4 = new Job();
            job4.setTitle("UI/UX Designer");
            job4.setDescription("Create intuitive and visually appealing user interfaces for web and mobile applications that enhance user experience.");
            job4.setCategory("Design");
            job4.setCompany("Creative Minds Studio");
            job4.setLocation("San Francisco, CA");
            job4.setJobType(JobType.CONTRACT);
            job4.setSalaryRange("$45 - $65 per hour");
            job4.setRequirements("Portfolio showcasing UI/UX design work, proficiency in design tools like Figma, Sketch, or Adobe XD, understanding of user-centered design principles");
            job4.setBenefits("Flexible schedule, remote work, competitive hourly rate, creative freedom");
            jobService.createJob(job4);

            Job job5 = new Job();
            job5.setTitle("Project Manager");
            job5.setDescription("Lead cross-functional teams to deliver projects on time and within budget while ensuring quality standards are met.");
            job5.setCategory("Management");
            job5.setCompany("Global Projects Inc.");
            job5.setLocation("Boston, MA");
            job5.setJobType(JobType.FULL_TIME);
            job5.setSalaryRange("$80,000 - $100,000");
            job5.setRequirements("Bachelor's degree, PMP certification preferred, 3+ years project management experience, strong leadership and communication skills");
            job5.setBenefits("Health insurance, retirement plans, bonus opportunities, professional certification support");
            jobService.createJob(job5);

            System.out.println("Sample jobs created successfully!");
        }
    }
}