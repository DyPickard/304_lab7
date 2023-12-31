<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%
// Get the current list of products
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

// Get product information
String id = request.getParameter("id");

// Remove the product
try {
    productList.remove(id);
}
catch (Error e) {
    System.out.println(e);
}

// Update quantity if add same item to order again

session.setAttribute("productList", productList);
%>
<jsp:forward page="showcart.jsp" />