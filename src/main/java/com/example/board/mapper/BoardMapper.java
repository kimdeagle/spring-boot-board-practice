package com.example.board.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.board.domain.BoardDTO;
import com.example.board.domain.Pagination;

@Mapper
public interface BoardMapper {

	public List<BoardDTO> getList(Pagination p);

	public BoardDTO get(Long bno);
	
	public int register(BoardDTO board);

	public int modify(BoardDTO board);

	public int remove(Long bno);
	
	public int getTotalBoardCnt(Pagination p);

	public int increaseReplyCnt(Long bno);

	public void increaseReadCnt(Long bno);

	public void decreaseReplyCnt(Long bno);

	public int getReplyCnt(Long bno);
	
}
