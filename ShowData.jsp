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
	String selectQuery = "SELECT *FROM StockReport";
	Statement stmt = dbConnection.createStatement();
	ResultSet rs = stmt.executeQuery(selectQuery);
	String fields[] = {"ItemID", "Description", "UnitPrice", "StockQty", "Update", "Delete"};
	int fieldCounter = 0;
	out.println("<table id='report' border='5' width='50%'>");
	out.println("<tr>");
	while(fieldCounter < fields.length) {
		out.println("<th>" + fields[fieldCounter] + "</th>");
		fieldCounter++;
	}
	out.println("</tr>");
	while(rs.next()) {
		fieldCounter = 1;
		out.println("<tr>");
		out.println("<td>" + rs.getString(fieldCounter) + "</td>");
		fieldCounter++;
		out.println("<td>" + rs.getString(fieldCounter) + "</td>");
		fieldCounter++;
		out.println("<td>" + rs.getInt(fieldCounter) + "</td>");
		fieldCounter++;
		out.println("<td>" + rs.getInt(fieldCounter) + "</td>");
		fieldCounter++;
		out.println("<td><center>" + rs.getString(fieldCounter) + "</center></td>");
		fieldCounter++;
		out.println("<td><center>" + rs.getString(fieldCounter) + "</center></td></tr>");
	}
	out.println("</table>");
%>