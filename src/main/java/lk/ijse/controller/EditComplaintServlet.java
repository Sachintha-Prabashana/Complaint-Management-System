package lk.ijse.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.ijse.dto.ComplaintDTO;
import lk.ijse.model.ComplaintModel;

import java.io.IOException;

@WebServlet("/editComplaintServlet")
public class EditComplaintServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String id = request.getParameter("id");
        String title = request.getParameter("title");
        String category = request.getParameter("category");
        String description = request.getParameter("description");

        ComplaintModel model = new ComplaintModel();
        ComplaintDTO complaint = model.getComplaintById(id);

        if (complaint == null || "Resolved".equalsIgnoreCase(complaint.getStatus())) {
            response.sendRedirect(request.getContextPath() + "/jsp/employee-dashboard.jsp?error=CannotEditResolved");
            return;
        }

        complaint.setTitle(title);
        complaint.setCategory(category);
        complaint.setDescription(description);

        boolean success = model.updateComplaint(complaint);
        if (success) {
            response.sendRedirect(request.getContextPath() + "/jsp/employee-dashboard.jsp?message=ComplaintUpdated");

        } else {
            response.sendRedirect(request.getContextPath() + "/jsp/edit-complaint.jsp?id=" + id + "&error=UpdateFailed");

        }
    }
}


