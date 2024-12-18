package com.example.demo.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CharacterDto {
	private int id;
	private String characterName;
	private int memberId;
	private int characterHp;
	private int characterAttackPower;
	private int characterBerrior;
	private int stageNum;
	private String skillAttr;
}
