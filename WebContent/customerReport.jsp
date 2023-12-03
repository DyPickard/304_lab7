<!DOCTYPE html>
<html>
<head>
<title>Sales Report</title>
</head>
<body>
<%@ include file="boilerplate.jsp" %>

<%@ include file="auth.jsp"%>
<%@ include file="jdbc.jsp" %>
<%@ page import="java.text.NumberFormat" %>

<%
NumberFormat currFormat = NumberFormat.getCurrencyInstance();

// Write SQL query that prints out total order amount by day
try {
    getConnection();
    Statement s = con.createStatement();
    ResultSet r = s.executeQuery("SELECT * FROM Customer");
    out.print("<table border=\"1\" cellpadding=\"5\"><tr><th>Customer ID</th><th>First Name</th><th>Last Name</th><th>Username</th><th>Email</th><th>Phone Number</th><th>Address</th><th>City</th><th>State / Province</th><th>Postal Code</th><th>Country</th></tr>");

    while (r.next()){
        String id = r.getString("customerId");
        String firstName = r.getString("firstName");
        String lastName = r.getString("lastName");
        String username = r.getString("userid");
        String email = r.getString("email");
        String phoneNum = r.getString("phonenum");
        String address = r.getString("address");
        String city = r.getString("city");
        String state = r.getString("state");
        String postalCode = r.getString("postalCode");
        String country = r.getString("country");
        out.print("<tr><td>"+id+"</td><td>"+firstName+"</td><td>"+lastName+"</td><td>"+username+"</td><td>"+email+"</td><td>"+phoneNum+"</td><td>"+address+"</td><td>"+city+"</td><td>"+state+"</td><td>"+postalCode+"</td><td>"+country+"</td></tr>");
    }
}
catch (Exception e){
}
out.print("<h2><li><a href=\"/shop/admin.jsp\">Back</a></li>");
%>
 
</body>
</html>

