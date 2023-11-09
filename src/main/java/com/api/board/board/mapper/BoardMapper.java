package com.api.board.board.mapper;

import java.util.List;
import com.api.board.board.Board;
import org.apache.ibatis.annotations.*;

@Mapper
public interface BoardMapper {
    List<Board> getBoardList();
    void insertBoard(Board board)throws Exception;

}
