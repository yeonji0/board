package com.api.board.board;

import com.api.board.board.service.BoardService;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class BoardController {
    private final BoardService boardService;
    private Cookie nameCookie;

    @Autowired
    public BoardController(BoardService boardService) {
        this.boardService = boardService;
    }

    @GetMapping("/")
    public String index(Model model,
                        @RequestParam(name = "page", defaultValue = "1") Integer page,
                        @RequestParam(name = "pageSize", defaultValue = "10") Integer pageSize,
                        @RequestParam(defaultValue = "") String keyword,
                        @RequestParam(defaultValue = "") String type) {
        int listCnt = boardService.getBoardList();
        BoardSearch boardSearch = new BoardSearch(listCnt, page, pageSize, 5);
        //boardSearch.setType(type);
        boardSearch.setKeyword(keyword);

        List<Board> pagedBoardList = boardService.getListWithPaging(boardSearch);
        List<String> largeCodes = boardService.getLargeCodes();
        List<String> middleCodes = boardService.getMiddleCodes();

        model.addAttribute("boardSearch", boardSearch);
        model.addAttribute("nameCookie", nameCookie);
        model.addAttribute("pageSize", pageSize);
        model.addAttribute("boardList", pagedBoardList);
        model.addAttribute("largeCodes", largeCodes);
        model.addAttribute("middleCodes", middleCodes);

        return "index";
    }

    @GetMapping("/login")
    public String loginForm() {
        return "index";
    }

    @PostMapping("/login")
    public String login(Model model,
                        HttpServletResponse response,
                        @RequestParam(name = "id", required = false) String id,
                        @RequestParam(name = "name", required = false) String name) {
        nameCookie = new Cookie(id, name);
        nameCookie.setPath("/");
        nameCookie.setMaxAge(3600); // 1시간
        nameCookie.setDomain("localhost");
        response.addCookie(nameCookie);
        model.addAttribute("nameCookie", nameCookie);

        return "redirect:/";
    }

    @GetMapping("/post")
    public String openPost(Model model) {
        List<String> largeCodes = boardService.getLargeCodes();
        List<String> middleCodes = boardService.getMiddleCodes();
        model.addAttribute("nameCookie", nameCookie);
        model.addAttribute("largeCodes", largeCodes);
        model.addAttribute("middleCodes", middleCodes);
        return "post";
    }

    @PostMapping("/post")
    public String insertBoard(@ModelAttribute Board board) throws Exception {
        board.setRegDate(LocalDate.now());
        board.setModDate(LocalDate.now());
        boardService.insertBoard(board);

        return "redirect:/";
    }
    @PostMapping("/deleteSelected")
    public String deleteSelectedBoards(@RequestParam(value = "selectedBoards", required = false) List<Long> selectedBoards) {
        if (selectedBoards != null && !selectedBoards.isEmpty()) {
            for (Long boardNo : selectedBoards) {
                boardService.deleteBoard(boardNo);
            }
        }
        return "redirect:/";
    }

    @GetMapping("/search")
    public String getListWithPaging(Model model,
                                    @RequestParam(name = "page", defaultValue = "1") Integer page,
                                    @RequestParam(name = "pageSize", defaultValue = "10") Integer pageSize,
                                    @RequestParam(name = "no", defaultValue = "") String no,
                                    @RequestParam(name = "title", defaultValue = "") String title,
                                    @RequestParam(name = "regDate", defaultValue = "") String regDate,
                                    @RequestParam(name = "type", defaultValue = "") String type) {
        Map<String, Object> searchParams = new HashMap<>();
//        searchParams.put("no", no);
//        searchParams.put("title", title);
//        searchParams.put("regDate", regDate);
//        searchParams.put("type", type);

        int totalSearchResult = boardService.getCountWithSearch(searchParams);


        BoardSearch boardSearch = new BoardSearch(totalSearchResult, page, pageSize, 5);
//        boardSearch.setKeyword(no);
//        boardSearch.setType("no");

//        if (!title.isEmpty()) {
//            boardSearch.setKeyword(title);
//            boardSearch.setType("title");
//        } else if (!regDate.isEmpty()) {
//            boardSearch.setKeyword(regDate);
//            boardSearch.setType("regDate");
//        }

        boardSearch.setType(type);
        boardSearch.setListCnt(totalSearchResult);
        boardSearch.setOffset((page - 1) * pageSize);
        boardSearch.setAmount(pageSize);

        List<String> largeCodes = boardService.getLargeCodes();
        List<String> middleCodes = boardService.getMiddleCodes();
        List<Board> pagedBoardList = boardService.getListWithPaging(boardSearch);

        model.addAttribute("boardSearch", boardSearch);
        model.addAttribute("nameCookie", nameCookie);
        model.addAttribute("pageSize", pageSize);
        model.addAttribute("boardList", pagedBoardList);
        model.addAttribute("largeCodes", largeCodes);
        model.addAttribute("middleCodes", middleCodes);
        System.out.println("Search Result Size: " + pagedBoardList.size() + pagedBoardList);
        return "search";
    }

    @GetMapping("/getMiddleCodes")
    @ResponseBody
    public List<String> getMiddleCodesByLargeCode(@RequestParam String largeCode) {
        return boardService.getMiddleCodesByLargeCode(largeCode);
    }

}
