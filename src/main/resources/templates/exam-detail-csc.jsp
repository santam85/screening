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
            <fmt:parseDate pattern="dd/MM/yyyy" var="tmp" value="${param.dataesame}" />

            <sql:transaction dataSource="jdbc/screening">
                <sql:update>
                    update esami set 
                    dataesame = ?,
                    completamento = ? 
                    where id = ?
                    <sql:dateParam value="${tmp}" type="DATE" />
                    <sql:param value="${param.completamento}" />
                    <sql:param value="${param.id}" />
                </sql:update>

                <sql:update>
                    update colonscopia set 
                    cancro = ?,
                    chemio = ?,
                    colesterolo = ?,
                    completo = ?,
                    pulizia = ?,
                    glicemia = ?,
                    ihc = ?,
                    inr = ?,
                    intervento = ?,
                    mutazioni = ?,
                    nlinfonodipositivi = ?,
                    radio = ?,
                    sedecancro_ascendente = ?,
                    sedecancro_discendente = ?,
                    sedecancro_cieco = ?,
                    sedecancro_flessuraepatica = ?,
                    sedecancro_flessurasplenica = ?,
                    sedecancro_retto = ?,
                    sedecancro_sigma = ?,
                    sedecancro_trasverso = ?,
                    stadio = ?,
                    tipopreparazione = ?,
                    tnm = ?,
                    trigliceridi = ?,
                    altric = ?
                    where esami_id = ?
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
                    <sql:param value="${param.id}" />
                </sql:update>
            </sql:transaction>
            <c:set var="examid" value="${param.id}" />
        </c:when>
        <c:when test="${not empty param.action and param.action.equalsIgnoreCase('addpolipo')}">
            <sql:update dataSource="jdbc/screening">
                INSERT INTO polipi
                (colonscopia_esami_id,dimensione,tipo,sede,displasia,istologia)
                VALUES
                (?,?,?,?,?,?);
                <sql:param value="${param.id}" />
                <sql:param value="${param.dimensione}" />
                <sql:param value="${param.tipo}" />
                <sql:param value="${param.sede}" />
                <sql:param value="${param.displasia}" />
                <sql:param value="${param.istologia}" />
            </sql:update>
            <c:set var="examid" value="${param.id}" />
        </c:when>
        <c:when test="${not empty param.action and param.action.equalsIgnoreCase('savepolipo')}">
            <sql:update dataSource="jdbc/screening">
                UPDATE polipi
                SET dimensione=?,tipo=?,sede=?,displasia=?,istologia=?
                WHERE id=?;
                <sql:param value="${param.dimensione}" />
                <sql:param value="${param.tipo}" />
                <sql:param value="${param.sede}" />
                <sql:param value="${param.displasia}" />
                <sql:param value="${param.istologia}" />
                <sql:param value="${param.polipo_id}" />
            </sql:update>
            <c:set var="examid" value="${param.id}" />
        </c:when>
        <c:when test="${not empty param.action and param.action.equalsIgnoreCase('deletepolipo')}">
            <sql:update dataSource="jdbc/screening">
                DELETE FROM polipi
                WHERE id = ?
                <sql:param value="${param.polipo_id}" />
            </sql:update>
            <c:set var="examid" value="${param.id}" />
        </c:when>
        <c:otherwise>
            <c:set var="examid" value="${param.id}" />
        </c:otherwise>
    </c:choose>
    <sql:query var="rs" dataSource="jdbc/screening">
        select * from esami join colonscopia on esami.id = colonscopia.esami_id join anagrafica on anagrafica.id = esami.anagrafica_id where esami.id = ?
        <sql:param value="${examid}" />
    </sql:query>

    <sql:query var="rspol" dataSource="jdbc/screening">
        select * from polipi where polipi.colonscopia_esami_id = ?
        <sql:param value="${examid}" />
    </sql:query>
</c:catch>

