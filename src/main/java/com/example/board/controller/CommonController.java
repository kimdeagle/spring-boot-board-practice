package com.example.board.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.board.domain.MemberDTO;
import com.example.board.service.MemberService;

@Controller
public class CommonController {

	@Autowired
	private MemberService memberService;
	
	@GetMapping("/login")
	public void login() {
		
	}
	
	@PostMapping("/login")
	public String login(MemberDTO member, RedirectAttributes rttr, HttpSession session) {
		
		if (!memberService.isMember(member)) {
			//회원X -> 로그인 다시
			rttr.addFlashAttribute("result", "회원 정보가 일치하지 않습니다.");
			
			return "redirect:/login";
		}
		
		//회원O
		session.setAttribute("userid", member.getUserid());
		
		return "redirect:/board/list";
	}
	
	@GetMapping("/logout")
	public String logout(RedirectAttributes rttr, HttpSession session) {
		
		session.invalidate();
		
		rttr.addFlashAttribute("result", "로그아웃 완료");
		
		return "redirect:/board/list";
	}
	
	@GetMapping("/join")
	public void join() {
		
	}
	
	@PostMapping("/join")
	public String join(MemberDTO member, RedirectAttributes rttr) {
		if (memberService.join(member) != 1) {
			rttr.addFlashAttribute("result", "회원가입 실패");
			return "redirect:/join";
		}
		
		rttr.addFlashAttribute("result", "회원가입 성공");
		
		return "redirect:/board/list";
		
	}
	
	@GetMapping("/checkUserId")
	@ResponseBody
	public boolean checkUserId(String userid) {
		return memberService.existUserId(userid);
	}
	
}
