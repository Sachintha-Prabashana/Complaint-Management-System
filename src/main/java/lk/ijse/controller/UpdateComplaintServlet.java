package lk.ijse.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.ijse.model.ComplaintModel;

import java.io.IOException;

@WebServlet("/updateComplain")
public class UpdateComplaintServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String complaintId = req.getParameter("complaintId");
        String status = req.getParameter("status");
        String remarks = req.getParameter("remarks");

        ComplaintModel model = new ComplaintModel();
        boolean success = model.updateStatus(complaintId, status, remarks);

        if (success) {
            // Redirect back to dashboard on success
            resp.sendRedirect("/jsp/admin-dashboard.jsp");
        } else {
            // Forward back to dashboard with error message
            req.setAttribute("error", "Failed to update complaint.");
            req.getRequestDispatcher("/jsp/admin-dashboard.jsp").forward(req, resp);
        }
    }
}

