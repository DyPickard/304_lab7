<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>A&D Grocery</title>
</head>
<body>

<%@ include file="boilerplate.jsp" %>

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

String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
String uid = "sa";
String pw = "304#sa#pw"; 

// Get productID
String id = request.getParameter("id");

try ( Connection con = DriverManager.getConnection(url, uid, pw)){
    String userName = (String) session.getAttribute("authenticatedUser");
    // Get product name
    PreparedStatement p = con.prepareStatement("SELECT productId, productName, productPrice, productImageURL, productImage, productDesc FROM product WHERE productId = ?;");
    p.setString(1, id);
    ResultSet r = p.executeQuery();
    r.next();

    NumberFormat cr = NumberFormat.getCurrencyInstance();
	String x = cr.format(r.getFloat("productPrice")); // Used to change float value into currency string format for display

    // Display data
    out.println("<h2>" + r.getString("productName") + "</h2><table border=2><tr><th>Id</th><td>" + r.getInt("productId") + "</td></tr><tr><th>Price</th><td>" + x + "</td></tr><tr><th>Description</th><td>" + r.getString("productDesc") + "</td>");

    // If there is no URL
    if (r.getString("productImageURL") != null){
        out.println("</tr><img src=\"" + r.getString("productImageURL") + "\">");
    }

    // If there is no photo in database
    if (r.getBytes("productImage") != null){
        out.println("<img src=\"displayImage.jsp?id=" + r.getInt("productId") + "\"");
    }
    out.println("</table><h3><a href=\"addcart.jsp?id=" + r.getInt("productId") + "&name=" + r.getString("productName") + "&price=" + r. getFloat("productPrice") + "\">Add to Cart</a></h3><h3><a href=\"listprod.jsp\">Continue Shopping</a></h3>");

%>

<form action="createReview.jsp?pid=<%= prodId %>" method="post">
<label for="rating">Rating:</label>
<select id="rating" name="rating" required>
  <option value="">Select Rating</option>
  <option value="5">5 Stars</option>
  <option value="4">4 Stars</option>
  <option value="3">3 Stars</option>
  <option value="2">2 Stars</option>
  <option value="1">1 Star</option>
</select><br><br>
<label for="review_comment">Review Comment:</label><br>
<textarea id="review_comment" name="review_comment" rows="4" cols="50" minlength="10" maxlength="1000" required></textarea><br><br>
<input type="submit" value="Submit">
</form>

<%




}
catch (SQLException ex)
{
    out.println(ex);
	System.err.println("SQLException: " + ex);
}
%>
</body>
</html>

