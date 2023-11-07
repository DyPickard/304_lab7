<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>Anthony & Dylan's Store Order Processing</title>
</head>
<body>

<% 

String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
String uid = "sa";
String pw = "304#sa#pw";

// Get customer id
String custId = request.getParameter("customerId");
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

// Determine if valid customer id was entered

try (Connection con = DriverManager.getConnection(url, uid, pw)) {
	// search for customer id
	PreparedStatement ps = con.prepareStatement("SELECT customerId FROM customer WHERE customerId = ?");
	ps.setString(1, custId);
	ResultSet results = ps.executeQuery();
	// customer id is invalid
	if (!results.next()) {
		out.println("<h3>User id invalid</h3><h4><a href=\"/shop/checkout.jsp\">Re-enter id</a></h4>");
	}
	// product list is empoty
	else if (productList == null){
		out.println("<h3>Error, no items in cart</h3><h4><a href=\"/shop/listprod.jsp\">Go to products</a></h4>");
	}
	else {
	// id valid and product list is not empty

		// saves info to database
		String sql = "INSERT INTO ordersummary (customerId) VALUES (?)";
		PreparedStatement ps2 = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
		ps2.setString(1,custId);
		int affectedRows = ps2.executeUpdate();
		// have to execute update before getting generated keys, update orderId after creation
		PreparedStatement ps3 = con.prepareStatement("UPDATE ordersummary SET orderId = ? WHERE customerId = ?");
		ResultSet keys = ps2.getGeneratedKeys();
		keys.next();
		int orderId = keys.getInt(1);
		ps3.setInt(1,orderId);
		ps3.setString(2,custId);

		// insert products into OrderProduct table using OrderId
		String sql2 = "INSERT INTO orderproduct (orderId, productId, quantity) VALUES (?, ?, ?)";

		Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
		while (iterator.hasNext()) {
			Map.Entry<String, ArrayList<Object>> entry = iterator.next();
			ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
			String productId = (String) product.get(0);
        	String price = (String) product.get(2);
			double pr = Double.parseDouble(price);
			int qty = ( (Integer)product.get(3)).intValue();
			// add each product to the orderproduct table
			PreparedStatement ps4 = con.prepareStatement("INSERT INTO orderproduct (orderId, productId, price, quantity) VALUES (?, ?, ?, ?)");
			ps4.setInt(1,orderId);
			ps4.setString(2,productId);
			ps4.setString(3,price);
			ps4.setInt(4,qty);
			ps4.executeUpdate();
		}
		// print out order summary
		// add product info to table
		out.println("<h2>Order Summary</h2>");
		out.println(orderId);
		// test
		out.println("<Table border=1> <tr> <th> Product ID </th> <th> Price </th> <th> quantity </th>"
		+"<tr> <td> 12 </td> <td> $100 </td> <td> 4 </td> </table>");
	}
}
		catch (Exception e){
	out.println(e);
}


	/*
	// Use retrieval of auto-generated keys.
	PreparedStatement pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);			
	ResultSet keys = pstmt.getGeneratedKeys();
	keys.next();
	int orderId = keys.getInt(1);
	*/

// Insert each item into OrderProduct table using OrderId from previous INSERT

// Update total amount for order record

// Here is the code to traverse through a HashMap
// Each entry in the HashMap is an ArrayList with item 0-id, 1-name, 2-quantity, 3-price

/*
	Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
	while (iterator.hasNext())
	{ 
		Map.Entry<String, ArrayList<Object>> entry = iterator.next();
		ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
		String productId = (String) product.get(0);
        String price = (String) product.get(2);
		double pr = Double.parseDouble(price);
		int qty = ( (Integer)product.get(3)).intValue();
            ...
	}
*/

// Print out order summary

// Clear cart if order placed successfully
%>
</BODY>
</HTML>