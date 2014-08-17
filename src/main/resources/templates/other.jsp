<%-- 
    Document   : edit
    Created on : Aug 30, 2012, 5:38:09 PM
    Author     : MSANTARE
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@include file="WEB-INF/jspf/sessionmanager.jsp" %>

<!DOCTYPE html> 
<html> 
    <head> 
        <title>Screening - Other</title> 
        <%@include file="WEB-INF/jspf/head.jsp" %>
    </head>
    <body>
        <c:import url="WEB-INF/jspf/header.jsp">
            <c:param name="key" value="value" />
        </c:import>

        <div data-role="content">
            <ul data-role="listview" data-inset="true">
                <li data-icon="gear">
                    <a href="settings.jsp">Settings</a>
                </li>
                <c:if test="${sessionScope.user.role.equalsIgnoreCase('admin')}">
                <li data-icon="fa-user">
                    <a href="users.jsp">Users</a>
                </li>
                <li data-icon="fa-download-alt">
                    <a href="fullbackup.sql" data-ajax="false">Backup Data</a>
                </li>
                <li data-icon="fa-download">
                    <a href="export-data.jsp" data-ajax="false">Export Data</a>
                </li>
                </c:if>
                <li data-icon="fa-time">
                    <a href="#">Stats</a>
                </li>
                <li data-icon="fa-bar-chart">
                    <a href="#">Charts</a>
                </li>
                <li data-icon="fa-bar-chart">
                    <a href="note.jsp">Notes</a>
                </li>
                
            </ul>
            <h3>Authors</h3>
            <p>Marco Santarelli</p>
            <p>Nicola Garavelli</p>
        </div>

        <%@include file="WEB-INF/jspf/footer.jsp" %>

    </body>
</html>
