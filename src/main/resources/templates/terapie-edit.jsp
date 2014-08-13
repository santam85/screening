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
        select * from terapie where id = ?
        <sql:param value="${param.id}" />
    </sql:query>
    <sql:query var="rsanag" dataSource="jdbc/screening">
        select * from anagrafica where id = ?
        <sql:param value="${rs.rows[0].anagrafica_id}" />
    </sql:query>
    <sql:query var="rspcon" dataSource="jdbc/screening">
        select *, (select count(*) from a2p2t where patologiec_id=id and terapie_id=? ) as selected from patologiec where anagrafica_id = ?
        <sql:param value="${param.id}" />
        <sql:param value="${rs.rows[0].anagrafica_id}" />
    </sql:query>
</c:catch>
<!DOCTYPE html> 
<html> 
    <head> 
        <title>Screening - Modifica terapia</title> 
        <%@include file="WEB-INF/jspf/head.jsp" %>
    </head>
    <body>
        <div data-role="page">
            <c:import url="WEB-INF/jspf/header.jsp">
                <c:param name="key" value="value" />
            </c:import>

            <div data-role="content">

                <form action="terapie-detail.jsp?id=${param.id}" method="post">

                    <h4><strong>Paziente:</strong> <a href="patient-detail.jsp?id=${rsanag.rows[0].id}">${rsanag.rows[0].nome} ${rsanag.rows[0].cognome}</a></h4>

                    <div data-role="fieldcontain">
                        <label for="tipo">Tipo:</label>
                        <select name="tipo" id="tipo" data-mini="true" >
                            <option value="" >Nessuno</option>
                            <option value="Cardio ASA" ${rs.rows[0].tipo eq 'Cardio ASA'?'selected="selected"':''} >Cardio ASA</option>
                            <option value="Aspirina" ${rs.rows[0].tipo eq 'Aspirina'?'selected="selected"':''} >Aspirina</option>
                            <option value="Altri FANS" ${rs.rows[0].tipo eq 'Altri FANS'?'selected="selected"':''}>Altri FANS</option>
                            <option value="Ipoglicemizzanti" ${rs.rows[0].tipo eq 'Ipoglicemizzanti'?'selected="selected"':''}>Ipoglicemizzanti</option>
                            <option value="Statine" ${rs.rows[0].tipo eq 'Statine'?'selected="selected"':''}>Statine</option>
                            <option value="Anti-ipertensivi" ${rs.rows[0].tipo eq 'Anti-ipertensivi'?'selected="selected"':''}>Anti-ipertensivi</option>
                            <option value="Altro" ${rs.rows[0].tipo eq 'Altro'?'selected="selected"':''}>Altro</option>
                        </select>
                    </div>

                    <div data-role="fieldcontain">
                        <label for="descrizione">Descrizione:</label>
                        <textarea name="descrizione" id="descrizione" data-mini="true" required >${rs.rows[0].descrizione}</textarea>
                    </div>

                    <div data-role="fieldcontain" >
                        <label for="inizio">Data inizio terapia</label>
                        <input type="date" name="inizio" id="inizio" value="<fmt:formatDate value="${rs.rows[0].inizio}" pattern="dd/MM/yyyy" />" data-mini="true" data-role="datebox" />
                    </div>

                    <div data-role="fieldcontain" >
                        <label for="fine">Data fine terapia</label>
                        <input type="date" name="fine" id="fine" value="<fmt:formatDate value="${rs.rows[0].fine}" pattern="dd/MM/yyyy" />" data-mini="true" data-role="datebox" />
                    </div>

                    <c:if test="${rspcon.rowCount>0}">
                        <div data-role="fieldcontain">
                            <fieldset data-role="controlgroup" data-mini="true" >
                                <legend>Patologie relative</legend>
                                <c:forEach var="row" items="${rspcon.rows}" varStatus="i">
                                    <label for="patologiac-${i.index}">[${row.id}] ${row.tipo} - ${row.descrizione} (${row.sindrome}/${row.mutazioni})</label>
                                    <input type="checkbox" name="patologiec_id" id="patologiac-${i.index}" value="${row.id}" ${row.selected>0?'checked="true"':''} />
                                </c:forEach>
                            </fieldset>
                        </div>
                    </c:if>

                    <div class="ui-grid-a"  >
                        <div class="ui-block-a">
                            <a data-rel="back" data-role="button" data-icon="delete" data-iconpos="left" data-theme="c">Cancel</a>
                        </div>
                        <div class="ui-block-b">
                            <button type="submit" name="action" value="save" data-icon="check" data-iconpos="right" data-theme="b">Save</button>
                        </div>
                    </div>
                </form>
            </div>

            <%@include file="WEB-INF/jspf/footer.jsp" %>
        </div>

    </body>
</html>