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
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Username:</font></div></td>
	<td><input type="text" name="username"  size=10 maxlength=10></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Password:</font></div></td>
	<td><input type="password" name="password" size=10 maxlength="10"></td>
</tr>
</table>
<br/>
<input class="submit" type="submit" name="Submit2" value="Log In">
</form>

</body>
</html>

