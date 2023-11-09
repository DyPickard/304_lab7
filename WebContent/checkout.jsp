<!DOCTYPE html>
<html>
<head>
<title>A&D CheckOut Line</title>
<style>
        .menu {
        list-style-type: none;
        margin: 0;
        padding: 0;
        align-items: center;
        overflow: hidden;
        background-color: #333;
        }
        .menu li {
        float: left;
        }
        .menu li a {
        display: block;
        color: white;
        text-align: center;
        padding: 14px 16px;
        }
        .menu li a:hover {
        background-color: #111;
        }
</style> 
</head>
<body>
<ul class="menu">
        <li><a href="/shop">Home</a></li>
        <li><a href="listprod.jsp">Products</a></li>
        <li><a href="listorder.jsp">Orders</a></li>
        <li><a href="showcart.jsp">Cart</a></li>
</ul>
<h1>Enter your customer id to complete the transaction:</h1>

<form method="get" action="order.jsp">
<input type="number" name="customerId" min="1">
<input type="submit" value="Submit"><input type="reset" value="Reset">
</form>

</body>
</html>

