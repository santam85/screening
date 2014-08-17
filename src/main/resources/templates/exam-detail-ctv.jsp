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
                    update colontcvirtuale set 
                    dimensioni = ?,
                    lesioni = ?,
                    pulizia = ?,
                    sedecancro_ascendente = ?,
                    sedecancro_cieco = ?,
                    sedecancro_flessuraepatica = ?,
                    sedecancro_flessurasplenica = ?,
                    sedecancro_retto = ?,
                    sedecancro_sigma = ?,
                    sedecancro_trasverso = ?,
                    tipolesioni = ? 
                    where esami_id = ?
                    <sql:param value="${param.dimensioni}" />
                    <sql:param value="${not empty param.lesioni}" />
                    <sql:param value="${param.pulizia}" />
                    <sql:param value="${not empty param.sedecancro_ascendente}" />
                    <sql:param value="${not empty param.sedecancro_cieco}" />
                    <sql:param value="${not empty param.sedecancro_flessuraepatica}" />
                    <sql:param value="${not empty param.sedecancro_flessurasplenica}" />
                    <sql:param value="${not empty param.sedecancro_retto}" />
                    <sql:param value="${not empty param.sedecancro_sigma}" />
                    <sql:param value="${not empty param.sedecancro_trasverso}" />
                    <sql:param value="${param.tipolesioni}" />
                    <sql:param value="${param.id}" />
                </sql:update>
                <sql:query var="rs">
                    select * from esami join colontcvirtuale on esami.id = colontcvirtuale.esami_id join anagrafica on anagrafica.id = esami.anagrafica_id where esami.id = ?
                    <sql:param value="${param.id}" />
                </sql:query>
            </sql:transaction>
        </c:when>
        <c:otherwise>
            <sql:query var="rs" dataSource="jdbc/screening">
                select * from esami join colontcvirtuale on esami.id = colontcvirtuale.esami_id join anagrafica on anagrafica.id = esami.anagrafica_id where esami.id = ?
                <sql:param value="${param.id}" />
            </sql:query>
        </c:otherwise>
    </c:choose>
