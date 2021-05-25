package com.example.board.service;

import java.util.List;

import com.example.board.domain.BoardDTO;
import com.example.board.domain.Pagination;

public interface BoardService {

	public List<BoardDTO> getList(Pagination p);

	public BoardDTO get(String bno);
	
	public int register(BoardDTO board);

	public int modify(BoardDTO board);

	public int remove(String bno);

	public Pagination getPagination(Pagination p);

	public int getTotalBoardCnt(Pagination p);
	
}
