package com.example.demo.controller;

import org.springframework.stereotype.Controller;

import com.example.demo.service.CharacterService;

@Controller
public class CharacterController {

	CharacterService characterService;
	
	public CharacterController(CharacterService characterService) {
		this.characterService = characterService;
	}
	
}
