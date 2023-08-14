<%@ page import="java.sql.*" %>
<% response.setHeader("Access-Control-Allow-Origin", "*"); %>
<%@ page import="org.json.JSONObject"%>
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
	Statement stmt = dbConnection.createStatement();
	String selectQuery = "SELECT *FROM Stock WHERE ItemID='" + itemID + "'";
	ResultSet rs = stmt.executeQuery(selectQuery);
	JSONObject json = new JSONObject();
	if (rs.next()) {
		json.put("itemID", rs.getString("ItemID"));
		json.put("description", rs.getString("Description"));
		json.put("stockQty", rs.getInt("StockQty"));
		json.put("unitPrice",rs.getInt("UnitPrice"));
	}
	out.println(json);
%>
