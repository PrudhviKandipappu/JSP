<%@ page import="java.sql.*" %>
<% response.setHeader("Access-Control-Allow-Origin", "*"); %>
<%
	String user = "Prudhvi";
	String password = "Prudhvi@2004";
	Connection dbConnection = null;
	try {
		dbConnection = DriverManager.getConnection("jdbc:mysql://138.68.140.83/dbPrudhvi", user, password);
	}
	catch (Exception e) {
		out.println(e);
	}
	String itemID = request.getParameter("itemID");
	String deleteQuery = "DELETE FROM Stock WHERE ItemID=" + itemID;
	Statement stmt = dbConnection.createStatement();
	int i = stmt.executeUpdate(deleteQuery);
%>