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
            <sql:transaction dataSource="jdbc/screening">
                <sql:update var="result">
                    UPDATE familiari
                    SET grado=?,ccr=?,pa=?,altric=?,desc_altri=?,sindrome=?,mutazioni=? where id=?
                    <sql:param value="${param.grado}" />
                    <sql:param value="${not empty param.ccr}" />
                    <sql:param value="${not empty param.pa}" />
                    <sql:param value="${not empty param.altric}" />
                    <sql:param value="${param.desc_altri}" />
                    <sql:param value="${param.sindrome}" />
                    <sql:param value="${param.mutazioni}" />
                    <sql:param value="${param.id}" />
                </sql:update>
            </sql:transaction>
        </c:when>
    </c:choose>
    <sql:query var="rs" dataSource="jdbc/screening">
        select * from familiari join anagrafica on familiari.anagrafica_id = anagrafica.id where familiari.id = ?
        <sql:param value="${param.id}" />
    </sql:query>
</c:catch>

<!DOCTYPE html> 
<html> 
    <head> 
        <title>Screening - Familiare</title> 
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

                <ul data-role="listview" data-inset="true" data-theme="d">
                    <li>
                        <h3>Grado</h3>
                        <p class="ui-li-aside" style="margin: 0.6em 0; font-size: 16px;">${rs.rows[0].grado}</p>
                    </li>

                    <li>
                        <h3>Familiarità per CCR</h3>
                        <fieldset data-role="controlgroup" data-mini="true" class="ui-li-aside">
                            <label for="ccr">Si/No</label>
                            <input type="checkbox" name="ccr" id="ccr" ${rs.rows[0].ccr?'checked="true"':''} disabled/>
                        </fieldset>
                    </li>
                    <li>
                        <h3>Familiarità per Polipi Adenomatosi</h3>
                        <fieldset data-role="controlgroup" data-mini="true" class="ui-li-aside">
                            <label for="pa">Si/No</label>
                            <input type="checkbox" name="pa" id="pa" ${rs.rows[0].pa?'checked="true"':''} disabled/>
                        </fieldset>
                    </li>
                    <li>
                        <h3>Familiarità per altre tipologie</h3>
                        <fieldset data-role="controlgroup" data-mini="true" class="ui-li-aside">
                            <label for="altric">Si/No</label>
                            <input type="checkbox" name="altric" id="altric" ${rs.rows[0].altric?'checked="true"':''} disabled/>
                        </fieldset>
                    </li>


                    <li>
                        <h3>Tipologie</h3>
                        <p class="ui-li-aside" style="margin: 0.6em 0; font-size: 16px;">${rs.rows[0].desc_altri}</p>
                    </li>

                    <li>
                        <h3>Sindrome</h3>
                        <p class="ui-li-aside" style="margin: 0.6em 0; font-size: 16px;">${rs.rows[0].sindrome}</p>
                    </li>
                    <li>
                        <h3>Mutazioni</h3>
                        <p class="ui-li-aside" style="margin: 0.6em 0; font-size: 16px;">${rs.rows[0].mutazioni}</p>
                    </li>
                </ul>

                <div class="ui-grid-a"  >
                    <div class="ui-block-a">
                        <form action="patient-detail.jsp?id=${rs.rows[0].anagrafica_id}" method="post">
                            <input type="hidden" name="familiari_id" value="${param.id}">
                            <button type="submit" name="action" value="deletefamiliare" data-icon="delete" data-iconpos="left" data-theme="e">Delete</button>
                        </form>
                    </div>
                    <div class="ui-block-b">
                        <a href="familiare-edit.jsp?id=${param.id}" data-role="button" data-icon="gear" data-iconpos="right" data-theme="b">Edit</a>
                    </div>
                </div>
            </div>

            <%@include file="WEB-INF/jspf/footer.jsp" %>
        </div>
    </body>
</html>