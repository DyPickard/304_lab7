<%@ page import="java.io.*,java.util.*" %>
<%@ page import="java.sql.*,java.net.URLEncoder" %>
<html>
<head>
</head>
<body>
<%@ include file="boilerplate.jsp" %>
<%


String userName = (String) session.getAttribute("authenticatedUser");

// review id 
String prodId = request.getParameter("productId");
String reviewRating = request.getParameter("rating");
String comment = request.getParameter("review_comment");
String pid = request.getParameter("pid");

if (userName == null){
    response.sendRedirect("login.jsp?loginMessage=Please login to review a product.");
}

String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
String uid = "sa";
String pw = "304#sa#pw"; 

try (Connection con = DriverManager.getConnection(url, uid, pw)) { 
Statement stmt = con.createStatement();
// get user id
PreparedStatement ps1 = con.prepareStatement("SELECT customerId FROM customer WHERE userid = ?");
ps1.setString(1,userName);
ResultSet r = ps1.executeQuery();
String cId = "";
if (r.next()){
    cId = r.getString("customerId");
}
else {
    response.sendRedirect("login.jsp?loginMessage=Please login to review a product.");
}
// insert review into DB
    try {
    PreparedStatement ps2 = con.prepareStatement("INSERT INTO review (reviewRating, reviewDate, customerId, productId, reviewComment) VALUES (?, GETDATE(), ?, ?, ?)",Statement.RETURN_GENERATED_KEYS);
    ps2.setString(1,reviewRating);
    ps2.setString(2,cId);
    ps2.setString(3,prodId);
    ps2.setString(4,comment);
    ps2.executeUpdate();
    out.print("<h2>Review Created!</h2>");
    }
    catch (Exception e){
        out.print(e);
    }

} 
catch (Exception e){
    out.print(e);
}
%>
</body>
</html>


