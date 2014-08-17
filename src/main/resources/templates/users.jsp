<%-- 
    Document   : users
    Created on : Aug 30, 2012, 5:38:09 PM
    Author     : MSANTARE
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>	
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@taglib uri="/WEB-INF/tlds/md5hash" prefix="md5" %>

<%-- Only admins can manage users --%>
<c:if test="${not sessionScope.user.role.equalsIgnoreCase('admin')}">
    <c:redirect url="login.jsp"/>
</c:if>

<c:catch var="ex">
    <c:if test="${not empty param.action and param.action.equalsIgnoreCase('delete')}">
        <c:choose>
            <c:when test="${param.id eq sessionScope.user.id}">
                <c:set var="msg" value="Deleting the currently logged user is forbidden."/>
            </c:when>
            <c:when test="${param.id eq 0}">
                <c:set var="msg" value="Deleting the root admin is forbidden."/>
            </c:when>
            <c:otherwise>
                <sql:update dataSource="jdbc/screening" var="result">
                    delete from users where id = ?
                    <sql:param value="${param.id}" />
                </sql:update>
            </c:otherwise>
        </c:choose>
    </c:if>

    <c:if test="${not empty param.action and param.action.equalsIgnoreCase('enable')}">
        <sql:update dataSource="jdbc/screening" var="result">
            update users set status = true where id = ?
            <sql:param value="${param.id}" />
        </sql:update>
    </c:if>

    <c:if test="${not empty param.action and param.action.equalsIgnoreCase('disable')}">
        <c:choose>
            <c:when test="${param.id eq sessionScope.user.id}">
                <c:set var="msg" value="Disabling the currently logged user is forbidden."/>
            </c:when>
            <c:otherwise>
                <sql:update dataSource="jdbc/screening" var="result">
                    update users set status = false where id = ?
                    <sql:param value="${param.id}" />
                </sql:update>
            </c:otherwise>
        </c:choose>
    </c:if>

    <c:if test="${not empty param.action and param.action.equalsIgnoreCase('adduser')}">
        <jsp:useBean id="now" class="java.util.Date" />
        <c:choose>
            <c:when test="${param.password eq param.repeatpassword}">
                <c:set var="passwordhash" value="${md5:md5(param.password.concat(now.time))}"/>
                <sql:update dataSource="jdbc/screening" var="result">
                    insert into users (nome, cognome, email, passwordhash, salt, role, status) values (?,?,?,?,?,?,?)
                    <sql:param value="${param.nome}" />
                    <sql:param value="${param.cognome}" />
                    <sql:param value="${param.username}" />
                    <sql:param value="${passwordhash}" />
                    <sql:param value="${now.time}" />
                    <sql:param value="${param.role}" />
                    <sql:param value="${param.status}" />
                </sql:update>
            </c:when>
            <c:otherwise>
                <c:set var="msg" value="Password does not match."/>
            </c:otherwise>
        </c:choose>

    </c:if>

    <sql:query var="rst" dataSource="jdbc/screening">
        select * from users
    </sql:query>
</c:catch>

<!DOCTYPE html>
<html> 
    <head> 
        <title>Screening - Users</title> 
        <%@include file="WEB-INF/jspf/head.jsp" %>
    </head> 
    <body>

        <div data-role="page" data-add-back-btn="true">
            <c:import url="WEB-INF/jspf/header.jsp">
                <c:param name="key" value="value" />
            </c:import>

            <div data-role="content">

                <c:if test="${not empty ex}">
                    <div data-role="collapsible" data-collapsed="false" data-icon="alert">
                        <h3>Error:</h3>
                        <p>${ex.localizedMessage}</p>
                    </div>
                </c:if>
                <c:if test="${not empty msg}">
                    <div data-role="collapsible" data-collapsed="false" data-icon="alert">
                        <h3>Error:</h3>
                        <p>${msg}</p>
                    </div>
                </c:if>

                <ul data-role="listview" class="patient-list" data-inset="true" data-autodividers="true">
                    <c:forEach var="row" items="${rst.rows}">
                        <li style="overflow: auto;">
                            <h3>${row.nome} ${row.cognome}</h3>
                            <p><strong>E-mail: </strong>${row.email}</p>
                            <p><strong>Role: </strong>${row.role}</p>
                            <div class="ui-li-aside">
                                <p>
                                    <strong>Last logged on:</strong><br/>
                                    <span><fmt:formatDate value="${row.lastlogged}" type="both" /></span><br/>
                                </p>

                                <form action="users.jsp" method="post" style="display: inline;">
                                    <input type="hidden" name="id" value="${row.id}" />
                                    <button data-inline="true" data-mini="true" action="submit" name="action" value="delete">Delete</button>

                                    <c:choose>
                                        <c:when test="${row.status}">
                                            <button data-inline="true" data-mini="true" action="submit" name="action" value="disable">Disable</button>
                                        </c:when>
                                        <c:otherwise>
                                            <button data-inline="true" data-mini="true" action="submit" name="action" value="enable">Enable</button>
                                        </c:otherwise>
                                    </c:choose>
                                </form>
                            </div>
                        </li>
                    </c:forEach>
                </ul>
                <div data-role="collapsible" data-inset="true">
                    <h3>Add new user</h3>
                    <p>
                    <form action="users.jsp?_=${now.time}" method="post">
                        <div data-role="fieldcontain">
                            <label for="username">Nome</label>
                            <input id="nome" name="nome" type="text" />
                        </div>

                        <div data-role="fieldcontain">
                            <label for="password">Cognome</label>
                            <input id="cognome" name="cognome" type="text" />
                        </div>

                        <div data-role="fieldcontain">
                            <label for="username">Username</label>
                            <input id="username" name="username" type="text" placeholder="email@domain.com"/>
                        </div>

                        <div data-role="fieldcontain">
                            <label for="password">Password</label>
                            <input id="password" name="password" type="password" />
                        </div>

                        <div data-role="fieldcontain">
                            <label for="repeatpassword">Reenter Password</label>
                            <input id="repeatpassword" name="repeatpassword" type="password" />
                        </div>

                        <div data-role="fieldcontain">
                            <label for="role">Role</label>
                            <select id="role" name="role">
                                <option value="admin">Admin</option>
                                <option value="user" data-placeholder="true">User</option>
                                <option value="readonly">Read only</option>
                            </select>
                        </div>

                        <div data-role="fieldcontain" class="longflipswitch">
                            <label for="status">Status</label>
                            <select id="status" name="status" data-role="slider">
                                <option value="0">Disabled</option>
                                <option value="1">Enabled</option>
                            </select> 
                        </div>

                        <button type="submit" name="action" value="adduser">Register</button>
                    </form>
                    </p>
                </div>
            </div>
            <%@include file="WEB-INF/jspf/footer.jsp" %>
        </div>
    </body>
</html>
