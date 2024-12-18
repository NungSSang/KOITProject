package com.example.demo.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.dto.ResultData;
import com.example.demo.dto.SkillDto;
import com.example.demo.service.SkillService;

@Controller
public class SkillController {

	SkillService skillService;
	public SkillController(SkillService skillService) {
		this.skillService = skillService;
	}
	@GetMapping("/usr/skill/getSkillInfo")
	@ResponseBody
	public List<SkillDto> getSkillInfo() {
		return skillService.getSkillInfo();
	}
	@GetMapping("/usr/skill/updateSkills")
	@ResponseBody
	public void updateSkills(int id, int skillId, int changeSkillId) {
		skillService.updateSkills(id, skillId, changeSkillId);
	}
	@GetMapping("/usr/skill/showMySkills")
	@ResponseBody
	public ResultData<List<SkillDto>> showMySkills(int id) {
		return ResultData.from("S-1", "test", skillService.showMySkills(id));
	}
	@GetMapping("/usr/skill/deleteSkill")
	@ResponseBody
	public void deleteSkill(int characterId, int skillId) {
		skillService.deleteSkill(characterId, skillId);
	}
	
}
