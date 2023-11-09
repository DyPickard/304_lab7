<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>A&D Grocery</title>
</head>
<body>

<h1>Search for the products you want to buy:</h1>
<h4><a href="/shop">Home</a></h4>
<h4><a href="/shop/showcart.jsp"> Go to cart</a></h4>

<form method="get" action="listprod.jsp">
<input type="text" name="productName" size="50">
<label for="category">Category</label>
<select id="category" name="category">
<option value="All">All</option>
<option value="Beverages">Beverages</option>
<option value="Condiments">Condiments</option>
<option value="Dairy Products">Dairy Products</option>
<option value="Produce">Produce</option>
<option value="Meat/Poultry">Meat/Poultry</option>
<option value="Seafood">Seafood</option>
<option value="Confections">Confections</option>
<option value="Grains/Cereals">Grains/Cereals</option>

<input type="submit" value="Submit"><input type="reset" value="Reset"> (Leave blank for all products)
</form>

<% // Get product name to search for
String name = request.getParameter("productName");
// TO DO
String category = request.getParameter("category");		
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
	if (name == null) // Checks if there isn't any user input. Will display this query on page load.
	{
		Statement s = con.createStatement();
		r = s.executeQuery("SELECT productId, productName, productPrice FROM product ORDER BY productName ASC;");
	}
	else // When there is user input.
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
		NumberFormat cr = NumberFormat.getCurrencyInstance();
		String x = cr.format(r.getFloat("productPrice")); // Used to change float value into currency string format for display

		out.println("<tr><td>" + "<a href=\"/shop/addcart.jsp" + "?id=" + r.getString("productId") + "&name=" + r.getString("productName") + "&price=" + r.getString("productPrice") + "\">Add to cart</a>" + "</td><td>" + r.getString("productName") + "</td><td>" + x + "</td></tr>"); // Putting the data in the url sent to the /addcart.jsp page for each item.
	}
	out.println("</table>");

	con.close(); // Close the connection
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