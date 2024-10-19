<%-- 
    Document   : timeout_visitor
    Created on : 24-Apr-2024, 12:16:24 am
    Author     : LENOVO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" 
        import="java.time.LocalDate"
        import="java.time.LocalTime"
        import="java.time.format.DateTimeFormatter"
        import="java.io.*"%>

<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Gate Entry Portal - Yashaswi Bhavan</title>
    <link rel="stylesheet" href="CSS/style.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    
</head>

<body>

    <section class="vh-100">
        <div class="container py-5 h-100">
            <div class="row d-flex justify-content-center align-items-center h-100">
                <div class="col-12 col-md-8 col-lg-6 col-xl-5">
                    <div class="card shadow-2-strong" style="border-radius: 1rem;">
                        <div class="card-body p-5 text-center" style="background-color: #7FC7D9;">
                            <div class="heading" style="background-color: #365486;">
                                <h3 class="mb-5">Gate Entry Portal</h3>
                            </div>

                            <div class="form-outline2 mb-4">
                                
                                <%
                                    int vid = Integer.parseInt(request.getParameter("vid"));
                                    LocalDate currentDate = LocalDate.now();
                                    LocalTime currentTime = LocalTime.now();

                                    DateTimeFormatter df = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                                    DateTimeFormatter tf = DateTimeFormatter.ofPattern("HH:mm:ss");

                                    String date = currentDate.format(df);
                                    String time = currentTime.format(tf);
                                    
                                    Connection con;
                                    PreparedStatement ps;
                                    try
                                    {
                                        Class.forName("com.mysql.jdbc.Driver");
                                        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/gate_entry","root","");
                                        ps = con.prepareStatement("UPDATE visitors SET timeout = ? WHERE VID = ?");
                                        ps.setString(1, time);
                                        ps.setInt(2, vid);
                                        int x = ps.executeUpdate();
                                        if(x>0)
                                        {
                                            out.println("<h4>Record Updated Successfully</h4>");
                                        }
                                        else
                                        {
                                            out.println("<h4>Unable to update record</h4>");
                                        }
                                    }
                                    catch(Exception e)
                                    {
                                    out.println("Something went wrong");
                                }
                                        
                                %>
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

