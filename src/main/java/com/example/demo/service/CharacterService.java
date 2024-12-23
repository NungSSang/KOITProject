package com.example.demo.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.example.demo.dao.CharacterDao;
import com.example.demo.dto.CharacterDto;

@Service
public class CharacterService {
	CharacterDao characterDao;
	
	public CharacterService(CharacterDao characterDao) {
		this.characterDao = characterDao;
	}
	
	public List<CharacterDto> getCharacter(int memberId) {
		return characterDao.getCharacter(memberId);
	}
	
	public CharacterDto getCharacterInfo(int memberId) {
		return characterDao.getCharacterInfo(memberId);
	}

	public void updateCharacterStatus(int id, String characterName, int memberId, int characterHp,int characterAttackPower, int characterBerrior, int stageNum) {
		characterDao.updateCharacterStatus(id, characterName, memberId, characterHp, characterAttackPower, characterBerrior, stageNum);
	}

	public void getSkills(int id, int skillId) {
		 characterDao.getSkills(id, skillId);
	}

	public List<CharacterDto> getSkillsCount(int id) {
		return characterDao.getSkillsCount(id);
	}

	public void insertcharacterEquippedItem(int characterId, String itemType) {
		characterDao.insertcharacterEquippedItem(characterId, itemType);
	}
	
	public void insertCharacter(int characterId, String userName) {
		characterDao.insertCharacter(characterId, userName);
	}
}
