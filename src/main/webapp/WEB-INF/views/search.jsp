<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="container">
    <form action="/search" method="get" name="searchForm">
        <div class="form-group row">
            <div class="row" style="margin-right: 20px;">
                <label>제목</label>
                <div>
                    <input id="title" type="text" name="keyword" value="${keyword}">
                </div>
            </div>
            <div class="row" style="margin-right: 20px;">
                <label>구분</label>
                <div class="">
                    <select name="largeCode">
                        <c:forEach var="largeCode" items="${largeCodes}">
                            <option value="${largeCode}">${largeCode}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="">
                    <select name="middleCode">
                        <c:forEach var="middleCode" items="${middleCodes}">
                            <option value="${middleCode}">${middleCode}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <div class="row" style="margin-right: 20px;">
                <label>등록일자</label>
                <div>
                    <input type="text" name="regDate"/>
                </div>
            </div>
            <div class="row">
                <div>
                    <input type="submit" value="검색">
                </div>
            </div>
        </div>
    </form>
</div>