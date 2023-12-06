<!DOCTYPE html>
<html>
<head>
<title>Edit Items</title>
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

        out.println("<h4><a href=newProduct.jsp>Create A New Product</a></h4><h4><a href=editProducts.jsp>Return To Previous Menu</a></h4>");

        Statement s1 = con.createStatement();
        ResultSet r1 = s1.executeQuery("SELECT productId, productName, categoryName FROM product JOIN category ON product.categoryId = category.categoryId ORDER BY categoryName ASC;");

        out.println("<table><tr><th>Delete Item</th><th>View Item</th><th>Category</th><th>Edit Item</th></tr>");

        while (r1.next()){
            out.println("<tr><td><a class=button style=\"color:red;\" href=deleteItem.jsp?id=" + r1.getInt("productId") + ">Delete</td><td><a href=product.jsp?id=" + r1.getInt("productId") + ">" + r1.getString("productName") + "</td><td style=\"text-align:center;\">" + r1.getString("categoryName") + "<td><a class=button style=\"color:green;\" href=editItemForm.jsp?id=" + r1.getInt("productId") + ">Edit</a></td></tr>");
        }

        out.println("</table>");
    }
%>