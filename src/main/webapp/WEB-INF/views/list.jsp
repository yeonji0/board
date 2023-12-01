<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
                <tb>
                    <c:if test="${not empty boardList}">
                        <form id="deleteForm" action="/deleteSelected" method="post">
                            <c:forEach var="board" items="${boardList}" varStatus="status">
                                <c:if test="${nameCookie.value == board.regUser}">
                                    <c:if test="${(empty boardSearch.keyword or fn:contains(board.title, boardSearch.keyword)) and
                           (empty boardSearch.no or fn:contains(board.no, boardSearch.no)) and
                           (empty boardSearch.regDate or fn:contains(board.regDate, boardSearch.regDate))}">
                                        <tr class="text-center">
                                            <td>
                                                <p><input type="checkbox" name="selectedBoards" value="${board.no}"></p>
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
                            <div style="display: flex;justify-content: flex-end;margin: 5px; gap: 5px;">
                                <button type="button" class="btn btn-primary" onclick="location.href='post'">글쓰기
                                </button>
                                <button type="submit" class="btn btn-danger">삭제</button>
                            </div>
                        </form>
                    </c:if>
                    <c:if test="${empty nameCookie.value}">
                        <tr>
                            <td colspan="9" class="text-center">검색 결과가 없습니다.</td>
                        </tr>
                    </c:if>
                </tb>
            </table>
            <c:if test="${not empty nameCookie.value}">
                <nav aria-label="Page navigation example">
                    <div class="row">
                        <div class="col-sm-12">
                            <select id="pageSizeSelect" onchange="changePageSize(this)">
                                <option value="10" ${pageSize == 10 ? 'selected' : ''}>10</option>
                                <option value="20" ${pageSize == 20 ? 'selected' : ''}>20</option>
                                <option value="100" ${pageSize == 100 ? 'selected' : ''}>100</option>
                            </select>
                        </div>
                    </div>
                    <ul class="pagination justify-content-center">
                        <c:if test="${boardSearch.curPage != 1}">
                            <li class="page-item">
                                <a class="page-link" href="#" onclick="fn_paging(1)">
                                    <span>&laquo;</span>
                                </a>
                            </li>
                            <li class="page-item">
                                <a class="page-link" href="#" onclick="fn_paging(${boardSearch.prevPage})">
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
                                        <a class="page-link" href="#" onClick="fn_paging(${pageNum})">${pageNum}</a>
                                    </c:otherwise>
                                </c:choose>
                            </li>
                        </c:forEach>
                        <c:if test="${boardSearch.curPage != boardSearch.endPage}">
                            <li class="page-item">
                                <a class="page-link" href="#" onClick="fn_paging(${boardSearch.nextPage})">
                                    <span aria-hidden="true">&gt;</span>
                                </a>
                            </li>
                            <li class="page-item">
                                <a class="page-link" href="#" onClick="fn_paging(${boardSearch.pageCnt})">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                        </c:if>
                    </ul>
                </nav>
            </c:if>
        </div>
    </div>
</div>
<script>
    function changePageSize(select) {
        var pageSize = select.value;
        var url = window.location.href.split('?')[0] + '?page=1&pageSize=' + pageSize;
        window.location.href = url;
    }

    function fn_paging(page) {
        var url = '?page=' + page + '&pageSize=' + ${pageSize};
        window.location.href = url;
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