<%-- 
    Document   : edit
    Created on : Aug 30, 2012, 5:38:09 PM
    Author     : MSANTARE
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <title>Screening - Censimento <scr:decodeExamType>sof</scr:decodeExamType></title> 
        <%@include file="WEB-INF/jspf/head.jsp" %>
    </head>
    <body>
        <div data-role="page">
            <c:import url="WEB-INF/jspf/header.jsp">
                <c:param name="key" value="value" />
            </c:import>

            <div data-role="content">
                <c:if test="${not empty exins}">
                    <div data-role="collapsible" data-collapsed="false" data-theme="e" data-content-theme="d" data-icon="alert">
                        <h3>Error:</h3>
                        <p>${exins}</p>
                    </div>
                </c:if>
                <form action="exam-list.jsp?anagrafica_id=${param.anagrafica_id}" method="post">

                    <h4><strong>Paziente:</strong> <a href="patient-detail.jsp?id=${param.anagrafica_id}">${rs.rows[0].nome} ${rs.rows[0].cognome}</a></h4>

                    <input type="hidden" name="tipo" value="sof"/>

                    <div data-role="fieldcontain" >
                        <label for="dataesame">Data esame</label>
                        <input type="date" name="dataesame" id="dataesame" value="<fmt:formatDate value="${rs.rows[0].dataesame}" pattern="dd/MM/yyyy" />" data-mini="true" data-role="datebox" />
                    </div>

                    <div data-role="fieldcontain" >
                        <label for="completamento">Completamento diagnostico</label>
                        <select id="completamento" name="completamento" data-mini="true">
                            <option value="">Esame indipendente</option>
                            <c:forEach var="row" items="${rscomp.rows}">
                                <option value="${row.id}">[<fmt:formatNumber value="${row.id}" maxFractionDigits="0" minIntegerDigits="5" groupingUsed="false"/>] <scr:decodeExamType>${row.tipo}</scr:decodeExamType> in data <fmt:formatDate value="${row.dataesame}" pattern="dd/MM/yyyy" /> </option>
                            </c:forEach>
                        </select>
                    </div>

                    <div data-role="fieldcontain">
                        <fieldset data-role="controlgroup" data-mini="true">
                            <legend>Positivo</legend>

                            <label for="positivo">Si/No</label>
                            <input type="checkbox" name="positivo" id="positivo" ${empty rs.rows[0].positivo?'':'checked="true"'}/>
                        </fieldset>
                    </div>

                    <div class="ui-grid-a"  >
                        <div class="ui-block-a">
                            <a data-rel="back" data-role="button" data-icon="delete" data-iconpos="left" data-theme="c">Cancel</a>
                        </div>
                        <div class="ui-block-b">
                            <button type="submit" name="action" value="add" data-icon="check" data-iconpos="right" data-theme="b">Save</button>
                        </div>
                    </div>
                </form>
            </div>

            <%@include file="WEB-INF/jspf/footer.jsp" %>

    </body>
</html>
