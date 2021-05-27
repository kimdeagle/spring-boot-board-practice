package com.example.board.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.board.domain.ReplyDTO;

@Mapper
public interface ReplyMapper {

	public List<ReplyDTO> getList(Long bno);

	public int register(ReplyDTO reply);

	public int remove(Long rno);

	public int modify(ReplyDTO reply);

}
