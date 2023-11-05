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
<title>YOUR NAME Grocery Order Processing</title>
</head>
<body>

<% 
// Get customer id
String custId = request.getParameter("customerId");
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");


String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
String uid = "sa";
String pw = "304#sa#pw"; 
boolean validId = false;
try (Connection con = DriverManager.getConnection(url, uid, pw)){	
	try (Statement s = con.createStatement(); PreparedStatement ps = con.prepareStatement("SELECT customerId FROM customer")){
		ResultSet rst = ps.executeQuery();
		// to validate customer id, first get arraylist of customer ids
		// If either are not true, display an error message ^
		ArrayList<String> idArray = new ArrayList<>();
		while (rst.next()){
			idArray.add(rst.getString("customerId")); }
		// Determine if valid customer id was entered
		if (!idArray.contains(custId)){
			out.println("Error. Customer ID entered is not valid. Please try again."); }
		// Determine if there are products in the shopping cart
		else if (productList == null){
			out.println("Error. No items in cart."); }
		else {
			validId=true; }
	}
	catch (Exception e){
		System.err.println("SQLException: " + e); }
	try (PreparedStatement ps = con.prepareStatement("", Statement.RETURN_GENERATED_KEYS)){
		ResultSet keys = ps.getGeneratedKeys();
		keys.next();
		int orderId = keys.getInt(1);

	}
}
	catch (SQLException ex) {
	System.err.println("SQLException: " + ex); }



// Make connection

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

