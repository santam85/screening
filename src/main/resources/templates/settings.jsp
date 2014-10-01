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
        select * from cartelle where cartella = ?
        <sql:param value="${param.id}" />
    </sql:query>
</c:catch>
<!DOCTYPE html> 
<html> 
    <head> 
        <title>Screening - Settings</title> 
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
                    <form action="detail.jsp" method="post">

                        <h2>Edit patient information</h2>
                        
                        <div class="ui-field-contain">
                            <label for="cartella">Numero Cartella:</label>
                            <input type="text" name="cartella" id="cartella" value="${rs.rows[0].cartella}" data-mini="true" disabled />
                        </div>

                        <div class="ui-field-contain">
                            <label for="nome">Nome:</label>
                            <input type="text" name="nome" id="nome" value="${rs.rows[0].nome}" data-mini="true" />
                        </div>

                        <div class="ui-field-contain">
                            <label for="cognome">Cognome:</label>
                            <input type="text" name="cognome" id="cognome" value="${rs.rows[0].cognome}" data-mini="true" />
                        </div>

                        <div class="ui-field-contain">
                            <label for="cartella">Iniziali:</label>
                            <input type="text" name="iniziali" id="iniziali" value="${rs.rows[0].iniziali}" data-mini="true" />
                        </div>

                        <div class="ui-field-contain">
                            <label for="sesso">Sesso:</label>
                            <select name="sesso" id="sesso" data-role="slider" data-mini="true">
                                <option value="M" <c:if test="${rs.rows[0].sesso eq 'M'}">selected="true"</c:if>>M</option>
                                <option value="F" <c:if test="${rs.rows[0].sesso eq 'F'}">selected="true"</c:if>>F</option>
                                </select>
                            </div>

                            <div class="ui-field-contain">
                                <label for="datanascita">Data di nascita:</label>
                                <input type="date" name="datanascita" id="datanascita" value="<fmt:formatDate value="${rs.rows[0].datanascita}" pattern="dd/MM/yyyy"/>" data-mini="true" data-role="datebox" />
                        </div>

                        <div class="ui-field-contain">
                            <label for="luogonascita">Luogo di nascita:</label>
                            <input type="text" name="luogonascita" id="luogonascita" value="${rs.rows[0].luogonascita}" data-mini="true" />
                        </div>

                        <div class="ui-field-contain">
                            <label for="nazionenascita">Nazionalit&agrave;:</label>
                            <input type="text" name="nazionenascita" id="nazionenascita" value="${rs.rows[0].nazionenascita}" data-mini="true" />
                        </div>

                        <div class="ui-field-contain">
                            <label for="peso">Peso</label>
                            <input type="number" name="peso" id="peso" value="${rs.rows[0].peso}" data-mini="true" />
                        </div>

                        <div class="ui-field-contain">
                            <label for="altezzam">Altezza (m)</label>
                            <input type="number" name="altezzam" id="altezzam" value="${rs.rows[0].altezzam}" data-mini="true" />
                        </div>

                        <div class="ui-field-contain">
                            <label for="altezzam2">Altezza (m2)</label>
                            <input type="number" name="altezzam2" id="altezzam2" value="${rs.rows[0].altezzam2}" data-mini="true" />
                        </div>

                        <div class="ui-field-contain">
                            <label for="bmi">BMI</label>
                            <input type="number" name="bmi" id="bmi" value="${rs.rows[0].bmi}" data-mini="true" />
                        </div>

                        <div class="ui-field-contain">
                            <fieldset data-role="controlgroup" data-mini="true">
                                <legend>Familiarit&agrave; CCR</legend>

                                <label for="familiarita">Si/No</label>
                                <input type="checkbox" name="familiarita" id="familiarita" ${rs.rows[0].familiarita?"checked":""}/>

                            </fieldset>
                        </div>

                        <div class="ui-field-contain">
                            <label for="nccr">Numero CCR</label>
                            <input type="number" name="nccr" id="nccr" value="${rs.rows[0].nccr}" data-mini="true" />
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

                </c:otherwise>
            </c:choose>
        </div>

        <%@include file="WEB-INF/jspf/footer.jsp" %>

    </body>
</html>
