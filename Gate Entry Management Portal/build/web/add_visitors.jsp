<%-- 
    Document   : add_visitors
    Created on : 16-Apr-2024, 7:39:21 pm
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
    <script>
        function printPage() {
            window.location.href="print_gate_pass.jsp";
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
                                <h3 class="mb-5">Gate Entry Portal</h3>
                            </div>

                            <div class="form-outline2 mb-4">
                                
                                <%
                                    String name = request.getParameter("name");
                                    String address = request.getParameter("address");
                                    String phone = request.getParameter("phone");
                                    String idProof = request.getParameter("idProof");
                                    String govid = request.getParameter("govid");
                                    String email = request.getParameter("email");
                                    String purpose = request.getParameter("purpose");
                                    int eid = Integer.parseInt(request.getParameter("employee"));
                                    
                                    LocalDate currentDate = LocalDate.now();
                                    LocalTime currentTime = LocalTime.now();

                                    DateTimeFormatter df = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                                    DateTimeFormatter tf = DateTimeFormatter.ofPattern("HH:mm:ss");

                                    String date = currentDate.format(df);
                                    String time = currentTime.format(tf);
                                    
                                    String photoData = request.getParameter("photoData");
                                    
                                    Connection con;
                                    PreparedStatement ps;
                                    try
                                    {
                                        Class.forName("com.mysql.jdbc.Driver");
                                        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/gate_entry","root","");
                                        ps = con.prepareStatement("INSERT INTO visitors " + "(name, address, phone, id_type, gov_id, email, purpose, EID, date_, timein) " + "VALUES (?,?,?,?,?,?,?,?,?,?)");
                                        //ps = con.prepareStatement("insert into visitors(name, email) values (?,?)");
                                        //ps.setString(1, name);
                                        //ps.setString(2, email);
                                        
                                        ps.setString(1, name);
                                        ps.setString(2, address);
                                        ps.setString(3, phone);
                                        ps.setString(4, idProof);
                                        ps.setString(5, govid);
                                        ps.setString(6, email);
                                        ps.setString(7, purpose);
                                        ps.setInt(8,eid);
                                        ps.setString(9, date);
                                        ps.setString(10, time);
                                        //con.close();
                                        int x=ps.executeUpdate();
                                        if(x>0)
                                        {
                                            //out.println("Record added succesfully");
                                            PreparedStatement ps2;
                                            
                                            ps2 = con.prepareStatement("SELECT VID from visitors WHERE name = ? AND date_ = ? AND phone = ?;");
                                            ps2.setString(1,name);
                                            ps2.setString(2, date);
                                            ps2.setString(3,phone);
                                            ResultSet rs = ps2.executeQuery();
                                         %>
                                         
                                         
                                        <% if (rs.next()) 
                                        {
                                        int vid = rs.getInt(1);
                                        session.setAttribute("vid", vid);
                                        %>
                                        <video id="video" width="640" height="480" autoplay></video>
                                        <canvas id="canvas" width="300" height="300" style="display: none;"></canvas><br>
    <button id="capture-btn" class="btn btn-primary">Capture Photo</button>
    <button id="upload-btn" class="btn btn-primary">Upload Photo</button>

    <script>
        const video = document.getElementById('video');
        const canvas = document.getElementById('canvas');
        const captureBtn = document.getElementById('capture-btn');
        const uploadBtn = document.getElementById('upload-btn');
        const ctx = canvas.getContext('2d');
        video.width = 300;
        video.height = 300;

        captureBtn.addEventListener('click', () => {
            ctx.drawImage(video, 0, 0, canvas.width, canvas.height);
            canvas.style.display = 'block';
        });

        uploadBtn.addEventListener('click', () => {
            const imageData = canvas.toDataURL('image/jpeg');
            uploadPhoto(imageData);
        });

        async function uploadPhoto(imageData) {
            try {
                const response = await fetch('upload.jsp', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded'
                    },
                    body: 'imageData=' + encodeURIComponent(imageData)
                });
                const data = await response.text();
                alert(data); // Display response from server
            } catch (error) {
                console.error('Error:', error);
            }
        }

        // Access the camera
        navigator.mediaDevices.getUserMedia({ video: true })
            .then(stream => {
                video.srcObject = stream;
            })
            .catch(err => {
                console.error('Error accessing camera:', err);
            });
    </script>
                                        <% 
                                        } 
                                            else { %>
                                            No Visitor ID found.
                                        <% } %>
                                         </h3>
                                         <%
                                            
                                            
                                        }
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
