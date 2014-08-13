<%-- 
    Document   : edit
    Created on : Aug 30, 2012, 5:38:09 PM
    Author     : MSANTARE
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>

<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@include file="WEB-INF/jspf/sessionmanager.jsp" %>

<c:catch var="ex">
    <sql:query var="rs" dataSource="jdbc/screening">
        select * from anagrafica where id = ?
        <sql:param value="${param.id}" />
    </sql:query>
</c:catch>
<!DOCTYPE html> 
<html> 
    <head> 
        <title>Screening - Modifica paziente</title> 
        <%@include file="WEB-INF/jspf/head.jsp" %>
    </head>
    <body>
        <c:import url="WEB-INF/jspf/header.jsp">
            <c:param name="key" value="value" />
        </c:import>

        <div data-role="content">
            <c:choose>
                <c:when test="${not empty ex}">
                    <div data-role="collapsible" data-collapsed="false" data-theme="e" data-content-theme="d" data-icon="alert">
                        <h3>Error:</h3>
                        <p>${ex.localizedMessage}</p>
                    </div> 
                </c:when>
                <c:otherwise>
                    <form action="patient-detail.jsp?id=${rs.rows[0].id}" method="post">

                        <h2>Edit patient information</h2>


                        <h3>Anagrafica</h3>
                        <div data-role="fieldcontain">
                            <label for="screeningslider">Screening:</label>
                            <select id="screeningslider" class="screeningslider" data-role="slider" data-mini="true">
                                <option value="No" ${empty rs.rows[0].cartella?'selected="true"':''} >No</option>
                                <option value="Si" ${not empty rs.rows[0].cartella?'selected="true"':''}>Si</option>
                            </select>
                        </div>

                        <div data-role="fieldcontain" class="cartellafieldcontain" ${empty rs.rows[0].cartella?'style="display:none;"':''}>
                            <label for="cartella">Numero Cartella:</label>
                            <input type="text" name="cartella" id="cartella" value="${rs.rows[0].cartella}" data-mini="true" />
                        </div>

                        <div data-role="fieldcontain">
                            <label for="nome">Nome:</label>
                            <input type="text" name="nome" id="nome" value="${rs.rows[0].nome}" data-mini="true" required/>
                        </div>

                        <div data-role="fieldcontain">
                            <label for="cognome">Cognome:</label>
                            <input type="text" name="cognome" id="cognome" value="${rs.rows[0].cognome}" data-mini="true" required/>
                        </div>

                        <div data-role="fieldcontain">
                            <label for="iniziali">Iniziali:</label>
                            <input type="text" name="iniziali" id="iniziali" value="${rs.rows[0].iniziali}" data-mini="true" required/>
                        </div>

                        <div data-role="fieldcontain">
                            <label for="sesso">Sesso:</label>
                            <select name="sesso" id="sesso" data-role="slider" data-mini="true">
                                <option value="M" ${rs.rows[0].sesso eq 'M'?'selected="true"':''}>M</option>
                                <option value="F" ${rs.rows[0].sesso eq 'F'?'selected="true"':''}>F</option>
                            </select>
                        </div>

                        <div data-role="fieldcontain" >
                            <label for="datanascita">Data di nascita:</label>
                            <input type="date" name="datanascita" id="datanascita" value="<fmt:formatDate value="${rs.rows[0].datanascita}" pattern="dd/MM/yyyy" />" data-mini="true" data-role="datebox" required/>
                        </div>

                        <div data-role="fieldcontain">
                            <label for="luogonascita">Luogo di nascita:</label>
                            <input type="text" name="luogonascita" id="luogonascita" value="${rs.rows[0].luogonascita}" data-mini="true" required/>
                        </div>

                        <div data-role="fieldcontain">
                            <label for="nazionenascita">Nazionalit&agrave;:</label>
                            <input type="text" name="nazionenascita" id="nazionenascita" value="${rs.rows[0].nazionenascita}" data-mini="true" required/>
                        </div>


                        <div data-role="collapsible-set" data-theme="a">
                            <div data-role="collapsible" data-content-theme="d" data-collapsed="false">
                                <h3>Antropom</h3>
                                <p>
                                <div data-role="fieldcontain">
                                    <label for="peso">Peso</label>
                                    <input type="text" name="peso" id="peso" value="${rs.rows[0].peso}" data-mini="true" />
                                </div>

                                <div data-role="fieldcontain">
                                    <label for="altezza">Altezza (m)</label>
                                    <input type="text" name="altezza" id="altezza" value="${rs.rows[0].altezza}" data-mini="true" />
                                </div>
                                </p>
                            </div>

                            <div data-role="collapsible" data-content-theme="d">
                                <h3>Stile di vita</h3>
                                <p>
                                <div data-role="fieldcontain">
                                    <fieldset data-role="controlgroup" data-mini="true">
                                        <legend>Fumo</legend>

                                        <label for="fumo">Si/No</label>
                                        <input type="checkbox" name="fumo" id="fumo" ${rs.rows[0].fumo?'':'checked="true"'}/>

                                    </fieldset>
                                </div>

                                <div data-role="fieldcontain">
                                    <fieldset data-role="controlgroup" data-mini="true">
                                        <legend>Alcool</legend>

                                        <label for="alcohol">Si/No</label>
                                        <input type="checkbox" name="alcohol" id="alcohol" ${rs.rows[0].alcohol?'':'checked="true"'}/>

                                    </fieldset>
                                </div>

                                </p>
                            </div>
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
                </c:otherwise>
            </c:choose>
        </div>

        <%@include file="WEB-INF/jspf/footer.jsp" %>

    </body>
</html>
