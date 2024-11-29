package com.example.demo.service;

import org.springframework.stereotype.Service;

import com.example.demo.dao.CharacterDao;

@Service
public class CharacterService {
	
		CharacterDao characterDao;
		
		public CharacterService(CharacterDao characterDao) {
			this.characterDao = characterDao;
		}
	
	public void addTestData(String characterName, int userId, int characterHp, int characterAttackPower, int characterBerrior) {
		characterDao.addTestData("test",1,100,10,0);
	}

}
