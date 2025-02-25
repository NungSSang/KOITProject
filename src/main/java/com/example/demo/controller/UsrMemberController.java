package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.Util.Util;
import com.example.demo.dto.Member;
import com.example.demo.dto.ResultData;
import com.example.demo.dto.Rq;
import com.example.demo.service.MemberService;

import jakarta.servlet.http.HttpServletRequest;
@Controller
public class UsrMemberController {
	MemberService memberService;
	CharacterController characterController;
	public UsrMemberController(MemberService memberService, CharacterController characterController) {
		this.memberService = memberService;
		this.characterController = characterController;
	}

	@GetMapping("/usr/member/join")
	public String join() {
		return "usr/member/join";
	}

	@PostMapping("/usr/member/doJoin")
	@ResponseBody
	public String doJoin(String loginId, String loginPw, String userName) {
		memberService.joinMember(loginId, loginPw, userName);

		int id = memberService.getLastInsertId();
		memberService.getMemberById(id);
		characterController.insertCharacter(memberService.getMemberById(id).getId(), userName);
		characterController.insertcharacterEquippedItem(memberService.getMemberById(id).getId());
		return Util.jsReturn(String.format("%s 님이 가입되었습니다.", loginId), "../home/main");
	}

	@GetMapping("/usr/member/loginIdDupChk")
	@ResponseBody
	public ResultData loginIdDupChk(String loginId) {

		Member member = memberService.getMemberByLoginId(loginId);

		if (member != null) {
			return ResultData.from("F-1", String.format("[ %s ]은(는) 이미 사용중인 아이디입니다", loginId));
		}
		return ResultData.from("S-1", String.format("[ %s ]은(는) 사용가능한 아이디입니다", loginId));
	}

	@GetMapping("/usr/member/login")
	public String login() {
		return "usr/member/login";
	}

	@PostMapping("/usr/member/doLogin")
	@ResponseBody
	public String doLogin(HttpServletRequest req, String loginId, String loginPw) {
		Rq rq = (Rq) req.getAttribute("rq");
		
		Member member = memberService.getMemberByLoginId(loginId);

		if (member == null) {
			return Util.jsReturn(String.format("[ %s ] 은(는) 존재하지 않는 아이디입니다", loginId), null);
		}

		if (member.getLoginPw().equals(loginPw) == false) {
			return Util.jsReturn("비밀번호를 확인해주세요", null);
		}
		rq.login(member.getId());
		return Util.jsReturn(String.format("%s님 환영합니다~", member.getUserName()), "../home/main");
	}
	@GetMapping("/usr/member/doLogout")
	@ResponseBody
	public String doLogout(HttpServletRequest req) {
		Rq rq = (Rq) req.getAttribute("rq");
		
		rq.logout();
		
		return Util.jsReturn("정상적으로 로그아웃 되었습니다", "../home/main");
	}
}
