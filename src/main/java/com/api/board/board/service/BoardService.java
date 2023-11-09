package com.api.board.board.service;

import com.api.board.board.Board;
import com.api.board.board.BoardSearch;
import com.api.board.board.mapper.BoardMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class BoardService {
    private BoardMapper boardMapper;
    @Autowired
    public BoardService(BoardMapper boardMapper){
        this.boardMapper = boardMapper;
    }
    public List<Board> getBoardList(){

        return boardMapper.getBoardList();
    }
    @Transactional
    public void insertBoard(Board board)throws Exception{
       boardMapper.insertBoard(board);
    }
}
