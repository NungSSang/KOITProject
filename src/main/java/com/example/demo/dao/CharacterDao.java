package com.example.demo.dao;

import java.util.List;

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
	
}
