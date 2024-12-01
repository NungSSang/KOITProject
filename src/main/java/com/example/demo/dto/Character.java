package com.example.demo.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Character {
	
	private int id;
	private String characterName;
	private int userId;
	private int characterHp;
	private int characterAttackPower;
	private int characterBerrior;
	
	
}
