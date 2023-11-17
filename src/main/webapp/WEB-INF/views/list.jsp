<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="container">
    <jsp:include page="search.jsp"></jsp:include>
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
                        </c:when>
                    </c:choose>
                </c:forEach>
                </tbody>
            </table>
            <nav aria-label="Page navigation example">
                <div class="row">
                    <div class="col-sm-12">
                        <select id="pageSizeSelect" onchange="changePageSize(this)">
                            <option value="10" ${boardSearch.pageSize == 10 ? 'selected' : ''}>10</option>
                            <option value="20" ${boardSearch.pageSize == 20 ? 'selected' : ''}>20</option>
                            <option value="100" ${boardSearch.pageSize == 100 ? 'selected' : ''}>100</option>
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

            <button type="button" class="btn btn-primary" onclick="location.href='post'">글쓰기</button>
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
        var url = '?page=' + page + '&pageSize=' + ${boardSearch.pageSize};
        window.location.href = url;
    }
</script>
