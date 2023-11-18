<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Date" %>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>A&D Grocery Shipment Processing</title>
</head>
<body>
        
<%@ include file="header.jsp" %>

<%
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
	// TODO: Get order id
    String orderID = request.getParameter("orderId");
	// TODO: Check if valid order id in database
	try (Connection con = DriverManager.getConnection(url, uid, pw)){
		
		// get data from order ID
		PreparedStatement p = con.prepareStatement("SELECT orderId FROM ordersummary WHERE orderId = ?");
		p.setString(1,orderID);
		ResultSet r = p.executeQuery();
		// if no order with that id is found
		if (!r.next()){
			out.println("Error. No order found with order id "+orderID);
		}
		// order ID valid
		else {
			// Start a transaction (turn-off auto-commit)
			//out.println("Order found. ID: "+orderID);
			Statement stmt = con.createStatement();
			con.setAutoCommit(false);
			// Retrieve all items in order with given id
			ResultSet rst1 = stmt.executeQuery("SELECT * FROM orderproduct WHERE orderId = "+orderID);

			// TODO: Create a new shipment record.
			String sql = "INSERT INTO shipment (shipmentDate) VALUES (GETDATE())";
			PreparedStatement p2 = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
			p2.executeUpdate();

			// TODO: For each item verify sufficient quantity available in warehouse 1.
			// for each product in order, check inventory
			boolean shipValid = true;
			while (rst1.next()){
				int product = rst1.getInt("productId");
				int prodQuant = rst1.getInt("quantity");
				PreparedStatement p3 = con.prepareStatement("SELECT * FROM productinventory WHERE productId = ?");
				p3.setInt(1,product);
				ResultSet rst2 = p3.executeQuery();

				// check if returned results successfully
				if (!rst2.next()){
					out.println("Error. No results found for that product in warehouse.");
				}

				// no error with query
				else {
					int whQuant = rst2.getInt("quantity");
					// verify inventory


					// if warehouse has less than amount ordered
					if (whQuant < prodQuant){
						out.println("<h2>Shipment failed to process. Insufficient inventory for product number: "+product+"</h2>");
						shipValid = false;
					}
					// update warehouse inventory
					else {
						int newQnt = (whQuant - prodQuant);
						out.println("<table><tr><th><h3>Ordered product: </h3></th><td style="+"width:10%"+"><h3>"+product+"</h3></td>");
						out.println("<th><h3>Quantity: </h3></th><td style="+"width:10%"+" ><h3>"+prodQuant+"</h3></td>");
						out.println("<th><h3>Previous inventory: </h3></th><td style="+"width:10%"+" ><h3>"+whQuant+"</h3></td>");
						out.println("<th><h3>New inventory: </h3></th><td style="+"width:10%"+"><h3>"+newQnt+"</h3></td></tr></table>");
						// update inventory
						PreparedStatement p4 = con.prepareStatement("UPDATE productinventory SET quantity = ? WHERE productId = ?");
						p4.setInt(1,newQnt);
						p4.setInt(2,product);
						p4.executeUpdate();
					}
				}
			}
			// if shipment valid, commit transaction
			if (shipValid){
				con.commit();
				out.println("<h2>Shipment successfully processed</h2>");
			}
			// if shipment invalid, rollback transaction
			else {
				con.rollback();
			}
			con.setAutoCommit(true);
		}
	
	
	
	
	
	// TODO: If any item does not have sufficient inventory, cancel transaction and rollback. Otherwise, update inventory for each item.
	
	// TODO: Auto-commit should be turned back on
	}

%>                       				

<h2><a href="shop.html">Back to Main Page</a></h2>

</body>
</html>
