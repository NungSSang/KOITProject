package com.example.demo.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.dto.Enemy;
import com.example.demo.service.EnemyService;

@Controller
public class EnemyController {
	EnemyService enemyService;
	public EnemyController(EnemyService enemyService) {
		this.enemyService = enemyService;
	}
	
	@GetMapping("/usr/enemy/getEnemy")
	@ResponseBody
	public List<Enemy> getEnemy(int stageNum) {
		int adjustedStageNum = (stageNum / 5) * 5; 
		if(adjustedStageNum == 0) {
			adjustedStageNum = 1;
		}
		return enemyService.getEnemy(adjustedStageNum);
		
	}
	
	@GetMapping("/usr/enemy/getEnemyAttack")
	@ResponseBody
	public List<Enemy> getEnemyAttackByEnemyId(String enemyType) {
		return enemyService.getEnemyAttackByEnemyId(enemyType);
	}
}
