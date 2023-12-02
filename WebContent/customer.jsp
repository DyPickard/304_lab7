<!DOCTYPE html>
<html>
<head>
<title>Customer Page</title>
</head>
<body>

<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>
<%@ include file="boilerplate.jsp" %>
<%
	String userName = (String) session.getAttribute("authenticatedUser");
%>

<%

// Print Customer information
try{
	getConnection();
	PreparedStatement p = con.prepareStatement("SELECT * FROM customer WHERE userid = ?;");
	p.setString(1, userName);
	ResultSet r = p.executeQuery();
	if (r.next()){
		out.println("<h2>Customer Profile</h2><table border=2><tr><th>Id</th><td>" + r.getInt("customerId") + "</td></tr><tr><th>First Name</th><td>" + r.getString("firstName") + "</td></tr><tr><th>Last Name</th><td>" + r.getString("lastName") + "</td></tr><tr><th>Email</th><td>" + r.getString("email") + "</td></tr><tr><th>Phone</th><td>" + r.getString("phonenum") + "</td></tr><tr><th>Address</th><td>" + r.getString("address") + "</td></tr><tr><th>City</th><td>" + r.getString("city") + "</td></tr><tr><th>State</th><td>" + r.getString("state") + "</td></tr><tr><th>Postal Code</th><td>" + r.getString("postalCode") + "</td></tr><tr><th>Country</th><td>" + r.getString("country") + "</td></tr><tr><th>User id</th><td>" + r.getString("userid") + "</td></tr></table><h2><a href=\"/shop/index.jsp\">Return to Main Menu</a></h3>");

		closeConnection();
	}
}
catch (Exception e){

	out.println(e);
}
String sql = "";

// Make sure to close connection
%>

</body>
</html>

