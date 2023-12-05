<%@ page import="java.io.*,java.util.*" %>
<%@ page import="java.time.*" %>
<%

String userName = (String) session.getAttribute("authenticatedUser");
// review id 
String prodId = request.getParameter("productId");
String reviewRating = request.getParameter("rating");
LocalDate date = java.time.LocalDate.now();
String comment = request.getParameter("review_comment");
String pid = request.getParameter("pid");
out.println(pid);
out.println(userName);
out.println(reviewRating);
out.println(date);
out.println(comment);


%>



