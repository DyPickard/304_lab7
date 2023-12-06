<!DOCTYPE html>
<html>
<head>
<title>Edit Categories</title>
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
        
        // Get the list of all categories
        Statement s1 = con.createStatement();
        ResultSet r1 = s1.executeQuery("SELECT categoryId, categoryName FROM category ORDER BY categoryName ASC;");

        out.println("<table>");

        while (r1.next()){
            out.println("<form name=UpdateCatName method=get action=updateInventory.jsp><tr><td>" + r1.getString("categoryName") + "<td><input type=hidden name=newCatId value=" + r1.getInt("categoryId") + "><input name=newValue type=number value=\"" + r1.getInt("") + "\"></td><td class=update><input type=submit value=\"Update\"</td></tr></form>");
        }
        out.println("</table>");
    }

    // Below is used for adding a category
    out.println("<h3>Add a Category</h3>");

    out.println("<form name=NewCategoryForm method=get action=createNewCategory.jsp><input type=text name=newCategory required><input type=submit value=Create></form>");
%>

<h3><a href=editProducts.jsp>Return To Previous Menu</h3>