<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<jsp:useBean id="board" class="com.api.board.board.Board" scope="session" />
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html" charset="UTF-8" />
    <title>Board</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<style>
    *{margin: 0; padding: 0; box-sizing: border-box;}
    a{color: inherit;text-decoration: none}
    a:link,a:visited{text-decoration: none;color: #333}
    ul,li{list-style: none;}
</style>
<body>
<jsp:include page="cookieLogin.jsp"></jsp:include>
<jsp:include page="login.jsp"></jsp:include>
<jsp:include page="list.jsp"></jsp:include>
</body>
</html>