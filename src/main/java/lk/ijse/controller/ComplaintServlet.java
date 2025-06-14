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

@WebServlet("/complaint")
public class ComplaintServlet  extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
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
                "Pending", today, user.getId()
        );

        boolean success = dao.saveComplaint(dto);

        if (success) {
            resp.sendRedirect("/jsp/employee-dashboard.jsp?success=1");
        } else {
            resp.sendRedirect("/jsp/employee-dashboard.jsp?error=1");
        }
    }

}
