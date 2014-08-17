<%-- 
    Document   : edit
    Created on : Aug 30, 2012, 5:38:09 PM
    Author     : MSANTARE
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>

<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@taglib uri="WEB-INF/tlds/screening.tld" prefix="scr" %>

<%@include file="WEB-INF/jspf/sessionmanager.jsp" %>

<c:catch var="ex">
    <sql:query var="rs" dataSource="jdbc/screening">
        select * from esami join colonscopia on esami.id = colonscopia.esami_id join anagrafica on anagrafica.id = esami.anagrafica_id where esami.id = ?
        <sql:param value="${param.id}" />
    </sql:query>
    <sql:query var="rspol" dataSource="jdbc/screening">
        select * from polipi where polipi.colonscopia_esami_id = ?
        <sql:param value="${param.id}" />
    </sql:query>
    <sql:query var="rscomp" dataSource="jdbc/screening">
        select * from esami where anagrafica_id = ? and  id != ? and id not in (select completamento from esami where anagrafica_id = ? and not completamento is null and id != ?)
        <sql:param value="${rs.rows[0].anagrafica_id}" />
        <sql:param value="${param.id}" />
        <sql:param value="${rs.rows[0].anagrafica_id}" />
        <sql:param value="${param.id}" />
    </sql:query>
