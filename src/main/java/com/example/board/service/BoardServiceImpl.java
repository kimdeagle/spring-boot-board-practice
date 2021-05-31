package com.example.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.board.domain.BoardDTO;
import com.example.board.domain.Pagination;
import com.example.board.mapper.BoardMapper;

@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	private BoardMapper boardMapper;
	
	@Override
	public List<BoardDTO> getList(Pagination p) {
		
		return boardMapper.getList(p);
	}
	
	@Override
	public BoardDTO get(Long bno) {
		return boardMapper.get(bno);
	}
	
	@Override
	public int register(BoardDTO board) {
		return boardMapper.register(board);
	}
	
	@Override
	public int modify(BoardDTO board) {
		return boardMapper.modify(board);
	}
	
	@Override
	public int remove(Long bno) {
		return boardMapper.remove(bno);
	}
	
	@Override
	public int getTotalBoardCnt(Pagination p) {
		return boardMapper.getTotalBoardCnt(p);
	}
	
	@Override
	public Pagination getPagination(Pagination p) {
		
		p.setPagination(p.getPageNum(), p.getAmount());
		
		return p;
	}
	
	@Override
	public void increaseReadCnt(Long bno) {
		boardMapper.increaseReadCnt(bno);		
	}
	
	@Override
	public int getReplyCnt(Long bno) {
		return boardMapper.getReplyCnt(bno);
	}
	
}
