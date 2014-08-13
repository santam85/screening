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
        select * from familiari join anagrafica on familiari.anagrafica_id = anagrafica.id where familiari.id = ?
        <sql:param value="${param.id}" />
    </sql:query>
</c:catch>
<!DOCTYPE html> 
<html> 
    <head> 
        <title>Screening - Modifica familiare</title> 
        <%@include file="WEB-INF/jspf/head.jsp" %>
    </head>
    <body>
        <div data-role="page">
            <c:import url="WEB-INF/jspf/header.jsp">
                <c:param name="key" value="value" />
            </c:import>

            <div data-role="content">

                <form action="familiare-detail.jsp?id=${param.id}" method="post">

                    <h4><strong>Paziente:</strong> <a href="patient-detail.jsp?id=${rs.rows[0].anagrafica_id}">${rs.rows[0].nome} ${rs.rows[0].cognome}</a></h4>

                    <div data-role="fieldcontain">
                        <label for="grado">Grado:</label>
                        <input type="range" name="grado" id="grado" value="<fmt:formatNumber value="${rs.rows[0].grado}" maxFractionDigits="0" />" min="1" max="5" data-mini="true" required />
                    </div>

                    <div data-role="fieldcontain">
                        <fieldset data-role="controlgroup" data-mini="true">
                            <legend>Familiarità per CCR:</legend>
                            <label for="ccr">Si/No</label>
                            <input type="checkbox" name="ccr" id="ccr" ${rs.rows[0].ccr?'checked="true"':''}/>
                        </fieldset>
                    </div>

                    <div data-role="fieldcontain">
                        <fieldset data-role="controlgroup" data-mini="true">
                            <legend>Familiarità per Polipi Adenomatosi:</legend>
                            <label for="pa">Si/No</label>
                            <input type="checkbox" name="pa" id="pa" ${rs.rows[0].pa?'checked="true"':''}/>
                        </fieldset>
                    </div>

                    <div data-role="fieldcontain">
                        <fieldset data-role="controlgroup" data-mini="true">
                            <legend>Familiarità per altre tipologie:</legend>
                            <label for="altric">Si/No</label>
                            <input type="checkbox" name="altric" id="altric" ${rs.rows[0].altric?'checked="true"':''}/>
                        </fieldset>
                    </div>

                    <div data-role="fieldcontain">
                        <label for="desc_altri">Tipologie:</label>
                        <input type="text" name="desc_altri" id="desc_altri" value="${rs.rows[0].desc_altri}" data-mini="true" />
                    </div>

                    <div data-role="fieldcontain">
                        <label for="sindrome">Sindrome:</label>
                        <select name="sindrome" id="sindrome" data-mini="true" >
                            <option value="" >Nessuno</option>
                            <option value="FAP" ${rs.rows[0].sindrome eq 'FAP'?'selected="selected"':''} >FAP</option>
                            <option value="AFAP" ${rs.rows[0].sindrome eq 'AFAP'?'selected="selected"':''}>AFAP</option>
                            <option value="LYNCH" ${rs.rows[0].sindrome eq 'LYNCH'?'selected="selected"':''}>LYNCH</option>
                            <option value="MUTYH" ${rs.rows[0].sindrome eq 'MUTYH'?'selected="selected"':''}>MUTYH</option>
                            <option value="PJ" ${rs.rows[0].sindrome eq 'PJ'?'selected="selected"':''}>PJ</option>
                            <option value="JPS" ${rs.rows[0].sindrome eq 'JPS'?'selected="selected"':''}>JPS</option>
                        </select>
                    </div>

                    <div data-role="fieldcontain">
                        <label for="mutazioni">Mutazioni:</label>
                        <input type="text" name="mutazioni" id="mutazioni" value="${rs.rows[0].mutazioni}" data-mini="true" />
                    </div>


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