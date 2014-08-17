<%-- 
    Document   : edit
    Created on : Aug 30, 2012, 5:38:09 PM
    Author     : MSANTARE
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@taglib uri="WEB-INF/tlds/screening.tld" prefix="scr" %>

<%@include file="WEB-INF/jspf/sessionmanager.jsp" %>

<c:catch var="ex">
    <c:choose>
        <c:when test="${not empty param.action and param.action.equalsIgnoreCase('save')}">
            <sql:transaction dataSource="jdbc/screening">
                <sql:update>
                    UPDATE terapie
                    SET tipo=?,descrizione=?,inizio=?,fine=?,durata=?
                    WHERE id = ?
                    <sql:param value="${param.tipo}" />
                    <sql:param value="${param.descrizione}" />
                    <fmt:parseDate value="${param.inizio}" pattern="dd/MM/yyyy" var="iniziop" />
                    <sql:dateParam value="${iniziop}" />
                    <fmt:parseDate value="${param.fine}" pattern="dd/MM/yyyy" var="finep" />
                    <sql:dateParam value="${finep}" />
                    <fmt:formatNumber value="${(finep.time-iniziop.time)/(1000*60*60*24)}" maxFractionDigits="0" var="durata"/> 
                    <sql:param value="${durata}" />
                    <sql:param value="${param.id}" />
                </sql:update>

                <sql:update>
                    DELETE FROM a2p2t
                    WHERE terapie_id = ?
                    <sql:param value="${param.id}" />
                </sql:update>

                <c:forEach var="id" items="${paramValues.patologiec_id}">
                    <sql:update var="result">
                        INSERT INTO a2p2t
                        (patologiec_id,terapie_id)
                        VALUES
                        (?,?);
                        <sql:param value="${id}" />
                        <sql:param value="${param.id}" />
                    </sql:update>
                </c:forEach>
            </sql:transaction>
        </c:when>
    </c:choose>
    <sql:query var="rs" dataSource="jdbc/screening">
        select * from terapie where id = ?
        <sql:param value="${param.id}" />
    </sql:query>

    <sql:query var="rsanag" dataSource="jdbc/screening">
        select * from anagrafica where id = ?
        <sql:param value="${rs.rows[0].anagrafica_id}" />
    </sql:query>
    <sql:query var="rspcon" dataSource="jdbc/screening">
        select * from a2p2t join patologiec on a2p2t.patologiec_id = patologiec.id where a2p2t.terapie_id = ?
        <sql:param value="${param.id}" />
    </sql:query>
</c:catch>

<!DOCTYPE html> 
<html> 
    <head> 
        <title>Screening - Terapia</title> 
        <%@include file="WEB-INF/jspf/head.jsp" %>
    </head> 
    <body>
        <div id="detail" data-role="page" data-add-back-btn="true">
            <jsp:include page="WEB-INF/jspf/header.jsp">
                <jsp:param name="key" value="value" />
            </jsp:include>

            <div data-role="content">
                <c:if test="${not empty ex}">
                    <div data-role="collapsible" data-collapsed="false" data-icon="alert">
                        <h3>Error</h3>
                        <p>${ex.localizedMessage}</p>
                    </div>
                </c:if>

                <h4><strong>Paziente:</strong> <a href="patient-detail.jsp?id=${rs.rows[0].anagrafica_id}">${rsanag.rows[0].nome} ${rsanag.rows[0].cognome}</a></h4>

                <ul data-role="listview" data-inset="true">
                    <li>
                        <h3>Tipo</h3>
                        <p class="ui-li-aside" style="margin: 0.6em 0; font-size: 16px;">${rs.rows[0].tipo}</p>
                    </li>
                    <li>
                        <h3>Descrizione</h3>
                        <p class="ui-li-aside" style="margin: 0.6em 0; font-size: 16px;">${rs.rows[0].descrizione}</p>
                    </li>
                    <li>
                        <h3>Data inizio terapia</h3>
                        <p class="ui-li-aside" style="margin: 0.6em 0; font-size: 16px;"><fmt:formatDate value="${rs.rows[0].inizio}" pattern="dd/MM/yyyy" /></p>
                    </li>
                    <li>
                        <h3>Data fine terapia</h3>
                        <p class="ui-li-aside" style="margin: 0.6em 0; font-size: 16px;"><fmt:formatDate value="${rs.rows[0].fine}" pattern="dd/MM/yyyy" /></p>
                    </li>
                    <li>
                        <h3>Durata terapia (gg)</h3>
                        <p class="ui-li-aside" style="margin: 0.6em 0; font-size: 16px;">${rs.rows[0].durata}</p>
                    </li>
                </ul>

                <ul data-role="listview" data-inset="true">
                    <li data-role="list-divider">Patologie associate <a class="ui-li-count" style="font-size: 14px;padding: 0;" href="patologiec-add.jsp?anagrafica_id=${rs.rows[0].anagrafica_id}&terapie_id=${param.id}" data-role="button" data-icon="plus" data-iconpos="notext">Inserimento nuovo esame</a> </li>
                    <c:choose>
                        <c:when test="${rspcon.rowCount eq 0}">
                            <li>Nessuna patologia associata.</li>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="row" items="${rspcon.rows}">
                                <li>
                                    <a href="patologiec-detail.jsp?id=${row.id}">
                                        <h3>${row.tipo}</h3>
                                        <p>${row.descrizione}</p>
                                        <p class="ui-li-aside"><strong>Sindrome: </strong>${row.sindrome}<br/><strong>Mutazioni: </strong>${row.mutazioni}</p>
                                    </a>
                                </li>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </ul>

                <div class="ui-grid-a"  >
                    <div class="ui-block-a">
                        <form action="patient-detail.jsp?id=${rs.rows[0].anagrafica_id}" method="post">
                            <input type="hidden" name="terapie_id" value="${param.id}">
                            <button type="submit" name="action" value="deleteterapia" data-icon="delete" data-iconpos="left">Delete</button>
                        </form>
                    </div>
                    <div class="ui-block-b">
                        <a href="terapie-edit.jsp?id=${param.id}" data-role="button" data-icon="gear" data-iconpos="right">Edit</a>
                    </div>
                </div>
            </div>

            <%@include file="WEB-INF/jspf/footer.jsp" %>
        </div>
    </body>
</html>