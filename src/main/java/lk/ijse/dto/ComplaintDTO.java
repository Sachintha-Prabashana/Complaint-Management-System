package lk.ijse.dto;

public class ComplaintDTO {
    private String id;
    private String title;
    private String category;
    private String description;
    private String status;
    private String date;
    private String userId;

    // Additional fields for Admin
    private String remarks;         // For admin remarks

    // Constructors
    public ComplaintDTO() {}

    public ComplaintDTO(String id, String title, String category, String description, String status, String date, String userId, String remarks) {
        this.id = id;
        this.title = title;
        this.category = category;
        this.description = description;
        this.status = status;
        this.date = date;
        this.userId = userId;
        this.remarks = remarks;
    }

    // Getters and Setters
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getDate() { return date; }
    public void setDate(String date) { this.date = date; }

    public String getUserId() { return userId; }
    public void setUserId(String userId) { this.userId = userId; }

    public String getRemarks() { return remarks; }
    public void setRemarks(String remarks) { this.remarks = remarks; }

}
