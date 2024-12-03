package com.example.demo.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Enemy {
	private int id;
	private String enemyName;
	private int enemyHp;
	private int enemyAttackPower;
	private int enemyBerrior;
}
