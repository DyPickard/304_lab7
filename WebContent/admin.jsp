<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>
</head>
<body>
<%@ include file="boilerplate.jsp" %>

<%@ include file="auth.jsp"%>
<%@ include file="jdbc.jsp" %>
<%@ page import="java.text.NumberFormat" %>


<%
out.println("<h2><a href=\"listorder.jsp\">Orders Report</a></h2>");
out.println("<h2><a href=\"/shop/salesReport.jsp\">Sales Report</a></h2>");
out.println("<h2><a href=\"/shop/customerReport.jsp\">Customers Report</a></h2>");
%>

</body>
</html>

