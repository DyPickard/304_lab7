<%@ page import="java.sql.*,java.net.URLEncoder" %>

<%
    String categoryName = request.getParameter("newCategory");
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
        PreparedStatement p1 = con.prepareStatement("INSERT INTO category(categoryName) VALUES (?)");
        p1.setString(1, categoryName);
        p1.execute();
    }
%>
<jsp:forward page="editCategories.jsp" />