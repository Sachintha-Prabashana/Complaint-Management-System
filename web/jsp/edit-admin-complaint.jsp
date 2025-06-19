<%--
  Created by IntelliJ IDEA.
  User: Sachi
  Date: 6/19/2025
  Time: 1:58 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="lk.ijse.dto.ComplaintDTO, lk.ijse.model.ComplaintModel" %>
<%
    String id = request.getParameter("id");
    ComplaintModel model = new ComplaintModel();
    ComplaintDTO complaint = model.getComplaintById(id);

    if (complaint == null) {
%>
<div class="alert alert-danger">Complaint not found.</div>
<a href="<%= request.getContextPath() %>/jsp/admin-dashboard.jsp">Back to Dashboard</a>
<%
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Update Complaint - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h3><i class="fas fa-edit me-2"></i>Update Complaint Status</h3>
    <hr>

    <form action="<%= request.getContextPath() %>/adminComplaint" method="post" class="p-4 bg-light rounded shadow-sm">
        <input type="hidden" name="action" value="update">
        <input type="hidden" name="complaintId" value="<%= complaint.getId() %>">

        <div class="mb-3">
            <label for="complaintIdDisplay" class="form-label">Complaint ID</label>
            <input type="text" class="form-control" id="complaintIdDisplay" value="<%= complaint.getId() %>" readonly>
        </div>

        <div class="mb-3">
            <label for="status" class="form-label">Status</label>
            <select class="form-select" id="status" name="status" required>
                <option value="">Select Status</option>
                <option value="Pending" <%= "Pending".equalsIgnoreCase(complaint.getStatus()) ? "selected" : "" %>>Pending</option>
                <option value="Resolved" <%= "Resolved".equalsIgnoreCase(complaint.getStatus()) ? "selected" : "" %>>Resolved</option>
                <option value="Rejected" <%= "Rejected".equalsIgnoreCase(complaint.getStatus()) ? "selected" : "" %>>Rejected</option>
            </select>
        </div>

        <div class="mb-3">
            <label for="remarks" class="form-label">Admin Remarks</label>
            <textarea class="form-control" id="remarks" name="remarks" rows="5" placeholder="Enter remarks..."><%= complaint.getRemarks() != null ? complaint.getRemarks() : "" %></textarea>
        </div>

        <div class="d-flex justify-content-between">
            <a href="<%= request.getContextPath() %>/jsp/admin-dashboard.jsp" class="btn btn-secondary">
                <i class="fas fa-arrow-left me-1"></i>Back
            </a>
            <button type="submit" class="btn btn-primary">
                <i class="fas fa-save me-1"></i>Update
            </button>
        </div>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
