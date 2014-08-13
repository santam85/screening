<%-- any content can be specified here e.g.: --%>
<%@ page pageEncoding="UTF-8" %>
<div data-role="header" data-position="fixed" data-id="header" data-tap-toggle="false">
    <h1>Database Screening</h1>
    <c:if test="${not empty sessionScope.user}" >
        <form action="login.jsp" method="post"><button name="action" value="logout" class="ui-btn-right" data-icon="delete">Log Out</button></form>
    </c:if>
</div>
