<%-- 
    Document   : upload
    Created on : 16-May-2024, 1:12:29 pm
    Author     : LENOVO
--%>

<%@ page import="java.io.*, java.sql.*, java.util.Base64" %>
<%@ page contentType="text/plain; charset=UTF-8" %>
<%
String imageData = request.getParameter("imageData");
if (imageData != null && !imageData.isEmpty()) {
    // Decode base64 image data
    byte[] decodedImageData = Base64.getDecoder().decode(imageData.split(",")[1]);
    
    int vid = (int)session.getAttribute("vid");
    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/gate_entry", "root", "");
        
        // Insert image data into the database
        String query = "UPDATE visitors SET photo = ? WHERE VID = ?";
        PreparedStatement statement = connection.prepareStatement(query);
        statement.setBytes(1, decodedImageData);
        statement.setInt(2,vid);
        int rowsInserted = statement.executeUpdate();
        
        if (rowsInserted > 0) {
            out.println("Image uploaded successfully.");
        } else {
            out.println("Failed to upload image.");
        }
        
        connection.close();
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    }
} else {
    out.println("No image data received.");
}
%>
