<title>A&D Grocery</title>
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
        <li><a href="/shop/index.jsp">Home</a></li>
        <li><a href="listprod.jsp">Products</a></li>
        <li><a href="listorder.jsp">Orders</a></li>
        <li><a href="showcart.jsp">Cart</a></li>
        

        <%
	String userName2 = (String) session.getAttribute("authenticatedUser");
	if (userName2 != null){
		out.println("<li><a href=\"logout.jsp\">Log out</a></li>");
                out.println("<li><a href=\"customer.jsp\">My Profile</a><li>");
        }
        else if (userName2 == null){
                out.println("<li><a href=\"login.jsp\">Login</a></li>");
        }
        %>
</ul>