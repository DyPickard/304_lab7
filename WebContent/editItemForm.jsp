<!DOCTYPE html>
<html>
<head>
<title>Edit Items</title>
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
<%
    String productId = request.getParameter("id");
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
        Statement s2 = con.createStatement();
        ResultSet r2 = s2.executeQuery("SELECT * FROM category");
        PreparedStatement p1 = con.prepareStatement("SELECT productId, productName, productPrice, productImageURL, productDesc, categoryId FROM product WHERE productId = ?;");
        p1.setInt(1, Integer.valueOf(productId));
        ResultSet r1 = p1.executeQuery();
        r1.next();
        out.println("<form method=post action=editItem.jsp><table><tr><th>Product Name</th><td><input type=hidden name=id value=" + r1.getInt("productId") + "><input type=text name=productName value=\"" + r1.getString("productName") + "\" required</td></tr><tr><th><Product Price</th><td><input type=number name=productPrice value=" + r1.getFloat("productPrice") + " required></td></tr><tr><th>ImageURL</th><td><input type=text name=productImageURL value=\"" + r1.getString("productImageURL") + "\"></td></tr><tr><th>Product Description</th><td><textarea name=productDescription style=\"height:50px;\">" + r1.getString("productDesc") + "</textarea></td></tr><tr><th>Category</th><td><select name=categoryId>");
        while(r2.next()){
            // Gets the list of available categories
            out.println("<option value=" + r2.getInt("categoryId"));
            if(r1.getInt("categoryId") == r2.getInt("categoryId")){
                // Displays the previously selected category
                out.println(" selected");
            }
             out.println(">" + r2.getString("categoryName") + "</option>");
        }
    }
%>

</select></td>
        </tr>
    </table>
<input type=submit value="Submit" style="width:100px;margin-top:50px">
</form>
<form action=editItems.jsp>
    <input type=submit value="Back" style="width:100px;margin-top:10px;">
</form>
</body>