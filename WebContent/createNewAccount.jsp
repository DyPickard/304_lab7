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


    // validate first name and last name
    boolean invalidName = false;
    firstName = firstName.trim();
    lastName = lastName.trim();
    char[] fChars = firstName.toCharArray();
    char[] lChars = lastName.toCharArray();
    // checks first name
    for (char c : fChars){
        if (!Character.isLetter(c)){
            invalidName = true;
        }
    }
    // checks last name
    for (char c : lChars){
        if (!Character.isLetter(c)){
            invalidName = true;
        }
    }

    // validates password
    boolean invalidPassword = true;
    char[] pChars = password.toCharArray();
    boolean hasUpper = false;
    boolean hasLower = false;
    boolean hasNumber = false;
    boolean hasSymbol = false;
    for (char c : pChars){
        if (Character.isUpperCase(c)){
            hasUpper=true;
        }
        if (Character.isLowerCase(c)){
            hasLower=true;
        }
        if (Character.isDigit(c)){
            hasNumber=true;
        }
        if (!Character.isDigit(c) && !Character.isLetter(c)){
            hasSymbol = true;
        }
    }
    if (hasUpper && hasLower && hasNumber && hasSymbol){
        invalidPassword=false;
    }

    // if passwords not the same
    if (!password.equals(passwordConfirm)){
        response.sendRedirect("accountCreation.jsp?error=Error, passwords do not match.");
    }
    // if first or last name invalid
    else if (invalidName){
    response.sendRedirect("accountCreation.jsp?error=Error, first and last name must only contain letters.");
    }
    else if (invalidPassword){
        response.sendRedirect("accountCreation.jsp?error=Error, password must contain a uppercase letter, a lowercase letter, a number, and a symbol.");
    }
    else {
        if (username != null && password != null) {
        // Note: Forces loading of SQL Server driver
        try
        {	// Load driver class
	    Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        }
        catch (java.lang.ClassNotFoundException e)
        {
	    out.println("ClassNotFoundException: " +e);
        }
        // Make connection
        String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
        String uid = "sa";
        String pw = "304#sa#pw"; 

        try (Connection con = DriverManager.getConnection(url, uid, pw)) { 
            Statement stmt = con.createStatement();

            // validate unique username
            PreparedStatement ps0 = con.prepareStatement("SELECT userid FROM customer WHERE userid = ?");
            ps0.setString(1,username);
            ResultSet rs = ps0.executeQuery();
            // if username is already in database:
            if (!rs.next() == false){
                response.sendRedirect("accountCreation.jsp?error=Username taken. Please try again.");
            }

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
            out.print("<h2><a href=\"login.jsp\">Go To Login</a></h2>");
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

