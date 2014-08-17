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
        select * from anagrafica where id = ?
        <sql:param value="${param.anagrafica_id}" />
    </sql:query>
    <sql:query var="rscomp" dataSource="jdbc/screening">
        select * from esami where anagrafica_id = ? and id not in (select completamento from esami where anagrafica_id = ? and not completamento is null)
        <sql:param value="${param.anagrafica_id}" />
        <sql:param value="${param.anagrafica_id}" />
    </sql:query>
</c:catch>
<!DOCTYPE html> 
<html> 
    <head> 
        <title>Screening - Censimento <scr:decodeExamType>csc</scr:decodeExamType></title> 
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
                    <form action="exam-list.jsp?anagrafica_id=${param.anagrafica_id}" method="post">

                        <h4><strong>Paziente:</strong> <a href="patient-detail.jsp?id=${param.anagrafica_id}">${rs.rows[0].nome} ${rs.rows[0].cognome}</a></h4>

                        <input type="hidden" name="tipo" value="csc"/>

                        <div data-role="fieldcontain">
                            <label for="dataesame">Data esame</label>
                            <input type="date" name="dataesame" id="dataesame" value="<fmt:formatDate value="${param.dataesame}" pattern="dd/MM/yyyy" />" data-mini="true" data-role="datebox" />
                        </div>

                        <div data-role="fieldcontain">
                            <label for="completamento">Completamento diagnostico</label>
                            <select id="completamento" name="completamento" data-mini="true">
                                <option value="">Esame indipendente</option>
                                <c:forEach var="row" items="${rscomp.rows}">
                                    <option value="${row.id}">[<fmt:formatNumber value="${row.id}" maxFractionDigits="0" minIntegerDigits="5" groupingUsed="false"/>] <scr:decodeExamType>${row.tipo}</scr:decodeExamType> in data <fmt:formatDate value="${row.dataesame}" pattern="dd/MM/yyyy" /> </option>
                                </c:forEach>
                            </select>
                        </div>

                        <div data-role="fieldcontain">
                            <label for="pulizia">Pulizia</label>
                            <input type="text" name="pulizia" id="pulizia" value="${param.pulizia}" data-mini="true" />
                        </div>

                        <div data-role="fieldcontain">
                            <fieldset data-role="controlgroup" data-mini="true">
                                <legend>Esame portato a termine</legend>

                                <label for="completo">Si/No</label>
                                <input type="checkbox" name="completo" id="completo" ${empty param.completo?'':'checked="true"'}/>

                            </fieldset>
                        </div>

                        <div data-role="fieldcontain">
                            <label for="tipopreparazione">Tipo preparazione</label>
                            <input type="text" name="tipopreparazione" id="tipopreparazione" value="${param.tipopreparazione}" data-mini="true" />
                        </div>

                        <h3>Esami di laboratorio</h3>
                        <div data-role="fieldcontain">
                            <label for="glicemia">Glicemia</label>
                            <input type="text" name="glicemia" id="glicemia" value="${param.glicemia}" data-mini="true" />
                        </div>
                        <div data-role="fieldcontain">
                            <label for="trigliceridi">Trigliceridi</label>
                            <input type="text" name="trigliceridi" id="trigliceridi" value="${param.trigliceridi}" data-mini="true" />
                        </div>
                        <div data-role="fieldcontain">
                            <label for="colesterolo">Colesterolo</label>
                            <input type="text" name="colesterolo" id="colesterolo" value="${param.colesterolo}" data-mini="true" />
                        </div>
                        <div data-role="fieldcontain">
                            <label for="inr">INR</label>
                            <input type="text" name="inr" id="inr" value="${param.inr}" data-mini="true" />
                        </div>

                        <h3>Polipi</h3>
                        <p>Per inserire nuovi polipi relativi all'esame corrente, consultare la pagina di dettaglio dopo il salvataggio.</p>

                        <h3>Cancro</h3>
                        <div data-role="fieldcontain">
                            <fieldset data-role="controlgroup" data-mini="true">
                                <legend>Cancro</legend>
                                <label for="cancro">Si/No</label>
                                <input type="checkbox" name="cancro" id="cancro" ${empty param.cancro?'':'checked="true"'}/>
                            </fieldset>
                        </div>

                        <div data-role="fieldcontain">
                            <fieldset data-role="controlgroup" data-mini="true">
                                <legend>Sede cancro</legend>
                                <label for="sedecancro_cieco">Cieco</label>
                                <input type="checkbox" name="sedecancro_cieco" id="sedecancro_cieco" ${param.sedecancro_cieco?'checked="true"':''} />
                                <label for="sedecancro_ascendente">Ascendente</label>
                                <input type="checkbox" name="sedecancro_ascendente" id="sedecancro_ascendente" ${param.sedecancro_ascendente?'checked="true"':''} />
                                <label for="sedecancro_discendente">Discendente</label>
                                <input type="checkbox" name="sedecancro_discendente" id="sedecancro_discendente" ${param.sedecancro_discendente?'checked="true"':''} />
                                <label for="sedecancro_flessuraepatica">Flessura Epatica</label>
                                <input type="checkbox" name="sedecancro_flessuraepatica" id="sedecancro_flessuraepatica" ${param.sedecancro_flessuraepatica?'checked="true"':''} />
                                <label for="sedecancro_trasverso">Trasverso</label>
                                <input type="checkbox" name="sedecancro_trasverso" id="sedecancro_trasverso" ${param.sedecancro_trasverso?'checked="true"':''} />
                                <label for="sedecancro_flessurasplenica">Flessura Splenica</label>
                                <input type="checkbox" name="sedecancro_flessurasplenica" id="sedecancro_flessurasplenica" ${param.sedecancro_flessurasplenica?'checked="true"':''} />
                                <label for="sedecancro_sigma">Sigma</label>
                                <input type="checkbox" name="sedecancro_sigma" id="sedecancro_sigma" ${param.sedecancro_sigma?'checked="true"':''} />
                                <label for="sedecancro_retto">Retto</label>
                                <input type="checkbox" name="sedecancro_retto" id="sedecancro_retto" ${param.sedecancro_retto?'checked="true"':''} />
                            </fieldset>
                        </div>

                        <div data-role="fieldcontain">
                            <label for="stadio">Stadio</label>
                            <input type="text" name="stadio" id="stadio" value="${param.stadio}" data-mini="true" />
                        </div>

                        <div data-role="fieldcontain">
                            <label for="tnm">TNM</label>
                            <input type="text" name="tnm" id="tnm" value="${param.tnm}" data-mini="true" />
                        </div>

                        <div data-role="fieldcontain">
                            <label for="nlinfonodipositivi">Numero Linfonodi positivi</label>
                            <input type="text" name="nlinfonodipositivi" id="nlinfonodipositivi" value="${param.nlinfonodipositivi}" data-mini="true" />
                        </div>

                        <div data-role="fieldcontain">
                            <label for="intervento">Intervento Chirurgico</label>
                            <select name="intervento" id="intervento" data-mini="true">
                                <option value="">Nessuno</option>
                                <option value="Emicolectomia DX" ${param.intervento eq 'Emicolectomia DX'?'selected="selected"':''} >Emicolectomia DX</option>
                                <option value="Emicolectomia SX" ${param.intervento eq 'Emicolectomia SX'?'selected="selected"':''}>Emicolectomia SX</option>
                                <option value="Ileo-Retto Anastomosi" ${param.intervento eq 'Ileo-Retto Anastomosi'?'selected="selected"':''}>Ileo-Retto Anastomosi</option>
                                <option value="Colectomia Totale con pouch" ${param.intervento eq 'Colectomia Totale con pouch'?'selected="selected"':''}>Colectomia Totale con pouch</option>
                                <option value="Resezione semplice" ${param.intervento eq 'Resezione semplice'?'selected="selected"':''}>Resezione semplice</option>
                                <option value="Resezione anteriore retto" ${param.intervento eq 'Resezione anteriore retto'?'selected="selected"':''}>Resezione anteriore retto</option>
                            </select>
                        </div>

                        <div data-role="fieldcontain">
                            <label for="ihc">IHC</label>
                            <input type="text" name="ihc" id="ihc" value="${param.ihc}" data-mini="true" />
                        </div>
                        <div data-role="fieldcontain">
                            <label for="mutazioni">Mutazioni</label>
                            <select name="mutazioni" id="mutazioni" data-mini="true">
                                <option value="">Nessuno</option>
                                <option value="MSI" ${param.mutazioni eq 'MSI'?'selected="selected"':''} >MSI</option>
                                <option value="BRAF" ${param.mutazioni eq 'BRAF'?'selected="selected"':''}>BRAF</option>
                                <option value="KRAS 12" ${param.mutazioni eq 'KRAS 12'?'selected="selected"':''}>KRAS 12</option>
                                <option value="KRAS 13" ${param.mutazioni eq 'KRAS 13'?'selected="selected"':''}>KRAS 13</option>
                                <option value="KRAS 61" ${param.mutazioni eq 'KRAS 61'?'selected="selected"':''}>KRAS 61</option>
                            </select>
                        </div>

                        <div data-role="fieldcontain">
                            <label for="chemio">Chemio (Tipo)</label>
                            <input type="text" name="chemio" id="chemio" value="${param.chemio}" data-mini="true" />
                        </div>

                        <div data-role="fieldcontain">
                            <fieldset data-role="controlgroup" data-mini="true">
                                <legend>Radio</legend>
                                <label for="radio">Si/No</label>
                                <input type="checkbox" name="radio" id="radio" ${empty param.radio?'':'checked="true"'}/>
                            </fieldset>
                        </div>
                            
                        <h3>Altri carcinomi</h3>
                        <div data-role="fieldcontain">
                            <label for="othercslider">Altri:</label>
                            <select id="othercslider" class="othercslider" data-role="slider" data-mini="true">
                                <option value="No">No</option>
                                <option value="Si" selected="true">Si</option>
                            </select>
                        </div>
                        
                        <div data-role="fieldcontain" class="othercfieldcontain">
                            <label for="altric">Descrizione:</label>
                            <textarea name="altric" id="altric" data-mini="true"></textarea>
                        </div>

                        <div class="ui-grid-a"  >
                            <div class="ui-block-a">
                                <a data-rel="back" data-role="button" data-icon="delete" data-iconpos="left">Cancel</a>
                            </div>
                            <div class="ui-block-b">
                                <button type="submit" name="action" value="add" data-icon="check" data-iconpos="right">Save</button>
                            </div>
                        </div>
                    </form>
                </c:otherwise>
            </c:choose>
        </div>

        <%@include file="WEB-INF/jspf/footer.jsp" %>

    </body>
</html>
