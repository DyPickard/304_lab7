<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="boilerplate.jsp" %>
<%@ page import="java.io.*,java.util.*" %>

<%
	// String authenticatedUser = null;
	// session = request.getSession(true);

 	// Retrieving form data
	String username = request.getParameter("username");
    String password = request.getParameter("password");

	if (username != null && password != null) {
        // Here, you'd typically perform database operations or any other logic to create the account
        // For demonstration purposes, let's assume the account creation is successful
        out.println("<h2>Account Created Successfully!</h2>");
        out.println("<p>Username: " + username + "</p>");
        out.println("<p>Password: " + password + "</p>");
    } 
	else {
        out.println("<h2>Error Creating Account!</h2>");
    }

%>

