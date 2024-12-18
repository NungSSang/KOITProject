package com.example.demo.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.example.demo.dao.SkillDao;
import com.example.demo.dto.SkillDto;

@Service
public class SkillService {

	SkillDao skillDao;
	public SkillService(SkillDao skillDao) {
		this.skillDao = skillDao;
	}
	public List<SkillDto> getSkillInfo() {
		return skillDao.getSkillInfo();
	}
	public void updateSkills(int id, int skillId, int changeSkillId) {
		skillDao.updateSkills(id, skillId, changeSkillId);
	}
	public List<SkillDto> showMySkills(int id) {
		return skillDao.showMySkills(id);
	}
	public void deleteSkill(int characterId, int skillId) {
		skillDao.deleteSkill(characterId, skillId);
		
	}

}
