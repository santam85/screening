<%-- 
    Document   : folderlist
    Created on : Aug 31, 2012, 4:32:51 PM
    Author     : MSANTARE
--%>


<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="javax.naming.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>

<ul data-role="listview" data-inset="true">
    <%
        Connection con = null;
        Statement stmt = null;
        ResultSet rst = null;
        try {
            Context ctx = new InitialContext();
            DataSource ds = (DataSource) ctx.lookup("java:/comp/env/jdbc/screening");
            con = ds.getConnection();
            stmt = con.createStatement();
            rst = stmt.executeQuery("select * from cartelle");
            while (rst.next()) {
    %>

    <li>
        <a href="detail.jsp?id=<%=rst.getString("cartella")%>">
            <h3><%=rst.getString("nome")%> <%=rst.getString("cognome")%></h3>
            <p><strong><%=rst.getString("cartella")%></strong></p>

            <p class="ui-li-aside">
                <strong>BMI: </strong><%=rst.getFloat("bmi")%><br/>
                <strong>Nato il: </strong><%=new SimpleDateFormat("dd/MM/yyyy").format(rst.getDate("datanascita"))%>
            </p>
        </a>
    </li>
    <%}
        } catch (Exception ex) {
    %>
        <li>
            <h1>Error:</h1>
            <p> <%=ex.getLocalizedMessage()%></p>
        </li>
    <%        
        } finally {
            // Always make sure result sets and statements are closed,
            // and the connection is returned to the pool
            if (rst != null) {
                try {
                    rst.close();
                } catch (SQLException e) {;
                }
                rst = null;
            }
            if (stmt != null) {
                try {
                    stmt.close();
                } catch (SQLException e) {;
                }
                stmt = null;
            }
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException e) {;
                }
                con = null;
            }
        }
    %>
</ul>
