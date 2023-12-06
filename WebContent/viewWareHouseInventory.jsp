<!DOCTYPE html>
<html>
<head>
<title>View Warehouse Inventory</title>
</head>
<style>

th, td {
    padding:0 20px 0 20px;
    text-align:left;
}

</style>
<body>
<%@ include file="boilerplate.jsp" %>

<%@ include file="auth.jsp"%>
<%@ include file="jdbc.jsp" %>
<%@ page import="java.text.NumberFormat" %>
<%
    String id = request.getParameter("id");
    //Note: Forces loading of SQL Server driver
    try
    {	// Load driver class
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
    }
    catch (java.lang.ClassNotFoundException e)
    {
        out.println("ClassNotFoundException: " +e);
    }


    // Make the connection

    String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
    String uid = "sa";
    String pw = "304#sa#pw"; 
    try ( Connection con = DriverManager.getConnection(url, uid, pw)){

        PreparedStatement p1 = con.prepareStatement("SELECT productName, SUM(quantity) AS q FROM product JOIN productinventory ON product.productId = productinventory.productId WHERE warehouseId = ? GROUP BY productName ORDER BY productName ASC;");
        p1.setString(1, id);
        ResultSet r1 = p1.executeQuery();

        PreparedStatement p2 = con.prepareStatement("SELECT warehouseName FROM warehouse WHERE warehouseId = ?;");
        p2.setString(1, id);
        ResultSet r2 = p2.executeQuery();
        r2.next();

        out.println("<h3>"+r2.getString("warehouseName") + "</h3>");
        out.println("<table><tr><th>Product</th><th>Quantity</th></tr>");

        while (r1.next()){
            out.println("<tr><td>" + r1.getString("productName") + "</td><td>" + r1.getInt("q") + "</td></tr>");
        }

        out.println("</table>");
    }
%>

<h4><a href=warehouseReport.jsp>Return to previous page</h4>
</body></html>