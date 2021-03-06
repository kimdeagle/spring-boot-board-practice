package com.example.board.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.example.board.domain.MemberDTO;

@Mapper
public interface MemberMapper {

	public int isMember(MemberDTO member);

	public int join(MemberDTO member);

	public int existUserId(String userid);

	public MemberDTO get(String userid);

	public int updateUserpw(MemberDTO member);

	public int updateName(MemberDTO member);
	
	public int updateEmail(MemberDTO member);
	
}