<!DOCTYPE html> 
<html> 
    <head> 
        <title>Screening - <scr:decodeExamType>csc</scr:decodeExamType></title> 
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

                <h4><strong>Paziente:</strong> <a href="patient-detail.jsp?id=${rs.rows[0].anagrafica_id}">${rs.rows[0].nome} ${rs.rows[0].cognome}</a></h4>
                <h5><scr:decodeExamType>${rs.rows[0].tipo}</scr:decodeExamType> in data <fmt:formatDate value="${rs.rows[0].dataesame}" pattern="dd/MM/yyyy" /></h5>

                    <ul data-role="listview" data-inset="true" data-theme="d">
                        <li>
                            <h3>Tipo</h3>
                            <p class="ui-li-aside" style="margin: 0.6em 0; font-size: 16px;"><scr:decodeExamType>${rs.rows[0].tipo}</scr:decodeExamType></p>
                        </li>
                        <li>
                            <h3>Data</h3>
                            <p class="ui-li-aside" style="margin: 0.6em 0; font-size: 16px;"><fmt:formatDate value="${rs.rows[0].dataesame}" pattern="dd/MM/yyyy" /></p>
                    </li>
                    <li>
                        <h3>Completamento diagnostico</h3>
                        <p class="ui-li-aside" style="margin: 0.6em 0; font-size: 16px;">${not empty rs.rows[0].completamento?"Si":"No"}</p>
                    </li>
                    <sql:query var="rsc" dataSource="jdbc/screening">
                        select * from esami where esami.id = ?
                        <sql:param value="${rs.rows[0].completamento}" />
                    </sql:query>
                    <c:if test="${rsc.rowCount > 0}">
                        <li data-theme="a">
                            <a href="exam-detail-${rsc.rows[0].tipo}.jsp?id=${rs.rows[0].completamento}">Questo esame completa la <scr:decodeExamType>${rsc.rows[0].tipo}</scr:decodeExamType> in data <fmt:formatDate value="${rsc.rows[0].dataesame}" pattern="dd/MM/yyyy" /></a>
                            </li> 
                    </c:if>
                    <sql:query var="rse" dataSource="jdbc/screening">
                        select * from esami where esami.completamento = ?
                        <sql:param value="${param.id}" />
                    </sql:query>
                    <c:if test="${rse.rowCount > 0}">
                        <li data-theme="a">
                            <a href="exam-detail-${rse.rows[0].tipo}.jsp?id=${rse.rows[0].id}">Questo esame è completato dalla <scr:decodeExamType>${rse.rows[0].tipo}</scr:decodeExamType> in data <fmt:formatDate value="${rse.rows[0].dataesame}" pattern="dd/MM/yyyy" /></a>
                            </li> 
                    </c:if>
                </ul>
                <h4>Dati esame</h4>    
                <ul data-role="listview" data-inset="true" data-theme="d">
                    <li data-role="list-divider" >Generali</li>
                     <li>
                        <h3>Pulizia</h3>
                        <p class="ui-li-aside" style="margin: 0.6em 0; font-size: 16px;">${rs.rows[0].pulizia}</p>
                    </li>
                    <li>
                        <h3>Esame portato a termine</h3>
                        <fieldset data-role="controlgroup" data-mini="true" class="ui-li-aside">
                            <label for="completo">Si/No</label>
                            <input type="checkbox" name="completo" id="completo" ${rs.rows[0].completo?'checked="true"':''} disabled/>
                        </fieldset>
                    </li>
                    <li>
                        <h3>Tipo preparazione</h3>
                        <p class="ui-li-aside" style="margin: 0.6em 0; font-size: 16px;">${rs.rows[0].tipopreparazione}</p>
                    </li>
                </ul>

                <ul data-role="listview" data-inset="true" data-theme="d">
                    <li data-role="list-divider" >Esami di laboratorio</li>
                    <li>
                        <h3>Glicemia</h3>
                        <p class="ui-li-aside" style="margin: 0.6em 0; font-size: 16px;">${rs.rows[0].glicemia}</p>
                    </li>
                    <li>
                        <h3>Trigliceridi</h3>
                        <p class="ui-li-aside" style="margin: 0.6em 0; font-size: 16px;">${rs.rows[0].trigliceridi}</p>
                    </li>
                    <li>
                        <h3>Colesterolo</h3>
                        <p class="ui-li-aside" style="margin: 0.6em 0; font-size: 16px;">${rs.rows[0].colesterolo}</p>
                    </li>
                    <li>
                        <h3>INR</h3>
                        <p class="ui-li-aside" style="margin: 0.6em 0; font-size: 16px;">${rs.rows[0].inr}</p>
                    </li>
                </ul>


                <ul data-role="listview" data-inset="true" data-theme="d">
                    <li data-role="list-divider">Polipi <a class="ui-li-count" style="font-size: 14px;padding: 0;" href="exam-detail-csc-addpolipo.jsp?esami_id=${param.id}" data-role="button" data-theme="a" data-icon="plus" data-iconpos="notext">Inserimento nuovo polipo</a> <span class="ui-li-count" style="margin-right: 3em;"> <fmt:formatNumber value="${rspol.rowCount}" maxFractionDigits="0" /> polipi </span></li>
                    <c:choose>
                        <c:when test="${rspol.rowCount eq 0}">
                            <li data-theme="d">Nessun polipo.</li>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="row" items="${rspol.rows}">
                                <li data-theme="d">
                                    <h3>Tipo: <span style="font-weight: normal;">${row.tipo}</span></h3>
                                    <p><strong>Grado di displasia: </strong>${row.displasia}</p>
                                    <p>${row.istologia}</p>

                                    <div class="ui-li-aside ui-li-desc ui-grid-a">
                                        <div class="ui-block-a">
                                            <p style="margin-top: 0;">
                                                <strong>Sede: </strong>${row.sede}<br/>
                                                <strong>Dimensioni (mm): </strong>${row.dimensione}<br/>
                                            </p>
                                        </div>

                                        <div class="ui-block-b">
                                            <form action="exam-detail-csc.jsp?id=${param.id}" method="post" style="display: inline;">
                                                <input type="hidden" name="polipo_id" value="${row.id}"/>
                                                <button data-inline="true" data-mini="true" data-theme="e" action="submit" name="action" value="deletepolipo">Elimina</button>
                                            </form>
                                            <form action="exam-detail-csc-editpolipo.jsp?esami_id=${param.id}" method="post" style="display: inline;">
                                                <input type="hidden" name="polipo_id" value="${row.id}"/>
                                                <button data-inline="true" data-mini="true" data-theme="c" action="submit" name="action">Modifica</button>
                                            </form>
                                        </div>
                                    </div>

                                </li>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </ul>

                <ul data-role="listview" data-inset="true" data-theme="d">
                    <li data-role="list-divider" >Cancro</li>
                    <li>
                        <h3>Cancro</h3>
                        <fieldset data-role="controlgroup" data-mini="true" class="ui-li-aside">
                            <label for="cancro">Si/No</label>
                            <input type="checkbox" name="cancro" id="cancro" ${rs.rows[0].cancro?'checked="true"':''} disabled/>
                        </fieldset>
                    </li>

                    <li style="overflow:auto;">
                        <h3>Sede cancro</h3>
                        <fieldset data-role="controlgroup" data-mini="true" class="ui-li-aside" >
                            <label for="sedecancro_cieco">Cieco</label>
                            <input type="checkbox" name="sedecancro_cieco" id="sedecancro_cieco" ${rs.rows[0].sedecancro_cieco?'checked="true"':''} disabled />
                            <label for="sedecancro_ascendente">Ascendente</label>
                            <input type="checkbox" name="sedecancro_ascendente" id="sedecancro_ascendente" ${rs.rows[0].sedecancro_ascendente?'checked="true"':''} disabled />
                            <label for="sedecancro_discendente">Discendente</label>
                            <input type="checkbox" name="sedecancro_discendente" id="sedecancro_discendente" ${rs.rows[0].sedecancro_discendente?'checked="true"':''} disabled/>
                            <label for="sedecancro_flessuraepatica">Flessura Epatica</label>
                            <input type="checkbox" name="sedecancro_flessuraepatica" id="sedecancro_flessuraepatica" ${rs.rows[0].sedecancro_flessuraepatica?'checked="true"':''} disabled />
                            <label for="sedecancro_trasverso">Trasverso</label>
                            <input type="checkbox" name="sedecancro_trasverso" id="sedecancro_trasverso" ${rs.rows[0].sedecancro_trasverso?'checked="true"':''} disabled />
                            <label for="sedecancro_flessurasplenica">Flessura Splenica</label>
                            <input type="checkbox" name="sedecancro_flessurasplenica" id="sedecancro_flessurasplenica" ${rs.rows[0].sedecancro_flessurasplenica?'checked="true"':''} disabled />
                            <label for="sedecancro_sigma">Sigma</label>
                            <input type="checkbox" name="sedecancro_sigma" id="sedecancro_sigma" ${rs.rows[0].sedecancro_sigma?'checked="true"':''} disabled />
                            <label for="sedecancro_retto">Retto</label>
                            <input type="checkbox" name="sedecancro_retto" id="sedecancro_retto" ${rs.rows[0].sedecancro_retto?'checked="true"':''} disabled />
                        </fieldset>
                    </li>
                    <li>
                        <h3>Stadio</h3>
                        <p class="ui-li-aside" style="margin: 0.6em 0; font-size: 16px;">${rs.rows[0].stadio}</p>
                    </li>
                    <li>
                        <h3>TNM</h3>
                        <p class="ui-li-aside" style="margin: 0.6em 0; font-size: 16px;">${rs.rows[0].tnm}</p>
                    </li>
                    <li>
                        <h3>Numero Linfonodi Positivi</h3>
                        <p class="ui-li-aside" style="margin: 0.6em 0; font-size: 16px;">${rs.rows[0].nlinfonodipositivi}</p>
                    </li>
                    <li>
                        <h3>Intervento Chirurgico</h3>
                        <p class="ui-li-aside" style="margin: 0.6em 0; font-size: 16px;">${rs.rows[0].intervento}</p>
                    </li>
                    <li>
                        <h3>IHC</h3>
                        <p class="ui-li-aside" style="margin: 0.6em 0; font-size: 16px;">${rs.rows[0].ihc}</p>
                    </li>
                    <li>
                        <h3>Mutazioni</h3>
                        <p class="ui-li-aside" style="margin: 0.6em 0; font-size: 16px;">${rs.rows[0].mutazioni}</p>
                    </li>

                    <li>
                        <h3>Chemio</h3>
                        <p class="ui-li-aside" style="margin: 0.6em 0; font-size: 16px;">${rs.rows[0].chemio}</p>
                    </li>

                    <li>
                        <h3>Radio</h3>
                        <fieldset data-role="controlgroup" data-mini="true" class="ui-li-aside">
                            <label for="radio">Si/No</label>
                            <input type="checkbox" name="radio" id="radio" ${rs.rows[0].radio?'checked="true"':''} disabled/>
                        </fieldset>
                    </li>
                    
                    <li>
                        <h3>Altri</h3>
                        <p class="ui-li-aside" style="margin: 0.6em 0; font-size: 16px;">${rs.rows[0].altric}</p>
                    </li>
                </ul>


                <div class="ui-grid-a"  >
                    <div class="ui-block-a">
                        <form action="exam-list.jsp?anagrafica_id=${rs.rows[0].anagrafica_id}" method="post">
                            <input type="hidden" name="id" id="id" value="${param.id}">
                            <button type="submit" name="action" value="delete" data-icon="delete" data-iconpos="left" data-theme="e">Delete</button>
                        </form>
                    </div>
                    <div class="ui-block-b">
                        <a href="exam-edit-csc.jsp?id=${rs.rows[0].esami_id}" data-role="button" data-icon="gear" data-iconpos="right" data-theme="b">Edit</a>
                    </div>
                </div>
            </div>

            <%@include file="WEB-INF/jspf/footer.jsp" %>
        </div>
    </body>
</html>