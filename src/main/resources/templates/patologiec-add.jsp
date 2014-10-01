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
</c:catch>

<!DOCTYPE html> 
<html> 
    <head> 
        <title>Screening - Censimento patologia</title> 
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
                    <c:if test="${not empty param.terapie_id}">
                        <h5>La patologia verrà collegata a una <a href="terapie-detail.jsp?id=${param.terapie_id}">terapia</a> esistente.</h5>
                    </c:if>

                    <div class="ui-field-contain">
                        <label for="tipo">Tipo:</label>
                        <select name="tipo" id="tipo" data-mini="true">
                            <option value="">Nessuno</option>
                            <option value="Ipertensione" ${param.tipo eq 'Ipertensione'?'selected="selected"':''} >Ipertensione</option>
                            <option value="Dislipidemia" ${param.tipo eq 'Dislipidemia'?'selected="selected"':''}>Dislipidemia</option>
                            <option value="Diabete" ${param.tipo eq 'Diabete'?'selected="selected"':''}>Diabete</option>
                            <option value="Patologie autoimmuni" ${param.tipo eq 'Patologie autoimmuni'?'selected="selected"':''}>Patologie autoimmuni</option>
                            <option value="Altre patologie neoplastiche" ${param.tipo eq 'Altre patologie neoplastiche'?'selected="selected"':''}>Altre patologie neoplastiche</option>
                            <option value="Altro" ${param.tipo eq 'Altro'?'selected="selected"':''}>Altro</option>
                        </select>
                    </div>

                    <div class="ui-field-contain">
                        <label for="descrizione">Descrizione:</label>
                        <textarea name="descrizione" id="descrizione" data-mini="true" required >${param.descrizione}</textarea>
                    </div>

                    <div class="ui-field-contain">
                        <label for="sindrome">Sindrome:</label>
                        <select name="sindrome" id="sindrome" data-mini="true">
                            <option value="">Nessuno</option>
                            <option value="FAP" ${param.tipo eq 'FAP'?'selected="selected"':''} >FAP</option>
                            <option value="AFAP" ${param.tipo eq 'AFAP'?'selected="selected"':''}>AFAP</option>
                            <option value="LYNCH" ${param.tipo eq 'LYNCH'?'selected="selected"':''}>LYNCH</option>
                            <option value="MUTYH" ${param.tipo eq 'MUTYH'?'selected="selected"':''}>MUTYH</option>
                            <option value="PJ" ${param.tipo eq 'PJ'?'selected="selected"':''}>PJ</option>
                            <option value="JPS" ${param.tipo eq 'JPS'?'selected="selected"':''}>JPS</option>
                        </select>
                    </div>

                    <div class="ui-field-contain">
                        <label for="mutazioni">Mutazioni:</label>
                        <input type="text" name="mutazioni" id="mutazioni" value="${param.mutazioni}" data-mini="true" />
                    </div>

                    <c:if test="${not empty param.terapie_id}">
                        <input type="hidden" name="terapie_id" value="${param.terapie_id}" />
                    </c:if>

                    <div class="ui-grid-a"  >
                        <div class="ui-block-a">
                            <a data-rel="back" data-role="button" data-icon="delete" data-iconpos="left">Cancel</a>
                        </div>
                        <div class="ui-block-b">
                            <button type="submit" name="action" value="addpatologiac" data-icon="check" data-iconpos="right">Save</button>
                        </div>
                    </div>
                </form>
            </div>

            <%@include file="WEB-INF/jspf/footer.jsp" %>
        </div>

    </body>
</html>