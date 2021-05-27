package com.example.board.service;

import com.example.board.domain.MemberDTO;

public interface MemberService {

	public boolean isMember(MemberDTO member);

	public int join(MemberDTO member);

	public boolean existUserId(String userid);

	public MemberDTO get(String userid);

	public int updateUserpw(MemberDTO member);

	public int updateName(MemberDTO member);
	
	public int updateEmail(MemberDTO member);
	
}
