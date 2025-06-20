package lk.ijse.model;

import lk.ijse.dto.UserDTO;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserModel {

    private final DataSource dataSource;

    public UserModel(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    private Connection getConnection() throws Exception {
        return dataSource.getConnection();
    }

    public String getNextId() {
        String sql = "SELECT id FROM users ORDER BY id DESC LIMIT 1";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            if (rs.next()) {
                String lastId = rs.getString("id"); // e.g., "U00-007"
                int numeric = Integer.parseInt(lastId.split("-")[1]) + 1;
                return String.format("U00-%03d", numeric);
            } else {
                return "U00-001";
            }

        } catch (Exception e) {
            e.printStackTrace();
            return "U00-001"; // fallback in error
        }
    }


    public boolean registerUser(UserDTO dto) {
        String sql = "INSERT INTO users (id, fullName, username, password, role) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            String userId = getNextId();
            stmt.setString(1, userId);
            stmt.setString(2, dto.getFullName());
            stmt.setString(3, dto.getUsername());
            stmt.setString(4, dto.getPassword());
            stmt.setString(5, dto.getRole());

            return stmt.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public UserDTO authenticateUser(String username, String password) {
        String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, username);
            stmt.setString(2, password);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                UserDTO dto = new UserDTO();
                dto.setId(rs.getString("id"));
                dto.setFullName(rs.getString("fullName"));
                dto.setUsername(rs.getString("username"));
                dto.setPassword(rs.getString("password"));
                dto.setRole(rs.getString("role"));
                return dto;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
