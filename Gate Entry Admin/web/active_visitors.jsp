<%-- 
    Document   : active_visitors
    Created on : 28-Apr-2024, 3:18:30 pm
    Author     : LENOVO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"
        import="java.time.LocalDate"
        import="java.time.LocalTime"
        import="java.time.format.DateTimeFormatter"
        import="java.io.*"%>
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
        <div class="col-12 col-md-8 col-lg-6 col-xl-10">
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
                          <a class="nav-link" href="add_employee.html"
                          style="color:white">Add Employee</a>
                        </li>
                        <li class="nav-item">
                          <a class="nav-link" href="delete_employee.html"
                          style="color:white">Delete Employee</a>
                        </li>
                        <li class="nav-item">
                          <a class="nav-link" href="view_employee.jsp"
                          style="color:white">View Employee</a>
                        </li>
                        <li class="nav-item active">
                          <a class="nav-link" href="visitor_menu.html"
                          style="color:yellow">View Visitors</a>
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
              <div class="form-outline3 mb-4">
                <br>
                <h3>Active Visitors of Yashaswi Bhavan</h3>
                <br>
                
                <%
                    int count = 0;
                    LocalDate currentDate = LocalDate.now();
                    LocalTime currentTime = LocalTime.now();

                    DateTimeFormatter df = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                    DateTimeFormatter tf = DateTimeFormatter.ofPattern("HH:mm:ss");

                    String date = currentDate.format(df);
                    String time = currentTime.format(tf);
                    String from_date = request.getParameter("from_date");
                    String to_date = request.getParameter("to_date");
                    Connection con;
                    
                    PreparedStatement ps,ps0,ps1;
                    Class.forName("com.mysql.jdbc.Driver");
                    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/gate_entry","root","");
                    ps0 = con.prepareStatement("UPDATE visitors SET time_difference = TIMEDIFF(timeout, timein), total_hours = HOUR(TIMEDIFF(timeout, timein));");
                    ps0.executeUpdate();
                    ps = con.prepareStatement("SELECT V.VID, V.name, V.address, V.phone,v.id_type, V.gov_id, V.email, V.purpose, V.EID, E.name, V.date_, V.timein,V.timeout,V.time_difference from visitors V INNER JOIN employee E on V.EID = E.EID WHERE timeout IS NULL;");
                   
                    ResultSet rs = ps.executeQuery();
                    
                    if(rs.next()==false)
                    {
                    out.println("<h4>No Active Visitors");
                }
                else
                {
                   
                    
                %>
                <div style="overflow-y: auto; max-height: 400px;">
                    
                <table border="2">
                    <tr>
                        <th>Visitor ID</th>
                        <th>Name</th>
                        <th>Address</th>
                        <th>Phone Number</th>
                        <th>ID type</th>
                        <th>Government ID </th>
                        <th>Email</th>
                        <th>Purpose</th>
                        <th>Reference Employee ID</th>
                        <th>Employee Name
                        <th>Date</th><!-- comment -->
                        <th>TimeIN</th>
                        <th>TimeOUT</th>
                        <th>Total Duration (in hrs)</th>
                    </tr>
                    <%
                        do
                        { count++;
                            %>
                            <tr>
                                <td> <%=rs.getInt(1)%></td>
                                <td> <%=rs.getString(2)%></td>
                                <td> <%=rs.getString(3)%></td>
                                <td> <%=rs.getString(4)%></td>
                                <td> <%=rs.getString(5)%></td>
                                <td> <%=rs.getString(6)%></td>
                                <td> <%=rs.getString(7)%></td>
                                <td> <%=rs.getString(8)%></td>
                                <td> <%=rs.getInt(9)%></td>
                                <td> <%=rs.getString(10)%></td>
                                <td> <%=rs.getString(11)%></td>
                                <td> <%=rs.getString(12)%></td>
                                <td> <%=rs.getString(13)%></td>
                                <td> <%=rs.getString(14)%></td>
                            </tr>
                            
                            
                        <% 
                        }while(rs.next());
                    %>
                </table>
                <h4>Total Active Visitors: <%=count%></h4>
                <%
                }
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

