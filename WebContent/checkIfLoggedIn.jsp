<%
	if ((String) session.getAttribute("authenticatedUser") == null){
        response.sendRedirect("login.jsp");
    }
%>