</c:catch>
<!DOCTYPE html> 
<html> 
    <head> 
        <title>Screening - Modifica <scr:decodeExamType>csc</scr:decodeExamType></title> 
        <%@include file="WEB-INF/jspf/head.jsp" %>
    </head>
    <body>
        <c:import url="WEB-INF/jspf/header.jsp">
            <c:param name="key" value="value" />
        </c:import>

        <div data-role="content">
            <c:choose>
                <c:when test="${not empty ex}">
                    <div data-role="collapsible" data-collapsed="false" data-icon="alert">
                        <h3>Error:</h3>
                        <p>${ex.localizedMessage}</p>
                    </div> 
                </c:when>
                <c:otherwise>
                    <form action="exam-detail-csc.jsp?id=${rs.rows[0].esami_id}" method="post">

                        <h4><strong>Paziente:</strong> <a href="patient-detail.jsp?id=${rs.rows[0].anagrafica_id}">${rs.rows[0].nome} ${rs.rows[0].cognome}</a></h4>
                        <h5><scr:decodeExamType>${rs.rows[0].tipo}</scr:decodeExamType> in data <fmt:formatDate value="${rs.rows[0].dataesame}" pattern="dd/MM/yyyy" /></h5>

                            <div data-role="fieldcontain">
                                <label for="dataesame">Data esame</label>
                                <input type="date" name="dataesame" id="dataesame" value="<fmt:formatDate value="${rs.rows[0].dataesame}" pattern="dd/MM/yyyy" />" data-mini="true" data-role="datebox" />
                        </div>

                        <div data-role="fieldcontain">
                            <label for="completamento">Completamento diagnostico</label>
                            <select id="completamento" name="completamento" data-mini="true">
                                <option value="">Esame indipendente</option>
                                <c:forEach var="row" items="${rscomp.rows}">
                                    <option value="${row.id}" ${rs.rows[0].completamento eq row.id?'selected="true"':''}>[<fmt:formatNumber value="${row.id}" maxFractionDigits="0" minIntegerDigits="5" groupingUsed="false"/>] <scr:decodeExamType>${row.tipo}</scr:decodeExamType> in data <fmt:formatDate value="${rs.rows[0].dataesame}" pattern="dd/MM/yyyy" /> </option>
                                </c:forEach>
                            </select>
                        </div>

                        <div data-role="fieldcontain">
                            <label for="pulizia">Pulizia</label>
                            <input type="text" name="pulizia" id="pulizia" value="${rs.rows[0].pulizia}" data-mini="true" />
                        </div>

                        <div data-role="fieldcontain">
                            <fieldset data-role="controlgroup" data-mini="true">
                                <legend>Esame portato a termine</legend>

                                <label for="completo">Si/No</label>
                                <input type="checkbox" name="completo" id="completo" ${empty rs.rows[0].completo?'':'checked="true"'}/>

                            </fieldset>
                        </div>

                        <div data-role="fieldcontain">
                            <label for="tipopreparazione">Tipo preparazione</label>
                            <input type="text" name="tipopreparazione" id="tipopreparazione" value="${rs.rows[0].tipopreparazione}" data-mini="true" />
                        </div>

                        <h3>Esami di laboratorio</h3>
                        <div data-role="fieldcontain">
                            <label for="glicemia">Glicemia</label>
                            <input type="text" name="glicemia" id="glicemia" value="${rs.rows[0].glicemia}" data-mini="true" />
                        </div>
                        <div data-role="fieldcontain">
                            <label for="trigliceridi">Trigliceridi</label>
                            <input type="text" name="trigliceridi" id="trigliceridi" value="${rs.rows[0].trigliceridi}" data-mini="true" />
                        </div>
                        <div data-role="fieldcontain">
                            <label for="colesterolo">Colesterolo</label>
                            <input type="text" name="colesterolo" id="colesterolo" value="${rs.rows[0].colesterolo}" data-mini="true" />
                        </div>
                        <div data-role="fieldcontain">
                            <label for="inr">INR</label>
                            <input type="text" name="inr" id="inr" value="${rs.rows[0].inr}" data-mini="true" />
                        </div>

                        <h3>Polipi</h3>
                        <ul data-role="listview" data-inset="true">
                            <li data-role="list-divider">Polipi <span class="ui-li-count"> <fmt:formatNumber value="${rspol.rowCount}" maxFractionDigits="0" /> ${rspol.rowCount>1?"polipi":"polipo"} </span></li>
                            <c:choose>
                                <c:when test="${rspol.rowCount eq 0}">
                                    <li>Nessun polipo.</li>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="row" items="${rspol.rows}">
                                        <li>
                                            <h3>Tipo: <span style="font-weight: normal;">${row.tipo}</span></h3>
                                            <p><strong>Grado di displasia: </strong>${row.displasia}</p>
                                            <p>${row.istologia}</p>

                                            <p class="ui-li-aside">
                                                <strong>Sede: </strong>${row.sede}<br/>
                                                <strong>Dimensioni (mm): </strong>${row.dimensione}<br/>
                                            </p>
                                        </li>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </ul>

                        <h3>Cancro</h3>
                        <div data-role="fieldcontain">
                            <fieldset data-role="controlgroup" data-mini="true">
                                <legend>Cancro</legend>
                                <label for="cancro">Si/No</label>
                                <input type="checkbox" name="cancro" id="cancro" ${rs.rows[0].cancro?'checked="true"':''}/>
                            </fieldset>
                        </div>

                        <div data-role="fieldcontain">
                            <fieldset data-role="controlgroup" data-mini="true">
                                <legend>Sede cancro</legend>
                                <label for="sedecancro_cieco">Cieco</label>
                                <input type="checkbox" name="sedecancro_cieco" id="sedecancro_cieco" ${rs.rows[0].sedecancro_cieco?'checked="true"':''} />
                                <label for="sedecancro_ascendente">Ascendente</label>
                                <input type="checkbox" name="sedecancro_ascendente" id="sedecancro_ascendente" ${rs.rows[0].sedecancro_ascendente?'checked="true"':''} />
                                <label for="sedecancro_discendente">Discendente</label>
                                <input type="checkbox" name="sedecancro_discendente" id="sedecancro_discendente" ${rs.rows[0].sedecancro_discendente?'checked="true"':''} />
                                <label for="sedecancro_flessuraepatica">Flessura Epatica</label>
                                <input type="checkbox" name="sedecancro_flessuraepatica" id="sedecancro_flessuraepatica" ${rs.rows[0].sedecancro_flessuraepatica?'checked="true"':''} />
                                <label for="sedecancro_trasverso">Trasverso</label>
                                <input type="checkbox" name="sedecancro_trasverso" id="sedecancro_trasverso" ${rs.rows[0].sedecancro_trasverso?'checked="true"':''} />
                                <label for="sedecancro_flessurasplenica">Flessura Splenica</label>
                                <input type="checkbox" name="sedecancro_flessurasplenica" id="sedecancro_flessurasplenica" ${rs.rows[0].sedecancro_flessurasplenica?'checked="true"':''} />
                                <label for="sedecancro_sigma">Sigma</label>
                                <input type="checkbox" name="sedecancro_sigma" id="sedecancro_sigma" ${rs.rows[0].sedecancro_sigma?'checked="true"':''} />
                                <label for="sedecancro_retto">Retto</label>
                                <input type="checkbox" name="sedecancro_retto" id="sedecancro_retto" ${rs.rows[0].sedecancro_retto?'checked="true"':''} />
                            </fieldset>
                        </div>

                        <div data-role="fieldcontain">
                            <label for="stadio">Stadio</label>
                            <input type="text" name="stadio" id="stadio" value="${rs.rows[0].stadio}" data-mini="true" />
                        </div>

                        <div data-role="fieldcontain">
                            <label for="tnm">TNM</label>
                            <input type="text" name="tnm" id="tnm" value="${rs.rows[0].tnm}" data-mini="true" />
                        </div>

                        <div data-role="fieldcontain">
                            <label for="nlinfonodipositivi">Numero Linfonodi positivi</label>
                            <input type="text" name="nlinfonodipositivi" id="nlinfonodipositivi" value="${rs.rows[0].nlinfonodipositivi}" data-mini="true" />
                        </div>

                        <div data-role="fieldcontain">
                            <label for="intervento">Intervento Chirurgico</label>
                            <select name="intervento" id="intervento" data-mini="true">
                                <option value="">Nessuno</option>
                                <option value="Emicolectomia DX" ${rs.rows[0].intervento eq 'Emicolectomia DX'?'selected="selected"':''} >Emicolectomia DX</option>
                                <option value="Emicolectomia SX" ${rs.rows[0].intervento eq 'Emicolectomia SX'?'selected="selected"':''}>Emicolectomia SX</option>
                                <option value="Ileo-Retto Anastomosi" ${rs.rows[0].intervento eq 'Ileo-Retto Anastomosi'?'selected="selected"':''}>Ileo-Retto Anastomosi</option>
                                <option value="Colectomia Totale con pouch" ${rs.rows[0].intervento eq 'Colectomia Totale con pouch'?'selected="selected"':''}>Colectomia Totale con pouch</option>
                                <option value="Resezione semplice" ${rs.rows[0].intervento eq 'Resezione semplice'?'selected="selected"':''}>Resezione semplice</option>
                                <option value="Resezione anteriore retto" ${rs.rows[0].intervento eq 'Resezione anteriore retto'?'selected="selected"':''}>Resezione anteriore retto</option>
                            </select>
                        </div>

                        <div data-role="fieldcontain">
                            <label for="ihc">IHC</label>
                            <input type="text" name="ihc" id="ihc" value="${rs.rows[0].ihc}" data-mini="true" />
                        </div>
                        <div data-role="fieldcontain">
                            <label for="mutazioni">Mutazioni</label>
                            <select name="mutazioni" id="mutazioni" data-mini="true">
                                <option value="">Nessuno</option>
                                <option value="MSI" ${rs.rows[0].mutazioni eq 'MSI'?'selected="selected"':''} >MSI</option>
                                <option value="BRAF" ${rs.rows[0].mutazioni eq 'BRAF'?'selected="selected"':''}>BRAF</option>
                                <option value="KRAS 12" ${rs.rows[0].mutazioni eq 'KRAS 12'?'selected="selected"':''}>KRAS 12</option>
                                <option value="KRAS 13" ${rs.rows[0].mutazioni eq 'KRAS 13'?'selected="selected"':''}>KRAS 13</option>
                                <option value="KRAS 61" ${rs.rows[0].mutazioni eq 'KRAS 61'?'selected="selected"':''}>KRAS 61</option>
                            </select>
                        </div>

                        <div data-role="fieldcontain">
                            <label for="chemio">Chemio (Tipo)</label>
                            <input type="text" name="chemio" id="chemio" value="${rs.rows[0].chemio}" data-mini="true" />
                        </div>

                        <div data-role="fieldcontain">
                            <fieldset data-role="controlgroup" data-mini="true">
                                <legend>Radio</legend>
                                <label for="radio">Si/No</label>
                                <input type="checkbox" name="radio" id="radio" ${rs.rows[0].radio?'checked="true"':''}/>
                            </fieldset>
                        </div>

                        <h3>Altri carcinomi</h3>
                        <div data-role="fieldcontain">
                            <label for="othercslider">Altri:</label>
                            <select id="othercslider" class="othercslider" data-role="slider" data-mini="true">
                                <option value="No" ${empty rs.rows[0].altric?'selected="selected"':''}>No</option>
                                <option value="Si" ${not empty rs.rows[0].altric?'selected="selected"':''}>Si</option>
                            </select>
                        </div>

                        <div data-role="fieldcontain" class="othercfieldcontain" ${empty rs.rows[0].altric?'style="display:none;"':''}>
                            <label for="altric">Descrizione:</label>
                            <textarea name="altric" id="altric" data-mini="true">${rs.rows[0].altric}</textarea>
                        </div>

                        <div class="ui-grid-a"  >
                            <div class="ui-block-a">
                                <a data-rel="back" data-role="button" data-icon="delete" data-iconpos="left">Cancel</a>
                            </div>
                            <div class="ui-block-b">
                                <button type="submit" name="action" value="save" data-icon="check" data-iconpos="right">Save</button>
                            </div>
                        </div>
                    </form>
                </c:otherwise>
            </c:choose>
        </div>

        <%@include file="WEB-INF/jspf/footer.jsp" %>

    </body>
</html>
