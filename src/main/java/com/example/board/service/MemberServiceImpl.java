package com.example.board.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.board.domain.MemberDTO;
import com.example.board.mapper.MemberMapper;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberMapper memberMapper;
	
	@Override
	public boolean isMember(MemberDTO member) {
		return memberMapper.isMember(member) == 1 ? true : false;
	}
	
	@Override
	public int join(MemberDTO member) {
		return memberMapper.join(member);
	}
	
	@Override
	public boolean existUserId(String userid) {
		return memberMapper.existUserId(userid) == 1;
	}
	
}
