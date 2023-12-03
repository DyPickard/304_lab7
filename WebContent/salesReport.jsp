<!DOCTYPE html>
<html>
<head>
<title>Sales Report</title>
</head>
<body>
<%@ include file="boilerplate.jsp" %>

<%@ include file="auth.jsp"%>
<%@ include file="jdbc.jsp" %>
<%@ page import="java.text.NumberFormat" %>

<%
NumberFormat currFormat = NumberFormat.getCurrencyInstance();

// Write SQL query that prints out total order amount by day
try {
    getConnection();
    Statement s = con.createStatement();
    ResultSet r = s.executeQuery("SELECT CAST(orderDate AS DATE) as d, SUM(totalAmount) as t FROM ordersummary GROUP BY CAST(orderDate AS DATE);");

    out.println("<h2>Administrator Sales Report by Day</h3><table border=2><tr><th>Order Date</th><th>Total Order Amount</th></tr>");

    while (r.next()){
        out.println("<tr><td>" + r.getDate("d") + "</td><td>" + currFormat.format(r.getFloat("t")) + "</td></tr>");
    }
    out.println("</table><h2><a href=\"/shop/index.jsp\">Return to Main Menu</a></h3>");
}
catch (Exception e){
	out.println(e);
}
%>

</body>
</html>

