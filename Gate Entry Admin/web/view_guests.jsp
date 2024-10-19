<%-- 
    Document   : view_guests
    Created on : 02-May-2024, 12:04:09 pm
    Author     : LENOVO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
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
                    <a class="navbar-brand" href="employee_home.jsp">
                      <img src="iims.png" alt="Logo" width="70" height="70" class="d-inline-block align-text-top">
                    </a>
                    
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                      <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarNav">
                      <ul class="navbar-nav">
                        <li class="nav-item">
                          <a class="nav-link" aria-current="page" href="employee_home.jsp"
                          style="color:white">Home</a>
                        </li>
                        <li class="nav-item active">
                          <a class="nav-link" href="view_guests.jsp"
                          style="color:yellow">View My Guests</a>
                        </li>
                        
                        <li class="nav-item">
                          <a class="nav-link" href="view_my_attendance.jsp"
                          style="color:white">View My Attendance</a>
                        </li>
                        
                        <li class="nav-item">
                          <a class="nav-link" href="update_profile.jsp"
                          style="color:white">Update Profile</a>
                        </li>
                       
                        
                      </ul>
                        
                        <ul class="navbar-nav">
                        <li class="nav-item">
                            <a class="nav-link" href="index.html"
                                style="color:white; background-color: red; border-radius: 20px;">Logout</a>
                        </li>
                        </ul>
                    </div>
                  </div>
                </nav>
              </div>
              <div class="form-outline3 mb-4">
                <br>
                <h4>My Guests</h4>
                <br>
                
                <form id="dateForm" method="POST" action="view_guests.jsp" class="row align-items-center">
                  <div class="col-md-auto">
                    <b>Select Dates:</b>
                  </div>
                  <div class="col-md-auto">
                    From:
                  </div>
                  <div class="col-md-auto">
                    <input type="date" name="from_date" id="from_date" class="form-control" required>
                  </div>
                  <div class="col-md-auto">
                    To:
                  </div>
                  <div class="col-md-auto">
                    <input type="date" name="to_date" id="to_date" class="form-control" required>
                  </div>
                  <div class="col-md-auto">
                    <input type="submit" value="View Guests" class="btn btn-primary">
                  </div>
                </form>
                <br>
                   
                <%
                    HttpSession ssn = request.getSession();
                    int eid = (int)ssn.getAttribute("eid");
                    String from_date = request.getParameter("from_date");
                    String to_date = request.getParameter("to_date");
                    Connection con;
                    PreparedStatement ps;
                    ResultSet rs;
                    Class.forName("com.mysql.jdbc.Driver");
                    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/gate_entry","root","");
                    ps = con.prepareStatement("SELECT * FROM visitors WHERE EID = ? AND date_ BETWEEN ? AND ?");
                    ps.setInt(1, eid);
                    ps.setString(2, from_date);
                    ps.setString(3, to_date);
                    rs = ps.executeQuery();
                    if(rs.next()==false)
                    {
                        out.println("<h4>No Records Found</h4>");
                    }
                    else
                    {%>
                    <b>Report is generated From <span style="color:green"><%=from_date%></span>
                        to <span style="color:green"><%=to_date%></span></b> <br>
                    <div style="overflow-y: auto; max-height: 400px;">
                <table border="2">
                    <tr>
                        <th>Visitor ID</th>
                        <th>Visitor Name</th>
                        <th>Address</th>
                        <th>Phone Number</th>
                        <th>ID Type</th>
                        <th>Government ID Number</th>
                        <th>Email</th>
                        <th>Purpose</th>
                        <th>Date</th>
                        <th>Time IN</th>
                        <th>Time OUT</th>
                        <th>Time Difference</th>
                    </tr>
                   
                    <%
                        do
                        {
                    %>
                    <tr>
                        <td><%=rs.getInt(1)%></td>
                        <td><%=rs.getString(2)%></td>
                        <td><%=rs.getString(3)%></td>
                        <td><%=rs.getString(4)%></td>
                        <td><%=rs.getString(5)%></td>
                        <td><%=rs.getString(6)%></td>
                        <td><%=rs.getString(7)%></td>
                        <td><%=rs.getString(8)%></td>
                        <td><%=rs.getString(9)%></td>
                        <td><%=rs.getString(10)%></td>
                        <td><%=rs.getString(11)%></td>
                        <td><%=rs.getString(12)%></td>
                    </tr>
                    <%
                        }while(rs.next());
                    %>
                    
                </table>
                        
                   <% }
                %>
                
                
                </div>
                  <br><br>

                  <div class="footer-bottom" style="background-color: #365486; color: yellow;">
                    &copy;gate-entry-management-portal.com | Developed by Tanmay Chachad
                  </div>
                  
                
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
