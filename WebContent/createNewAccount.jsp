<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ include file="boilerplate.jsp" %>
<%@ page import="java.io.*,java.util.*" 
%>

<%
	String authenticatedUser = null;
	session = request.getSession(true);

 	// Retrieving form data
    String firstName = request.getParameter("firstName");
    String lastName = request.getParameter("lastName");
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String passwordConfirm = request.getParameter("passwordConfirm");
    String email = request.getParameter("emailAddress");
    String phoneNum = request.getParameter("phoneNumber");
    String postalCode = request.getParameter("postalCode");
    String address = request.getParameter("address");
    String city = request.getParameter("city");
    String province = request.getParameter("province");
    String country = request.getParameter("country");

    
    // invalid password
    if (!password.equals(passwordConfirm)){
        response.sendRedirect("accountCreation.jsp?error=Error, passwords do not match.");
    }
    else {
        if (username != null && password != null) {
        //Note: Forces loading of SQL Server driver
        // try
        // {	// Load driver class
	    // Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        // }
        // catch (java.lang.ClassNotFoundException e)
        // {
	    // out.println("ClassNotFoundException: " +e);
        // }
        // Make connection
        String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
        String uid = "sa";
        String pw = "304#sa#pw"; 

        try (Connection con = DriverManager.getConnection(url, uid, pw)) { 
            Statement stmt = con.createStatement();
            PreparedStatement ps = con.prepareStatement("INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);");
            ps.setString(1,firstName);
            ps.setString(2,lastName);
            ps.setString(3,email);
            ps.setString(4,phoneNum);
            ps.setString(5,address);
            ps.setString(6,city);
            ps.setString(7,province);
            ps.setString(8,postalCode);
            ps.setString(9,country);
            ps.setString(10,username);
            ps.setString(11,password);
            ps.executeUpdate();
            out.print("<h2>Account Created!</h2>");
        } 
        catch (Exception e){
            out.print(e);
        }
    }
	else 
    {
        out.println("<h2>Error Creating Account!</h2>");
    }
}


	

%>

