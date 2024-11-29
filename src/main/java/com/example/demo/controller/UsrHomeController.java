package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import jakarta.servlet.http.HttpSession;

@Controller
public class UsrHomeController {

	@GetMapping("/usr/home/main")
	public String main(HttpSession sesstion, String direction) {
		return "usr/home/main";
	}
}
