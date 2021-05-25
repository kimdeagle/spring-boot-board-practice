package com.example.board.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.board.domain.BoardDTO;
import com.example.board.domain.Pagination;

@Mapper
public interface BoardMapper {

	public List<BoardDTO> getList(Pagination p);

	public BoardDTO get(String bno);
	
	public int register(BoardDTO board);

	public int modify(BoardDTO board);

	public int remove(String bno);
	
	public int getTotalBoardCnt(Pagination p);
	
}
