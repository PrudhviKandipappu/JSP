<html>
	<body>	
		<b>First Name: </b> <%= request.getParameter("firstName") %><br>
		<b>Last Name: </b> <% out.println(request.getParameter("lastName")); %>
	</body>
</html>
