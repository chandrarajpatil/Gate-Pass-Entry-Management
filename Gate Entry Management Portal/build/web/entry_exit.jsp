<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, java.time.LocalDate, java.time.LocalTime, java.time.format.DateTimeFormatter" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Gate Entry Portal - Yashaswi Bhavan</title>
    <link rel="stylesheet" href="CSS/style.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
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
                                    try {
                                        int emp_id = Integer.parseInt(request.getParameter("eid"));
                                        LocalDate currentDate = LocalDate.now();
                                        LocalTime currentTime = LocalTime.now();

                                        DateTimeFormatter df = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                                        DateTimeFormatter tf = DateTimeFormatter.ofPattern("HH:mm:ss");

                                        String date = currentDate.format(df);
                                        String time = currentTime.format(tf);

                                        Class.forName("com.mysql.cj.jdbc.Driver");
                                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/gate_entry", "root", "");

                                        // Check for any record with timein and null timeout for the current date
                                        PreparedStatement ps1 = con.prepareStatement("SELECT * FROM entry_exit WHERE EID = ? AND date_ = ? AND timeout IS NULL ORDER BY EntryID DESC");
                                        ps1.setInt(1, emp_id);
                                        ps1.setString(2, date);
                                        ResultSet rs = ps1.executeQuery();

                                        if (rs.next()) {
                                            // Update the existing record's timeout
                                            PreparedStatement ps2 = con.prepareStatement("UPDATE entry_exit SET timeout = ? WHERE EntryID = ?");
                                            ps2.setString(1, time);
                                            ps2.setInt(2, rs.getInt("EntryID"));
                                            int i = ps2.executeUpdate();
                                            if (i > 0) {
                                                out.println("<h4>Exit Successful</h4>");
                                            } else {
                                                out.println("<h4>Exit Unsuccessful</h4>");
                                            }
                                        } else {
                                            // Insert a new record with timein
                                            PreparedStatement ps3 = con.prepareStatement("INSERT INTO entry_exit (EID, date_, timein) VALUES (?, ?, ?)");
                                            ps3.setInt(1, emp_id);
                                            ps3.setString(2, date);
                                            ps3.setString(3, time);
                                            int j = ps3.executeUpdate();
                                            if (j > 0) {
                                                out.println("<h4>Entry Successful</h4>");
                                            } else {
                                                out.println("<h4>Entry Unsuccessful</h4>");
                                            }
                                        }
                                        con.close();
                                    } catch(Exception e) {
                                        out.println("<h4>Something Went Wrong</h4>");
                                        e.printStackTrace();
                                    }
                                %>
                                
                                <h3><a href="index.html" style="text-decoration: none;">Back to main page</a></h3>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>
