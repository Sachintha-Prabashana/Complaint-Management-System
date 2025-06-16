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
        out.println("<h4 class='text-danger'>Complaint not found!</h4>");
        return;
    }

    if ("Resolved".equalsIgnoreCase(complaint.getStatus())) {
        out.println("<h4 class='text-warning'>Resolved complaints cannot be edited.</h4>");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Complaint</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2>Edit Complaint</h2>
    <form action="<%= request.getContextPath() %>/editComplaintServlet" method="post">
        <input type="hidden" name="id" value="<%= complaint.getId() %>">

        <div class="mb-3">
            <label class="form-label">Title</label>
            <input type="text" name="title" class="form-control" value="<%= complaint.getTitle() %>" required>
        </div>

        <div class="mb-3">
            <label for="category" class="form-label">Category</label>
            <select class="form-select" id="category" name="category" required>
                <option value="">Select Category</option>
                <option value="Technical" <%= "Technical".equals(complaint.getCategory()) ? "selected" : "" %>>Technical</option>
                <option value="Facilities" <%= "Facilities".equals(complaint.getCategory()) ? "selected" : "" %>>Facilities</option>
                <option value="HR" <%= "HR".equals(complaint.getCategory()) ? "selected" : "" %>>Human Resources</option>
                <option value="Other" <%= "Other".equals(complaint.getCategory()) ? "selected" : "" %>>Other</option>
            </select>
        </div>

        <div class="mb-3">
            <label class="form-label">Description</label>
            <textarea name="description" class="form-control" rows="4" required><%= complaint.getDescription() %></textarea>
        </div>

        <button type="submit" class="btn btn-primary">Update Complaint</button>
        <a href="<%= request.getContextPath() %>/jsp/employee-dashboard.jsp" class="btn btn-secondary">Cancel</a>
    </form>
</div>
</body>
</html>


