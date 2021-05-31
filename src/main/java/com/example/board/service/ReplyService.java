package com.example.board.service;

import java.util.List;

import com.example.board.domain.ReplyDTO;

public interface ReplyService {

	public List<ReplyDTO> getList(Long bno);

	public int register(ReplyDTO reply);

	public int remove(Long bno, Long rno);

	public int modify(ReplyDTO reply);

}
