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
    <c:if test="${not empty param.action and param.action.equalsIgnoreCase('register')}">
        <jsp:useBean id="now" class="java.util.Date" />
        <c:set var="salt" value="${now.time}" />

        <c:choose>
            <c:when test="${not param.password.equals(param.repeatpassword)}">
                <c:set var="msg" value="The password fields did not match!" />
            </c:when>
            <c:when test="${empty param.password}">
                <c:set var="msg" value="The password cannot be empty!" />
            </c:when>
            <c:otherwise>
                <sql:update dataSource="jdbc/screening" var="saltds">
                    INSERT INTO users(email,nome,cognome,passwordhash,salt,role,status)
                    VALUES (?,?,?,?,?,?,?)
                    <sql:param value="${param.username}" />
                    <sql:param value="${param.nome}" />
                    <sql:param value="${param.cognome}" />
                    <sql:param value="${md5:md5(param.password.concat(salt))}" />
                    <sql:param value="${salt}" />
                    <sql:param value="user" />
                    <sql:param value="${false}" />
                </sql:update>
            </c:otherwise>
        </c:choose>
    </c:if>
</c:catch>

<!DOCTYPE html>
<html> 
    <head> 
        <title>Screening - Register</title> 
        <%@include file="WEB-INF/jspf/head.jsp" %>
    </head> 
    <body>

        <div id="register" data-role="page" data-add-back-btn="false">
            <c:import url="WEB-INF/jspf/header.jsp">
                <c:param name="key" value="value" />
            </c:import>

            <div data-role="content">
                <c:choose>
                    <c:when test="${not empty ex}">
                        <div data-role="collapsible" data-collapsed="false" data-icon="alert">
                            <h3>Error:</h3>
                            <p>${ex}</p>
                        </div>
                    </c:when>
                    <c:when test="${empty ex and param.action.equalsIgnoreCase('register') and empty msg}">
                        <div data-role="collapsible" data-collapsed="false" data-icon="alert">
                            <h3>User registered with success!</h3>
                            <p>The registered user needs to be enabled by an administrator. Register another user or <a href="login.jsp">log in</a>.</p>
                        </div>
                    </c:when>
                    <c:when test="${empty ex and param.action.equalsIgnoreCase('register') and not empty msg}">
                        <div data-role="collapsible" data-collapsed="false" data-icon="alert">
                            <h3>Error:</h3>
                            <p>${msg}</p>
                        </div>
                    </c:when>
                    <c:otherwise>

                    </c:otherwise>
                </c:choose>
                <form action="register.jsp" method="post">
                    <label for="username">Nome</label>
                    <input id="nome" name="nome" type="text" value="${param.nome}" />

                    <label for="password">Cognome</label>
                    <input id="cognome" name="cognome" type="text" value="${param.cognome}"/>

                    <label for="username">Username</label>
                    <input id="username" name="username" type="text" placeholder="email@domain.com" value="${param.username}"/>

                    <label for="password">Password</label>
                    <input id="password" name="password" type="password" />

                    <label for="repeatpassword">Reenter Password</label>
                    <input id="repeatpassword" name="repeatpassword" type="password" />

                    <div class="ui-grid-a"  >
                        <div class="ui-block-a">
                            <a data-role="button" href="login.jsp" data-icon="cancel" data-iconpos="left">Cancel</a>
                        </div>
                        <div class="ui-block-b">
                            <button type="submit" name="action" value="register">Register</button>
                        </div>
                    </div>
                </form>
            </div>
            <%@include file="WEB-INF/jspf/footer.jsp" %>
        </div>
    </body>
</html>
