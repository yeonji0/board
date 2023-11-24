
package com.api.board.board.mapper;

import java.util.List;
import java.util.Map;

import com.api.board.board.Board;
import com.api.board.board.BoardSearch;
import org.apache.ibatis.annotations.*;

@Mapper
public interface BoardMapper {
    int getBoardList();

    void insertBoard(Board board) throws Exception;

    List<Board> getListWithPaging(Map<String, Object> params);

    List<String> getLargeCodes();

    List<String> getMiddleCodes();

}
