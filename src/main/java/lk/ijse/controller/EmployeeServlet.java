package lk.ijse.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lk.ijse.dto.ComplaintDTO;
import lk.ijse.dto.UserDTO;
import lk.ijse.model.ComplaintModel;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet("/employeeServlet")
public class EmployeeServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        if (action == null) {
            resp.sendRedirect(req.getContextPath() + "/jsp/employee-dashboard.jsp?error=InvalidAction");
            return;
        }

        switch (action) {
            case "submit":
                handleSubmitComplaint(req, resp);
                break;
            case "edit":
                handleEditComplaint(req, resp);
                break;
            case "delete":
                handleDeleteComplaint(req, resp);
                break;
            default:
                resp.sendRedirect(req.getContextPath() + "/jsp/employee-dashboard.jsp?error=UnknownAction");
        }
    }

    private void handleSubmitComplaint(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession(false);
        UserDTO user = (UserDTO) session.getAttribute("user");

        if (user == null || !"Employee".equals(user.getRole())) {
            resp.sendRedirect("signIn.jsp");
            return;
        }

        String title = req.getParameter("title");
        String category = req.getParameter("category");
        String description = req.getParameter("description");
        String today = new SimpleDateFormat("yyyy-MM-dd").format(new Date());

        ComplaintModel dao = new ComplaintModel();
        String complaintId = dao.getNextId();

        ComplaintDTO dto = new ComplaintDTO(
                complaintId, title, category, description,
                "Pending", today, user.getId(), null
        );

        boolean success = dao.saveComplaint(dto);

        if (success) {
            resp.sendRedirect(req.getContextPath() + "/jsp/employee-dashboard.jsp?msg=submit-success");
        } else {
            resp.sendRedirect(req.getContextPath() + "/jsp/employee-dashboard.jsp?error=1");
        }
    }

    private void handleEditComplaint(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String id = req.getParameter("id");
        String title = req.getParameter("title");
        String category = req.getParameter("category");
        String description = req.getParameter("description");

        ComplaintModel model = new ComplaintModel();
        ComplaintDTO complaint = model.getComplaintById(id);

        if (complaint == null || "Resolved".equalsIgnoreCase(complaint.getStatus())) {
            resp.sendRedirect(req.getContextPath() + "/jsp/employee-dashboard.jsp?error=CannotEditResolved");
            return;
        }

        complaint.setTitle(title);
        complaint.setCategory(category);
        complaint.setDescription(description);

        boolean success = model.updateComplaint(complaint);

        if (success) {
            resp.sendRedirect(req.getContextPath() + "/jsp/employee-dashboard.jsp?msg=update-success");
        } else {
            resp.sendRedirect(req.getContextPath() + "/jsp/edit-complaint.jsp?id=" + id + "&error=UpdateFailed");
        }
    }

    private void handleDeleteComplaint(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String complaintId = req.getParameter("id");

        ComplaintModel model = new ComplaintModel();
        ComplaintDTO complaint = model.getComplaintById(complaintId);

        if (complaint == null) {
            resp.sendRedirect(req.getContextPath() + "/jsp/employee-dashboard.jsp?error=ComplaintNotFound");
            return;
        }

        // Prevent deletion if already resolved
        if ("Resolved".equalsIgnoreCase(complaint.getStatus())) {
            resp.sendRedirect(req.getContextPath() + "/jsp/employee-dashboard.jsp?error=CannotDeleteResolved");
            return;
        }

        boolean deleted = model.deleteComplaint(complaintId);

        if (deleted) {
            resp.sendRedirect(req.getContextPath() + "/jsp/employee-dashboard.jsp?msg=delete-success");
        } else {
            resp.sendRedirect(req.getContextPath() + "/jsp/employee-dashboard.jsp?error=DeleteFailed");
        }
    }

}
