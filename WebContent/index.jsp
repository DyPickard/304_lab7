<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>

<%@ include file="boilerplate.jsp" %>

<style>
	td, th {
		text-align: right;
		padding-left: 30px;
	}
</style>

<body>
<h1 align="center">Welcome to A&D Grocery</h1>

<!-- <h2 align="center"><a href="login.jsp">Login</a></h2> -->

<!-- <h2 align="center"><a href="listprod.jsp">Begin Shopping</a></h2> -->

<!-- <h2 align="center"><a href="listorder.jsp">List All Orders</a></h2> -->

<!-- <h2 align="center"><a href="customer.jsp">Customer Info</a></h2> -->

<!-- <h2 align="center"><a href="admin.jsp">Administrators</a></h2> -->

<!-- <h2 align="center"><a href="logout.jsp">Log out</a></h2> -->

<%
	String userName = (String) session.getAttribute("authenticatedUser");
	if (userName != null)
		out.println("<h3 align=\"center\">Signed in as: "+userName+"</h3>");
%>

<h2>Top 5 Best-Selling Products:</h2>

<%

	//Note: Forces loading of SQL Server driver
	try
	{	// Load driver class
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	}
	catch (java.lang.ClassNotFoundException e)
	{
		out.println("ClassNotFoundException: " +e);
	}

	// Make the connection
	String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
	String uid = "sa";
	String pw = "304#sa#pw"; 
	try ( Connection con = DriverManager.getConnection(url, uid, pw)){
		Statement s = con.createStatement();
		ResultSet r = s.executeQuery("SELECT TOP 5 product.productId, productName, productPrice, SUM(orderproduct.quantity) AS q FROM product JOIN orderproduct ON product.productId = orderproduct.productId GROUP BY product.productId, productName, productPrice ORDER BY q DESC;");

		out.println("<table><tr><th>Product Name</th><th>Product Price</th><th>Number of times ordered</th></tr>");

		

		while (r.next()){
			NumberFormat cr = NumberFormat.getCurrencyInstance();
			String x = cr.format(r.getFloat("productPrice")); // Used to change float value into currency string format for display
			out.println("<tr><td><a href=\"product.jsp?id=" + r.getInt("productId") + "\"/>" + r.getString("productName") + "</td><td>" + x + "</td><td>" + r.getInt("q") + "</tr>");
		}

		out.println("</table>");
	}
%>


</body>
</head>


