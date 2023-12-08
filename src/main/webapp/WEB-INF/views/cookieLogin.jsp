<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="container" style="margin-top: 30px">
    <form id="loginForm" action="/login" method="post">
        <div class="form-group row">
            <div class="row">
                <label for="inputId" class="col-sm-3 col-form-label">아이디</label>
                <div class="col-sm-9">
                    <input type="text" name="id" class="form-control" id="inputId">
                </div>
            </div>
            <div class="row">
                <label for="inputName" class="col-sm-3 col-form-label">이름</label>
                <div class="col-sm-9">
                    <input type="text" name="name" class="form-control" id="inputName">
                </div>
            </div>
            <div class="row">
                <div class="col-auto">
                    <input class="btn btn-primary" type="submit" role="button" value="쿠키생성">
                    <input class="btn btn-danger" type="button" role="button" value="쿠키삭제" onclick="deleteCookie()">
                </div>
            </div>
        </div>
    </form>
</div>
<script>
    function showAlert() {
        var message = '<spring:message code="006"></spring:message>';
        alert(message);
    }
    document.getElementById('loginForm').addEventListener('submit', showAlert);
    function deleteCookie() {
        var message = '<spring:message code="007"></spring:message>';
        alert(message);
    }
</script>