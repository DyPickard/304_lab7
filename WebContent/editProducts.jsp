<!DOCTYPE html>
<html>
<head>
<title>Edit Products</title>
</head>
<body>
<%@ include file="boilerplate.jsp" %>

<%@ include file="auth.jsp"%>
<%@ include file="jdbc.jsp" %>
<%@ page import="java.text.NumberFormat" %>


<%
out.println("<h2><a href=\"/shop/editCategories.jsp\">Categories</a></h2>");
out.println("<h2><a href=\"/shop/editItems.jsp\">Items</a></h2>");
out.println("<h3><a href=\"/shop/admin.jsp\">Back To Previous Menu</a></h3>");
%>

</body>
</html>

