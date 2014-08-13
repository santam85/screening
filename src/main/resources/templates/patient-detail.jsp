<%-- 
    Document   : edit
    Created on : Aug 30, 2012, 5:38:09 PM
    Author     : MSANTARE
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ taglib uri="WEB-INF/tlds/screening.tld" prefix="scr" %>

<%@include file="WEB-INF/jspf/sessionmanager.jsp" %>

<c:catch var="ex">
    <c:choose>
        <c:when test="${not empty param.action and param.action.equalsIgnoreCase('add')}">
            <sql:transaction dataSource="jdbc/screening" >
                <fmt:parseDate pattern="dd/MM/yyyy" var="tmp" value="${param.datanascita}" />
                <c:set var="bmi" value="${param.peso/(param.altezza*param.altezza)}" />

                <sql:update>
                    INSERT INTO anagrafica
                    (screening,cartella,nome,cognome,iniziali,sesso,datanascita,luogonascita,nazionenascita,peso,altezza,bmi,fumo,alcohol)
                    VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?)
                    <sql:param value="${param.screening}" />
                    <sql:param value="${param.cartella}" />
                    <sql:param value="${param.nome}" />
                    <sql:param value="${param.cognome}" />
                    <sql:param value="${param.iniziali}" />
                    <sql:param value="${param.sesso}" />
                    <sql:dateParam value="${tmp}" type="DATE" />
                    <sql:param value="${param.luogonascita}" />
                    <sql:param value="${param.nazionenascita}" />
                    <sql:param value="${param.peso}"/>
                    <sql:param value="${param.altezza}"/>
                    <sql:param value="${bmi eq 'NaN' ? null: bmi}"/>
                    <sql:param value="${not empty param.fumo}" />
                    <sql:param value="${not empty param.alcohol}" />
                </sql:update>

                <sql:query var="rsLid">
                    select LAST_INSERT_ID() as lastrowid
                </sql:query>

                <c:set var="patientid" value="${rsLid.rows[0].lastrowid}" />
            </sql:transaction>
        </c:when>
        <c:when test="${not empty param.action and param.action.equalsIgnoreCase('save')}">
            <fmt:parseDate pattern="dd/MM/yyyy" var="tmp" value="${param.datanascita}" />
            <c:set var="bmi" value="${param.peso/(param.altezza*param.altezza)}" />

            <sql:update dataSource="jdbc/screening" >
                update anagrafica set cartella=?,nome=?,cognome=?,iniziali=?,sesso=?,datanascita=?,luogonascita=?,nazionenascita=?,peso=?,altezza=?,bmi=?,fumo=?,alcohol=? where id = ?
                <sql:param value="${param.cartella}" />
                <sql:param value="${param.nome}" />
                <sql:param value="${param.cognome}" />
                <sql:param value="${param.iniziali}" />
                <sql:param value="${param.sesso}" />
                <sql:dateParam value="${tmp}" type="DATE" />
                <sql:param value="${param.luogonascita}" />
                <sql:param value="${param.nazionenascita}" />
                <sql:param value="${param.peso}" />
                <sql:param value="${param.altezza}" />
                <sql:param value="${bmi}" />
                <sql:param value="${not empty param.fumo}" />
                <sql:param value="${not empty param.alcohol}" />
                <sql:param value="${param.id}" />
            </sql:update>
            <c:set var="patientid" value="${param.id}" />
        </c:when>
        <c:when test="${not empty param.action and param.action.equalsIgnoreCase('addpatologiac')}">
            <sql:transaction dataSource="jdbc/screening">
                <sql:update var="result">
                    INSERT INTO patologiec
                    (anagrafica_id,tipo,descrizione,sindrome,mutazioni)
                    VALUES
                    (?,?,?,?,?);
                    <sql:param value="${param.id}" />
                    <sql:param value="${param.tipo}" />
                    <sql:param value="${param.descrizione}" />
                    <sql:param value="${param.sindrome}" />
                    <sql:param value="${param.mutazioni}" />
                </sql:update>

                <sql:query var="rsLid">
                    select LAST_INSERT_ID() as lastrowid
                </sql:query>
                <c:set var="patologiec_id" value="${rsLid.rows[0].lastrowid}" />

                <c:forEach var="id" items="${paramValues.terapie_id}">
                    <sql:update var="result">
                        INSERT INTO a2p2t
                        (patologiec_id,terapie_id)
                        VALUES
                        (?,?);
                        <sql:param value="${patologiec_id}" />
                        <sql:param value="${id}" />
                    </sql:update>
                </c:forEach>
            </sql:transaction>
            <c:set var="patientid" value="${param.id}" />
        </c:when>
        <c:when test="${not empty param.action and param.action.equalsIgnoreCase('deletepatologiac')}">
            <sql:update dataSource="jdbc/screening" var="result">
                DELETE FROM patologiec
                WHERE id = ?
                <sql:param value="${param.patologiec_id}" />
            </sql:update>
            <c:set var="patientid" value="${param.id}" />
        </c:when>
        <c:when test="${not empty param.action and param.action.equalsIgnoreCase('addterapia')}">
            <sql:transaction dataSource="jdbc/screening">
                <sql:update var="result">
                    INSERT INTO terapie
                    (anagrafica_id,tipo,descrizione,inizio,fine,durata)
                    VALUES
                    (?,?,?,?,?,?);
                    <sql:param value="${param.id}" />
                    <sql:param value="${param.tipo}" />
                    <sql:param value="${param.descrizione}" />
                    <fmt:parseDate value="${param.inizio}" pattern="dd/MM/yyyy" var="iniziop" />
                    <sql:dateParam value="${iniziop}" />
                    <fmt:parseDate value="${param.fine}" pattern="dd/MM/yyyy" var="finep" />
                    <sql:dateParam value="${finep}" />
                    <fmt:formatNumber value="${(finep.time-iniziop.time)/(1000*60*60*24)}" maxFractionDigits="0" var="durata"/> 
                    <sql:param value="${durata}" />
                </sql:update>
                <sql:query var="rsLid">
                    select LAST_INSERT_ID() as lastrowid
                </sql:query>
                <c:set var="terapie_id" value="${rsLid.rows[0].lastrowid}" />
                <c:forEach var="id" items="${paramValues.patologiec_id}">
                    <sql:update var="result">
                        INSERT INTO a2p2t
                        (patologiec_id,terapie_id)
                        VALUES
                        (?,?);
                        <sql:param value="${id}" />
                        <sql:param value="${terapie_id}" />
                    </sql:update>
                </c:forEach>
            </sql:transaction>
            <c:set var="patientid" value="${param.id}" />
        </c:when>
        <c:when test="${not empty param.action and param.action.equalsIgnoreCase('deleteterapia')}">
            <sql:update dataSource="jdbc/screening" var="result">
                DELETE FROM terapie
                WHERE id = ?
                <sql:param value="${param.terapie_id}" />
            </sql:update>
            <c:set var="patientid" value="${param.id}" />
        </c:when>
        <c:when test="${not empty param.action and param.action.equalsIgnoreCase('addfamiliare')}">
            <sql:transaction dataSource="jdbc/screening">
                <sql:update var="result">
                    INSERT INTO familiari
                    (anagrafica_id,grado,ccr,pa,altric,desc_altri,sindrome,mutazioni)
                    VALUES
                    (?,?,?,?,?,?,?,?);
                    <sql:param value="${param.id}" />
                    <sql:param value="${param.grado}" />
                    <sql:param value="${not empty param.ccr}" />
                    <sql:param value="${not empty param.pa}" />
                    <sql:param value="${not empty param.altric}" />
                    <sql:param value="${param.desc_altri}" />
                    <sql:param value="${param.sindrome}" />
                    <sql:param value="${param.mutazioni}" />
                </sql:update>
            </sql:transaction>
            <c:set var="patientid" value="${param.id}" />
        </c:when>
        <c:when test="${not empty param.action and param.action.equalsIgnoreCase('deletefamiliare')}">
            <sql:transaction dataSource="jdbc/screening">
                <sql:update var="result">
                    DELETE FROM familiari
                    WHERE id = ?
                    <sql:param value="${param.familiari_id}" />
                </sql:update>
            </sql:transaction>
            <c:set var="patientid" value="${param.id}" />
        </c:when>
        <c:otherwise>
            <c:set var="patientid" value="${param.id}" />
        </c:otherwise>
    </c:choose>
    <sql:query dataSource="jdbc/screening" var="rspn">
        select count(*) as numesami from esami where anagrafica_id=?
        <sql:param value="${patientid}" />
    </sql:query>
    <sql:query dataSource="jdbc/screening" var="rs">
        select * from anagrafica where id = ?
        <sql:param value="${patientid}" />
    </sql:query>
    <sql:query dataSource="jdbc/screening" var="rses">
        select * from esami where anagrafica_id=? order by dataesame desc
        <sql:param value="${patientid}" />
    </sql:query>
    <sql:query dataSource="jdbc/screening" var="rspcon">
        select * from patologiec where anagrafica_id=?
        <sql:param value="${patientid}" />
    </sql:query>
    <sql:query dataSource="jdbc/screening" var="rster">
        select * from terapie where anagrafica_id=?
        <sql:param value="${patientid}" />
    </sql:query>
    <sql:query dataSource="jdbc/screening" var="rsfam">
        select * from familiari where anagrafica_id=?
        <sql:param value="${patientid}" />
    </sql:query>
