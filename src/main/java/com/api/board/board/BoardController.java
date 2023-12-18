package com.api.board.board;

import com.api.board.board.service.BoardService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RequiredArgsConstructor
@CrossOrigin
@RestController
public class BoardController {
    private final BoardService boardService;
    //private Cookie nameCookie;

    @GetMapping("/board/list")
    public List<Board> boardList() {
        return boardService.getAllBoards();
    }

}
