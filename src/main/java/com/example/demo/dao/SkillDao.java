package com.example.demo.dao;

import java.util.List;

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
							AND skillId = #{skillId}
			""")
	public void updateSkills(int id, int skillId, int changeSkillId);

	@Select("""
			SELECT * 
					FROM skills AS s
					LEFT JOIN characterSkill AS cs 
					ON s.id = cs.skillId
					WHERE characterId = #{id}
			""")
	public List<SkillDto> showMySkills(int id);

}
