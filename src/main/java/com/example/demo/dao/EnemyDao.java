package com.example.demo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.example.demo.dto.Enemy;

@Mapper
public interface EnemyDao {

	@Select("""
				SELECT *, e.id
					FROM enemy AS e
					RIGHT JOIN map AS m
					ON e.enemyType = m.enemyType
					WHERE stageNum = #{stageNum}
			""")
	List<Enemy> getEnemy(int stageNum);

	@Select("""
			SELECT *
					FROM enemy
					WHERE id = #{id}
			""")
	Enemy getEnemyInfoById(int id);

	@Select("""
			SELECT eA.firstAttack
					,eA.secondAttack
					,eA.thirdAttack
					,eA.defaultAttack
					FROM enemyAttackPattern AS eA
					INNER JOIN enemy AS e
					ON eA.enemyType = e.enemyType
					WHERE ea.enemyType = #{enemyType}
					LIMIT 1	
			""")
	List<Enemy> getEnemyAttackByEnemyId(String enemyType);


}
