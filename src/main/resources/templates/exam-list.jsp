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
    <c:choose>
        <c:when test="${not empty param.action and param.action.equalsIgnoreCase('add')}">
            <fmt:parseDate pattern="dd/MM/yyyy" var="tmp" value="${param.dataesame}" />

            <sql:transaction dataSource="jdbc/screening">
                <sql:update>
                    insert into esami 
                    (anagrafica_id,dataesame,tipo,completamento)
                    values (?,?,?,?); 
                    <sql:param value="${param.anagrafica_id}" />
                    <sql:dateParam value="${tmp}" type="DATE" />
                    <sql:param value="${param.tipo}" />
                    <sql:param value="${param.completamento}" />
                </sql:update>

                <sql:query var="rsLid">
                    select LAST_INSERT_ID() as lastrowid
                </sql:query>

                <c:set var="examid" value="${rsLid.rows[0].lastrowid}" />
                <c:choose>
                    <c:when test="${param.tipo eq 'csc'}">
                        <sql:update>
                            insert into colonscopia
                            (esami_id,cancro,chemio,colesterolo,completo,pulizia,
                            glicemia,ihc,inr,intervento,mutazioni,
                            nlinfonodipositivi,radio,sedecancro_ascendente,
                            sedecancro_discendente,sedecancro_cieco,sedecancro_flessuraepatica,
                            sedecancro_flessurasplenica,sedecancro_retto,
                            sedecancro_sigma,sedecancro_trasverso,stadio,
                            tipopreparazione,tnm,trigliceridi,altric)
                            values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)
                            <sql:param value="${examid}" />
                            <sql:param value="${not empty param.cancro}" />
                            <sql:param value="${param.chemio}" />
                            <sql:param value="${param.colesterolo}" />
                            <sql:param value="${not empty param.completo}" />
                            <sql:param value="${param.pulizia}" />
                            <sql:param value="${param.glicemia}" />
                            <sql:param value="${param.ihc}" />
                            <sql:param value="${param.inr}" />
                            <sql:param value="${param.intervento}" />
                            <sql:param value="${param.mutazioni}" />
                            <sql:param value="${param.nlinfonodipositivi}" />
                            <sql:param value="${not empty param.radio}" />
                            <sql:param value="${not empty param.sedecancro_ascendente}" />
                            <sql:param value="${not empty param.sedecancro_discendente}" />
                            <sql:param value="${not empty param.sedecancro_cieco}" />
                            <sql:param value="${not empty param.sedecancro_flessuraepatica}" />
                            <sql:param value="${not empty param.sedecancro_flessurasplenica}" />
                            <sql:param value="${not empty param.sedecancro_retto}" />
                            <sql:param value="${not empty param.sedecancro_sigma}" />
                            <sql:param value="${not empty param.sedecancro_trasverso}" />
                            <sql:param value="${param.stadio}" />
                            <sql:param value="${param.tipopreparazione}" />
                            <sql:param value="${param.tnm}" />
                            <sql:param value="${param.trigliceridi}" />
                            <sql:param value="${param.altric}" />
                        </sql:update>
                    </c:when>
                    <c:when test="${param.tipo eq 'ctv'}">
                        <sql:update>
                            insert into colontcvirtuale 
                            (esami_id,dimensioni,lesioni,pulizia,sedecancro_ascendente,
                            sedecancro_cieco,sedecancro_flessuraepatica,sedecancro_flessurasplenica,
                            sedecancro_retto,sedecancro_sigma,sedecancro_trasverso,tipolesioni)
                            values (?,?,?,?,?,?,?,?,?,?,?,?)
                            <sql:param value="${examid}" />
                            <sql:param value="${param.dimensioni}" />
                            <sql:param value="${not empty param.lesioni}" />
                            <sql:param value="${param.pulizia}" />
                            <sql:param value="${not empty param.sedecancro_ascendente}" />
                            <sql:param value="${not empty param.sedecancro_cieco}" />
                            <sql:param value="${not empty param.sedecancro_flessuraepatica}" />
                            <sql:param value="${not empty param.sedecancro_flessurasplenica}" />
                            <sql:param value="${not empty param.sedecancro_retto}" />
                            <sql:param value="${not empty param.sedecancro_sigma}" />
                            <sql:param value="${not empty param.sedecancro_trasverso}" />
                            <sql:param value="${param.tipolesioni}" />
                        </sql:update>
                    </c:when>
                    <c:when test="${param.tipo eq 'sof'}">
                        <sql:update>
                            insert into sof 
                            (esami_id,positivo)
                            values (?,?)
                            <sql:param value="${examid}" />
                            <sql:param value="${not empty param.positivo}" />
                        </sql:update>
                    </c:when>
                </c:choose>
            </sql:transaction>
        </c:when>
        <c:when test="${not empty param.action and param.action.equalsIgnoreCase('delete')}">
            <sql:update dataSource="jdbc/screening" var="result">
                delete from esami where id = ?
                <sql:param value="${param.id}" />
            </sql:update>
        </c:when>
    </c:choose>

    <sql:query dataSource="jdbc/screening" var="rs">
        select * from esami where anagrafica_id=? order by dataesame desc
        <sql:param value="${param.anagrafica_id}" />
    </sql:query>

    <sql:query dataSource="jdbc/screening" var="rsanag">
        select * from anagrafica where id=?
        <sql:param value="${param.anagrafica_id}" />
    </sql:query>
</c:catch>
<!DOCTYPE html>
<html> 
    <head> 
        <title>Screening - Esami per ${rsanag.rows[0].nome} ${rsanag.rows[0].cognome}</title> 
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

                        <h4><strong>Paziente:</strong> <a href="patient-detail.jsp?id=${rs.rows[0].anagrafica_id}">${rsanag.rows[0].nome} ${rsanag.rows[0].cognome}</a></h4>

                        <ul data-role="listview" data-inset="true" data-filter="true">
                            <li data-role="list-divider">Lista esami <a class="ui-li-count" style="font-size: 14px;padding: 0;" href="#type-popup" data-rel="popup" data-role="button" data-icon="plus" data-iconpos="notext">Inserimento nuovo esame</a></li>
                            <c:choose>
                                <c:when test="${rs.rowCount eq 0}">
                                    <li>Nessun esame trovato.</li>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="row" items="${rs.rows}">
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
