<%@ page import="java.sql.*,java.net.URLEncoder" %>

<%
    String pId = request.getParameter("pId");
    String wId = request.getParameter("wId");

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
        PreparedStatement p1 = con.prepareStatement("DELETE FROM productinventory WHERE productId = ? AND warehouseId = ?;");
        p1.setInt(1, Integer.valueOf(pId));
        p1.setInt(2, Integer.valueOf(wId));
        p1.execute();
    }
%>
<jsp:forward page="editInventory.jsp" />