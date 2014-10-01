<%-- 
    Document   : edit
    Created on : Aug 30, 2012, 5:38:09 PM
    Author     : MSANTARE
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<%@taglib uri="WEB-INF/tlds/jqm.tld" prefix="jqm" %>

<%@include file="WEB-INF/jspf/sessionmanager.jsp" %>

<c:catch>
    <sql:query var="rs" dataSource="jdbc/screening">
        select * from patologiec where id = ?
        <sql:param value="${param.id}" />
    </sql:query>
    <sql:query var="rsanag" dataSource="jdbc/screening">
        select * from anagrafica where id = ?
        <sql:param value="${rs.rows[0].anagrafica_id}" />
    </sql:query>
    <sql:query var="rspter" dataSource="jdbc/screening">
        select *, (select count(*) from a2p2t where terapie_id=id and patologiec_id=? ) as selected from terapie where anagrafica_id = ?
        <sql:param value="${param.id}" />
        <sql:param value="${rs.rows[0].anagrafica_id}" />
    </sql:query>
</c:catch>

<!DOCTYPE html> 
<html> 
    <head> 
        <title>Screening - Modifica patologia</title> 
        <%@include file="WEB-INF/jspf/head.jsp" %>
    </head>
    <body>
        <div data-role="page">
            <c:import url="WEB-INF/jspf/header.jsp">
                <c:param name="key" value="value" />
            </c:import>

            <div data-role="content">

                <form action="patologiec-detail.jsp?id=${param.id}" method="post">

                    <h4><strong>Paziente:</strong> <a href="patient-detail.jsp?id=${param.anagrafica_id}">${rsanag.rows[0].nome} ${rsanag.rows[0].cognome}</a></h4>

                    <div class="ui-field-contain">
                        <label for="tipo">Tipo:</label>
                        <select name="tipo" id="tipo" data-mini="true">
                            <option value="">Nessuno</option>
                            <option value="Ipertensione" ${rs.rows[0].tipo eq 'Ipertensione'?'selected="selected"':''} >Ipertensione</option>
                            <option value="Dislipidemia" ${rs.rows[0].tipo eq 'Dislipidemia'?'selected="selected"':''}>Dislipidemia</option>
                            <option value="Diabete" ${rs.rows[0].tipo eq 'Diabete'?'selected="selected"':''}>Diabete</option>
                            <option value="Patologie autoimmuni" ${rs.rows[0].tipo eq 'Patologie autoimmuni'?'selected="selected"':''}>Patologie autoimmuni</option>
                            <option value="Altre patologie neoplastiche" ${rs.rows[0].tipo eq 'Altre patologie neoplastiche'?'selected="selected"':''}>Altre patologie neoplastiche</option>
                            <option value="Altro" ${rs.rows[0].tipo eq 'Altro'?'selected="selected"':''}>Altro</option>
                        </select>
                    </div>

                    <div class="ui-field-contain">
                        <label for="descrizione">Descrizione:</label>
                        <textarea name="descrizione" id="descrizione" data-mini="true" required >${rs.rows[0].descrizione}</textarea>
                    </div>

                    <div class="ui-field-contain">
                        <label for="sindrome">Sindrome:</label>
                        <select name="sindrome" id="sindrome" data-mini="true">
                            <option value="">Nessuno</option>
                            <option value="FAP" ${rs.rows[0].sindrome eq 'FAP'?'selected="selected"':''} >FAP</option>
                            <option value="AFAP" ${rs.rows[0].sindrome eq 'AFAP'?'selected="selected"':''}>AFAP</option>
                            <option value="LYNCH" ${rs.rows[0].sindrome eq 'LYNCH'?'selected="selected"':''}>LYNCH</option>
                            <option value="MUTYH" ${rs.rows[0].sindrome eq 'MUTYH'?'selected="selected"':''}>MUTYH</option>
                            <option value="PJ" ${rs.rows[0].sindrome eq 'PJ'?'selected="selected"':''}>PJ</option>
                            <option value="JPS" ${rs.rows[0].sindrome eq 'JPS'?'selected="selected"':''}>JPS</option>
                        </select>
                    </div>

                    <div class="ui-field-contain">
                        <label for="mutazioni">Mutazioni:</label>
                        <input type="text" name="mutazioni" id="mutazioni" value="${rs.rows[0].mutazioni}" data-mini="true" />
                    </div>

                    <c:if test="${rspter.rowCount>0}">
                        <div class="ui-field-contain">
                            <fieldset data-role="controlgroup" data-mini="true">
                                <legend>Terapie relative</legend>
                                <c:forEach var="row" items="${rspter.rows}" varStatus="i">
                                    <label for="terapia-${i.index}">[${row.id}] ${row.tipo} - ${row.descrizione} (<fmt:formatDate value="${row.inizio}" pattern="dd/MM/yyyy" />-<fmt:formatDate value="${row.fine}" pattern="dd/MM/yyyy" />)</label>
                                    <input type="checkbox" name="terapie_id" id="terapia-${i.index}" value="${row.id}" ${row.selected>0?'checked="true"':''} />
                                </c:forEach>
                            </fieldset>
                        </div>
                    </c:if>

                    <div class="ui-grid-a"  >
                        <div class="ui-block-a">
                            <a data-rel="back" data-role="button" data-icon="delete" data-iconpos="left">Cancel</a>
                        </div>
                        <div class="ui-block-b">
                            <button type="submit" name="action" value="save" data-icon="check" data-iconpos="right">Save</button>
                        </div>
                    </div>
                </form>
            </div>

            <%@include file="WEB-INF/jspf/footer.jsp" %>
        </div>

    </body>
</html>