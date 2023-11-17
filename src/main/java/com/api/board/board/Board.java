package com.api.board.board;

import lombok.*;

import java.time.LocalDate;

@Data
public class Board {

   private Long no;
   private Long subNo;
   private Long seq;
   private String largeCode;
   private String largeCodeName;
   private String middleCode;
   private String middleCodeName;
   private String title;
   private String contents;
   private String level;
   private LocalDate regDate;
   private String regUser;
   private String modUser;
   private LocalDate modDate;

}