</c:catch>

<!DOCTYPE html> 
<html> 
    <head> 
        <title>Screening - Paziente</title> 
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

                <div data-role="popup" id="type-popup">
                    <p>
                        Selezionare il tipo di esame:
                        <a href="exam-add-sof.jsp?anagrafica_id=${patientid}" data-role="button" data-theme="a" data-icon="plus">SOF</a>
                        <a href="exam-add-ctv.jsp?anagrafica_id=${patientid}" data-role="button" data-theme="a" data-icon="plus">Colon TC Virtuale</a>
                        <a href="exam-add-csc.jsp?anagrafica_id=${patientid}" data-role="button" data-theme="a" data-icon="plus">Colonscopia</a>
                    <p>
                </div>

                <ul data-role="listview" data-inset="true" data-theme="d">
                    <li>
                        <h3>Numero cartella</h3>
                        <p class="ui-li-aside" style="margin: 0.6em 0; font-size: 16px;">${rs.rows[0].cartella}</p>
                    </li>
                    <li>
                        <h3>Nome</h3>
                        <p class="ui-li-aside" style="margin: 0.6em 0; font-size: 16px;">${rs.rows[0].nome}</p>
                    </li>
                    <li>
                        <h3>Cognome</h3>
                        <p class="ui-li-aside" style="margin: 0.6em 0; font-size: 16px;">${rs.rows[0].cognome}</p>
                    </li>
                    <li>
                        <h3>Iniziali</h3>
                        <p class="ui-li-aside" style="margin: 0.6em 0; font-size: 16px;">${rs.rows[0].iniziali}</p>
                    </li>
                    <li>
                        <h3>Sesso</h3>
                        <p class="ui-li-aside" style="margin: 0.6em 0; font-size: 16px;">${rs.rows[0].sesso}</p>
                    </li>
                    <li>
                        <h3>Data di nascita</h3>
                        <p class="ui-li-aside" style="margin: 0.6em 0; font-size: 16px;"><fmt:formatDate pattern="dd/MM/yyyy" value="${rs.rows[0].datanascita}" /></p>
                    </li>
                    <li>
                        <h3>Luogo di nascita</h3>
                        <p class="ui-li-aside" style="margin: 0.6em 0; font-size: 16px;">${rs.rows[0].luogonascita}</p>
                    </li>
                    <li>
                        <h3>Nazionalit&agrave;</h3>
                        <p class="ui-li-aside" style="margin: 0.6em 0; font-size: 16px;">${rs.rows[0].nazionenascita}</p>
                    </li>				
                </ul>

                <div data-role="collapsible-set" >
                    <div data-role="collapsible" data-content-theme="d">
                        <h3>Antropom</h3>

                        <ul data-role="listview" data-theme="d">
                            <li>
                                <h3>Peso</h3>
                                <p class="ui-li-aside" style="margin: 0.6em 0; font-size: 16px;">${rs.rows[0].peso} <strong>Kg</strong></p>
                            </li>
                            <li>
                                <h3>Altezza (m)</h3>
                                <p class="ui-li-aside" style="margin: 0.6em 0; font-size: 16px;">${rs.rows[0].altezza} <strong>m</strong></p>
                            </li>
                            <li>
                                <h3>BMI</h3>
                                <p class="ui-li-aside" style="margin: 0.6em 0; font-size: 16px;">${rs.rows[0].bmi}</p>
                            </li>
                        </ul>

                    </div>

                    <div data-role="collapsible" data-content-theme="d">
                        <h3>Stile di vita</h3>
                        <ul data-role="listview" data-theme="d">
                            <li>
                                <h3>Fumo</h3>
                                <fieldset data-role="controlgroup" data-mini="true" class="ui-li-aside">
                                    <label for="fumo">Si/No</label>
                                    <input type="checkbox" name="fumo" id="fumo" ${rs.rows[0].fumo?'checked="true"':''} disabled/>
                                </fieldset>
                            </li>
                            <li>
                                <h3>Alcool</h3>
                                <fieldset data-role="controlgroup" data-mini="true" class="ui-li-aside">
                                    <label for="alcohol">Si/No</label>
                                    <input type="checkbox" name="alcohol" id="alcohol" ${rs.rows[0].alcohol?'checked="true"':''} disabled/>
                                </fieldset>
                            </li>
                        </ul>
                    </div>
                </div>

                <div data-role="collapsible-set" data-theme="a">
                    <div data-role="collapsible" data-content-theme="d">
                        <h3>Storia familiare</h3>
                        <ul data-role="listview" data-theme="d">
                            <li data-role="list-divider">Lista familiarità <a class="ui-li-count" style="font-size: 14px;padding: 0;" href="familiare-add.jsp?anagrafica_id=${patientid}" data-role="button" data-theme="a" data-icon="plus" data-iconpos="notext">Inserimento nuovo familiare</a></li>
                            <c:choose>
                                <c:when test="${rsfam.rowCount eq 0}">
                                    <li data-theme="d">Nessuna familiarità trovata.</li>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="row" items="${rsfam.rows}">
                                        <li data-theme="d">
                                            <a href="familiare-detail.jsp?id=${row.id}">
                                                <h3>Grado ${row.grado}</h3>
                                                <p>${row.ccr?"CCR":""}${row.pa?(row.ccr?", PA":"PA"):""}${row.altric?(row.ccr or row.pa?", ".concat(row.desc_altri):row.desc_altri):""}</p>
                                                <p class="ui-li-aside">
                                                    <strong>CCR: </strong>${row.ccr?"Si":"No"}  <br/>
                                                    <strong>PA: </strong>${row.pa?"Si":"No"}  <br/>    
                                                    <strong>Altri: </strong>${row.altric?"Si":"No"}
                                                </p>
                                            </a>
                                        </li>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </ul>
                    </div>
                    <div data-role="collapsible" data-content-theme="d">
                        <h3>Esami</h3>
                        <ul data-role="listview" data-theme="d" data-filter="true">
                            <li data-role="list-divider">Lista esami <a class="ui-li-count" style="font-size: 14px;padding: 0;" href="#type-popup" data-rel="popup" data-role="button" data-theme="a" data-icon="plus" data-iconpos="notext">Inserimento nuovo esame</a></li>
                            <c:choose>
                                <c:when test="${rses.rowCount eq 0}">
                                    <li data-theme="d">Nessun esame trovato.</li>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="row" items="${rses.rows}">
                                        <li data-theme="d">
                                            <a href="exam-detail-${row.tipo}.jsp?id=${row.id}">
                                                <h3><scr:decodeExamType>${row.tipo}</scr:decodeExamType></h3>
                                                <p class="ui-li-aside"><strong>Data: </strong><fmt:formatDate value="${row.dataesame}" pattern="dd/MM/yyyy"/></p>
                                            </a>
                                        </li>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </ul>
                    </div>
                    <div data-role="collapsible" data-content-theme="d">
                        <h3>Patologie concomitanti</h3>
                        <ul data-role="listview" data-theme="d">
                            <li data-role="list-divider">Lista patologie concomitanti<a class="ui-li-count" style="font-size: 14px;padding: 0;" href="patologiec-add.jsp?anagrafica_id=${patientid}" data-role="button" data-theme="a" data-icon="plus" data-iconpos="notext">Inserimento nuova patologia</a></li>
                            <c:choose>
                                <c:when test="${rspcon.rowCount eq 0}">
                                    <li data-theme="d">Nessuna patologia trovata.</li>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="row" items="${rspcon.rows}">
                                        <li data-theme="d">
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
                    </div>
                    <div data-role="collapsible" data-content-theme="d">
                        <h3>Terapie</h3>
                        <ul data-role="listview" data-theme="d">
                            <li data-role="list-divider">Lista terapie<a class="ui-li-count" style="font-size: 14px;padding: 0;" href="terapie-add.jsp?anagrafica_id=${patientid}" data-role="button" data-theme="a" data-icon="plus" data-iconpos="notext">Inserimento nuova terapia</a></li>
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
                    </div>
                </div>

                <ul data-role="listview" data-inset="true" data-theme="a">
                    <li><a href="exam-list.jsp?anagrafica_id=${patientid}">Esami</a> <span class="ui-li-count"><fmt:formatNumber value="${rspn.rows[0].numesami}" maxFractionDigits="0"/> esami</span></li>
                </ul>

                <div class="ui-grid-a"  >
                    <div class="ui-block-a">
                        <form action="index.jsp" method="post">
                            <input type="hidden" name="id" id="id" value="${param.id}">
                            <button type="submit" name="action" value="delete" data-icon="delete" data-iconpos="left" data-theme="e">Delete</button>
                        </form>
                    </div>
                    <div class="ui-block-b">
                        <a href="patient-edit.jsp?id=${rs.rows[0].id}" data-role="button" data-icon="gear" data-iconpos="right" data-theme="b">Edit</a>
                    </div>
                </div>
            </div>

            <%@include file="WEB-INF/jspf/footer.jsp" %>
        </div>
    </body>
</html>
