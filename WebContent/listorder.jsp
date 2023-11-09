<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>A&D Grocery Order List</title>
<style>
        .menu {
        list-style-type: none;
        margin: 0;
        padding: 0;
        align-items: center;
        overflow: hidden;
        background-color: #333;
        }
        .menu li {
        float: left;
        }
        .menu li a {
        display: block;
        color: white;
        text-align: center;
        padding: 14px 16px;
        }
        .menu li a:hover {
        background-color: #111;
        }
</style> 
</head>
<body>
<ul class="menu">
        <li><a href="/shop">Home</a></li>
        <li><a href="listprod.jsp">Products</a></li>
        <li><a href="listorder.jsp">Orders</a></li>
        <li><a href="showcart.jsp">Cart</a></li>
</ul>
<h1>Order List</h1>
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
// Useful code for formatting currency values:
NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0);  // Prints $5.00

// Make connection
String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
String uid = "sa";
String pw = "304#sa#pw"; 

try ( Connection con = DriverManager.getConnection(url, uid, pw);
	Statement stmt = con.createStatement();) { 
	// Write query to retrieve all order summary records
    ResultSet rst = stmt.executeQuery("SELECT * FROM ordersummary join customer ON ordersummary.customerId = customer.customerId");		
	// For each order in the ResultSet
	// Print out the order summary information
	// Write a query to retrieve the products in the order
	// Use a PreparedStatement as will repeat this query many times
	// For each product in the order
	// Write out product information 
	out.println("<table border=\"1\"><tr><th> Order ID </th> <th> Order Date </th> <th> Customer ID </th> <th> Customer Name </th> <th> Total Amount </th></tr>");

	PreparedStatement prest = con.prepareStatement("SELECT orderId, productId, quantity, price FROM orderproduct WHERE orderId = ?");
	while (rst.next()){
		String orderID = rst.getString("orderId");
		String orderDate = rst.getString("orderDate");
		String customerID = rst.getString("customerId");
		String customerNameFirst = rst.getString("firstName");
		String customerNameLast = rst.getString("lastName");
		double totalAmount = rst.getDouble("totalAmount");
%>

	<tr>
		<td><% out.println(orderID); %></td>
		<td><% out.println(orderDate); %></td>
		<td><% out.println(customerID); %></td>
		<td><% out.println(customerNameFirst+" "+customerNameLast); %></td>
		<td><% out.println(currFormat.format(totalAmount)); %></td>
	</tr>
	<tr align="right">
		<td colspan="4">
			<table border="1">
				<tr>
					<th> Product ID </th> <th> Quantity </th> <th> Price </th>
				</tr>	
				<%
					prest.setString(1,orderID);
					ResultSet rst2 = prest.executeQuery();
					while (rst2.next()){
						String productID = rst2.getString("productId");
						String quantity = rst2.getString("quantity");
						double price = rst2.getDouble("price");
				%>				
				<tr>
					<td>
						<% out.println(productID); %>
					</td>
					<td>
						<% out.println(quantity); %>
						</td>
					<td>
						<% out.println(currFormat.format(price)); %>
					</td>
				</tr>
				<%
					}
				%>		
			</table>
		</td>
	</tr>
<%
        }
	out.println("</table>");
	// close connection
	con.close();
    }
catch (SQLException ex){
    out.println("SQLException: " + ex); 
}
%>


</body>
</html>

