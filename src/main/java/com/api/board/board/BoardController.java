package com.api.board.board;

import com.api.board.board.service.BoardService;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;


import java.util.List;
import java.time.LocalDate;

@Controller
public class BoardController {
    private BoardService boardService;

    @Autowired
    public BoardController(BoardService boardService) {
        this.boardService = boardService;
    }

    @GetMapping(value = "/")
    public String index(Model model) {
        List<Board> boardList = boardService.getBoardList();
        model.addAttribute("boardList", boardList);

        return "index";
    }

    @PostMapping("/login")
    public String login(Model model, HttpServletResponse response, @RequestParam("id") String id, @RequestParam("name") String name) {
        List<Board> boardList = boardService.getBoardList();
        model.addAttribute("boardList", boardList);

        Cookie idCookie = new Cookie("id", id);
        Cookie nameCookie = new Cookie("name", name);
        idCookie.setMaxAge(3600); // 1시간
        response.addCookie(idCookie);
        response.addCookie(nameCookie);
        model.addAttribute("idCookie", idCookie);
        model.addAttribute("nameCookie", nameCookie);

        return "index";
    }
    @GetMapping("/post")
    public String openPost(Model model) {

        return "post";
    }
    @PostMapping("/post")
    public String insertBoard(@ModelAttribute Board board)throws Exception{

        boardService.insertBoard(board);
        return "redirect:/";
    }

}
