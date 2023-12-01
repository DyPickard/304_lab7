<!DOCTYPE html>
<html>
<head>
<title>Create Account Screen</title>
</head>
<body>
<%@ include file="boilerplate.jsp" %>
<div style="margin:0 auto;text-align:center;display:inline">

<h3>Create New Account</h3>

<form name="MyForm" method=post action="createNewAccount.jsp">
<table style="display:inline">
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">First Name</font></div></td>
	<td><input type="text" name="firstName" size=10 maxlength="40" required></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Last Name</font></div></td>
	<td><input type="text" name="lastName" size=10 maxlength="40" required></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Username</font></div></td>
	<td><input type="text" name="username"  size=10 maxlength="20" required></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Password</font></div></td>
	<td><input type="password" name="password" size=10 maxlength="30" required></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Confirm Password</font></div></td>
	<td><input type="password" name="passwordConfirm" size=10 maxlength="30" required></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Email Address</font></div></td>
	<td><input type="email" name="emailAddress" size=10 maxlength="50" required></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Phone Number</font></div></td>
	<td><input type="text" name="phoneNumber" size=10 maxlength="20" required></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Address</font></div></td>
	<td><input type="text" name="address" size=10 maxlength="50" required></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">City</font></div></td>
	<td><input type="text" name="city" size=10 maxlength="40" required></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Province</font></div></td>
	<td><input type="text" name="province" size=10 maxlength="20" required></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Postal Code</font></div></td>
	<td><input type="text" name="postalCode" size=10 maxlength="6" minlength="6" required></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Country</font></div></td>
	<td><input type="text" name="country" size=10 maxlength="40" required></td>
</tr>
</table>
<br/>
<input class="submit" type="submit" name="submit" value="Create Account">
</form>
	<%
	String error = request.getParameter("error");
    if (error != null && !error.isEmpty()) {
		out.print("<h2>"+error+"</h2>");
		 } 
	%>
</body>
</html>

