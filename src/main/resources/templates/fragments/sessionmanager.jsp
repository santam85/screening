<%-- Configuring defaults --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${empty sessionScope.pageSize}">
    <c:set var="pageSize" scope="session" value="${initParam.pageSize}"/>
</c:if>

<c:if test="${empty sessionScope.user}">
    <c:redirect url="login.jsp?redirect=${pageContext.request.servletPath}"/>
</c:if>
