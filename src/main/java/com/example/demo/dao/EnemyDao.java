package com.example.demo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.example.demo.dto.Enemy;

@Mapper
public interface EnemyDao {

	@Select("""
			SELECT * 
					FROM enemy
					WHERE id = #{id}
			""")
	List<Enemy> getEnemy(int id);

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
					FROM enemyAttackPattern as eA
					INNER JOIN enemy as e
					ON eA.enemyId = e.id
					WHERE ea.enemyId = #{id}
			""")
	List<Enemy> getEnemyAttackByEnemyId(int id);

}
