package com.example.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.board.domain.ReplyDTO;
import com.example.board.mapper.BoardMapper;
import com.example.board.mapper.ReplyMapper;

@Service
public class ReplyServiceImpl implements ReplyService {

	@Autowired
	private ReplyMapper replyMapper;
	
	@Autowired
	private BoardMapper boardMapper;
	
	@Override
	public List<ReplyDTO> getList(Long bno) {
		return replyMapper.getList(bno);
	}
	
	@Override
	@Transactional
	public int register(ReplyDTO reply) {
		
		int result = 0;
		
		try {
			//댓글 등록
			replyMapper.register(reply);
			
			//댓글수 증가
			boardMapper.increaseReplyCnt(reply.getBno());
			
			result = 1;
			
		} catch (Exception e) {
			return result;
		}
		
		return result;
		
	}
	
	@Override
	@Transactional
	public int remove(Long bno, Long rno) {
		
		int result = 0;
		
		try {
			
			replyMapper.remove(rno);
			
			boardMapper.decreaseReplyCnt(bno);
			
			result = 1;
			
		} catch (Exception e) {
			return result;
		}	
		
		return result;
	}
	
	@Override
	public int modify(ReplyDTO reply) {
		return replyMapper.modify(reply);
	}
	
}
