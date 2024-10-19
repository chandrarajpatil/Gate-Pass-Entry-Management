<%-- 
    Document   : print_gate_pass
    Created on : 16-May-2024, 1:36:44 pm
    Author     : LENOVO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" 
        import="java.time.LocalDate"
        import="java.time.LocalTime"
        import="java.time.format.DateTimeFormatter"
        import="java.io.*,java.util.Base64"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Gate Entry Portal - Yashaswi Bhavan</title>
    <link rel="stylesheet" href="CSS/style.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script>
        function printPage() {
            window.print();
        }
    </script>
</head>

<body>

    <section class="vh-100">
        <div class="container py-5 h-100">
            <div class="row d-flex justify-content-center align-items-center h-100">
                <div class="col-12 col-md-8 col-lg-6 col-xl-5">
                    <div class="card shadow-2-strong" style="border-radius: 1rem;">
                        <div class="card-body p-5 text-center" style="background-color: #7FC7D9;">
                            <div class="heading" style="background-color: #365486;">
                                <h3 class="mb-5">Gate Pass</h3>
                            </div>

                            <div class="form-outline2 mb-4">
                                
                                <%
                                    
                                            int vid = (int)session.getAttribute("vid");
                                            Connection con;
                                            //out.println("Record added succesfully");
                                            PreparedStatement ps2;
                                            Class.forName("com.mysql.jdbc.Driver");
                                            try{
                                            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/gate_entry","root","");
                                            ps2 = con.prepareStatement("SELECT V.VID, V.name, V.address, V.phone, V.id_type, V.gov_id, V.email, V.purpose, V.EID, E.name AS employee_name, V.date_, V.timein, V.photo FROM visitors V INNER JOIN employee E ON V.EID = E.EID WHERE V.VID = ?");
                                            ps2.setInt(1,vid);
                                            ResultSet rs = ps2.executeQuery();
                                         %>
                                         
                                         
                                        <% if (rs.next()) 
                                        { 
                                            byte[] imageData = rs.getBytes("photo");
                                            String base64Image = Base64.getEncoder().encodeToString(imageData);
                                            out.println("<img src='data:image/jpeg;base64," + base64Image + "'/>");
                                        %>
                                        
                                        <table>
                                            <tr>
                                                <td><h5>Visitor ID: </h5> <%=rs.getInt(1)%></td>
                                                <td><h5>Visitor Name: </h5> <%=rs.getString(2)%></td>
                                                
                                            </tr>
                                            
                                            <tr>
                                                <td><h5>Visitor Address: </h5> <%=rs.getString(3)%></td>
                                                <td><h5>Visitor Phone No: </h5> <%=rs.getString(4)%></td>
                                            </tr>
                                            
                                            <tr>
                                                <td><h5>Government ID Type </h5> <%=rs.getString(5)%></td>
                                                <td><h5>Government ID Number </h5> <%=rs.getString(6)%></td>
                                            </tr>
                                            
                                            <tr>
                                                <td><h5>Email </h5> <%=rs.getString(7)%></td>
                                                <td><h5>Purpose </h5> <%=rs.getString(8)%></td>
                                            </tr>
                                            <tr>
                                                <td><h5>Reference Employee ID: </h5><%=rs.getInt(9)%></td>
                                                <td><h5>Employee Name: </h5><%=rs.getString(10)%></td>
                                            </tr>
                                            <tr>
                                                <td><h5>Date </h5> <%=rs.getString(11)%></td>
                                                <td><h5>Time IN </h5> <%=rs.getString(12)%></td>
                                            </tr>
                                        </table>
                                        <% 
                                        } 
                                            else { %>
                                            No Visitor ID found.
                                        <% } %>
                                         </h3>
                                         <%
                                            
                                             }
                                             catch(Exception e)
                                              {
                                                out.println("Something went wrong");
                                                }
                                        
                                    
                                    
                                %>
                                    
                                <input type="button" value="Print" onclick="printPage()">
                                    
                                <h3><a href="index.html" style="text-decoration: none;">Back to main page 
                                    </a></h3>
                                
                            </div>
                            <!---<div class="form-outline mb-4">-->

                            <!---</div>-->
                            
                           
                            
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
</body>

</html>

