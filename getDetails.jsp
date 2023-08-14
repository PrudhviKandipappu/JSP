<%@ page import="java.sql.*"%>
<%@ page import="org.json.*"%>
<% response.setHeader("Access-Control-Allow-Origin", "*"); %>
<%
	String db = "dbPrudhvi";
	String user = "Prudhvi";
	String password = "Prudhvi@2004";
	Connection dbConnection = null;
	try {
		dbConnection = DriverManager.getConnection("jdbc:mysql://138.68.140.83/dbPrudhvi", user, password);
	}
	catch (Exception e) {
		out.println(e);
	}
	// String selectQuery = "SELECT *FROM Item WHERE ItemID like '" + request.getParameter("itemID") + "%'";
	String selectQuery = "SELECT *FROM Item";
	// out.println(selectQuery);
	Statement stmt = dbConnection.createStatement();
	ResultSet rs = stmt.executeQuery(selectQuery);
	String fields[] = {"ItemID", "Description", "StockQty", "UnitPrice", "SupplierID"};
	int fieldCounter = 0;
	// JSONObject jsonObject = new JSONObject();
	// rs.next(); jsonObject.put(<key>, <value>);
	out.println("<table border='2'>");
	out.println("<tr>");
	while (fieldCounter < 5) {
		out.println("<th>" + fields[fieldCounter] + "</th>");
		fieldCounter++;
	}
	out.println("</tr>");
	while (rs.next()) {
		fieldCounter = 1;
		out.println("<tr>");
		out.println("<td>" + rs.getString(fieldCounter) + "</td>");
		fieldCounter++;
		out.println("<td>" + rs.getString(fieldCounter) + "</td>");
		fieldCounter++;
		out.println("<td>" + rs.getString(fieldCounter) + "</td>");
		fieldCounter++;
		out.println("<td>" + rs.getString(fieldCounter) + "</td>");
		fieldCounter++;
		out.println("<td>" + rs.getString(fieldCounter) + "</td>");
		out.println("</tr>");
	}
	out.println("</table>");
%>
