package com.example.board.domain;

import java.util.Date;

import lombok.Data;

@Data
public class MemberDTO {

	private String userid;
	private String userpw;
	private String name;
	private String email;
	private Date regdate;
	
}
