package lk.ijse.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lk.ijse.dto.UserDTO;
import lk.ijse.model.UserDAO;

import java.io.IOException;

@WebServlet("/signIn")
public class SignInServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        // Here you would typically validate the username and password against a database

        UserDAO userDAO = new UserDAO();
        UserDTO user = userDAO.authenticateUser(username, password);

        if (user != null) {
            HttpSession session = req.getSession();
            session.setAttribute("user", user);
            session.setAttribute("username", user.getUsername());

            // Redirect based on role
            if ("Admin".equalsIgnoreCase(user.getRole())) {
                resp.sendRedirect(req.getContextPath() + "/jsp/admin-dashboard.jsp");
            } else {
                resp.sendRedirect(req.getContextPath() + "/jsp/employee-dashboard.jsp");
            }

        } else {
            resp.sendRedirect(req.getContextPath() + "signIn.jsp?error=1");

        }
    }
}
