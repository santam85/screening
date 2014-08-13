<%-- 
    Document   : testpage
    Created on : 25-set-2012, 20.24.46
    Author     : Santa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html> 
<html> 
    <head> 
        <title>Screening - Users</title> 
        <%@include file="WEB-INF/jspf/head.jsp" %>
    </head> 
    <body>

        <div data-role="page" data-add-back-btn="true">
            <%-- For every String[] item of paramValues... --%>
            <c:forEach var='parameter' items='${paramValues}'> 
                <ul>
                    <%-- Show the key, which is the request parameter
                         name --%>
                    <li><b><c:out value='${parameter.key}'/></b>:</li>
                    <%-- Iterate over the values -- a String[] -- 
                         associated with this request parameter --%>
                    <c:forEach var='value' items='${parameter.value}'>
                        <%-- Show the String value --%>
                        <c:out value='${value}'/>   
                    </c:forEach>
                </ul>
            </c:forEach>

            <c:out value='${param}'/>

        </div></body></html>