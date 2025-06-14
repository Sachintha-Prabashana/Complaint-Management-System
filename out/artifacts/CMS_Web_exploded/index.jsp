<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Complaint Management System</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .main-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            border: none;
        }

        .welcome-title {
            color: #2c3e50;
            font-weight: 600;
        }

        .btn-primary {
            background: linear-gradient(45deg, #007bff, #0056b3);
            border: none;
            border-radius: 25px;
            padding: 12px 30px;
            font-weight: 500;
            transition: transform 0.2s ease;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,123,255,0.3);
        }

        .navbar {
            background: rgba(255,255,255,0.95) !important;
            backdrop-filter: blur(10px);
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .navbar-brand {
            color: #2c3e50 !important;
            font-weight: 600;
        }

        footer {
            background: rgba(44, 62, 80, 0.9);
            color: white;
            padding: 30px 0;
        }
    </style>
</head>
<body>
<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-light">
    <div class="container">
        <span class="navbar-brand">Complaint Management System</span>
    </div>
</nav>

<!-- Main Content -->
<div class="container d-flex justify-content-center align-items-center" style="min-height: 80vh;">
    <div class="main-card p-5 text-center" style="max-width: 500px; width: 100%;">
        <h2 class="welcome-title mb-4">Welcome!</h2>
        <p class="text-muted mb-4">
            Manage complaints efficiently with our easy-to-use system.
            Report issues, track progress, and get quick resolutions.
        </p>
        <a href="signIn.jsp" class="btn btn-primary btn-lg">Login to Continue</a>
    </div>
</div>

<%--<!-- Footer -->
<footer class="text-center">
    <div class="container">
        <p class="mb-0">&copy; 2025 Complaint Management System. All rights reserved.</p>
    </div>
</footer>--%>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>