<%-- 
    Document   : download_visitor
    Created on : 01-May-2024, 3:49:31 pm
    Author     : LENOVO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"
        import="java.io.*"
        import="org.apache.poi.ss.usermodel.*"
        import="org.apache.poi.xssf.usermodel.XSSFWorkbook"%>
<%
            String from_date = request.getParameter("from_date");
            String to_date = request.getParameter("to_date");
            try{
            Connection con;
            PreparedStatement ps;
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/gate_entry","root","");
            ps = con.prepareStatement("SELECT * FROM visitors WHERE date_ BETWEEN ? AND ?");
            ps.setString(1, from_date);
            ps.setString(2, to_date);
            ResultSet rs = ps.executeQuery();
            // Create a new workbook
            XSSFWorkbook workbook = new XSSFWorkbook();
            Sheet sheet = workbook.createSheet("Visitors");
            Row headerRow = sheet.createRow(0);
            ResultSetMetaData metaData = rs.getMetaData();
            int columnCount = metaData.getColumnCount();
            for (int i = 1; i <= columnCount; i++) {
                Cell cell = headerRow.createCell(i - 1);
                cell.setCellValue(metaData.getColumnName(i));
            }
            int rowNum = 1;
            while (rs.next()) {
                Row row = sheet.createRow(rowNum++);
                for (int i = 1; i <= columnCount; i++) {
                    row.createCell(i - 1).setCellValue(rs.getString(i));
                }
            }

            // Write to response
            response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
            response.setHeader("Content-Disposition", "attachment; filename=\"visitors.xlsx\"");
            OutputStream outputStream = response.getOutputStream();
            workbook.write(outputStream);
            workbook.close();
            response.sendRedirect("view_visitor.jsp");
            con.close();
            }
            catch(ClassNotFoundException | SQLException e)
            {
                e.printStackTrace();
            }
%>