<!DOCTYPE html>
<html>
<head>

<%@ include file="boilerplate.jsp" %>

<body>
<h1 align="center">Welcome to A&D Grocery</h1>

<!-- <h2 align="center"><a href="login.jsp">Login</a></h2> -->

<!-- <h2 align="center"><a href="listprod.jsp">Begin Shopping</a></h2> -->

<!-- <h2 align="center"><a href="listorder.jsp">List All Orders</a></h2> -->

<!-- <h2 align="center"><a href="customer.jsp">Customer Info</a></h2> -->

<!-- <h2 align="center"><a href="admin.jsp">Administrators</a></h2> -->

<!-- <h2 align="center"><a href="logout.jsp">Log out</a></h2> -->

<%
	String userName = (String) session.getAttribute("authenticatedUser");
	if (userName != null)
		out.println("<h3 align=\"center\">Signed in as: "+userName+"</h3>");
%>

</body>
</head>


