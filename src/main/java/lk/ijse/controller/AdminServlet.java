package lk.ijse.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lk.ijse.dto.ComplaintDTO;
import lk.ijse.model.ComplaintModel;

import javax.sql.DataSource;
import java.io.IOException;
import java.util.List;

@WebServlet("/adminComplaint")
public class AdminServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || !"Admin".equals(((lk.ijse.dto.UserDTO) session.getAttribute("user")).getRole())) {
            resp.sendRedirect("signIn.jsp");
            return;
        }

        DataSource ds = (DataSource) getServletContext().getAttribute("dataSource");
        ComplaintModel model = new ComplaintModel(ds);
        List<ComplaintDTO> complaintList = model.getAllComplaints();

        req.setAttribute("complaintList", complaintList);
        req.getRequestDispatcher("/jsp/admin-dashboard.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        if (action == null) {
            resp.sendRedirect(req.getContextPath() + "/adminComplaint?error=missingAction");
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
                resp.sendRedirect(req.getContextPath() + "/adminComplaint?error=unknownAction");
        }
    }

    private void handleDelete(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String complaintId = req.getParameter("id");

        if (complaintId != null && !complaintId.isEmpty()) {
            DataSource ds = (DataSource) getServletContext().getAttribute("dataSource");
            ComplaintModel model = new ComplaintModel(ds);
            boolean deleted = model.deleteComplaint(complaintId);

            if (deleted) {
                resp.sendRedirect(req.getContextPath() + "/adminComplaint?deleted=1");
            } else {
                resp.sendRedirect(req.getContextPath() + "/adminComplaint?error=deleteFailed");
            }
        } else {
            resp.sendRedirect(req.getContextPath() + "/adminComplaint?error=invalidId");
        }
    }

    private void handleUpdate(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String complaintId = req.getParameter("complaintId");
        String status = req.getParameter("status");
        String remarks = req.getParameter("remarks");

        if (complaintId == null || complaintId.isEmpty() || status == null || status.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/adminComplaint?error=invalidUpdateData");
            return;
        }

        DataSource ds = (DataSource) getServletContext().getAttribute("dataSource");
        ComplaintModel model = new ComplaintModel(ds);
        boolean success = model.updateStatus(complaintId, status, remarks);

        if (success) {
            resp.sendRedirect(req.getContextPath() + "/adminComplaint?updated=1");
        } else {
            resp.sendRedirect(req.getContextPath() + "/adminComplaint?error=updateFailed");
        }
    }
}
