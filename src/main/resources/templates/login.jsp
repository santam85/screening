<%--
    Document   : index
    Created on : Aug 30, 2012, 5:23:17 PM
    Author     : MSANTARE
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>	
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@taglib uri="/WEB-INF/tlds/md5hash" prefix="md5" %>

<c:catch var="ex">
    <c:choose>
        <c:when test="${not empty param.action and param.action.equalsIgnoreCase('login')}">
            <sql:query dataSource="jdbc/screening" var="saltds">
                select * from users where email=?
                <sql:param value="${param.username}" />
            </sql:query>

            <c:choose>
                <c:when test="${saltds.rowCount eq 1}">
                    <c:set var="passwordhash" value="${md5:md5(param.password.concat(saltds.rows[0].salt))}"/>
                    <c:choose>
                        <c:when test="${passwordhash.equalsIgnoreCase(saltds.rows[0].passwordhash) and saltds.rows[0].status}">
                            <jsp:useBean id="now" class="java.util.Date" />
                            <c:set var="user" scope="session" value="${saltds.rows[0]}"/>
                            <c:set var="sessionScope.user.lastlogged" scope="session" value="${now}"/>

                            <sql:update dataSource="jdbc/screening">
                                update users set lastlogged = ? where id=?
                                <sql:dateParam value="${now}" />
                                <sql:param value="${saltds.rows[0].id}" />
                            </sql:update>

                            <c:choose>
                                <c:when test="${not empty param.redirect}">
                                    <c:redirect url="${param.redirect}"/>
                                </c:when>
                                <c:otherwise>
                                    <c:redirect url="/"/>
                                </c:otherwise>
                            </c:choose>
                        </c:when>
                        <c:when test="${passwordhash.equalsIgnoreCase(saltds.rows[0].passwordhash) and not saltds.rows[0].status}">
                            <c:set var="msg" value="User not enabled."/>
                        </c:when>
                        <c:otherwise>
                            <c:set var="msg" value="Wrong password."/>
                        </c:otherwise>
                    </c:choose>
                </c:when>
                <c:otherwise>
                    <c:set var="msg" value="Username not found."/>
                </c:otherwise>
            </c:choose>
        </c:when>

        <c:when test="${not empty param.action and param.action.equalsIgnoreCase('logout') }">
            <% session.invalidate();%>
        </c:when>

        <c:otherwise>
            <c:if test="${not empty sessionScope.user}">
                <c:choose>
                    <c:when test="${not empty param.redirect}">
                        <c:redirect url="${param.redirect}"/>
                    </c:when>
                    <c:otherwise>
                        <c:redirect url="/"/>
                    </c:otherwise>
                </c:choose>

            </c:if>
        </c:otherwise>
    </c:choose>
</c:catch>



<!DOCTYPE html>
<html> 
    <head> 
        <title>Screening - Login</title> 
        <%@include file="WEB-INF/jspf/head.jsp" %>
    </head> 
    <body>

        <div id="login" data-role="page" data-add-back-btn="false">
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
                    <c:when test="${not empty msg}">
                        <div data-role="collapsible" data-collapsed="false" data-icon="alert">
                            <h3>Error:</h3>
                            <p>${msg}</p>
                        </div>
                    </c:when>
                </c:choose>
                <form action="login.jsp" method="post" name="loginform">
                    <label for="username">Username</label>
                    <input id="username" name="username" type="text" value="${param.username}" placeholder="email@domain.com"/>

                    <label for="password">Password</label>
                    <input id="password" name="password" type="password" />

                    <input type="hidden" name="redirect" value="${param.redirect}" />

                    <div class="ui-grid-a">
                        <div class="ui-block-a">
                            <a data-role="button" href="register.jsp" data-icon="plus" data-iconpos="left">Register</a>
                        </div>
                        <div class="ui-block-b">
                            <button type="submit" name="action" value="login">Login</button>
                        </div>
                    </div>
                </form>

            </div>
            <%@include file="WEB-INF/jspf/footer.jsp" %>
        </div>
    </body>
</html>
