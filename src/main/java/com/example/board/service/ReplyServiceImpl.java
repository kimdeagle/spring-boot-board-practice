package com.example.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.board.domain.ReplyDTO;
import com.example.board.mapper.ReplyMapper;

@Service
public class ReplyServiceImpl implements ReplyService {

	@Autowired
	private ReplyMapper replyMapper;
	
	@Override
	public List<ReplyDTO> getList(Long bno) {
		return replyMapper.getList(bno);
	}
	
	@Override
	public int register(ReplyDTO reply) {
		return replyMapper.register(reply);
	}
	
	@Override
	public int remove(Long rno) {
		return replyMapper.remove(rno);
	}
	
	@Override
	public int modify(ReplyDTO reply) {
		return replyMapper.modify(reply);
	}
	
}
