<%-- 
    Document   : validate_OTP
    Created on : 30-Apr-2024, 5:00:31 pm
    Author     : LENOVO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, javax.servlet.http.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gate Entry Portal - Yashaswi Bhavan</title>
        <script>
        function showErrorMessage() {
            alert("OTP incorrect. Please try again.");
            window.location.href = "login.jsp"; // Redirect to otp.jsp
        }
    </script>
    </head>
    <body>
        <%
            String otptxt = request.getParameter("otptxt");
            String otp = request.getParameter("otp");
            int eid = Integer.parseInt(request.getParameter("eid"));
            if(otp.equals(otptxt))
            {
             HttpSession ssn = request.getSession();
             ssn.setAttribute("eid",eid);
             response.sendRedirect("employee_home.jsp");
            }
            else
            {
                out.println("<script>showErrorMessage();</script>");
            }
        %>
    </body>
</html>
