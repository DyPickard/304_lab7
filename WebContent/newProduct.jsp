<!DOCTYPE html>
<html>
<head>
<title>New Product</title>
</head>
<style>

    input, textarea {
        width:500px;
    }
    

</style>
<body>
<%@ include file="boilerplate.jsp" %>

<%@ include file="auth.jsp"%>
<%@ include file="jdbc.jsp" %>
<%@ page import="java.text.NumberFormat" %>

<form method=post action=createNewProduct.jsp>
    <table>
        <tr>
            <th>Product Name</th>
            <td><input type=text name=productName required>
        </tr>
        <tr>
            <th>Product Price</th>
            <td><input type=number name=productPrice step=0.01 required></td>
        </tr>
        <tr>
            <th>Image URL</th>
            <td><input type=text name=productImageURL></td>
        </tr>
        <%-- <tr>
            <th>Product Image</th>
            <td><input type=text></td>
        </tr> --%>
        <tr>
            <th>Product Description</th>
            <td><textarea name=productDescription style="width:500px;height:50px;"></textarea></td>
        </tr>
        <tr>
            <th>Category</th>
            <td><select name=categoryId>
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

    // Make the connection

    String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
    String uid = "sa";
    String pw = "304#sa#pw"; 
    try ( Connection con = DriverManager.getConnection(url, uid, pw)){
        Statement s1 = con.createStatement();
        ResultSet r1 = s1.executeQuery("SELECT * FROM category;");
        while(r1.next()){
            out.println("<option value=" + r1.getInt("categoryId") + ">" + r1.getString("categoryName") + "</option>");
        }
    }
%>

            </select></td>
        </tr>
    </table>
<input type=submit value="Submit" style="width:100px;margin-top:50px;">
</form>
<form action=editItems.jsp>
    <input type=submit value="Back" style="width:100px;margin-top:10px;">
</form>
</body>
        



    