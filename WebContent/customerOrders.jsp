<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>

<%@ include file="boilerplate.jsp" %>


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
NumberFormat currFormat = NumberFormat.getCurrencyInstance();

session = request.getSession(true);
// userName = userid
String userName = (String) session.getAttribute("authenticatedUser");
String username = request.getParameter("username");
if (userName != null){

	// Make connection
	String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
	String uid = "sa";
	String pw = "304#sa#pw"; 




	try ( Connection con = DriverManager.getConnection(url, uid, pw);
		Statement stmt = con.createStatement();) { 
		out.print("<h2>"+userName+"</h2>");
		PreparedStatement ps = con.prepareStatement("SELECT * FROM ordersummary join customer ON ordersummary.customerId = customer.customerId WHERE customer.userid = ?");		
		ps.setString(1,userName);
		ResultSet rst = ps.executeQuery();

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
		out.println("<h2><a href=\"/shop/customer.jsp\">Back</a></h3>");
		}
	catch (SQLException ex){
		out.println("SQLException: " + ex); 
	}
		}
		
else {
	out.println("<h2><a href=\"/shop/login.jsp\">Error. Please log in.</a></h3>");
	}
%>


</body>
</html>

