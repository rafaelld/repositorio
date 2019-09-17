<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Transportadora Ficticia</title>
</head>
<body>
<p>Rastreio da encomenda <%=request.getParameter("encomendaId")%></p>



<%
String formato = "dd/MM/yyyy HH:mm:ss";
SimpleDateFormat sdf = new SimpleDateFormat(formato);

Connection con;
Class.forName("org.postgresql.Driver");

String id = request.getParameter("encomendaId");
if(id == null || id.equals("")){
	id = "0";
} else {
	try {
        int i = Integer.parseInt(id);
    } catch (NumberFormatException e) {
        id = "0";
    } catch (NullPointerException e) {
    	id = "0";
    }
}

con=(Connection)DriverManager.getConnection("jdbc:postgresql://localhost:5432/postgres", "postgres", "rafael2903");
String command = "SELECT * from rastreio WHERE rastreio.\"encomendaId\" = " + id + " ORDER BY rastreio.\"statusId\"";

PreparedStatement ps=(PreparedStatement)con.prepareStatement(command);
ResultSet rs=ps.executeQuery();

if(rs.next() == false){
	out.println("Nenhuma encomenda encontrada");
} else {
	
	out.println("<table border=\"1\">");
	out.println("<tr>");
	out.println("<td>Data</td>");
	out.println("<td>Status</td>");
	out.println("</tr>");

	do {
		String status = rs.getString("status");
		Timestamp data = rs.getTimestamp("data");
		out.println("<tr><td>"+sdf.format(data)+"</td><td>"+status+"</td></tr>");
	} while(rs.next());
	
	out.println("</table>");
}
%>

<p><a href="pesquisa.jsp">voltar</a></p>

</body>
</html>