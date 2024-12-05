package com.example.demo.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.Util.Util;
import com.example.demo.dto.CharacterDto;
import com.example.demo.service.CharacterService;
import org.springframework.web.bind.annotation.RequestParam;



@Controller
public class CharacterController {

	CharacterService characterService;
	
	public CharacterController(CharacterService characterService) {
		this.characterService = characterService;
	}
	
	@GetMapping("/usr/character/getCharacter")
	@ResponseBody
	public List<CharacterDto> getCharacter(int memberId) {
		return characterService.getCharacter(memberId);
	}
	
	@GetMapping("/usr/character/updateCharacterStatus")
	@ResponseBody
	public void updateCharacterStatus(int id, String characterName, int memberId, int characterHp, int characterAttackPower, int characterBerrior) {
		characterService.updateCharacterStatus(id, characterName, memberId, characterHp, characterAttackPower, characterBerrior);
	}
	
	
}
