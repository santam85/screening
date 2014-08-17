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

<c:catch var="ex">
    <sql:query var="rs" dataSource="jdbc/screening">
        select * from esami join sof on esami.id = sof.esami_id join anagrafica on anagrafica.id = esami.anagrafica_id where esami.id = ?
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
        <title>Screening - Modifica <scr:decodeExamType>sof</scr:decodeExamType></title> 
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
                    <form action="exam-detail-sof.jsp?id=${rs.rows[0].esami_id}" method="post">

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
                            <fieldset data-role="controlgroup" data-mini="true">
                                <legend>Positivo</legend>

                                <label for="positivo">Si/No</label>
                                <input type="checkbox" name="positivo" id="positivo" ${empty rs.rows[0].positivo?'':'checked="true"'}/>
                            </fieldset>
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

                    <div id="validate-popup" data-role="popup" data-icon="alert" class="ui-content">
                        Check input data!
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <%@include file="WEB-INF/jspf/footer.jsp" %>

    </body>
</html>
