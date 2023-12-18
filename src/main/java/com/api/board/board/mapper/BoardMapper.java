
package com.api.board.board.mapper;

import java.util.List;
import java.util.Map;

import com.api.board.board.Board;
import com.api.board.board.BoardSearch;
import org.apache.ibatis.annotations.*;

@Mapper
public interface BoardMapper {
    List<Board> getAllBoards();

    int getBoardList();
    void insertBoard(Board board) throws Exception;

    void deleteBoard(Long no);
    List<Board> getListWithPaging(Map<String, Object> params);

    int getCountWithSearch(Map<String, Object> params);

    List<String> getLargeCodes();

    List<String> getMiddleCodes();

    List<String> getMiddleCodesByLargeCode(String largeCode);

}
