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
    <sql:query var="rs" dataSource="jdbc/screening">
        select * from esami join colonscopia on esami.id = colonscopia.esami_id join anagrafica on anagrafica.id = esami.anagrafica_id where esami.id = ?
        <sql:param value="${param.esami_id}" />
    </sql:query>
</c:catch>

<!DOCTYPE html> 
<html> 
    <head> 
        <title>Screening - Censimento polipo</title> 
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

                <form action="exam-detail-csc.jsp?id=${param.esami_id}" method="post">

                    <h4><strong>Paziente:</strong> <a href="patient-detail.jsp?id=${rs.rows[0].anagrafica_id}">${rs.rows[0].nome} ${rs.rows[0].cognome}</a></h4>
                    <h5><scr:decodeExamType>${rs.rows[0].tipo}</scr:decodeExamType> in data <fmt:formatDate value="${rs.rows[0].dataesame}" pattern="dd/MM/yyyy" /></h5>

                    <div data-role="fieldcontain">
                        <label for="dimensione">Dimensioni (mm)</label>
                        <input type="text" name="dimensione" id="dimensione" data-mini="true" />
                    </div>      

                    <div data-role="fieldcontain">
                        <label for="tipo">Tipo polipo</label>
                        <select name="tipo" id="tipo" data-mini="true">
                            <option value="">Nessuno</option>
                            <option value="Flat">Flat</option>
                            <option value="Sessile">Sessile</option>
                            <option value="Peduncolato">Peduncolato</option>
                        </select>
                    </div>

                    <div data-role="fieldcontain">
                        <label for="sede">Sede polipo</label>
                        <select name="sede" id="sede" data-mini="true">
                            <option value="">Nessuno</option>
                            <option value="Cieco">Cieco</option>
                            <option value="Ascendente">Ascendente</option> 
                            <option value="Ascendente">Discendente</option>  
                            <option value="Flessuraepatica">Flessura Epatica</option>
                            <option value="Trasverso">Trasverso</option>
                            <option value="Flessurasplenica">Flessura Splenica</option>
                            <option value="Sigma">Sigma</option>
                            <option value="Retto">Retto</option>
                        </select>
                    </div>
                    
                    <div data-role="fieldcontain">
                        <label for="istologia">Istologia</label>
                        <textarea name="istologia" id="istologia" data-mini="true"></textarea>
                    </div>    
                    
                    <div data-role="fieldcontain">
                        <label for="displasia">Grado di displasia</label>
                        <input type="text" name="displasia" id="displasia" data-mini="true" />
                    </div>    


                    <div class="ui-grid-a"  >
                        <div class="ui-block-a">
                            <a data-rel="back" data-role="button" data-icon="delete" data-iconpos="left">Cancel</a>
                        </div>
                        <div class="ui-block-b">
                            <button type="submit" name="action" value="addpolipo" data-icon="check" data-iconpos="right">Save</button>
                        </div>
                    </div>
                </form>
            </div>

            <%@include file="WEB-INF/jspf/footer.jsp" %>
        </div>
    </body>
</html>
