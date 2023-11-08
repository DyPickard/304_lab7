<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Date" %>
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
// import numberformat for currency variables.
NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// Get customer id
String custId = request.getParameter("customerId");
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");
long millis = System.currentTimeMillis();
java.sql.Date sqlDate = new java.sql.Date(millis);

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
		String sql = "INSERT INTO ordersummary (customerId, orderDate) VALUES (?, ?)";
		PreparedStatement ps2 = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
		ps2.setString(1,custId);
		ps2.setDate(2, sqlDate);
		int affectedRows = ps2.executeUpdate();
		// have to execute update before getting generated keys, update orderId after creation
		PreparedStatement ps3 = con.prepareStatement("UPDATE ordersummary SET orderId = ? WHERE customerId = ?");
		ResultSet keys = ps2.getGeneratedKeys();
		keys.next();
		// order id always unique because it is auto-incremented in the db
		int orderId = keys.getInt(1);
		ps3.setInt(1,orderId);
		ps3.setString(2,custId);

		// insert products into OrderProduct table using OrderId
		String sql2 = "INSERT INTO orderproduct (orderId, productId, quantity) VALUES (?, ?, ?)";
		Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
		while (iterator.hasNext()) {
			// iterate over each product in the product list and get values for each
			Map.Entry<String, ArrayList<Object>> entry = iterator.next();
			ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
			String productId = (String) product.get(0);
        	String price = (String) product.get(2);
			double pr = Double.parseDouble(price);
			int qty = ( (Integer)product.get(3)).intValue();

			// add the product to the orderproduct table for each product in list
			PreparedStatement ps4 = con.prepareStatement("INSERT INTO orderproduct (orderId, productId, price, quantity) VALUES (?, ?, ?, ?)");
			ps4.setInt(1,orderId);
			ps4.setString(2,productId);
			ps4.setString(3,price);
			ps4.setInt(4,qty);
			ps4.executeUpdate();
		}
		// print out order summary
		
		// add product info to table
		PreparedStatement ps6 = con.prepareStatement("SELECT productname, price, quantity, orderproduct.productId FROM orderproduct join product ON orderproduct.productId = product.productId WHERE orderproduct.orderId = ?");
		ps6.setInt(1,orderId);
		ResultSet rs = ps6.executeQuery();
		
		out.println("<h2>Order Summary</h2>");
		out.println("<h3>Order number: "+orderId+"</h3>");
		out.println("<Table border=1> <tr> <th>Product Id</th><th> Product </th> <th> quantity </th><th> Price </th><th>Sub-total</th></tr>");
		double totalPrice = 0;
		while (rs.next()){
			double subTotal = 0;
			int prodId = rs.getInt("productId");
			String prodName = rs.getString("productname");
			int quantity = rs.getInt("quantity");
			double price = rs.getDouble("price");
			subTotal = price * quantity;
			totalPrice += subTotal;
			out.println("<tr><td>"+prodId+"</td><td>"+prodName+"</td><td>"+quantity+"</td><td>"+currFormat.format(price)+"</td><td>"+currFormat.format(subTotal)+"</tr>");
		}
		out.println("</table>");
		out.println("<h3>Order Total: "+currFormat.format(totalPrice)+"</h3>");
	}
}
		catch (Exception e){
	out.println(e);
}

// Your code is in the other order file in the repo, I was having issues working on it so had to start from scratch, renamed it to order.jsp for testing.
// Seems to be working just need to finish the last part of the assignment + the extra stuff to add.

// TO DO

// Update total amount for order record
// Print out order summary
// Clear cart if order placed successfully
// Bonus Stuff
%>
</BODY>
</HTML>