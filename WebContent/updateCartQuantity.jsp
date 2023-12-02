<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%
// Get the current list of products
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

// Get product information
String id = request.getParameter("id");
String quantity = request.getParameter("newQuantity");
int q = Integer.valueOf(quantity);

// Update the product quantity
try {
        // Removes the item if set to zero
        if(q == 0){
            productList.remove(id);
        }
        // Update the item if not zero
        else{
        ArrayList l = productList.get(id);
        l.set(3, q);
        productList.put(id, l);
        }
}
catch (Error e) {
    System.out.println(e);
}

// Update session

session.setAttribute("productList", productList);
%>
<jsp:forward page="showcart.jsp" />