<%--
    Document   : index
    Created on : Aug 30, 2012, 5:23:17 PM
    Author     : MSANTARE
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>	
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@include file="WEB-INF/jspf/sessionmanager.jsp" %>

<c:catch var="ex">
    <c:if test="${not empty param.searchkey}">
        <sql:query var="rs" dataSource="jdbc/screening">
            select * from anagrafica where cartella like ? 
            or nome like ?
            or cognome like ?
            or iniziali like ?
            or luogonascita like ?
            limit 0,100
            <sql:param value="%${param.searchkey}%" />
            <sql:param value="%${param.searchkey}%" />
            <sql:param value="%${param.searchkey}%" />
            <sql:param value="%${param.searchkey}%" />
            <sql:param value="%${param.searchkey}%" />
        </sql:query>
    </c:if>


</c:catch>
<!DOCTYPE html>
<html> 
    <head> 
        <title>Screening - Search</title> 
        <%@include file="WEB-INF/jspf/head.jsp" %>
    </head> 
    <body>
        <div data-role="page" data-add-back-btn="true">
            <c:import url="WEB-INF/jspf/header.jsp">
                <c:param name="key" value="value" />
            </c:import>

            <div data-role="content">

                <c:choose>
                    <c:when test="${not empty ex}">
                        <div data-role="collapsible" data-collapsed="false" data-theme="e" data-content-theme="d" data-icon="alert">
                            <h3>Error:</h3>
                            <p>${ex}</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <form action="search.jsp" method="get">
                            <input type="search" name="searchkey" id="searchkey" value="${param.searchkey}" placeholder="enter at least 2 characters..." pattern=".{2,}"/>
                        </form>

                        <ul data-role="listview" data-inset="true" data-divider-theme="b" >
                            <li data-role="list-divider">Risultati della ricerca: <span class="ui-li-count"> <fmt:formatNumber value="${rs!=null?rs.rowCount:0}" maxFractionDigits="0" minIntegerDigits="1" /> results</span></li>
                            <c:forEach var="row" items="${rs.rows}">
                                <li data-theme="d">
                                    <a href="patient-detail.jsp?id=${row.id}">
                                        <h3>${row.nome} ${row.cognome}</h3>
                                        <p class="folder-number"><strong>${row.cartella}</strong></p>

                                        <p class="ui-li-aside">
                                            <strong>BMI: </strong>${row.bmi}<br/>
                                            <strong>Nato il: </strong><fmt:formatDate pattern="dd/MM/yyyy" value="${row.datanascita}" />
                                        </p>
                                    </a>
                                </li>
                            </c:forEach>
                        </ul>
                    </c:otherwise>
                </c:choose>
            </div>
            <%@include file="WEB-INF/jspf/footer.jsp" %>
        </div>
    </body>
</html>
