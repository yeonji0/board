<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="th" uri="http://www.springframework.org/tags/form" %>
<head>
    <meta http-equiv="Content-Type" content="text/html" charset="UTF-8"/>
    <title>Board</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<style>
    * {margin: 0;padding: 0;box-sizing: border-box;}
    a {color: inherit;text-decoration: none}
    a:link, a:visited {text-decoration: none;color: #333}
    ul, li {list-style: none;}
</style>
<body>
<div class="container">
    <form action="/post" method="post" name="loginForm">
        <div class="form-group row">
            <div class="field">
                <label>구분</label>
                <select name="largeCode" id="largeCodeSelect" onchange="changeLargeCode()">
                    <option value="" selected>--</option>
                    <c:forEach var="largeCode" items="${largeCodes}">
                        <option value="${largeCode}" ${param.largeCode eq largeCode ? 'selected' : ''}>${largeCode}</option>
                    </c:forEach>
                </select>
                <select name="middleCode" id="middleCodeSelect"></select>
            </div>
        </div>
        <div class="form-group row">
            <label for="inputTitle" class="col-sm-2 col-form-label"><strong>제목</strong></label>
            <div class="col-sm-10">
                <input type="text" name="title" class="form-control" id="inputTitle"/>
            </div>
        </div>
        <div class="form-group row">
            <label for="inputContent" class="col-sm-2 col-form-label"><strong>내용</strong></label>
            <div class="col-sm-10">
                <textarea name="contents" class="form-control" id="inputContent"></textarea>
            </div>
        </div>
        <div class="form-group row">
            <label for="inputContent" class="col-sm-2 col-form-label"><strong>작성자</strong></label>
            <div class="col-sm-10">
                <textarea name="regUser" class="form-control" value="${nameCookie.value}">${nameCookie.value}</textarea>
                <input type='hidden' name='modUser' value='${nameCookie.value}' />
            </div>
        </div>

        <div class="row">
            <div class="col-auto mr-auto"></div>
            <div class="col-auto">
                <input class="btn btn-primary" type="button" value="닫기" onclick="location.href='/'"/>
                <input class="btn btn-success" type="submit" value="저장"/>
            </div>
        </div>
    </form>

</div>
</body>
<script>
    function changeLargeCode() {
        var largeCodeSelect = document.getElementById("largeCodeSelect");
        var middleCodeSelect = document.getElementById("middleCodeSelect");
        var selectedLargeCode = largeCodeSelect.value;


        middleCodeSelect.innerHTML = "";

        fetch('/getMiddleCodes?largeCode=' + selectedLargeCode)
            .then(response => response.json())
            .then(data => {
                data.forEach(middleCode => {
                    var option = document.createElement("option");
                    option.value = middleCode;
                    option.text = middleCode;
                    middleCodeSelect.add(option);
                });
            })
            .catch(error => console.error('Error fetching middleCodes:', error));
    }
</script>
