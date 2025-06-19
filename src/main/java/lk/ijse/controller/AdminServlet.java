package lk.ijse.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.ijse.model.ComplaintModel;

import java.io.IOException;

@WebServlet("/adminComplaint")
public class AdminServlet extends HttpServlet {

    private final ComplaintModel model = new ComplaintModel();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        if (action == null) {
            resp.sendRedirect(req.getContextPath() + "/jsp/admin-dashboard.jsp?error=missingAction");
            return;
        }

        switch (action) {
            case "delete":
                handleDelete(req, resp);
                break;
            case "update":
                handleUpdate(req, resp);
                break;
            default:
                resp.sendRedirect(req.getContextPath() + "/jsp/admin-dashboard.jsp?error=unknownAction");
        }
    }

    private void handleDelete(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String complaintId = req.getParameter("id");

        if (complaintId != null && !complaintId.isEmpty()) {
            boolean deleted = model.deleteComplaint(complaintId);

            if (deleted) {
                resp.sendRedirect(req.getContextPath() + "/jsp/admin-dashboard.jsp?deleted=1");
            } else {
                resp.sendRedirect(req.getContextPath() + "/jsp/admin-dashboard.jsp?error=deleteFailed");
            }
        } else {
            resp.sendRedirect(req.getContextPath() + "/jsp/admin-dashboard.jsp?error=invalidId");
        }
    }

    private void handleUpdate(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String complaintId = req.getParameter("complaintId");
        String status = req.getParameter("status");
        String remarks = req.getParameter("remarks");

        if (complaintId == null || complaintId.isEmpty() || status == null || status.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/jsp/admin-dashboard.jsp?error=invalidUpdateData");
            return;
        }

        boolean success = model.updateStatus(complaintId, status, remarks);

        if (success) {
            resp.sendRedirect(req.getContextPath() + "/jsp/admin-dashboard.jsp?updated=1");
        } else {
            resp.sendRedirect(req.getContextPath() + "/jsp/admin-dashboard.jsp?error=updateFailed");
        }
    }
}
