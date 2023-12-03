<title>A&D Grocery</title>
<style>
        .menu {
        list-style-type: none;
        margin: 0;
        padding: 0;
        align-items: center;
        overflow: hidden;
        background-color: #333;
        display: flex;
        }
        .menu li {
        float: left;
        color: white;
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
        <li><a href="showcart.jsp">Cart</a></li>
        
        <%
	String userName2 = (String) session.getAttribute("authenticatedUser");
        // if logged in
	if (userName2 != null){
                out.print("<li><a href=\"customer.jsp\">My Profile</a><li>");
                out.print("<li><a href=\"admin.jsp\">Admin</a></li>");
                out.print("<li><a href=\"logout.jsp\">Log out</a></li>");
                out.print("<li style=\"margin-left:auto; margin-right:14px;\">Hello <u>" + userName2 + "</u></li>");
        }
        // if not logged in
        else if (userName2 == null){
                out.print("<li><a href=\"login.jsp\">Login</a></li>");
                out.print("<li><a href=\"accountCreation.jsp\">Create Account</a></li>");
        }
        %>
</ul>