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
                    update esami set dataesame=?, completamento=? where id = ?
                    <sql:dateParam value="${tmp}" type="DATE" />
                    <sql:param value="${param.completamento}" />
                    <sql:param value="${param.id}" />
                </sql:update>

                <sql:update>
                    update sof set positivo=? where esami_id = ?
                    <sql:param value="${not empty param.positivo}" />
                    <sql:param value="${param.id}" />
                </sql:update>

                <sql:query var="rs">
                    select * from esami join sof on esami.id = sof.esami_id join anagrafica on anagrafica.id = esami.anagrafica_id where esami.id = ?
                    <sql:param value="${param.id}" />
                </sql:query>
            </sql:transaction>
        </c:when>
        <c:otherwise>
            <sql:query var="rs" dataSource="jdbc/screening">
                select * from esami join sof on esami.id = sof.esami_id join anagrafica on anagrafica.id = esami.anagrafica_id where esami.id = ?
                <sql:param value="${param.id}" />
            </sql:query>
        </c:otherwise>
    </c:choose>
</c:catch>
<!DOCTYPE html> 
<html> 
    <head> 
        <title>Screening - <scr:decodeExamType>sof</scr:decodeExamType></title> 
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
                        <h3>Positivo</h3>
                        <p class="ui-li-aside" style="margin: 0.6em 0; font-size: 16px;">${rs.rows[0].positivo?"Si":"No"}</p>
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
                        <a href="exam-edit-sof.jsp?id=${rs.rows[0].esami_id}" data-role="button" data-icon="gear" data-iconpos="right" data-theme="b">Edit</a>
                    </div>
                </div>
            </div>

            <%@include file="WEB-INF/jspf/footer.jsp" %>
        </div>
    </body>
</html>
