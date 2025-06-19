<%--
  Created by IntelliJ IDEA.
  User: Sachi
  Date: 6/15/2025
  Time: 5:18 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="lk.ijse.dto.ComplaintDTO, lk.ijse.model.ComplaintModel" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String idStr = request.getParameter("id");
    ComplaintDTO complaint = new ComplaintModel().getComplaintById(idStr);

    if (complaint == null) {
        out.println("<div class='alert alert-danger'><i class='fas fa-exclamation-triangle me-2'></i>Complaint not found!</div>");
        return;
    }

    if ("Resolved".equalsIgnoreCase(complaint.getStatus())) {
        out.println("<div class='alert alert-warning'><i class='fas fa-info-circle me-2'></i>Resolved complaints cannot be edited.</div>");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Complaint - Complaint Management System</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            background: #f8fafc;
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            color: #1a202c;
            line-height: 1.6;
        }

        .dashboard-header {
            background: linear-gradient(135deg, #2563eb 0%, #1d4ed8 100%);
            color: white;
            padding: 1.5rem 0;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .navbar-brand {
            font-weight: 600;
            font-size: 1.25rem;
        }

        .page-content {
            padding: 2rem 0;
        }

        .page-header {
            margin-bottom: 2rem;
        }

        .page-title {
            color: #374151;
            font-weight: 600;
            font-size: 1.5rem;
            margin-bottom: 0.5rem;
        }

        .page-subtitle {
            color: #64748b;
            font-size: 0.875rem;
        }

        .form-card {
            background: white;
            border-radius: 8px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            border: 1px solid #e2e8f0;
            overflow: hidden;
        }

        .card-header {
            background: #f8fafc;
            padding: 1rem 1.5rem;
            border-bottom: 1px solid #e2e8f0;
            font-weight: 600;
            color: #374151;
        }

        .card-body {
            padding: 1.5rem;
        }

        .form-control, .form-select {
            border: 1px solid #d1d5db;
            border-radius: 6px;
            padding: 0.75rem;
            font-size: 0.875rem;
            transition: all 0.2s;
        }

        .form-control:focus, .form-select:focus {
            border-color: #2563eb;
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
            outline: none;
        }

        .form-label {
            color: #374151;
            font-weight: 500;
            margin-bottom: 0.5rem;
            font-size: 0.875rem;
        }

        .mb-3 {
            margin-bottom: 1.5rem;
        }

        .btn-primary {
            background: linear-gradient(135deg, #2563eb 0%, #1d4ed8 100%);
            border: none;
            padding: 0.75rem 1.5rem;
            border-radius: 6px;
            font-weight: 500;
            transition: all 0.2s;
            font-size: 0.875rem;
        }

        .btn-primary:hover {
            background: linear-gradient(135deg, #1d4ed8 0%, #1e40af 100%);
            transform: translateY(-1px);
        }

        .btn-secondary {
            background: #6b7280;
            border: none;
            padding: 0.75rem 1.5rem;
            border-radius: 6px;
            font-weight: 500;
            transition: all 0.2s;
            font-size: 0.875rem;
            color: white;
        }

        .btn-secondary:hover {
            background: #4b5563;
            transform: translateY(-1px);
            color: white;
        }

        .button-group {
            display: flex;
            gap: 1rem;
            margin-top: 2rem;
        }

        .alert {
            border-radius: 6px;
            border: 1px solid;
            padding: 1rem;
            margin-bottom: 1rem;
        }

        .alert-danger {
            background: #fee2e2;
            border-color: #fecaca;
            color: #991b1b;
        }

        .alert-warning {
            background: #fef3c7;
            border-color: #fde68a;
            color: #92400e;
        }

        .form-icon {
            position: absolute;
            right: 0.75rem;
            top: 50%;
            transform: translateY(-50%);
            color: #6b7280;
            pointer-events: none;
        }

        .input-group {
            position: relative;
        }

        .back-link {
            color: #2563eb;
            text-decoration: none;
            font-size: 0.875rem;
            font-weight: 500;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            margin-bottom: 1rem;
            transition: color 0.2s;
        }

        .back-link:hover {
            color: #1d4ed8;
        }

        @media (max-width: 768px) {
            .page-content {
                padding: 1rem 0;
            }

            .card-body {
                padding: 1rem;
            }

            .button-group {
                flex-direction: column;
            }

            .btn {
                width: 100%;
            }
        }

        .loading-spinner {
            display: none;
            width: 16px;
            height: 16px;
            border: 2px solid transparent;
            border-top: 2px solid currentColor;
            border-radius: 50%;
            animation: spin 1s linear infinite;
            margin-left: 0.5rem;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        .form-control:valid {
            border-color: #10b981;
        }

        .form-control:invalid:not(:focus) {
            border-color: #ef4444;
        }
    </style>
</head>
<body>
<!-- Header -->
<div class="dashboard-header">
    <div class="container">
        <div class="d-flex justify-content-between align-items-center">
            <div class="navbar-brand">
                Complaint Management System
            </div>
        </div>
    </div>
</div>

<!-- Main Content -->
<div class="page-content">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-8 col-md-10">
                <!-- Back Link -->
                <a href="<%= request.getContextPath() %>/jsp/employee-dashboard.jsp" class="back-link">
                    Back to Dashboard
                </a>

                <div class="page-header">
                    <h1 class="page-title">Edit Complaint</h1>
                    <p class="page-subtitle">Update your complaint details and information</p>
                </div>

                <div class="form-card">
                    <div class="card-header">
                        Complaint Information
                    </div>
                    <div class="card-body">
                        <form action="<%= request.getContextPath() %>/employeeServlet" method="post" id="editComplaintForm">
                            <input type="hidden" name="action" value="edit">
                            <input type="hidden" name="id" value="<%= complaint.getId() %>">

                            <div class="mb-3">
                                <label for="title" class="form-label">
                                    <i class="fas fa-heading me-1"></i>
                                    Complaint Title
                                </label>
                                <div class="input-group">
                                    <input type="text"
                                           name="title"
                                           id="title"
                                           class="form-control"
                                           value="<%= complaint.getTitle() %>"
                                           placeholder="Enter a clear and descriptive title"
                                           required>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="category" class="form-label">
                                    Category
                                </label>
                                <div class="input-group">
                                    <select class="form-select" id="category" name="category" required>
                                        <option value="">Choose a category...</option>
                                        <option value="Technical" <%= "Technical".equals(complaint.getCategory()) ? "selected" : "" %>>
                                            Technical Issues
                                        </option>
                                        <option value="Facilities" <%= "Facilities".equals(complaint.getCategory()) ? "selected" : "" %>>
                                            Facilities
                                        </option>
                                        <option value="HR" <%= "HR".equals(complaint.getCategory()) ? "selected" : "" %>>
                                            Human Resources
                                        </option>
                                        <option value="Other" <%= "Other".equals(complaint.getCategory()) ? "selected" : "" %>>
                                            Other
                                        </option>
                                    </select>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="description" class="form-label">
                                    Description
                                </label>
                                <div class="input-group">
                                        <textarea name="description"
                                                  id="description"
                                                  class="form-control"
                                                  rows="5"
                                                  placeholder="Provide a detailed description of your complaint..."
                                                  required><%= complaint.getDescription() %></textarea>
                                </div>
                                <small class="form-text text-muted">
                                    Please provide as much detail as possible to help us resolve your complaint effectively.
                                </small>
                            </div>

                            <div class="button-group">
                                <button type="submit" class="btn btn-primary">
                                    Update Complaint
                                    <div class="loading-spinner" id="loadingSpinner"></div>
                                </button>
                                <a href="<%= request.getContextPath() %>/jsp/employee-dashboard.jsp" class="btn btn-secondary">
                                    Cancel
                                </a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>