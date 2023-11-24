package com.api.board.board.service;

import com.api.board.board.Board;
import com.api.board.board.BoardSearch;
import com.api.board.board.mapper.BoardMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
    public List<Board> getListWithPaging(BoardSearch boardSearch) {
        int offset = (boardSearch.getCurPage() - 1) * boardSearch.getPageSize();
        String keyword = boardSearch.getKeyword();
        String[] typeArr = boardSearch.getTypeArr();

        Map<String, Object> params = new HashMap<>();
        params.put("offset", offset);
        params.put("pageSize", boardSearch.getPageSize());
        params.put("keyword", keyword);
        params.put("typeArr", typeArr);

        List<Board> pagedBoardList = boardMapper.getListWithPaging(params);

        return pagedBoardList;
    }
    public List<String> getLargeCodes() {
        return boardMapper.getLargeCodes();
    }

    public List<String> getMiddleCodes() {
        return boardMapper.getMiddleCodes();
    }
}
