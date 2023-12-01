<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
<jsp:include page="login.jsp"></jsp:include>
<div class="container">
    <form id="searchForm" action="/search" method="get">
        <div class="fields row">
            <div class="field">
                <label for="no">번호</label>
                <input type="text" id="no" name="no" placeholder="검색어" value="${param.no}">
            </div>
            <div class="field">
                <label for="title">제목</label>
                <input type="text" id="title" name="title" placeholder="검색어" value="${param.title}">
            </div>
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
            <div class="field">
                <label for="regDate">날짜</label>
                <input type="text" id="regDate" name="regDate" placeholder="검색어" value="${param.regDate}">
            </div>
            <input type="hidden" name="page" value="${boardSearch.curPage}">
            <input type="hidden" name="pageSize" value="${boardSearch.pageSize}">
            <input type="hidden" name="type" value="${param.type}">
            <input type="hidden" name="keyword" value="${param.keyword}">
            <input type="hidden" name="pageNum" value="1">
            <input type="hidden" name="amount" value="10">
            <button type="submit">검색</button>
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
                <c:if test="${not empty boardList}">
                    <c:forEach var="board" items="${boardList}" varStatus="status">
                        <c:if test="${nameCookie.value == board.regUser}">
                            <c:if test="${(empty param.no or board.no.toString().contains(param.no.toLowerCase())) and
                          (empty param.title or board.title.toLowerCase().contains(param.title.toLowerCase())) and
                          (empty param.regDate or board.regDate.toString().contains(param.regDate.toLowerCase()))}">
                                <tr class="text-center">
                                    <td>
                                        <p><input type="checkbox"></p>
                                    </td>
                                    <td>
                                        <p>${board.no}</p>
                                    </td>
                                    <td>
                                        <p>${board.largeCode}</p>
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
                            </c:if>
                        </c:if>
                    </c:forEach>
                </c:if>
                </tbody>
            </table>
            <nav aria-label="Page navigation example">
                <div class="row">
                    <div class="col-sm-12">
                        <select id="pageSizeSelect" onchange="changePageSizeAndPage(this)">
                            <option value="10" ${pageSize == 10 ? 'selected' : ''}>10</option>
                            <option value="20" ${pageSize == 20 ? 'selected' : ''}>20</option>
                            <option value="100" ${pageSize == 100 ? 'selected' : ''}>100</option>
                        </select>
                    </div>
                </div>
                <ul class="pagination justify-content-center">
                    <c:if test="${boardSearch.curPage != 1}">
                        <li class="page-item">
                            <a class="page-link" href="#" onclick="fn_paging(1, '${param.type}', '${param.keyword}')">
                                <span>&laquo;</span>
                            </a>
                        </li>
                        <li class="page-item">
                            <a class="page-link" href="#" onclick="fn_paging(${boardSearch.prevPage}, '${param.type}', '${param.keyword}')">
                                <span>&lt;</span>
                            </a>
                        </li>
                    </c:if>
                    <c:forEach var="pageNum" begin="${boardSearch.startPage}" end="${boardSearch.endPage}">
                        <li class="page-item">
                            <c:choose>
                                <c:when test="${pageNum == boardSearch.curPage}">
                                    <span class="page-link active">${pageNum}</span>
                                </c:when>
                                <c:otherwise>
                                    <a class="page-link" href="#" onclick="fn_paging(${pageNum})">${pageNum}</a>
                                </c:otherwise>
                            </c:choose>
                        </li>
                    </c:forEach>
                    <c:if test="${boardSearch.curPage != boardSearch.endPage and boardList.size() == boardSearch.pageSize}">
                        <li class="page-item">
                            <a class="page-link" href="#" onclick="fn_paging(${boardSearch.nextPage}, '${param.type}', '${param.keyword}')">
                                <span aria-hidden="true">&gt;</span>
                            </a>
                        </li>
                        <li class="page-item">
                            <a class="page-link" href="#" onclick="fn_paging(${boardSearch.pageCnt}, '${param.type}', '${param.keyword}')">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    </c:if>
                </ul>
            </nav>
            <button type="button" class="btn btn-secondary" onclick="location.href='/'">돌아가기</button>
            <button type="button" class="btn btn-primary" onclick="location.href='post'">글쓰기</button>
        </div>
    </div>
</div>
<script>
    function changePageSizeAndPage(select) {
        var pageSize = select.value;
        var form = document.getElementById('searchForm');
        form.elements['pageSize'].value = pageSize;

        if ('${not empty param.type}') {
            form.elements['type'].value = '${fn:escapeXml(param.type)}';
        }

        if ('${not empty param.keyword}') {
            form.elements['keyword'].value = '${fn:escapeXml(param.keyword)}';
        }

        form.submit();
    }
    function fn_paging(page, type, keyword) {
        var form = document.getElementById('searchForm');
        form.elements['page'].value = page;

        if (type) {
            form.elements['type'].value = type;
        }

        if (keyword) {
            form.elements['keyword'].value = keyword;
        }

        form.submit();
    }

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
