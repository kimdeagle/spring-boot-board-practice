package com.example.board.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.board.domain.ReplyDTO;
import com.example.board.service.ReplyService;

@RestController
@RequestMapping("/replies")
public class ReplyController {

	@Autowired
	private ReplyService replyService;
	
	@GetMapping("")
	public ResponseEntity<List<ReplyDTO>> getList(Long bno) {
		
		return new ResponseEntity<>(replyService.getList(bno), HttpStatus.OK);
	}
	
	@PostMapping("")
	public String register(ReplyDTO reply) {
		return replyService.register(reply) == 1 ? "등록 성공" : "등록 실패";
	}
	
	@DeleteMapping("/{rno}")
	public String remove(@PathVariable Long rno) {
		return replyService.remove(rno) == 1 ? "삭제 성공" : "삭제 실패";
	}
	
	@PatchMapping("/{rno}")
	public String modify(@PathVariable Long rno, ReplyDTO reply) {
		reply.setRno(rno);
		return replyService.modify(reply) == 1 ? "수정 성공" : "수정 실패";
	}
	
	
	
}
