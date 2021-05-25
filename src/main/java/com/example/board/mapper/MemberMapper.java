package com.example.board.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.example.board.domain.MemberDTO;

@Mapper
public interface MemberMapper {

	public int isMember(MemberDTO member);
	
}
