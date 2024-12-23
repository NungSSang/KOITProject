package com.example.demo.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.dto.CharacterDto;
import com.example.demo.service.CharacterService;

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
	public void updateCharacterStatus(int id, String characterName, int memberId, int characterHp,
			int characterAttackPower, int characterBerrior, int stageNum) {
		characterService.updateCharacterStatus(id, characterName, memberId, characterHp, characterAttackPower,
				characterBerrior, stageNum);
	}

	@GetMapping("/usr/character/getSkills")
	@ResponseBody
	public int getSkills(int id, int skillId) {
		if (characterService.getSkillsCount(id).size() < 3) {
			 characterService.getSkills(id, skillId);
			 return 1;
		}else {
			return 0;
		}
	}
	
	public void insertcharacterEquippedItem(int characterId) {
		characterService.insertcharacterEquippedItem(characterId, "head");
		characterService.insertcharacterEquippedItem(characterId, "body");
		characterService.insertcharacterEquippedItem(characterId, "foot");
		characterService.insertcharacterEquippedItem(characterId, "leftHand");
		characterService.insertcharacterEquippedItem(characterId, "rightHand");
	}
	
	public void insertCharacter(int characterId, String userName) {
		characterService.insertCharacter(characterId, userName);
	}
}