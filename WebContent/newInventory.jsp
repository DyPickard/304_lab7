<!DOCTYPE html>
<html>
<head>
<title>New Product</title>
</head>
<style>

    label, input, select {
        margin-top:20px;
        margin-left:5px;
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

    // Make the connection

    String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
    String uid = "sa";
    String pw = "304#sa#pw"; 
    try ( Connection con = DriverManager.getConnection(url, uid, pw)){
        out.println("<br><form method=post action=createNewInventory.jsp><label for=productId>Product:</label><select name=productId>");

        Statement s1 = con.createStatement();
        ResultSet r1 = s1.executeQuery("SELECT productId, productName FROM product ORDER BY productName ASC;");
        while(r1.next()){
            out.println("<option value=" + r1.getInt("productId") + ">" + r1.getString("productName") + "</option>");
        }
        out.print("</select><br><label for=warehouseId>Warehouse Location:</label><select name=warehouseId>");

        r1 = s1.executeQuery("SELECT warehouseId, warehouseName FROM warehouse;");
        while(r1.next()){
            out.println("<option value=" + r1.getInt("warehouseId") + ">" + r1.getString("warehouseName") + "</option>");
        }
        out.println("</select><br>");
        out.println("<label for=amount>Inventory Amount</label><input type=number name=amount></input>");
    }
%>

            </select></td>
        </tr>
    </table>
<input type=submit value="Submit">
</form>
<h4><a href=editInventory.jsp>Return To Previous Menu</h4>
</body>
        



    