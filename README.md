# Complaint Management System (CMS)

A comprehensive web-based complaint management system designed to streamline the process of complaint submission, tracking, and resolution within organizations. Built with Java Servlets, JSP, and MySQL, this system provides role-based access control for employees and administrators.

## 🚀 Project Overview

The Complaint Management System is a robust web application that facilitates efficient complaint handling in organizational environments. It provides a user-friendly interface for employees to submit and manage their complaints while offering administrators comprehensive tools to monitor, update, and resolve all complaints in the system.

## ✨ Features

### Employee Features
- **Complaint Submission**: Submit new complaints with detailed descriptions and categories
- **View Personal Complaints**: Access and review all previously submitted complaints
- **Edit Complaints**: Modify complaint details before admin review
- **Delete Complaints**: Remove complaints that are no longer relevant
- **Status Tracking**: Monitor complaint status and admin remarks
- **User Authentication**: Secure login system with session management

### Administrator Features
- **Dashboard Overview**: Comprehensive view of all complaints in the system
- **Complaint Management**: View detailed information for all submitted complaints
- **Status Updates**: Update complaint status (Pending, In Progress, Resolved, Rejected)
- **Admin Remarks**: Add detailed remarks and feedback for each complaint
- **User Management**: Manage employee accounts and permissions
- **Complaint Deletion**: Remove inappropriate or resolved complaints
- **Reporting**: Generate reports on complaint trends and resolution metrics

## 🛠️ Technologies Used

### Backend
- **Java Servlets**: Server-side request handling and business logic
- **JSP (Java Server Pages)**: Dynamic web page generation
- **JDBC**: Database connectivity and operations
- **Apache Tomcat**: Web server and servlet container

### Frontend
- **HTML5**: Semantic markup structure
- **CSS3**: Custom styling and responsive design
- **Bootstrap 5**: Responsive UI framework and components
- **JavaScript**: Client-side interactivity and form validation

### Database
- **MySQL**: Relational database management system
- **MySQL Connector/J**: JDBC driver for MySQL connectivity

### Development Tools
- **Apache Maven**: Dependency management and build automation
- **Git**: Version control system
- **IDE**: Eclipse/IntelliJ IDEA support

## 📖 Usage Guide

### For Employees

1. **Registration/Login**
   - New users can register with their email and create credentials
   - Existing users can log in with username/email and password

2. **Submitting Complaints**
   - Navigate to "Submit Complaint" page
   - Fill in complaint title, description, and select category
   - Choose priority level and submit

3. **Managing Complaints**
   - View all personal complaints in the dashboard
   - Edit complaint details if status is still "Pending"
   - Delete complaints that are no longer needed
   - Track status updates and admin remarks

### For Administrators

1. **Admin Dashboard**
   - Access comprehensive overview of all complaints
   - View statistics and complaint trends
   - Quick action buttons for common tasks

2. **Complaint Management**
   - Review complaint details and user information
   - Update complaint status with appropriate remarks
   - Assign priority levels and set resolution timelines
   - Delete inappropriate or spam complaints

3. **User Management**
   - View all registered users
   - Activate/deactivate user accounts
   - Reset user passwords if needed

## 📁 Project Structure

```
complaint-management-system/
cms-project/
│
├── src/
│   ├── controller/        # Servlet classes for handling requests
│   ├── model/             # Data models and DAO classes
│   ├── dto/               # Data Transfer Objects
│   └── utils/             # Utility classes (DB connection, helpers)
│
├── webapp/
│   ├── jsp/               # JSP pages (login, dashboards, forms)
│   ├── css/               # Stylesheets (Bootstrap)
│   └── js/                # Client-side scripts
│
├── database/
│   └── schema.sql         # Database schema and sample data
│
└── README.md              # Project documentation
```

## 🤝 Contributing

We welcome contributions to improve the Complaint Management System! Please follow these guidelines:

### How to Contribute

1.Clone the repository:

git clone https://github.com/hasinduudara/CMS.git

2.Import the project into your IDE (e.g., IntelliJ IDEA or Eclipse).
3.Set up a MySQL database using the schema above.
4.Configure DBContextListner.java with your DB credentials.
5.Deploy the project on Apache Tomcat (v10+ recommended).
6.Access the system:
## 📞 Contact Information

### Project Maintainer
- **Name**: [Sachintha Prabashana]
- **Email**: [sachinthaprabashana2003@gmail.com]
- **GitHub**: [@Sachintha-Prabashana](https://github.com/Sachintha-Prabashana)

### Support
- **Project Repository**: [https://github.com/yourusername/complaint-management-system](https://github.com/Sachintha-Prabashana/Complaint-Management-System.git)

---

**Thank you for using the Complaint Management System! We hope this tool helps streamline your organization's complaint handling process.**
