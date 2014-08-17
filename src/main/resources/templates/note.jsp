<%--
    Document   : index
    Created on : Aug 30, 2012, 5:23:17 PM
    Author     : MSANTARE
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>	
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@taglib uri="WEB-INF/tlds/screening.tld" prefix="scr" %>

<%@include file="WEB-INF/jspf/sessionmanager.jsp" %>

<c:catch var="ex">
    <c:choose>
        <c:when test="${not empty param.action and param.action.equalsIgnoreCase('add')}">
            <sql:update dataSource="jdbc/screening">
                insert into note 
                (users_id,subject,text)
                values (?,?,?); 
                <sql:param value="${param.users_id}" />
                <sql:param value="${param.subject}" />
                <sql:param value="${param.text}" />
            </sql:update>
        </c:when>
        <c:when test="${not empty param.action and param.action.equalsIgnoreCase('delete')}">
            <sql:update dataSource="jdbc/screening" var="result">
                delete from note where id = ?
                <sql:param value="${param.id}" />
            </sql:update>
        </c:when>
    </c:choose>

    <sql:query dataSource="jdbc/screening" var="rs">
        select * from note join users on note.users_id = users.id
    </sql:query>
</c:catch>
<!DOCTYPE html>
<html> 
    <head> 
        <title>Screening - Note</title> 
        <%@include file="WEB-INF/jspf/head.jsp" %>
    </head> 
    <body>
        <div data-role="page" data-add-back-btn="true">
            <c:import url="WEB-INF/jspf/header.jsp">
                <c:param name="key" value="value" />
            </c:import>

            <div data-role="content">
                <c:choose>
                    <c:when test="${not empty ex}">
                        <div data-role="collapsible" data-collapsed="false">
                            <h3>Error:</h3>
                            <p>${ex.localizedMessage}</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div data-role="popup" id="note-add-popup" data-overlay-theme="b" data-position-to="li">
                            <div style="padding:10px 20px; width: 500px;">
                                <form method="post" action="note.jsp">
                                    <div data-role="fieldcontain">
                                        <label for="subject">Titolo:</label>
                                        <input type="text" name="subject" id="subject" value="${param.subject}" data-mini="true" />
                                    </div>

                                    <div data-role="fieldcontain">
                                        <label for="text">Nota:</label>
                                        <textarea name="text" id="text" data-mini="true">${param.tnm}</textarea>
                                    </div>

                                    <input type="hidden" name="users_id" id="users_id" value="${sessionScope["user"].id}" data-mini="true" />

                                    <div class="ui-grid-a"  >
                                        <div class="ui-block-a">
                                            <a data-rel="back" data-role="button" data-icon="delete" data-iconpos="left">Cancel</a>
                                        </div>
                                        <div class="ui-block-b">
                                            <button type="submit" name="action" value="add" data-icon="check" data-iconpos="right">Save</button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>

                        <ul data-role="listview" data-inset="true" data-filter="true">
                            <li data-role="list-divider">Lista note <a class="ui-li-count" style="font-size: 14px;padding: 0;" href="#note-add-popup" data-rel="popup" data-role="button" data-icon="plus" data-iconpos="notext">Inserimento nuova nota</a></li>
                            <c:choose>
                                <c:when test="${rs.rowCount eq 0}">
                                    <li>Nessuna nota.</li>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="row" items="${rs.rows}">
                                        <li style="overflow: auto;">
                                            <h3>${row.subject}</h3>
                                            <p style="white-space: normal;">${row.text}</p>
                                            <div class="ui-li-aside ui-li-desc">
                                                <strong>Creata da: </strong>${row.email}<br/>
                                                <strong>Data inserimento: </strong><fmt:formatDate value="${row.date_added}" pattern="dd/MM/yyyy"/><br/>
                                                <strong>Data ultima modifica: </strong><fmt:formatDate value="${row.date_modified}" pattern="dd/MM/yyyy"/><br/>
                                                <form action="note.jsp" method="post" style="display: inline;text-align: right">
                                                    <input type="hidden" name="note_id" value="${row.id}"/>
                                                    <button data-inline="true" data-mini="true" action="submit" name="action" value="delete">Elimina</button>
                                                </form>
                                            </div>
                                        </li>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </ul>
                        <a href="#note-add-popup" data-rel="popup" data-role="button" data-icon="plus">Inserimento nuova nota</a>
                    </c:otherwise>
                </c:choose>
            </div>
            <%@include file="WEB-INF/jspf/footer.jsp" %>
        </div>
    </body>
</html>
