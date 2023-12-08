package com.api.board.board.service;

import com.api.board.board.Board;
import com.api.board.board.BoardSearch;
import com.api.board.board.mapper.BoardMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class BoardService {
    private BoardMapper boardMapper;

    @Autowired
    public BoardService(BoardMapper boardMapper) {
        this.boardMapper = boardMapper;
    }

    public int getBoardList() {
        return boardMapper.getBoardList();
    }

    @Transactional
    public void insertBoard(Board board) throws Exception {
        boardMapper.insertBoard(board);
    }
    @Transactional
    public void deleteBoard(Long no) {
        boardMapper.deleteBoard(no);
    }

    public List<Board> getListWithPaging(BoardSearch boardSearch) {
        String keyword = boardSearch.getKeyword();
        String[] typeArr = boardSearch.getTypeArr();

        LocalDate startDate = boardSearch.getStartDate();
        LocalDate endDate = boardSearch.getEndDate();

        LocalDateTime startDateTime = boardSearch.getStartDate() != null ? boardSearch.getStartDate().atStartOfDay() : null;
        LocalDateTime endDateTime = boardSearch.getEndDate() != null ? boardSearch.getEndDate().atTime(23, 59, 59) : null;

        Map<String, Object> params = new HashMap<>();
        params.put("pageSize", boardSearch.getPageSize());
        params.put("keyword", keyword);
        params.put("typeArr", Arrays.asList(typeArr));
        params.put("listCnt", boardSearch.getListCnt());
        params.put("offset", boardSearch.getOffset());
        params.put("amount", boardSearch.getAmount());
        params.put("startDate", startDateTime);
        params.put("endDate", endDateTime);
        int searchResultCount = boardMapper.getCountWithSearch(params);
        boardSearch.setListCnt(searchResultCount);

        boardSearch.setPageCnt((int) Math.ceil((double) searchResultCount / boardSearch.getPageSize()));

        boardSearch.rangeSetting(boardSearch.getCurPage());

        List<Board> pagedBoardList = boardMapper.getListWithPaging(params);
        boardSearch.setOffset((boardSearch.getCurPage() - 1) * boardSearch.getPageSize());
        boardSearch.setAmount(boardSearch.getPageSize());

        return pagedBoardList;
    }


    public List<String> getLargeCodes() {
        return boardMapper.getLargeCodes();
    }
    public List<String> getMiddleCodes() {
        return boardMapper.getMiddleCodes();
    }
    public List<String> getMiddleCodesByLargeCode(String largeCode) {
        return boardMapper.getMiddleCodesByLargeCode(largeCode);
    }
    public int getCountWithSearch(Map<String, Object> params) {
        return boardMapper.getCountWithSearch(params);
    }

}
