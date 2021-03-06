package com.example.board.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.board.domain.BoardDTO;
import com.example.board.domain.Pagination;
import com.example.board.service.BoardService;

@Controller
@RequestMapping("/board")
public class BoardController {

	@Autowired
	private BoardService boardService;
	
	@GetMapping("/list")
	public void list(Pagination p, Model model, HttpSession session) {
		
		session.removeAttribute("read");
		
		p.setTotalBoardCnt(boardService.getTotalBoardCnt(p));
		
		p = boardService.getPagination(p);
		
		model.addAttribute("pagination", p);
		
		model.addAttribute("list", boardService.getList(p));
		
	}
	
	@GetMapping("/get")
	public void get(@ModelAttribute("pagination") Pagination p, Long bno, Model model, HttpSession session) {
		
		if (session.getAttribute("read") == null) {
			session.setAttribute("read", true);
			boardService.increaseReadCnt(bno);
		}
		
		model.addAttribute("board", boardService.get(bno));
	}
	
	@GetMapping("/modify")
	public void modify(@ModelAttribute("pagination") Pagination p, Long bno, Model model) {
		model.addAttribute("board", boardService.get(bno));
	}
	
	@GetMapping("/register")
	public void register() {
		
	}
	
	@PostMapping("/register")
	public String register(BoardDTO board, RedirectAttributes rttr) {
		if (boardService.register(board) == 1) {
			rttr.addFlashAttribute("result", "등록 성공");
		}
		
		return "redirect:/board/list";
	}
	
	@PostMapping("/modify")
	public String modify(Pagination p, BoardDTO board, RedirectAttributes rttr) {
		
		if (boardService.modify(board) == 1) {
			rttr.addFlashAttribute("result", "수정 성공");
			rttr.addFlashAttribute("pagination", p);
		}
		
		return "redirect:/board/list";
	}
	
	@GetMapping("/remove")
	public String remove(Long bno, RedirectAttributes rttr) {
		
		if (boardService.remove(bno) == 1) {
			rttr.addFlashAttribute("result", "삭제 성공");
		}
		
		return "redirect:/board/list";
	}
	
	@GetMapping("/getReplyCnt")
	@ResponseBody
	public int getReplyCnt(Long bno) {
		return boardService.getReplyCnt(bno);
	}
	
}
