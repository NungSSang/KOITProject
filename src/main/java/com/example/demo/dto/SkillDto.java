package com.example.demo.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class SkillDto {

	private int id;
	private String skillName;
	private String skillAttr;
	private int skillDamage;
	private String skillEffectName;
	private String skillInfo;
}
