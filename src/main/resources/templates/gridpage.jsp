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
<<html> 
    <head> 
        <title>Screening - Users</title> 
        <%@include file="WEB-INF/jspf/head.jsp" %>
    </head> 
    <body>

        <div id="gridpage" data-role="page" data-add-back-btn="true">
            <div id="grid"></div>
            <div id="pager"></div>
        </div>
    </body>
</html>