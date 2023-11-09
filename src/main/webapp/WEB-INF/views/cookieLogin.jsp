<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="container" style="margin-top: 30px">
    <form action="/login" method="post">
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
                    <input class="btn btn-danger" type="reset" role="button" value="쿠키삭제">
                </div>
            </div>
        </div>
    </form>
</div>
