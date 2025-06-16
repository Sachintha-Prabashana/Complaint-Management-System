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
    <style>
        :root {
            --primary-color: #2c3e50;
            --secondary-color: #34495e;
            --accent-color: #e74c3c;
            --success-color: #27ae60;
            --warning-color: #f39c12;
            --info-color: #3498db;
            --light-bg: #ecf0f1;
            --dark-text: #2c3e50;
            --border-color: #bdc3c7;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: var(--light-bg);
            color: var(--dark-text);
            line-height: 1.6;
        }

        /* Header Styles */
        .dashboard-header {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            padding: 1rem 0;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .navbar-brand {
            font-size: 1.5rem;
            font-weight: bold;
            color: white;
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .user-avatar {
            width: 45px;
            height: 45px;
            background: rgba(255,255,255,0.2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            font-size: 1.2rem;
            border: 2px solid rgba(255,255,255,0.3);
        }

        .logout-btn {
            background: var(--accent-color);
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 5px;
            text-decoration: none;
            transition: all 0.3s ease;
        }

        .logout-btn:hover {
            background: #c0392b;
            color: white;
            transform: translateY(-1px);
        }

        /* Dashboard Content */
        .dashboard-content {
            padding: 2rem 0;
            min-height: calc(100vh - 80px);
        }

        /* Statistics Cards */
        .stats-card {
            background: white;
            border-radius: 10px;
            padding: 1.5rem;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            border-left: 4px solid var(--info-color);
            transition: all 0.3s ease;
            height: 100%;
        }

        .stats-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(0,0,0,0.15);
        }

        .stats-card.total { border-left-color: var(--info-color); }
        .stats-card.pending { border-left-color: var(--warning-color); }
        .stats-card.resolved { border-left-color: var(--success-color); }
        .stats-card.rejected { border-left-color: var(--accent-color); }

        .stats-number {
            font-size: 2.5rem;
            font-weight: bold;
            margin-bottom: 0.5rem;
        }

        .stats-number.total { color: var(--info-color); }
        .stats-number.pending { color: var(--warning-color); }
        .stats-number.resolved { color: var(--success-color); }
        .stats-number.rejected { color: var(--accent-color); }

        .stats-label {
            color: #7f8c8d;
            font-size: 0.9rem;
            text-transform: uppercase;
            font-weight: 500;
            letter-spacing: 0.5px;
        }

        .stats-icon {
            font-size: 1.5rem;
            opacity: 0.7;
            float: right;
        }

        /* Action Cards */
        .action-card {
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            margin-bottom: 1.5rem;
            overflow: hidden;
        }

        .card-header {
            background: var(--primary-color);
            color: white;
            padding: 1rem 1.5rem;
            font-weight: 600;
            border-bottom: none;
        }

        .card-body {
            padding: 1.5rem;
        }

        /* Complaints Table */
        .complaint-table {
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            overflow: hidden;
        }

        .table {
            margin-bottom: 0;
        }

        .table thead th {
            background: var(--light-bg);
            border-bottom: 2px solid var(--border-color);
            font-weight: 600;
            color: var(--dark-text);
            padding: 1rem;
        }

        .table tbody td {
            padding: 1rem;
            vertical-align: middle;
            border-bottom: 1px solid #ecf0f1;
        }

        .table tbody tr:hover {
            background-color: #f8f9fa;
        }

        /* Status Badges */
        .status-badge {
            padding: 0.3rem 0.8rem;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .status-pending {
            background: rgba(243, 156, 18, 0.1);
            color: var(--warning-color);
            border: 1px solid var(--warning-color);
        }

        .status-resolved {
            background: rgba(39, 174, 96, 0.1);
            color: var(--success-color);
            border: 1px solid var(--success-color);
        }

        .status-rejected {
            background: rgba(231, 76, 60, 0.1);
            color: var(--accent-color);
            border: 1px solid var(--accent-color);
        }

        .status-in-progress {
            background: rgba(52, 152, 219, 0.1);
            color: var(--info-color);
            border: 1px solid var(--info-color);
        }

        /* Action Buttons */
        .action-buttons {
            display: flex;
            gap: 0.5rem;
            flex-wrap: wrap;
        }

        .btn-sm {
            padding: 0.3rem 0.8rem;
            font-size: 0.8rem;
            border-radius: 5px;
        }

        .btn-outline-primary:hover {
            transform: translateY(-1px);
        }

        .btn-outline-success:hover {
            transform: translateY(-1px);
        }

        .btn-outline-danger:hover {
            transform: translateY(-1px);
        }

        /* Modal Styles */
        .modal-content {
            border-radius: 10px;
            border: none;
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
        }

        .modal-header {
            background: var(--primary-color);
            color: white;
            border-radius: 10px 10px 0 0;
        }

        .btn-close {
            filter: invert(1);
        }

        /* Form Styles */
        .form-control, .form-select {
            border-radius: 5px;
            border: 1px solid var(--border-color);
            padding: 0.6rem 1rem;
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.2rem rgba(44, 62, 80, 0.25);
        }

        /* Filter Section */
        .filter-section {
            background: white;
            border-radius: 10px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }

        .search-box {
            position: relative;
        }

        .search-box i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #7f8c8d;
        }

        .search-box input {
            padding-left: 2.5rem;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .stats-number {
                font-size: 2rem;
            }

            .action-buttons {
                flex-direction: column;
            }

            .table-responsive {
                font-size: 0.9rem;
            }

            .user-info {
                flex-direction: column;
                gap: 0.5rem;
            }
        }

        /* Animation Classes */
        .fade-in {
            animation: fadeIn 0.5s ease-in;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
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
                <a href="<%=request.getContextPath()%>/logout" class="logout-btn">
                    <i class="fas fa-sign-out-alt me-1"></i>Logout
                </a>
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
<%--                            <a href="javascript:void(0)" class="btn btn-outline-primary btn-sm" onclick="viewComplaint('<%= complaint.getId() %>')">View</a>--%>
                            <a href="javascript:void(0)" class="btn btn-outline-success btn-sm" onclick="openUpdateModal('<%= complaint.getId() %>', '<%= complaint.getStatus() %>', '<%= complaint.getRemarks() != null ? complaint.getRemarks().replace("'", "\\'") : "" %>')">Update</a>
                            <button type="button" class="btn btn-outline-danger btn-sm" data-bs-toggle="modal" data-bs-target="#deleteModal_<%= complaint.getId() %>">
                                Delete
                            </button>
                            <div class="modal fade" id="deleteModal_<%= complaint.getId() %>" tabindex="-1">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <form action="<%= request.getContextPath() %>/deleteComplaint" method="post">
                                            <div class="modal-header">
                                                <h5 class="modal-title text-danger">Confirm Delete</h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                            </div>
                                            <div class="modal-body">
                                                <p>Are you sure you want to delete complaint <strong><%= complaint.getId() %></strong>?</p>
                                                <input type="hidden" name="id" value="<%= complaint.getId() %>">
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

<!-- Update Status Modal -->
<div class="modal fade" id="updateStatusModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">
                    <i class="fas fa-edit me-2"></i>Update Complaint Status
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <form id="updateStatusForm" action="<%=request.getContextPath()%>/updateComplain" method="post">
                    <input type="hidden" id="complaintId" name="complaintId">
                    <div class="mb-3">
                        <label class="form-label">Complaint ID</label>
                        <input type="text" class="form-control" id="displayComplaintId" readonly>
                    </div>
                    <div class="mb-3">
                        <label for="newStatus" class="form-label">New Status</label>
                        <select class="form-select" id="newStatus" name="status" required>
                            <option value="">Select Status</option>
                            <option value="pending">Pending</option>
                            <option value="in-progress">In Progress</option>
                            <option value="resolved">Resolved</option>
                            <option value="rejected">Rejected</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="adminRemarks" class="form-label">Admin Remarks</label>
                        <textarea class="form-control" id="adminRemarks" name="remarks" rows="4"
                                  placeholder="Add your remarks about this complaint..."></textarea>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <button type="submit" form="updateStatusForm" class="btn btn-primary">
                    <i class="fas fa-save me-1"></i>Update Status
                </button>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function openUpdateModal(id, status, remark) {
        document.getElementById("complaintId").value = id;
        document.getElementById("newStatus").value = status;
        document.getElementById("adminRemarks").value = remark || "";
        const modal = new bootstrap.Modal(document.getElementById("updateStatusModal"));
        modal.show();
    }
</script>


</body>
</html>