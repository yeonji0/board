<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="container" style="margin-top: 30px">
    <c:choose>
        <c:when test="${not empty idCookie}">
            <p><strong>${nameCookie.value}</strong> 님, 로그인되었습니다.</p>
            <jsp:include page="list.jsp"></jsp:include>
        </c:when>
        <c:otherwise>
            <p> 로그인되지 않았습니다.</p>
        </c:otherwise>
    </c:choose>
</div>

