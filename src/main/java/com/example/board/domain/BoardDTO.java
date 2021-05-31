package com.example.board.domain;

import java.util.Date;

import lombok.Data;

@Data
public class BoardDTO {

	private Long bno;
	private String title;
	private String content;
	private String image;
	private int readcnt;
	private Date regdate;
	private Date updatedate;
	private String userid;
	
	private int replycnt;
	
}
