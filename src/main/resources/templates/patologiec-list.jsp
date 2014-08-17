<%--
    Document   : index
    Created on : Aug 30, 2012, 5:23:17 PM
    Author     : MSANTARE
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>	
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@taglib uri="WEB-INF/tlds/screening.tld" prefix="scr" %>

<%@include file="WEB-INF/jspf/sessionmanager.jsp" %>

<c:catch var="ex">
    <c:if test="${not empty param.action and param.action.equalsIgnoreCase('delete')}">
        <sql:update dataSource="jdbc/screening" var="result">
            delete from esami where id = ?
            <sql:param value="${param.id}" />
        </sql:update>
    </c:if>

    <sql:query var="rst" dataSource="jdbc/screening">
        select * from esami where anagrafica_id=? order by dataesame
        <sql:param value="${param.anagrafica_id}" />
    </sql:query>
</c:catch>
<!DOCTYPE html>
<html> 
    <head> 
        <title>Screening - Patologie concomitanti</title> 
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
                        <div data-role="collapsible" data-collapsed="false">
                            <h3>Error:</h3>
                            <p>${ex.localizedMessage}</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div data-role="popup" id="type-popup">
                            <p>
                                Selezionare il tipo di esame:
                                <a href="exam-add-sof.jsp?anagrafica_id=${param.anagrafica_id}" data-role="button" data-icon="plus">SOF</a>
                                <a href="exam-add-ctv.jsp?anagrafica_id=${param.anagrafica_id}" data-role="button" data-icon="plus">Colon TC Virtuale</a>
                                <a href="exam-add-csc.jsp?anagrafica_id=${param.anagrafica_id}" data-role="button" data-icon="plus">Colonscopia</a>
                            <p>
                        </div>

                        <ul data-role="listview" data-inset="true">
                            <li data-role="list-divider">Lista esami <a class="ui-li-count" style="font-size: 14px;padding: 0;" href="#type-popup" data-rel="popup" data-role="button" data-icon="plus" data-iconpos="notext">Inserimento nuovo esame</a></li>
                            <c:choose>
                                <c:when test="${rst.rowCount eq 0}">
                                    <li>Nessun esame trovato.</li>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="row" items="${rst.rows}">
                                        <li>
                                            <a href="exam-detail-${row.tipo}.jsp?id=${row.id}">
                                                <h3><scr:decodeExamType>${row.tipo}</scr:decodeExamType></h3>
                                                <p class="ui-li-aside"><strong>Data: </strong><fmt:formatDate value="${row.dataesame}" pattern="dd/MM/yyyy"/></p>
                                            </a>
                                        </li>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>

                        </ul>
                        <a href="#type-popup" data-rel="popup" data-role="button" data-icon="plus">Inserimento nuovo esame</a>
                    </c:otherwise>
                </c:choose>
            </div>
            <%@include file="WEB-INF/jspf/footer.jsp" %>
        </div>
    </body>
</html>
