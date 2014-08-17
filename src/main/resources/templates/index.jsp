<%--
    Document   : index
    Created on : Aug 30, 2012, 5:23:17 PM
    Author     : MSANTARE
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>	
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:catch var="ex">
    <sql:query var="rspn" dataSource="jdbc/screening">
        select count(*) as numcartelle from anagrafica
    </sql:query>

    <c:set var="records" value="${rspn.rows[0].numcartelle}"/>
    
    <c:choose>
        <c:when test="${not empty sessionScope.pageSize}"><c:set var="pageSize" value="${sessionScope.pageSize}"/></c:when>
        <c:otherwise><c:set var="pageSize" value="10"/></c:otherwise>
    </c:choose>
    
    <c:set var="pageNumber" value="${(records/pageSize)+(1-((records/pageSize)%1)%1)}"/>

    <c:choose>
        <c:when test="${empty param.page}">
            <c:set var="currentPage" value="0" />
        </c:when>
        <c:otherwise>
            <c:set var="currentPage" value="${param.page}" />
        </c:otherwise>
    </c:choose>

    
    <c:if test="${not empty param.action and param.action.equalsIgnoreCase('delete')}">
        <fmt:parseDate pattern="dd/MM/yyyy" var="tmp" value="${param.datanascita}" />

        <sql:update dataSource="jdbc/screening" var="result">
            delete from anagrafica where id = ?
            <sql:param value="${param.id}" />
        </sql:update>
    </c:if>

    <sql:query var="rst" dataSource="jdbc/screening" startRow="${currentPage * pageSize}" maxRows="${pageSize * 1}">
        select * from anagrafica
    </sql:query>
</c:catch>
<!DOCTYPE html>
<html> 
    <head> 
        <title>Screening - Pazienti</title> 
        <%@include file="WEB-INF/jspf/head.jsp" %>
    </head> 
    <body>
        <div id="index" data-role="page" data-add-back-btn="true">
            <c:import url="WEB-INF/jspf/header.jsp">
                <c:param name="key" value="value" />
            </c:import>

            <div data-role="content">
                <c:choose>
                    <c:when test="${not empty ex}">
                        <div data-role="collapsible" data-collapsed="false">
                            <h3>Error:</h3>
                            <p>${ex.localizedMessage}</p>
                            <c:forEach var="stackTraceElem" items="${ex.stackTrace}">
                                <p>${stackTrace}</p>
                            </c:forEach>
                            
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div data-role="controlgroup" data-type="horizontal" style="text-align: center;">
                            <a href="index.jsp?page=0" data-role="button" data-icon="arrow-l" data-iconpos="left" ${currentPage<1?'class="ui-disabled"':''}>First Page</a>
                            <a href="index.jsp?page=${currentPage-1}" data-role="button" data-icon="back" data-iconpos="left" ${currentPage<1?'class="ui-disabled"':''}>Previous Page</a>
                            <a href="index.jsp?page=${currentPage+1}" data-role="button" data-icon="forward" data-iconpos="right" ${currentPage+1>pageNumber-1?'class="ui-disabled"':''}>Next Page</a>
                            <a href="index.jsp?page=<fmt:formatNumber value="${pageNumber-1}" maxFractionDigits="0" />" data-role="button" data-icon="arrow-r" data-iconpos="right" ${currentPage+1>pageNumber-1?'class="ui-disabled"':''}>Last Page</a>
                        </div>

                        <ul data-role="listview" data-inset="true" style="clear: both;">
                            <li data-role="list-divider">Lista pazienti, pagina ${currentPage+1} di <fmt:formatNumber value="${pageNumber}" maxFractionDigits="0" /> <span class="ui-li-count"> <fmt:formatNumber value="${records}" maxFractionDigits="0" /> records </span></li>
                            <c:choose>
                                <c:when test="${rst.rowCount eq 0}">
                                    <li>Nessun paziente trovato.</li>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="row" items="${rst.rows}">
                                        <li>
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
                                </c:otherwise>
                            </c:choose>

                        </ul>
                    </c:otherwise>
                </c:choose>
            </div>
            <%@include file="WEB-INF/jspf/footer.jsp" %>
        </div>
    </body>
</html>
