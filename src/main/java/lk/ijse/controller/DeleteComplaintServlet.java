package lk.ijse.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.ijse.model.ComplaintModel;

import java.io.IOException;

@WebServlet("/deleteComplaint")
public class DeleteComplaintServlet extends HttpServlet {

    private final ComplaintModel model = new ComplaintModel();
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String complaintId = req.getParameter("id");

        if (complaintId != null && !complaintId.isEmpty()) {

            boolean deleted = model.deleteComplaint(complaintId);

            if (deleted) {
                resp.sendRedirect(req.getContextPath() + "/jsp/admin-dashboard.jsp?deleted=1");
            } else {
                resp.sendRedirect(req.getContextPath() + "/jsp/admin-dashboard.jsp?error=1");
            }
        } else {
            resp.sendRedirect(req.getContextPath() + "/jsp/admin-dashboard.jsp?error=1");
        }
    }
}
