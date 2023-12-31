<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>

<%@ include file="boilerplate.jsp" %>

<h1>Search for the products you want to buy:</h1>

<form method="get" action="listprod.jsp">
<input type="text" name="productName" size="50">
<label for="category">Category</label>
<select id="category" name="category">
<option value="All">All</option>


<%
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

// Make the connection

String url1 = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
String uid1 = "sa";
String pw1 = "304#sa#pw"; 
try ( Connection con = DriverManager.getConnection(url1, uid1, pw1)){
	Statement s1 = con.createStatement();
	ResultSet r1 = s1.executeQuery("SELECT categoryName FROM category ORDER BY categoryName ASC;");
	while (r1.next()){
		out.println("<option value=\"" + r1.getString("categoryName") + "\">" + r1.getString("categoryName") +  "</option>");
	}
}

%>
<input type="submit" value="Submit"><input type="reset" value="Reset">
</form>

<% // Get product name to search for
String name = request.getParameter("productName");
String category = request.getParameter("category");	
if (category == null){
	category = "All";
}	


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
	// if no category and no search term
	if (category.equals("All")){

		// Shows all the items
		if ( name == null || name.isEmpty())
		{
			Statement s = con.createStatement();
			r = s.executeQuery("SELECT productId, productName, productPrice FROM product ORDER BY productName ASC;");
		}
		// Search when category is set to all
		else
		{
			PreparedStatement p = con.prepareStatement("SELECT productId, productName, productPrice FROM product WHERE productName LIKE ? ORDER BY productName ASC;");
			name = "%" + name + "%";
			p.setString(1, name);
			r = p.executeQuery();
		}
		
	}
	// if category with no search term
	else if (name.isEmpty()) // Checks if there isn't any user input. Will display this query on page load.
	{
		//Statement s = con.createStatement();
		PreparedStatement p = con.prepareStatement("SELECT productId, productName, productPrice FROM product JOIN category on product.categoryId = category.categoryId WHERE categoryName = ? ORDER BY productName ASC;");
		p.setString(1, category);
		r = p.executeQuery();

	}
	else // When there is user input for both search and category
	{
		PreparedStatement p = con.prepareStatement("SELECT productId, productName, productPrice FROM product JOIN category on product.categoryId = category.categoryId WHERE productName LIKE ? AND categoryName = ? ORDER BY productName ASC;");
		name = "%" + name + "%";
		p.setString(1, name);
		p.setString(2, category);
		r = p.executeQuery();
	}

// Print out the ResultSet

	out.println("<h3>All Products</h3><Table><tr><th></th><th>Product Name</th><th>Price</th></tr>");

	while (r.next())
	{
		NumberFormat cr = NumberFormat.getCurrencyInstance();
		String x = cr.format(r.getFloat("productPrice")); // Used to change float value into currency string format for display

		out.println("<tr><td>" + "<a href=\"/shop/addcart.jsp" + "?id=" + r.getString("productId") + "&name=" + r.getString("productName") + "&price=" + r.getString("productPrice") + "\">Add to cart</a>" + "</td><td><a href=\"/shop/product.jsp?id=" + r.getString("productId") + "\">" + r.getString("productName") + "</a></td><td>" + x + "</td></tr>"); // Putting the data in the url sent to the /addcart.jsp page for each item and sent to product.jsp file for item description. 
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