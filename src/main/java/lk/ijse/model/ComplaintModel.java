package lk.ijse.model;

import lk.ijse.dto.ComplaintDTO;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ComplaintModel {
    private Connection getConnection() throws Exception {
        Context initCtx = new InitialContext();
        Context envCtx = (Context) initCtx.lookup("java:comp/env");
        DataSource ds = (DataSource) envCtx.lookup("jdbc/pool");
        return ds.getConnection();
    }

    // Generate next complaint ID like CMP-001
    public String getNextId() {
        String sql = "SELECT id FROM complaint ORDER BY id DESC LIMIT 1";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            if (rs.next()) {
                String lastId = rs.getString("id");
                int num = Integer.parseInt(lastId.split("-")[1]) + 1;
                return String.format("CMP-%03d", num);
            } else {
                return "CMP-001";
            }

        } catch (Exception e) {
            e.printStackTrace();
            return "CMP-001";
        }
    }

    // Save a new complaint
    public boolean saveComplaint(ComplaintDTO dto) {
        String sql = "INSERT INTO complaint (id, title, category, description, status, date, user_id, remarks) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, dto.getId());
            stmt.setString(2, dto.getTitle());
            stmt.setString(3, dto.getCategory());
            stmt.setString(4, dto.getDescription());
            stmt.setString(5, "Pending");
            stmt.setString(6, dto.getDate());
            stmt.setString(7, dto.getUserId());
            stmt.setString(8, dto.getRemarks()); // explicitly set remarks as null for now

            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }


    // Retrieve complaints submitted by a specific employee
    public List<ComplaintDTO> getComplaintsByUser(String userId) {
        List<ComplaintDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM complaint WHERE user_id = ? ORDER BY date DESC";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                ComplaintDTO dto = new ComplaintDTO();
                dto.setId(rs.getString("id"));
                dto.setTitle(rs.getString("title"));
                dto.setCategory(rs.getString("category"));
                dto.setDescription(rs.getString("description"));
                dto.setStatus(rs.getString("status"));
                dto.setDate(rs.getString("date"));
                dto.setUserId(rs.getString("user_id"));
                dto.setRemarks(rs.getString("remarks"));
                list.add(dto);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Retrieve all complaints (for Admin)
    public List<ComplaintDTO> getAllComplaints() {
        List<ComplaintDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM complaint ORDER BY date DESC";

        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                ComplaintDTO dto = new ComplaintDTO();
                dto.setId(rs.getString("id"));
                dto.setTitle(rs.getString("title"));
                dto.setCategory(rs.getString("category"));
                dto.setDescription(rs.getString("description"));
                dto.setStatus(rs.getString("status"));
                dto.setDate(rs.getString("date"));
                dto.setUserId(rs.getString("user_id"));
                dto.setRemarks(rs.getString("remarks"));
                list.add(dto);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Admin updates the status and remarks
    public boolean updateStatus(String id, String status, String remarks) {
        String sql = "UPDATE complaint SET status = ?, remarks = ? WHERE id = ?";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setString(2, remarks);
            ps.setString(3, id);

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteComplaint(String id) {
        String sql = "DELETE FROM complaint WHERE id = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, id);
            return stmt.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public ComplaintDTO getComplaintById(String id) {
        String sql = "SELECT * FROM complaint WHERE id = ?";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new ComplaintDTO(
                        rs.getString("id"),
                        rs.getString("title"),
                        rs.getString("category"),
                        rs.getString("description"),
                        rs.getString("status"),
                        rs.getString("date"),
                        rs.getString("user_id"),
                        rs.getString("remarks")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }


    public boolean updateComplaint(ComplaintDTO complaint) {
        String sql = "UPDATE complaint SET title = ?, category = ?, description = ? WHERE id = ?";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, complaint.getTitle());
            ps.setString(2, complaint.getCategory());
            ps.setString(3, complaint.getDescription());
            ps.setString(4, complaint.getId());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

}
