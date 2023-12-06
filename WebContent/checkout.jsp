<html>
<head>
<title>A&D Textiles</title>
</head>
<body>

<%

String userName = (String) session.getAttribute("authenticatedUser");
// if not logged in
if (userName == null){
%>
<%@ include file="login.jsp" %>
<%
}
// if logged in
else {
    response.sendRedirect("order.jsp");
}
%>
</body>
</html>

