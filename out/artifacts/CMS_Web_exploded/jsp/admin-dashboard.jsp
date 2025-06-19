<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 6/14/2025
  Time: 12:00 PM
  To change this template use File | Settings | File Templates.
--%>
<!-- ADMIN DASHBOARD (admin-dashboard.jsp) -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, java.text.*" %>
<%@ page import="lk.ijse.dto.ComplaintDTO, lk.ijse.model.ComplaintModel" %>
<%
    ComplaintModel complaintModel = new ComplaintModel();
    List<ComplaintDTO> complaintList = complaintModel.getAllComplaints();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard - Complaint Management System</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/admin-dashboard.css">


</head>
<body>
<!-- Header -->
<div class="dashboard-header">
    <div class="container">
        <div class="d-flex justify-content-between align-items-center">
            <div class="navbar-brand">
                <i class="fas fa-user-shield me-2"></i>
                Admin Panel - Complaint Management
            </div>
            <div class="user-info">
                <div class="user-avatar">
                    <%= session.getAttribute("username") != null ?
                            session.getAttribute("username").toString().substring(0,1).toUpperCase() : "A" %>
                </div>
                <div>
                    <div class="fw-semibold"><%= session.getAttribute("username") %></div>
                    <small class="opacity-75">Administrator</small>
                </div>
                <a href="<%=request.getContextPath()%>/logout" class="logout-btn">Logout</a>
            </div>
        </div>
    </div>
</div>

<!-- Dashboard Content -->
<div class="dashboard-content">
    <div class="container">
        <!-- Complaints Table -->
        <div class="complaint-table fade-in">
            <div class="card-header">
                <i class="fas fa-list me-2"></i>All Complaints Management
            </div>
            <div class="table-responsive">
                <table class="table" id="complaintsTable">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Employee</th>
                        <th>Title</th>
                        <th>Category</th>
                        <th>Status</th>
                        <th>Date</th>
                        <th>Remark</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <% if (complaintList != null && !complaintList.isEmpty()) {
                        for (ComplaintDTO complaint : complaintList) { %>
                    <tr>
                        <td><%= complaint.getId() %></td>
                        <td><%= complaint.getUserId() %></td>
                        <td><%= complaint.getTitle() %></td>
                        <td><%= complaint.getCategory() %></td>
                        <td>
        <span class="status-badge status-<%= complaint.getStatus().toLowerCase() %>">
            <%= complaint.getStatus() %>
        </span>
                        </td>
                        <td><%= complaint.getDate() %></td>
                        <td><%= complaint.getRemarks() != null ? complaint.getRemarks() : "" %></td>
                        <td class="action-buttons">
                            <a href="<%= request.getContextPath() %>/jsp/edit-admin-complaint.jsp?id=<%= complaint.getId() %>"
                               class="btn btn-outline-primary btn-sm">
                                Edit
                            </a>

                            <button type="button" class="btn btn-outline-danger btn-sm" data-bs-toggle="modal" data-bs-target="#deleteModal_<%= complaint.getId() %>">
                                Delete
                            </button>

                            <div class="modal fade" id="deleteModal_<%= complaint.getId() %>" tabindex="-1">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <form action="<%= request.getContextPath() %>/adminComplaint" method="post">
                                            <input type="hidden" name="action" value="delete">
                                            <input type="hidden" name="id" value="<%= complaint.getId() %>">
                                            <div class="modal-header">
                                                <h5 class="modal-title text-danger">Confirm Delete</h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                            </div>
                                            <div class="modal-body">
                                                <p>Are you sure you want to delete complaint <strong><%= complaint.getId() %></strong>?</p>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                                <button type="submit" class="btn btn-danger">Delete</button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </td>

                    </tr>
                    <%  }
                    } else { %>
                    <tr><td colspan="8" class="text-center text-muted">No complaints found.</td></tr>
                    <% } %>
                    </tbody>

                </table>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>