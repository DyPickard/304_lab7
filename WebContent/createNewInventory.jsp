<%@ page import="java.sql.*,java.net.URLEncoder" %>

<%
    String id = request.getParameter("productId");
    String warehouse = request.getParameter("warehouseId");
    String inventory = request.getParameter("amount");

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
        PreparedStatement p1 = con.prepareStatement("INSERT INTO productinventory (productId, warehouseId, quantity) VALUES (?, ?, ?);");
        p1.setInt(1, Integer.valueOf(id));
        p1.setInt(2, Integer.valueOf(warehouse));
        p1.setInt(3, Integer.valueOf(inventory));
        p1.execute();
    }
%>
<jsp:forward page="editInventory.jsp" />