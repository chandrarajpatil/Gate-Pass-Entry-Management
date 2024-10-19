<%-- 
    Document   : add_employee
    Created on : 18-Apr-2024, 2:36:28 pm
    Author     : LENOVO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
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
        <div class="col-12 col-md-8 col-lg-6 col-xl-8">
          <div class="card shadow-2-strong" style="border-radius: 1rem;">
            <div class="card-body p-5 text-center" style="background-color: #7FC7D9;">
              <div class="heading" style="background-color: #365486;">
                <nav class="navbar navbar-expand-lg" style="background-color: #365486;">
                  <div class="container-fluid">
                    <a class="navbar-brand" href="home.html">
                      <img src="iims.png" alt="Logo" width="70" height="70" class="d-inline-block align-text-top">
                    </a>
                    
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                      <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarNav">
                      <ul class="navbar-nav">
                        <li class="nav-item">
                          <a class="nav-link" aria-current="page" href="home.html"
                          style="color:white">Home</a>
                        </li>
                        <li class="nav-item">
                          <a class="nav-link active" href="add_employee.html"
                          style="color:yellow">Add Employee</a>
                        </li>
                        <li class="nav-item">
                          <a class="nav-link" href="delete_employee.html"
                          style="color:white">Delete Employee</a>
                        </li>
                        <li class="nav-item">
                          <a class="nav-link" href="view_employee.jsp"
                          style="color:white">View Employee</a>
                        </li>
                        <li class="nav-item">
                          <a class="nav-link" href="visitor_menu.html"
                          style="color:white">View Visitors</a>
                        </li>
                        <li class="nav-item">
                          <a class="nav-link" href="attendace_report.html"
                          style="color:white">Attendance Report</a>
                        </li>
                        <li class="nav-item">
                          <a class="nav-link active" href="index.html"
                          style="color:white; background-color: red; border-radius: 20px;">Logout</a>
                        </li>
                      </ul>
                    </div>
                  </div>
                </nav>
              </div>
              <div class="form-outline2 mb-4">
                <br>
                <h3>Add Employee</h3>
                <br>
                <%
                    
                    String name = request.getParameter("name");
                    String phone = request.getParameter("phone");
                    String email = request.getParameter("email");
                    String department = request.getParameter("department");
                    double exp_hrs = Double.parseDouble(request.getParameter("exphrs"));
                    
                    //out.println(name+" "+phone+" "+" "+email+" "+department);
                    
                    Connection con; 
                    PreparedStatement ps;
                    
                    try
                    {
                    Class.forName("com.mysql.jdbc.Driver");
                    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/gate_entry","root","");
                    ps = con.prepareStatement("INSERT INTO employee " 
                    + "(name, phone, email, department,exp_hrs) " 
                    + "VALUES (?,?,?,?,?)");
                    
                    ps.setString(1, name);
                    ps.setString(2, phone);
                    ps.setString(3, email);
                    ps.setString(4, department);
                    ps.setDouble(5,exp_hrs);
                    
                    int x = ps.executeUpdate();
                    if(x>0)
                    {
                        out.println("<h4 class='success'> Record added succesfully </h4>");
                                     
                    }
                  }
                  catch(Exception e)
                  {
                        out.println("<h4 class='danger'>Something went wrong</h4>");
                  }
                    
                %>                
                <br><br><br>
                  <div class="footer-bottom" style="background-color: #365486; color: yellow;">
                    &copy;gate-entry-management-portal.com | Developed by Tanmay Chachad
                  </div>
                  
                </p>
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