</c:catch>
<!DOCTYPE html> 
<html>
    <head> 
        <title>Screening - <scr:decodeExamType>ctv</scr:decodeExamType></title> 
        <%@include file="WEB-INF/jspf/head.jsp" %>
    </head> 
    <body>
        <div id="detail" data-role="page" data-add-back-btn="true">
            <jsp:include page="WEB-INF/jspf/header.jsp">
                <jsp:param name="key" value="value" />
            </jsp:include>

            <div data-role="content">
                <c:if test="${not empty ex}">
                    <div data-role="collapsible" data-collapsed="false" data-icon="alert">
                        <h3>Error</h3>
                        <p>${ex.localizedMessage}</p>
                    </div>
                </c:if>

                <h4><strong>Paziente:</strong> <a href="patient-detail.jsp?id=${rs.rows[0].anagrafica_id}">${rs.rows[0].nome} ${rs.rows[0].cognome}</a></h4>
                <h5><scr:decodeExamType>${rs.rows[0].tipo}</scr:decodeExamType> in data <fmt:formatDate value="${rs.rows[0].dataesame}" pattern="dd/MM/yyyy" /></h5>

                <ul data-role="listview" data-inset="true">
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
                        <li>
                            <a href="exam-detail-${rsc.rows[0].tipo}.jsp?id=${rs.rows[0].completamento}">Questo esame completa la <scr:decodeExamType>${rsc.rows[0].tipo}</scr:decodeExamType> in data <fmt:formatDate value="${rsc.rows[0].dataesame}" pattern="dd/MM/yyyy" /></a>
                        </li> 
                    </c:if>
                    <sql:query var="rse" dataSource="jdbc/screening">
                        select * from esami where esami.completamento = ?
                        <sql:param value="${param.id}" />
                    </sql:query>
                    <c:if test="${rse.rowCount > 0}">
                        <li>
                            <img class="ui-li-icon ui-icon ui-icon-arrow-r"/>
                            <a href="exam-detail-${rse.rows[0].tipo}.jsp?id=${rse.rows[0].id}">Questo esame è completato dalla <scr:decodeExamType>${rse.rows[0].tipo}</scr:decodeExamType> in data <fmt:formatDate value="${rse.rows[0].dataesame}" pattern="dd/MM/yyyy" /></a>
                        </li> 
                    </c:if>
                </ul>
                <h4>Dati esame</h4>    
                <ul data-role="listview" data-inset="true">
                    <li data-role="list-divider">Generali</li>
                    <li>
                        <h3>Pulizia</h3>
                        <p class="ui-li-aside" style="margin: 0.6em 0; font-size: 16px;">${rs.rows[0].pulizia}</p>
                    </li>

                    <li>
                        <h3>Lesioni</h3>
                        <fieldset data-role="controlgroup" data-mini="true" class="ui-li-aside">
                            <label for="lesioni">Si/No</label>
                            <input type="checkbox" name="lesioni" id="lesioni" ${rs.rows[0].lesioni?'checked="true"':''} disabled/>
                        </fieldset>
                    </li>

                    <li>
                        <h3>Tipo lesioni</h3>
                        <p class="ui-li-aside" style="margin: 0.6em 0; font-size: 16px;">${rs.rows[0].tipolesioni}</p>
                    </li>

                    <li style="overflow:auto;">
                        <h3>Sede lesioni</h3>
                        <fieldset data-role="controlgroup" data-mini="true" class="ui-li-aside">
                            <label for="cieco">Cieco</label>
                            <input type="checkbox" name="cieco" id="cieco" ${rs.rows[0].sedecancro_cieco?'checked="true"':''} disabled/>
                            <label for="ascendente">Ascendente</label>
                            <input type="checkbox" name="ascendente" id="ascendente" ${rs.rows[0].sedecancro_ascendente?'checked="true"':''} disabled/>
                            <label for="flessuraepatica">Flessura Epatica</label>
                            <input type="checkbox" name="flessuraepatica" id="flessuraepatica" ${rs.rows[0].sedecancro_flessuraepatica?'checked="true"':''} disabled/>
                            <label for="trasverso">Trasverso</label>
                            <input type="checkbox" name="trasverso" id="trasverso" ${rs.rows[0].sedecancro_trasverso?'checked="true"':''} disabled/>
                            <label for="flessurasplenica">Flessura Splenica</label>
                            <input type="checkbox" name="flessurasplenica" id="flessurasplenica" ${rs.rows[0].sedecancro_flessurasplenica?'checked="true"':''} disabled/>
                            <label for="sigma">Sigma</label>
                            <input type="checkbox" name="sigma" id="sigma" ${rs.rows[0].sedecancro_sigma?'checked="true"':''} disabled/>
                            <label for="retto">Retto</label>
                            <input type="checkbox" name="retto" id="retto" ${rs.rows[0].sedecancro_retto?'checked="true"':''} disabled/>
                        </fieldset>
                    </li>
                    <li>
                        <h3>Dimensioni(mm)</h3>
                        <p class="ui-li-aside" style="margin: 0.6em 0; font-size: 16px;"><fmt:formatNumber value="${rs.rows[0].dimensioni}" maxFractionDigits="0" /></p>
                    </li>
                </ul>


                <div class="ui-grid-a"  >
                    <div class="ui-block-a">
                        <form action="exam-list.jsp?anagrafica_id=${rs.rows[0].anagrafica_id}" method="post">
                            <input type="hidden" name="id" id="id" value="${param.id}">
                            <button type="submit" name="action" value="delete" data-icon="delete" data-iconpos="left">Delete</button>
                        </form>
                    </div>
                    <div class="ui-block-b">
                        <a href="exam-edit-ctv.jsp?id=${rs.rows[0].esami_id}" data-role="button" data-icon="gear" data-iconpos="right">Edit</a>
                    </div>
                </div>
            </div>

            <%@include file="WEB-INF/jspf/footer.jsp" %>
        </div>
    </body>
</html>
