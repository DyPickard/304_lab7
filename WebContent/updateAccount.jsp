<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ include file="boilerplate.jsp" %>
<%@ page import="java.io.*,java.util.*" 
%>

<%
    session = request.getSession(true);
    String userName = (String) session.getAttribute("authenticatedUser");
    String username = request.getParameter("username");
    if (userName != null){
 	// Retrieving form data
    String email = request.getParameter("emailAddress");
    String phoneNum = request.getParameter("phoneNumber");
    String postalCode = request.getParameter("postalCode");
    String address = request.getParameter("address");
    String city = request.getParameter("city");
    String province = request.getParameter("province");
    String country = request.getParameter("country");
    //int userid = session.getAttribute();

    // Note: Forces loading of SQL Server driver
    try {	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
    }
    catch (java.lang.ClassNotFoundException e) {
	out.println("ClassNotFoundException: " +e);
    }
    // Make connection
    String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
    String uid = "sa";
    String pw = "304#sa#pw"; 
    try (Connection con = DriverManager.getConnection(url, uid, pw)) { 
        Statement stmt = con.createStatement();

        PreparedStatement ps = con.prepareStatement("UPDATE customer SET email = ?, phonenum = ?, address = ?, city = ?, state = ?, postalCode = ?, country = ? WHERE userid = ?");
        ps.setString(1,email);
        ps.setString(2,phoneNum);
        ps.setString(3,address);
        ps.setString(4,city);
        ps.setString(5,province);
        ps.setString(6,postalCode);
        ps.setString(7,country);
        ps.setString(8,userName);

        try {
            ps.executeUpdate();
            out.print("<h2>Account Updated!</h2>");
        }
        catch (Exception e){
            out.println(e);
        }
        //out.print("<h2><a href=\"login.jsp\">Go To Login</a></h2>");
    } 
    catch (Exception e){
        out.print(e);
    }
}
else {
    response.sendRedirect("login.jsp?error=login");
}
%>

