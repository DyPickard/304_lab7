<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>
</head>
<style>

</style>
<body>
<%@ include file="boilerplate.jsp" %>

<%@ include file="auth.jsp"%>
<%@ include file="jdbc.jsp" %>
<%@ page import="java.text.NumberFormat" %>
<%
    String productId = request.getParameter("id");
    String productName = request.getParameter("productName");
    String productPrice = request.getParameter("productPrice");
    String productURL = request.getParameter("productImageURL");
    String productDesc = request.getParameter("productDescription");
    String productCategory = request.getParameter("categoryId");
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
        PreparedStatement p1 = con.prepareStatement("UPDATE product SET productName = ?, productPrice = ?, productImageURL = ?, productDesc = ?, categoryId = ? WHERE productId = ?");
        p1.setString(1, productName);
        p1.setFloat(2, Float.parseFloat(productPrice));
        p1.setString(3, productURL);
        p1.setString(4, productDesc);
        p1.setInt(5, Integer.valueOf(productCategory));
        p1.setInt(6, Integer.valueOf(productId));
        p1.execute();
    }
%>

<jsp:forward page="editItems.jsp" />
