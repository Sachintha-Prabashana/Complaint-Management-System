package lk.ijse.controller;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.ijse.dto.UserDTO;
import lk.ijse.model.UserModel;

import java.io.IOException;

@WebServlet("/signUp")
public class SignUpServlet  extends HttpServlet {

    private final UserModel userDAO = new UserModel();
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String fullName = req.getParameter("fullName");
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String confirmPassword = req.getParameter("confirmPassword");
        String role = req.getParameter("role");

        if (!password.equals(confirmPassword)) {
            resp.sendRedirect("signUp.jsp?error=PasswordMismatch");
            return;
        }

        UserDTO dto = new UserDTO();
        dto.setFullName(fullName);
        dto.setUsername(username);
        dto.setPassword(password);
        dto.setRole(role);

        boolean success = userDAO.registerUser(dto);

        if (success) {
            resp.sendRedirect("signIn.jsp?message=RegistrationSuccessful");
        } else {
            resp.sendRedirect("signUp.jsp?error=RegistrationFailed");
        }

    }
}
