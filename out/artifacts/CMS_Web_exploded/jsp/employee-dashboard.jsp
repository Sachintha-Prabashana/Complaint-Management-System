<%--
  Created by IntelliJ IDEA.
  User: Sachi
  Date: 6/13/2025
  Time: 10:28 PM
  To change this template use File | Settings | File Templates.
--%>
<!-- EMPLOYEE DASHBOARD (employee-dashboard.jsp) -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, java.text.*" %>
<%@ page import="lk.ijse.dto.ComplaintDTO" %>
<%@ page import="lk.ijse.dto.ComplaintDTO" %>
<%
    List<ComplaintDTO> complaints = (List<ComplaintDTO>) request.getAttribute("complaints");
%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Employee Dashboard - Complaint Management System</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/employee.css">

</head>
<body>
<!-- Header -->
<div class="dashboard-header">
    <div class="container">
        <div class="d-flex justify-content-between align-items-center">
            <div class="navbar-brand">
                Complaint Management System
            </div>
            <div class="user-info">
                <div class="user-avatar">
                    <%= session.getAttribute("username") != null ?
                            session.getAttribute("username").toString().substring(0,1).toUpperCase() : "U" %>
                </div>
                <div>
                    <div class="fw-semibold"><%= session.getAttribute("username") %></div>
                    <small class="opacity-75">Employee</small>
                </div>
                <a href="<%=request.getContextPath()%>/logout" class="logout-btn">Logout</a>
            </div>
        </div>
    </div>
</div>

<div class="dashboard-content">
    <div class="container">
        <div class="row mb-4">
            <div class="col-md-12">
                <div class="action-card">
                    <div class="card-header">Quick Actions</div>
                    <div class="card-body">
                        <p class="text-muted mb-3">Submit a new complaint to get started</p>
                        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#newComplaintModal">
                            Submit New Complaint
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Complaints Table -->
        <div class="complaint-table">
            <div class="card-header">My Complaints</div>
            <div class="table-responsive">
                <table class="table">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Title</th>
                        <th>Category</th>
                        <th>Status</th>
                        <th>Date</th>
                        <th>Remarks</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <% if (complaints != null && !complaints.isEmpty()) {
                        for (ComplaintDTO complaint : complaints) { %>
                    <tr>
                        <td><%= complaint.getId() %></td>
                        <td><%= complaint.getTitle() %></td>
                        <td><%= complaint.getCategory() %></td>
                        <td>
            <span class="status-badge status-<%= complaint.getStatus().toLowerCase() %>">
                <%= complaint.getStatus() %>
            </span>
                        </td>
                        <td><%= complaint.getDate() %></td>
                        <td><%= complaint.getRemarks() != null ? complaint.getRemarks() : "No remarks yet" %></td>
                        <td>
                            <% if (!"Resolved".equalsIgnoreCase(complaint.getStatus())) { %>
                            <a href="<%= request.getContextPath() %>/jsp/edit-complaint.jsp?id=<%= complaint.getId() %>" class="btn btn-outline-primary btn-sm">Edit</a>

                            <button type="button" class="btn btn-outline-danger btn-sm" data-bs-toggle="modal" data-bs-target="#deleteModal_<%= complaint.getId() %>">
                                Delete
                            </button>
                            <div class="modal fade" id="deleteModal_<%= complaint.getId() %>" tabindex="-1">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <form action="<%= request.getContextPath() %>/employeeServlet" method="post">
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
                            <% } else { %>
                            <span class="text-muted">Locked</span>
                            <% } %>
                        </td>
                    </tr>
                    <%  }
                    } else { %>
                    <tr><td colspan="7" class="text-center text-muted">No complaints submitted yet.</td></tr>
                    <% } %>
                    </tbody>
                </table>

            </div>
        </div>
    </div>
</div>

<!-- New Complaint Modal -->
<div class="modal fade" id="newComplaintModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Submit New Complaint</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <form id="complaintForm" action="<%=request.getContextPath()%>/employeeServlet" method="post">
                    <input type="hidden" name="action" value="submit">

                    <div class="mb-3">
                        <label for="title" class="form-label">Complaint Title</label>
                        <input type="text" class="form-control" id="title" name="title" required>
                    </div>
                    <div class="mb-3">
                        <label for="category" class="form-label">Category</label>
                        <select class="form-select" id="category" name="category" required>
                            <option value="">Select Category</option>
                            <option value="Technical">Technical</option>
                            <option value="Facilities">Facilities</option>
                            <option value="HR">Human Resources</option>
                            <option value="Other">Other</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="description" class="form-label">Description</label>
                        <textarea class="form-control" id="description" name="description" rows="4" required></textarea>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <button type="submit" form="complaintForm" class="btn btn-primary">Submit Complaint</button>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<!-- SweetAlert -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script src="<%= request.getContextPath() %>/js/alerts.js"></script>

</body>
</html>