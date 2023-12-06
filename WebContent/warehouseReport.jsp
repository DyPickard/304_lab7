<!DOCTYPE html>
<html>
<head>
<title>Warehouse Report</title>
</head>
<style>

 .delete {
        color:red;
    }
    .update {
        color:green;
    }
    td,th {
        padding-left:20px;
    }

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

        out.println("<h4><a href=newWarehouse.jsp>Add New Warehouse</a></h4><h4><a href=admin.jsp>Return To Previous Menu</a></h4>");

        Statement s1 = con.createStatement();
        ResultSet r1 = s1.executeQuery("SELECT * FROM warehouse");

        out.println("<table><tr><th>Delete</th><th>View Warehouse</th></tr>");

        while (r1.next()){
            out.println("<tr><td><a class=button style=\"color:red;\" href=deleteWarehouse.jsp?id=" + r1.getInt("warehouseId") + ">Delete</td><td><a href=\"viewWareHouseInventory.jsp?id=" +r1.getInt("warehouseId") + "\">" + r1.getString("warehouseName") + "</td></tr>");
        }

        out.println("</table>");
    }
%>