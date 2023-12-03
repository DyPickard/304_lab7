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

out.println("</table><h2><a href=\"/shop/salesReport.jsp\">Sales Report</a></h3>");
out.println("</table><h2><a href=\"/shop/customerReport.jsp\">Customer Report</a></h3>");
%>

</body>
</html>

