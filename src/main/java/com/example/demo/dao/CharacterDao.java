package com.example.demo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.example.demo.dto.CharacterDto;

@Mapper
public interface CharacterDao {
	
	@Select("""
			SELECT *
					FROM `character`
					WHERE memberId = #{memberId}
			""")
	List<CharacterDto> getCharacter(int memberId);

	@Select("""
			SELECT *
				  FROM `character`
				  WHERE memberId = #{memberId};
			""")
	CharacterDto getCharacterInfo(int memberId);

	@Update("""
			UPDATE `character`
							SET id = #{id}
							,characterName = #{characterName}
							,memberId = #{memberId}
							,characterHp = #{characterHp}
							,characterAttackPower = #{characterAttackPower}
							,characterBerrior = #{characterBerrior}
							,stageNum = #{stageNum}
							WHERE id = #{id}
			""")
	void updateCharacterStatus(int id, String characterName, int memberId, int characterHp, int characterAttackPower, int characterBerrior, int stageNum);

	@Insert("""
			INSERT INTO characterSkill
						SET characterId = #{id}
							,skillId = #{skillId}
			""")
	void getSkills(int id, int skillId);

	@Select("""
			SELECT * 
					FROM `character` AS c
					LEFT JOIN characterSkill AS cs
					ON c.id = cs.characterId
					WHERE c.id = #{id}
			""")
	List<CharacterDto> getSkillsCount(int id);
	
}
