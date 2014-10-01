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
    <sql:query var="rsanag" dataSource="jdbc/screening">
        select * from anagrafica where id = ?
        <sql:param value="${param.anagrafica_id}" />
    </sql:query>
    <sql:query var="rspcon" dataSource="jdbc/screening">
        select * from patologiec where anagrafica_id = ?
        <sql:param value="${param.anagrafica_id}" />
    </sql:query>
</c:catch>
<!DOCTYPE html> 
<html> 
    <head> 
        <title>Screening - Censimento terapia</title> 
        <%@include file="WEB-INF/jspf/head.jsp" %>
    </head>
    <body>
        <div data-role="page">
            <c:import url="WEB-INF/jspf/header.jsp">
                <c:param name="key" value="value" />
            </c:import>

            <div data-role="content">

                <form action="patient-detail.jsp?id=${param.anagrafica_id}" method="post">

                    <h4><strong>Paziente:</strong> <a href="patient-detail.jsp?id=${param.anagrafica_id}">${rsanag.rows[0].nome} ${rsanag.rows[0].cognome}</a></h4>

                        <c:if test="${not empty param.patologiec_id}">
                        <h5>La terapia verrà collegata alla <a href="patologiec-detail.jsp?id=${param.patologiec_id}">patologia</a> preselezionata.</h5>
                    </c:if>
                       
                    <div class="ui-field-contain">
                        <label for="tipo">Tipo:</label>
                        <select name="tipo" id="tipo" data-mini="true">
                            <option value="">Nessuno</option>
                            <option value="Cardio ASA" ${param.tipo eq 'Cardio ASA'?'selected="selected"':''} >Cardio ASA</option>
                            <option value="Aspirina" ${param.tipo eq 'Aspirina'?'selected="selected"':''} >Aspirina</option>
                            <option value="Altri FANS" ${param.tipo eq 'Altri FANS'?'selected="selected"':''}>Altri FANS</option>
                            <option value="Ipoglicemizzanti" ${param.tipo eq 'Ipoglicemizzanti'?'selected="selected"':''}>Ipoglicemizzanti</option>
                            <option value="Statine" ${param.tipo eq 'Statine'?'selected="selected"':''}>Statine</option>
                            <option value="Anti-ipertensivi" ${param.tipo eq 'Anti-ipertensivi'?'selected="selected"':''}>Anti-ipertensivi</option>
                            <option value="Altro" ${param.tipo eq 'Altro'?'selected="selected"':''}>Altro</option>
                        </select>
                    </div>

                    <div class="ui-field-contain">
                        <label for="descrizione">Descrizione:</label>
                        <textarea name="descrizione" id="descrizione" data-mini="true" required >${param.descrizione}</textarea>
                    </div>

                    <div class="ui-field-contain">
                        <label for="inizio">Data inizio terapia</label>
                        <input type="date" name="inizio" id="inizio" value="<fmt:formatDate value="${param.inizio}" pattern="dd/MM/yyyy" />" data-mini="true" data-role="datebox" />
                    </div>

                    <div class="ui-field-contain">
                        <label for="fine">Data fine terapia</label>
                        <input type="date" name="fine" id="fine" value="<fmt:formatDate value="${param.fine}" pattern="dd/MM/yyyy" />" data-mini="true" data-role="datebox" />
                    </div>

                    <div class="ui-field-contain">
                        <fieldset data-role="controlgroup" data-mini="true">
                            <legend>Patologie relative</legend>
                            <c:forEach var="row" items="${rspcon.rows}" varStatus="i">
                                <label for="patologiac-${i.index}">[${row.id}] ${row.tipo} - ${row.descrizione} (${row.sindrome}/${row.mutazioni})</label>
                                <input type="checkbox" name="patologiec_id" id="patologiac-${i.index}" value="${row.id}" ${row.id eq param.patologiec_id?'checked="true"':''} />
                            </c:forEach>
                        </fieldset>
                    </div>

                    <div class="ui-grid-a"  >
                        <div class="ui-block-a">
                            <a data-rel="back" data-role="button" data-icon="delete" data-iconpos="left">Cancel</a>
                        </div>
                        <div class="ui-block-b">
                            <button type="submit" name="action" value="addterapia" data-icon="check" data-iconpos="right">Save</button>
                        </div>
                    </div>
                </form>
            </div>

            <%@include file="WEB-INF/jspf/footer.jsp" %>
        </div>

    </body>
</html>