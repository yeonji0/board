package com.api.board.board;

import lombok.Data;

import java.time.LocalDate;

@Data
public class BoardSearch  {
    private Long no;
    private String title;
    private LocalDate regDate;
}
