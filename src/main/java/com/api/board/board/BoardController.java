package com.api.board.board;

import com.api.board.board.service.BoardService;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.support.ResourceBundleMessageSource;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
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
                        @RequestParam(defaultValue = "") String type,
                        @RequestParam(name = "startDate", defaultValue = "") @DateTimeFormat(pattern = "yyyyMMdd") LocalDate startDate,
                        @RequestParam(name = "endDate", defaultValue = "") @DateTimeFormat(pattern = "yyyyMMdd") LocalDate endDate
    ) {
        int listCnt = boardService.getBoardList();
        BoardSearch boardSearch = new BoardSearch(listCnt, page, pageSize, 5, startDate, endDate);
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
    public String getListWithPaging(Model model, HttpServletRequest request,
                                    @RequestParam(name = "page", defaultValue = "1") Integer page,
                                    @RequestParam(name = "pageSize", defaultValue = "10") Integer pageSize,
                                    @RequestParam(name = "no", defaultValue = "") String no,
                                    @RequestParam(name = "title", defaultValue = "") String title,
                                    @RequestParam(name = "startDate", defaultValue = "") @DateTimeFormat(pattern = "yyyyMMdd") LocalDate startDate,
                                    @RequestParam(name = "endDate", defaultValue = "") @DateTimeFormat(pattern = "yyyyMMdd") LocalDate endDate,
                                    @RequestParam(name = "type", defaultValue = "") String type) {

        int listCnt = boardService.getBoardList();

        Map<String, Object> searchParams = new HashMap<>();
        searchParams.put("no", no);
        searchParams.put("title", title);
        searchParams.put("startDate", startDate);
        searchParams.put("endDate", endDate);
        searchParams.put("type", type);

        String startDateStr = startDate != null ? startDate.toString() : "";
        String endDateStr = endDate != null ? endDate.toString() : "";

        int totalSearchResult = boardService.getCountWithSearch(searchParams);

        LocalDate parsedStartDate = (startDate == null || startDate.toString().isEmpty()) ? null : LocalDate.parse(startDate.toString(), DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        LocalDate parsedEndDate = (endDate == null || endDate.toString().isEmpty()) ? null : LocalDate.parse(endDate.toString(), DateTimeFormatter.ofPattern("yyyy-MM-dd"));

        BoardSearch boardSearch = new BoardSearch(listCnt, page, pageSize, 5, startDate, endDate);

        boardSearch.setKeyword(title);
        boardSearch.setType("title");
        boardSearch.setStartDate(parsedStartDate);
        boardSearch.setEndDate(parsedEndDate);

        List<String> largeCodes = boardService.getLargeCodes();
        List<String> middleCodes = boardService.getMiddleCodes();

        boardSearch.rangeSetting(boardSearch.getCurPage());

        List<Board> pagedBoardList = boardService.getListWithPaging(boardSearch);

        boardSearch.setPagedSearchResult(pagedBoardList);

        boardSearch.setOffset((boardSearch.getCurPage() - 1) * boardSearch.getPageSize());
        boardSearch.setAmount(boardSearch.getPageSize());
        boardSearch.setPagedSearchResult(pagedBoardList);

        model.addAttribute("boardList", pagedBoardList);
        model.addAttribute("boardSearch", boardSearch);
        model.addAttribute("nameCookie", nameCookie);
        model.addAttribute("pageSize", pageSize);
        model.addAttribute("largeCodes", largeCodes);
        model.addAttribute("middleCodes", middleCodes);

        if (parsedStartDate != null && parsedEndDate != null) {
            System.out.println(parsedStartDate + "+" + parsedEndDate);
        } else {
            System.out.println("null");
        }

        System.out.println("Search Result Size: " + pagedBoardList.size() + pagedBoardList);
        return "search";
    }


    @GetMapping("/getMiddleCodes")
    @ResponseBody
    public List<String> getMiddleCodesByLargeCode(@RequestParam String largeCode) {
        return boardService.getMiddleCodesByLargeCode(largeCode);
    }
    @Configuration
    public class MessageConfig {
        @Bean
        public MessageSource messageSource() {
            ResourceBundleMessageSource messageSource = new ResourceBundleMessageSource();
            messageSource.setBasenames("messages/messages");
            messageSource.setFallbackToSystemLocale(false);
            messageSource.setDefaultEncoding("UTF-8");

            return messageSource;
        }
    }
}
