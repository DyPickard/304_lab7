<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%
// get product list from session
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");
// clear product list
session.removeAttribute("productList");
%>
<jsp:forward page="showcart.jsp" />