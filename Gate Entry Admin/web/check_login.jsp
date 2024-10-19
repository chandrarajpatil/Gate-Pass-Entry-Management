<%-- 
    Document   : check_login
    Created on : 17-Apr-2024, 11:35:55 am
    Author     : LENOVO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            String uname = "admin";
            String password = "admin";
            
            String username = request.getParameter("username");
            String pwd = request.getParameter("password");
            
            if(username.equals(uname) && pwd.equals(password))
            {
                response.sendRedirect("home.html");
            }
            else
            {
                response.sendRedirect("index.html");
            }
        %>
    </body>
</html>
