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
        select * from esami join colontcvirtuale on esami.id = colontcvirtuale.esami_id join anagrafica on anagrafica.id = esami.anagrafica_id where esami.id = ?
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
        <title>Screening - Modifica <scr:decodeExamType>ctv</scr:decodeExamType></title> 
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
                    <form action="exam-detail-ctv.jsp?id=${rs.rows[0].esami_id}" method="post">

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
                            <select name="pulizia" id="pulizia" data-mini="true">
                                <option value="Nessun residuo" ${rs.rows[0].pulizia eq 'Nessun residuo'?'selected="selected"':''} >Nessun residuo</option>
                                <option value="Residui fluidi" ${rs.rows[0].pulizia eq 'Residui fluidi'?'selected="selected"':''}>Residui fluidi</option>
                                <option value="Residui solidi" ${rs.rows[0].pulizia eq 'Residui solidi'?'selected="selected"':''}>Residui solidi</option>
                            </select>
                        </div>

                        <div data-role="fieldcontain">
                            <fieldset data-role="controlgroup" data-mini="true">
                                <legend>Lesioni</legend>
                                <label for="lesioni">Si/No</label>
                                <input type="checkbox" name="lesioni" id="lesioni" ${empty rs.rows[0].lesioni?'':'checked="true"'}/>
                            </fieldset>
                        </div>

                        <div data-role="fieldcontain">
                            <label for="tipolesioni">Tipo lesioni</label>
                            <select name="tipolesioni" id="tipolesioni" data-mini="true">
                                <option value="">Nessuno</option>
                                <option value="Flat" ${rs.rows[0].tipolesioni eq 'Flat'?'selected="selected"':''} >Flat</option>
                                <option value="Sessile" ${rs.rows[0].tipolesioni eq 'Sessile'?'selected="selected"':''}>Sessile</option>
                                <option value="Peduncolato" ${rs.rows[0].tipolesioni eq 'Peduncolato'?'selected="selected"':''}>Peduncolato</option>
                            </select>
                        </div>

                        <div data-role="fieldcontain">
                            <fieldset data-role="controlgroup" data-mini="true">
                                <legend>Sede cancro</legend>
                                <label for="sedecancro_cieco">Cieco</label>
                                <input type="checkbox" name="sedecancro_cieco" id="sedecancro_cieco" ${rs.rows[0].sedecancro_cieco?'checked="true"':''} />
                                <label for="sedecancro_ascendente">Ascendente</label>
                                <input type="checkbox" name="sedecancro_ascendente" id="sedecancro_ascendente" ${rs.rows[0].sedecancro_ascendente?'checked="true"':''} />
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
                            <label for="dimensioni">Dimensioni (mm)</label>
                            <input type="text" name="dimensioni" id="dimensioni" value="<fmt:formatNumber value="${rs.rows[0].dimensioni}" maxFractionDigits="0" />" data-mini="true" />
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
