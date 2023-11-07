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
// Get customer id
String custId = request.getParameter("customerId");
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

// Determine if valid customer id was entered

try { // Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

// Connection
String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
String uid = "sa";
String pw = "304#sa#pw";

try ( Connection con = DriverManager.getConnection(url, uid, pw))
{
	PreparedStatement p = con.prepareStatement("SELECT customerId FROM customer WHERE customerId = ?;");
	p.setString(1, custId);
	ResultSet r = p.executeQuery();
		
	if (r.next())
	{
		if (productList == null) // Determine if there are products in the shopping cart
		{
			out.println("<h3>Error, no items in cart</h3><h4><a href=\"/shop/listprod.jsp\">Go to products</a></h4>");
		}
		else // Upon successful entry of customerId and cart is not empty
		{	
			
//TODO			
			// Save order information to database
			int orderId = 0;
			Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
				while (iterator.hasNext()) 
				{	// Get all items from hashmap with iterator
					Map.Entry<String, ArrayList<Object>> entry = iterator.next();
					ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
					String productId = (String) product.get(0);
					String price = (String) product.get(2);
					double pr = Double.parseDouble(price);
					int qty = ( (Integer)product.get(3)).intValue();

					PreparedStatement p4 = con.prepareStatement("INSERT INTO ordersummary (orderDate, totalAmount, customerId) VALUES(?, ?, ?;)", Statement.RETURN_GENERATED_KEYS);
					p4.setString(1,);

					if (orderId == 0) // Create orderId
					{
						PreparedStatement p2 = con.prepareStatement("INSERT INTO orderproduct (productId, quantity, price) VALUES(?, ?, ?);", Statement.RETURN_GENERATED_KEYS);
						p2.setString(1, productId);
						p2.setInt(2, qty);
						p2.setDouble(3, pr);
						p2.executeUpdate();
						ResultSet keys = p2.getGeneratedKeys();
						keys.next();
						orderId = keys.getInt(1);
					}
					else // OrderId already exists.
					{
						PreparedStatement p3 = con.prepareStatement("INSERT INTO orderproduct (order Id, productId, quantity, price) VALUES (?, ?, ?, ?);");
						p3.setInt(1, orderId);
						p3.setString(2, productId);
						p3.setInt(3, qty);
						p3.setDouble(4, pr);
						p3.executeUpdate();
					}
					// Clears cart upon successful entry
					productList = new HashMap<String, ArrayList<Object>>();
				}

			// Prints out shipping info
			PreparedStatement p1 = con.prepareStatement("SELECT customerId, firstName, lastName FROM customer WHERE customerId = ?;");
			p1.setString(1, custId);
			ResultSet r1 = p1.executeQuery();
			r1.next();
			out.println("<h3>Order completed. Will be shipped soon...</h3><h3>Your order reference number is: " + orderId + "</h3><h3>Shipping to customer: " + r1.getString("customerId") + " Name: " + r1.getString("firstName") + " " + r1.getString("lastName"));
		}
	}
	else // Displays error when id is invalid
	{
		out.println("<h3>User id invalid</h3><h4><a href=\"/shop/checkout.jsp\">Re-enter id</a></h4>");
	}
}
%>
</BODY>
</HTML>





// Save order information to database


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

