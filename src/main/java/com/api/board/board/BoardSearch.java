package com.api.board.board;

import lombok.*;

import java.util.List;

@Getter
@Setter
@Data
@NoArgsConstructor
@ToString
public class BoardSearch extends Board{
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
    public int getCurPage() {
        return curPage;
    }
    private List<Board> searchResult;
//    public List<Board> getPagedSearchResult() {
//        int startIdx = Math.min(offset, searchResult.size());
//        int endIdx = Math.min(startIdx + amount, searchResult.size());
//        return searchResult.subList(startIdx, endIdx);
//    }

    public String[] getTypeArr() {
        return type == null ? new String[]{} : type.split(",");
    }
//    public void setSearchResultCount(int totalSearchResult) {
//        this.listCnt = totalSearchResult;
//        rangeSetting(curPage);
//    }

    public BoardSearch(int listCnt, int curPage, int pageSize, int rangeSize) {
        this.listCnt = listCnt;
        this.curPage = curPage;
        this.pageSize = pageSize;
        this.rangeSize = rangeSize;
        this.pageCnt = (int) Math.ceil((double) listCnt / pageSize);

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

        this.prevPage = Math.max(1, curPage - 1);
        this.nextPage = Math.min(pageCnt, curPage + 1);
    }
}
