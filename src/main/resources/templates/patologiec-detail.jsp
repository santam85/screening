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
                <sql:update var="result">
                    UPDATE patologiec
                    SET tipo=?,descrizione=?,sindrome=?,mutazioni=?
                    WHERE id=?
                    <sql:param value="${param.tipo}" />
                    <sql:param value="${param.descrizione}" />
                    <sql:param value="${param.sindrome}" />
                    <sql:param value="${param.mutazioni}" />
                    <sql:param value="${param.id}" />
                </sql:update>

                <sql:update>
                    DELETE FROM a2p2t
                    WHERE patologiec_id = ?
                    <sql:param value="${param.id}" />
                </sql:update>
                    
                <c:forEach var="id" items="${paramValues.terapie_id}">
                    <sql:update var="result">
                        INSERT INTO a2p2t
                        (patologiec_id,terapie_id)
                        VALUES
                        (?,?);
                        <sql:param value="${param.id}" />
                        <sql:param value="${id}" />
                    </sql:update>
                </c:forEach>
            </sql:transaction>
        </c:when>
    </c:choose>
    <sql:query var="rs" dataSource="jdbc/screening">
        select * from patologiec where id = ?
        <sql:param value="${param.id}" />
    </sql:query>

    <sql:query var="rsanag" dataSource="jdbc/screening">
        select * from anagrafica where id = ?
        <sql:param value="${rs.rows[0].anagrafica_id}" />
    </sql:query>
        
    <sql:query var="rster" dataSource="jdbc/screening">
        select * from a2p2t join terapie on a2p2t.terapie_id = terapie.id where a2p2t.patologiec_id = ?
        <sql:param value="${param.id}" />
    </sql:query>
</c:catch>

<!DOCTYPE html> 
<html> 
    <head> 
        <title>Screening - Patologia concomitante</title> 
        <%@include file="WEB-INF/jspf/head.jsp" %>
    </head> 
    <body>
        <div id="detail" data-role="page" data-add-back-btn="true">
            <jsp:include page="WEB-INF/jspf/header.jsp">
                <jsp:param name="key" value="value" />
            </jsp:include>

            <div data-role="content">
                <c:if test="${not empty ex}">
                    <div data-role="collapsible" data-collapsed="false" data-theme="e" data-content-theme="d" data-icon="alert">
                        <h3>Error</h3>
                        <p>${ex.localizedMessage}</p>
                    </div>
                </c:if>

                <h4><strong>Paziente:</strong> <a href="patient-detail.jsp?id=${rsanag.rows[0].id}">${rsanag.rows[0].nome} ${rsanag.rows[0].cognome}</a></h4>

                <ul data-role="listview" data-inset="true" data-theme="d">
                    <li>
                        <h3>Tipo</h3>
                        <p class="ui-li-aside" style="margin: 0.6em 0; font-size: 16px;">${rs.rows[0].tipo}</p>
                    </li>
                    <li>
                        <h3>Descrizione</h3>
                        <p class="ui-li-aside" style="margin: 0.6em 0; font-size: 16px;">${rs.rows[0].descrizione}</p>
                    </li>
                    <li>
                        <h3>Sindrome</h3>
                        <p class="ui-li-aside" style="margin: 0.6em 0; font-size: 16px;">${rs.rows[0].sindrome}</p>
                    </li>
                    <li>
                        <h3>Mutazioni</h3>
                        <p class="ui-li-aside" style="margin: 0.6em 0; font-size: 16px;">${rs.rows[0].mutazioni}</p>
                    </li>
                </ul>

                <ul data-role="listview" data-inset="true" data-theme="d">
                    <li data-role="list-divider">Terapie associate<a class="ui-li-count" style="font-size: 14px;padding: 0;" href="terapie-add.jsp?anagrafica_id=${rs.rows[0].anagrafica_id}&patologiec_id=${param.id}" data-role="button" data-theme="a" data-icon="plus" data-iconpos="notext">Inserimento nuova terapia</a></li>
                    <c:choose>
                        <c:when test="${rster.rowCount eq 0}">
                            <li data-theme="d">Nessuna terapia trovata.</li>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="row" items="${rster.rows}">
                                <li data-theme="d">
                                    <a href="terapie-detail.jsp?id=${row.id}">
                                        <h3>${row.tipo}</h3>
                                        <p>${row.descrizione}</p>
                                        <p class="ui-li-aside"><strong>Inizio: </strong><fmt:formatDate value="${row.inizio}" pattern="dd/MM/yyyy"/><br/><strong>Fine: </strong><fmt:formatDate value="${row.fine}" pattern="dd/MM/yyyy"/><br/><strong>Durata (gg): </strong>${row.durata}</p>
                                    </a>
                                </li>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </ul>

                <div class="ui-grid-a"  >
                    <div class="ui-block-a">
                        <form action="patient-detail.jsp?id=${rs.rows[0].anagrafica_id}" method="post">
                            <input type="hidden" name="patologiec_id" value="${param.id}">
                            <button type="submit" name="action" value="deletepatologiac" data-icon="delete" data-iconpos="left" data-theme="e">Delete</button>
                        </form>
                    </div>
                    <div class="ui-block-b">
                        <a href="patologiec-edit.jsp?id=${param.id}" data-role="button" data-icon="gear" data-iconpos="right" data-theme="b">Edit</a>
                    </div>
                </div>
            </div>

            <%@include file="WEB-INF/jspf/footer.jsp" %>
        </div>
    </body>
</html>