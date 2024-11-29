package com.example.demo.dao;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CharacterDao {

	@Insert("""
			INSERT INTO `character`
					SET characterName = #{characterName}
						,userId = #{userId}
						,characterHp = #{characterHp}
						,characterAttackPower = #{characterAttackPower}
						,characterBerrior = #{characterBerrior};
			""")
	void addTestData(String characterName, int userId, int characterHp, int characterAttackPower, int characterBerrior);

	
}
