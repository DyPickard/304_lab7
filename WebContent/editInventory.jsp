<!DOCTYPE html>
<html>
<head>
<title>Edit Categories</title>
</head>
<style>

</style>
<body>
<%@ include file="boilerplate.jsp" %>

<%@ include file="auth.jsp"%>
<%@ include file="jdbc.jsp" %>
<%@ page import="java.text.NumberFormat" %>
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

    // Variable name now contains the search string the user entered
    // Use it to build a query and print out the resultset.  Make sure to use PreparedStatement!

    // Make the connection

    String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
    String uid = "sa";
    String pw = "304#sa#pw"; 
    try ( Connection con = DriverManager.getConnection(url, uid, pw)){
        
        // Get the list of all categories
        Statement s1 = con.createStatement();
        ResultSet r1 = s1.executeQuery("SELECT product.productId, productName, SUM(productinventory.quantity) as T, warehouseName, productinventory.warehouseId FROM product JOIN productinventory ON product.productId = productinventory.productId JOIN warehouse ON productinventory.warehouseId = warehouse.warehouseId GROUP BY product.productId, productName, warehouseName, productinventory.warehouseId ORDER BY productName ASC;");

        out.println("<h3><a href=newInventory.jsp>Add New Inventory</a></h3><h3><a href=admin.jsp>Return To Previous Menu</h3>");

        out.println("<table><tr><th></th><th>Product Name</th><th>Inventory Amount</th><th>Warehouse</th><th>Update Amount</th></tr>");
        while (r1.next()){
            out.println("<form method=get action=updateInventory.jsp><input type=hidden name=id value=" + r1.getInt("productId") + "><tr><td><a href=\"deleteInventory.jsp?pId=" + r1.getInt("productId") + "&wId=" + r1.getInt("warehouseId") + "\">Delete</a></td><td>" + r1.getString("productName") + "</td><td><input type=number value=\"" + r1.getInt("T") + "\"</td><td>" + r1.getString("warehouseName") + "<td class=update><input type=submit value=\"Update\"</td></tr></form>");
        }
        out.println("</table>");
    }
%>

</body></html>