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
	public List<Enemy> getEnemy(int id) {
		return enemyService.getEnemy(id);
	}
	@GetMapping("/usr/enemy/getEnemyAttack")
	@ResponseBody
	public List<Enemy> getEnemyAttackByEnemyId(int id) {
		return enemyService.getEnemyAttackByEnemyId(id);
	}
	
	
}
