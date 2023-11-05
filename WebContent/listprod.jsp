<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>YOUR NAME Grocery</title>
</head>
<body>

<h1>Search for the products you want to buy:</h1>

<form method="get" action="listprod.jsp">
<input type="text" name="productName" size="50">
<input type="submit" value="Submit"><input type="reset" value="Reset"> (Leave blank for all products)
</form>

<% // Get product name to search for
String name = request.getParameter("productName");
		
//Note: Forces loading of SQL Server driver
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

// Variable name now contains the search string the user entered
// Use it to build a query and print out the resultset.  Make sure to use PreparedStatement!

// Make the connection

String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
String uid = "sa";
String pw = "304#sa#pw"; 

try ( Connection con = DriverManager.getConnection(url, uid, pw)){
	ResultSet r;	
	if (name == null)
	{
		Statement s = con.createStatement();
		r = s.executeQuery("SELECT productId, productName, productPrice FROM product ORDER BY productName ASC;");
	}
	else 
	{
		PreparedStatement p = con.prepareStatement("SELECT productId, productName, productPrice FROM product WHERE productName LIKE ? ORDER BY productName ASC;");
		name = "%" + name + "%";
		p.setString(1, name);
		r = p.executeQuery();
	}

// Print out the ResultSet

	out.println("<h3>All Products</h3><Table><tr><th></th><th>Product Name</th><th>Price</th></tr>");

	while (r.next())
	{
		out.println("<tr><td>" + "<a href='/shop/addcart.jsp" + "?id=" + r.getString("productId") + "&name=" + r.getString("productName") + "&price=" + r.getString("productPrice") + "'>Add to cart</a>" + "</td><td>" + r.getString("productName") + "</td><td>" + r.getString("productPrice") + "</td></tr>");
	}
	out.println("</table>");

}

catch (SQLException ex)
{
	System.err.println("SQLException: " + ex);
}

// For each product create a link of the form
// addcart.jsp?id=productId&name=productName&price=productPrice
// Close connection

// Useful code for formatting currency values:
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0);	// Prints $5.00
%>

</body>
</html>