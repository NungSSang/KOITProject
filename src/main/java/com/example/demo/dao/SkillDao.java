package com.example.demo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.example.demo.dto.SkillDto;


@Mapper
public interface SkillDao {

	@Select("""
			SELECT *
					FROM skills
			""")
	public List<SkillDto> getSkillInfo();

	@Update("""
			UPDATE characterSkill
							SET skillId = #{changeSkillId}
							WHERE characterId = #{id} 
							AND id = #{skillId}
			""")
	public void updateSkills(int id, int skillId, int changeSkillId);

	@Select("""
			SELECT *
				FROM characterSkill AS c
				LEFT JOIN skills AS s
				ON c.skillId = s.id
				WHERE c.characterId = #{id}
			""")
	public List<SkillDto> showMySkills(int id);

	
	@Delete("""
			DELETE FROM characterSkill
					WHERE characterId = #{characterId} AND skillId = #{skillId}
			""")
	public void deleteSkill(int characterId, int skillId);

}
