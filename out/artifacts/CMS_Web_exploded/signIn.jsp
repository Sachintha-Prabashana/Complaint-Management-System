<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Sign In - Complaint Management System</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            background: #ffffff;
            min-height: 100vh;
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #1a1a1a;
        }

        .auth-container {
            width: 100%;
            max-width: 400px;
            padding: 0 20px;
        }

        .auth-card {
            background: #ffffff;
            border-radius: 12px;
            border: 1px solid #e5e7eb;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }

        .auth-header {
            background: linear-gradient(135deg, #2563eb 0%, #1d4ed8 100%);
            color: white;
            padding: 2rem;
            text-align: center;
        }

        .auth-header h1 {
            font-size: 1.5rem;
            font-weight: 600;
            margin-bottom: 0.25rem;
        }

        .auth-subtitle {
            font-size: 0.875rem;
            opacity: 0.9;
        }

        .auth-body {
            padding: 2rem;
        }

        .form-group {
            margin-bottom: 1.25rem;
        }

        .form-label {
            display: block;
            font-weight: 500;
            color: #374151;
            margin-bottom: 0.5rem;
            font-size: 0.875rem;
        }

        .form-control {
            width: 100%;
            padding: 0.75rem 1rem;
            border: 1px solid #d1d5db;
            border-radius: 6px;
            font-size: 0.95rem;
            transition: all 0.2s ease;
            outline: none;
        }

        .form-control:focus {
            border-color: #2563eb;
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
        }

        .btn-primary {
            width: 100%;
            padding: 0.75rem;
            background: linear-gradient(135deg, #2563eb 0%, #1d4ed8 100%);
            color: white;
            border: none;
            border-radius: 6px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .btn-primary:hover {
            background: linear-gradient(135deg, #1d4ed8 0%, #1e40af 100%);
            transform: translateY(-1px);
        }

        .alert {
            padding: 0.75rem;
            border-radius: 6px;
            margin-bottom: 1rem;
            font-size: 0.875rem;
        }

        .alert-danger {
            background-color: #fef2f2;
            color: #dc2626;
            border: 1px solid #fecaca;
        }

        .alert-success {
            background-color: #f0fdf4;
            color: #16a34a;
            border: 1px solid #bbf7d0;
        }

        .auth-footer {
            text-align: center;
            margin-top: 1.5rem;
            padding-top: 1.5rem;
            border-top: 1px solid #f3f4f6;
        }

        .auth-link {
            color: #2563eb;
            text-decoration: none;
            font-size: 0.875rem;
        }

        .auth-link:hover {
            text-decoration: underline;
        }

        .text-muted {
            color: #6b7280;
            font-size: 0.875rem;
        }

        @media (max-width: 480px) {
            .auth-container {
                padding: 0 15px;
            }
            .auth-header, .auth-body {
                padding: 1.5rem;
            }
        }
    </style>
</head>
<body>
<div class="auth-container">
    <div class="auth-card">
        <div class="auth-header">
            <h1>Sign In</h1>
            <p class="auth-subtitle">Welcome back to CMS</p>
        </div>

        <div class="auth-body">
            <%
                String errorMessage = request.getParameter("error");
                if (errorMessage != null && !errorMessage.isEmpty()) {
            %>
            <div class="alert alert-danger">
                Invalid username or password. Please try again.
            </div>
            <% } %>

            <form action="signIn" method="post" id="signinForm">
                <div class="form-group">
                    <label for="username" class="form-label">Username</label>
                    <input type="text" class="form-control" id="username" name="username"
                           placeholder="Enter your username" required>
                </div>

                <div class="form-group">
                    <label for="password" class="form-label">Password</label>
                    <input type="password" class="form-control" id="password" name="password"
                           placeholder="Enter your password" required>
                </div>

                <button type="submit" class="btn-primary">
                    Sign In
                </button>
            </form>

            <div class="auth-footer">
                <p class="text-muted">
                    Don't have an account?
                    <a href="signUp.jsp" class="auth-link">Sign up here</a>
                </p>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<%--<script>--%>
<%--    document.getElementById('signinForm').addEventListener('submit', function(e) {--%>
<%--        const username = document.getElementById('username').value.trim();--%>
<%--        const password = document.getElementById('password').value.trim();--%>

<%--        if (!username || !password) {--%>
<%--            e.preventDefault();--%>
<%--            alert('Please fill in all required fields.');--%>
<%--            return false;--%>
<%--        }--%>
<%--    });--%>
<%--</script>--%>
</body>
</html>