package com.api.board.board;

import lombok.*;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDate;
import java.util.List;

@Getter
@Setter
@Data
@NoArgsConstructor
@ToString
public class BoardSearch extends Board {
    private int curPage;
    private int listCnt;
    private int pageSize;
    private int rangeSize;
    private int pageCnt;
    private int rangeCnt;
    private int startPage;
    private int endPage;
    private int prevPage;
    private int nextPage;
    private int offset;
    private int amount;
    private String type;
    private String keyword;
    private String[] typeArr;
    private int totalPages;
    private int maxPage;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate startDate;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate endDate;
    public void setTotalPages(int totalPages) {
        this.totalPages = totalPages;
    }
    private List<Board> pagedSearchResult;

    public int calculateStartPage() {
        int startPage = Math.max(1, curPage - maxPage / 2);
        return Math.min(startPage, pageCnt - maxPage + 1);
    }

    public int calculateEndPage() {
        int endPage = Math.min(pageCnt, curPage + maxPage / 2);
        return Math.max(endPage, maxPage);
    }
    public int getTotalPages() {
        return (int) Math.ceil((double) listCnt / pageSize);
    }

    public int getCurPage() {
        return curPage;
    }

    public List<Board> getPagedSearchResult() {
        int startIdx = Math.min(offset, pagedSearchResult.size());
        int endIdx = Math.min(startIdx + amount, pagedSearchResult.size());
        return pagedSearchResult.subList(startIdx, endIdx);
    }

    public String[] getTypeArr() {
        return type == null ? new String[]{} : type.split(",");
    }
//    public void setSearchResultCount(int totalSearchResult) {
//        this.listCnt = totalSearchResult;
//        rangeSetting(curPage);
//    }

    public BoardSearch(int listCnt, int curPage, int pageSize, int rangeSize, LocalDate startDate, LocalDate endDate) {
        this.listCnt = listCnt;
        this.curPage = curPage;
        this.pageSize = pageSize;
        this.rangeSize = rangeSize;
        this.pageCnt = (int) Math.ceil((double) getTotalPages() / pageSize);
        this.startDate = startDate;
        this.endDate = endDate;

        rangeSetting(curPage);

        this.offset = (curPage - 1) * pageSize;
        this.amount = pageSize;
    }

    public void setPageCnt(int listCnt) {
        this.pageCnt = (int) Math.ceil((double) listCnt / pageSize);
    }

    public void rangeSetting(int curPage) {
        setPageCnt(listCnt);
        this.startPage = Math.max(1, Math.min(curPage - (rangeSize / 2), pageCnt - rangeSize + 1));
        this.endPage = Math.min(pageCnt, startPage + rangeSize - 1);

        if (endPage > pageCnt) {
            endPage = pageCnt;
        }

        this.prevPage = Math.max(1, curPage - 1);
        this.nextPage = Math.min(pageCnt, curPage + 1);
    }
    public void setPagedSearchResult(List<Board> pagedBoardList) {
        this.pagedSearchResult = pagedBoardList;
    }
}
