<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="container">
    <form action="/search" method="get">
        <div class="form-group row">
            <div class="row" style="margin-right: 20px;">
                <label>번호</label>
                <div class="">
                    <input type="text">
                </div>
            </div>
            <div class="row" style="margin-right: 20px;">
                <label>제목</label>
                <div class="">
                    <input type="text">
                </div>
            </div>
            <div class="row" style="margin-right: 20px;">
                <label>구분</label>
                <div class="">
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
            <div class="row" style="margin-right: 20px;">
                <label>등록일자</label>
                <div class="">
                    <input type="text">
                </div>
            </div>
            <div class="row">
                <div class="col-auto">
                    <input type="submit" role="button" value="조회" onclick="check()"/>
                </div>
            </div>
        </div>
    </form>
    <div class="row">
        <div class="col-sm-12">
            <table class="table">
                <thead class="thead-primary">
                <tr class="text-center">
                    <th scope="col">#</th>
                    <th scope="col">번호</th>
                    <th scope="col">구분</th>
                    <th scope="col">제목</th>
                    <th scope="col">첨부파일</th>
                    <th scope="col">등록자</th>
                    <th scope="col">등록일시</th>
                    <th scope="col">수정자</th>
                    <th scope="col">수정일시</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="board" items="${boardList}" varStatus="status">
                    <c:choose>
                    <c:when test="${nameCookie.value == board.regUser}">
                        <tr class="text-center">
                            <td>
                                <p><input type="checkbox"></p>
                            </td>
                            <td>
                                <p>${board.no}</p>
                            </td>
                            <td>
                                <p>//</p> <%--구분--%>
                            </td>
                            <td>
                                <p>${board.title}</p>
                            </td>
                            <td>
                                <p>첨부파일</p>
                            </td>
                            <td>
                                <p>${board.regUser}</p>
                            </td>
                            <td>
                                <p>${board.regDate}</p>
                            </td>
                            <td>
                                <p>${board.modUser}</p>
                            </td>
                            <td>
                                <p>${board.modDate}</p>
                            </td>
                        </tr>
                    </c:when>
                    </c:choose>
                </c:forEach>
                </tbody>
            </table>
            <button type="button" class="btn btn-primary" onclick="location.href='post'">글쓰기</button>
        </div>
    </div>
</div>