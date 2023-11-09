<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<head>
    <meta http-equiv="Content-Type" content="text/html" charset="UTF-8" />
    <title>Board</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<style>
    *{margin: 0; padding: 0; box-sizing: border-box;}
    a{color: inherit;text-decoration: none}
    a:link,a:visited{text-decoration: none;color: #333}
    ul,li{list-style: none;}
</style>
<body>
<jsp:include page="login.jsp"></jsp:include>
<div class="container">
    <form action="/post" method="post">
        <div class="form-group row">
            <label class="col-sm-2 col-form-label"><strong>구분</strong></label>
            <div>
                <select>
                    <option value="">대분류1</option>
                    <option value="">대분류2</option>
                    <option value="">대분류3</option>
                </select>
            </div>
            <div class="">
                <select>
                    <option value="">중분류1</option>
                    <option value="">중분류2</option>
                    <option value="">중분류3</option>
                </select>
            </div>
        </div>
        <div class="form-group row">
            <label for="inputTitle" class="col-sm-2 col-form-label"><strong>제목</strong></label>
            <div class="col-sm-10">
                <input type="text" name="title" class="form-control" id="inputTitle" />
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
                <p>
                    ${nameCookie}
                </p>
            </div>

        </div>

        <div class="row">
            <div class="col-auto mr-auto"></div>
            <div class="col-auto">
                <input class="btn btn-primary" type="button" value="닫기" onclick="location.href='/'" />
                <input class="btn btn-success" type="submit" value="저장" />
                <input class="btn" type="submit" value="삭제" />
            </div>
        </div>
    </form>

</div>
</body>