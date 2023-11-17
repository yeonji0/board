package com.api.board.board;

import lombok.*;

@Getter
@Setter
@Data
@NoArgsConstructor
@AllArgsConstructor
public class BoardSearch {
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
    private String type;
    private String keyword;
    public String[] getTypeArr() {
        return type == null ? new String[]{} : type.split("");
    }
    public BoardSearch getBoardSearch() {
        return this;
    }
    private int offset;
    private int amount;

    public BoardSearch(int listCnt, int curPage, int pageSize, int rangeSize) {
        this.listCnt = listCnt;
        this.curPage = curPage;
        this.pageSize = pageSize;
        this.rangeSize = rangeSize;

        rangeSetting(curPage);

        this.offset = (curPage - 1) * pageSize;
        this.amount = pageSize;
    }

    public BoardSearch(int listCnt, int curPage) {
        this(listCnt, curPage, 3, 5);
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
