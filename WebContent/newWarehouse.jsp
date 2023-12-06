<!DOCTYPE html>
<html>
<head>
<title>New Product</title>
</head>
<style>


</style>
<body>
<%@ include file="boilerplate.jsp" %>

<%@ include file="auth.jsp"%>
<%@ include file="jdbc.jsp" %>
<%@ page import="java.text.NumberFormat" %>

<form method=post action=createNewWarehouse.jsp>
<label style="margin-top:30px;" for=warehouseName>Warehouse Name:</label>
<input style="margin-top:30px;" type=text name=warehouseName required>
<input type=submit value="Submit">
</form>
<h4><a href=warehouseReport.jsp>Return to previous menu</h4>
</body>
        



    