package com.example.demo.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.example.demo.dao.EnemyDao;
import com.example.demo.dto.Enemy;

@Service
public class EnemyService {
	EnemyDao enemyDao;
	
	public EnemyService(EnemyDao enemyDao) {
		this.enemyDao = enemyDao;
	}

	public List<Enemy> getEnemy(int stageNum) {
		return enemyDao.getEnemy(stageNum);
	}
	public Enemy getEnemyInfoById(int id) {
		return enemyDao.getEnemyInfoById(id);
	}

	public List<Enemy> getEnemyAttackByEnemyId(String enemyType) {
		return enemyDao.getEnemyAttackByEnemyId(enemyType);
	}

}
