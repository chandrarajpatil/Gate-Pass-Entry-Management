<%-- 
    Document   : otp
    Created on : 29-Apr-2024, 5:18:24 pm
    Author     : LENOVO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@ page import="java.util.Random" %>
<%@ page import="javax.mail.*" %>
<%@ page import="javax.mail.internet.*" %>
<%@ page import="java.util.Properties" %>
<%@ page import="javax.activation.DataHandler"%>
<!DOCTYPE html>
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
                                <center><h2 class="mb-4">Sign In</h2></center>
                                
                                <%
                                    int eid = Integer.parseInt(request.getParameter("eid"));
                                    
                                    Random rand = new Random();
                                    int otp = rand.nextInt(900000) + 100000; 
                                    
                                    Connection con;
                                    PreparedStatement ps;
                                    Class.forName("com.mysql.jdbc.Driver");
                                    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/gate_entry","root","");
                                    ps = con.prepareStatement("SELECT email FROM employee WHERE EID = ?");
                                    ps.setInt(1, eid);
                                    ResultSet rs = ps.executeQuery();
                                    if(rs.next()==false)
                                    {
                                        out.println("<h3>Invalid Employee ID</h4>");
                                    }
                                    else
                                    {
                                        String email = rs.getString("email");
                                        String to = email;
                                        

                                        // Email Configuration
                                        //String to = "tanmaychachad@gmail.com";
                                        String from = "tanmaychachad@gmail.com"; // Use the same Gmail address to send email
                                        String host = "smtp.gmail.com";
                                        final String user = "tanmaychachad@gmail.com"; // Use the same Gmail address to authenticate
                                        final String password = "psmmnebzkrvlmals"; // Replace with your Gmail password

                                        // Email properties
                                        Properties properties = System.getProperties();
                                        properties.setProperty("mail.smtp.host", host);
                                        properties.setProperty("mail.smtp.port", "587");
                                        properties.setProperty("mail.smtp.auth", "true");
                                        properties.setProperty("mail.smtp.starttls.enable", "true");

                                        // Session object to authenticate the host
                                        Session ssn = Session.getInstance(properties, new Authenticator() {
                                            protected PasswordAuthentication getPasswordAuthentication() {
                                                return new PasswordAuthentication(user, password);
                                            }
                                        });
                                        // Compose the message
                                        try {
                                            MimeMessage message = new MimeMessage(ssn);
                                            message.setFrom(new InternetAddress(from));
                                            message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
                                            message.setSubject("Your OTP");
                                            message.setText("Your OTP is: " + otp);

                                            // Send message
                                            Transport.send(message);
                                            out.println("<h5>OTP sent successfully on your registered email id.</h5>");
                                        } catch (MessagingException mex) {
                                            out.println("Error: unable to send OTP.");
                                            mex.printStackTrace();
                                        }
                                }
                                        // Method to generate a 6-digit OTP
                                       
                                        
                                        
                                %>
                               
                                <form method="POST" action="validate_OTP.jsp">
                                    
                                    <table>
                                        <tr>
                                            <td><h4>Enter OTP </h4></td>
                                            <td><input type="text" name="otptxt"></td>
                                        </tr>
                                        
                                    </table>
                                    <input type="hidden" name="eid" value="<%= eid %>">
                                    <input type="hidden" name="otp" value="<%= otp %>">
                                    <br>
                                    <input type="submit" value="Login">
                                    
                                    
                                </form>
                                
                            </div>
                            
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

