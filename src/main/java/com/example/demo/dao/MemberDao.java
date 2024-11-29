package com.example.demo.dao;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.example.demo.dto.Member;

@Mapper
public interface MemberDao {

	@Insert("""
			INSERT INTO `member`
						SET loginId = #{loginId}
							,loginPw = #{loginPw}
							,userName = #{userName}
			""")
	void joinMember(String loginId, String loginPw, String userName);

	@Select("""
			SELECT LAST_INSERT_ID();
			""")
	int getLastInsertId();
	@Select("""
			SELECT *
				FROM `member`
				WHERE loginId = #{loginId}
			""")
	Member getMemberByLoginId(String loginId);
	@Select("""
			SELECT *
				FROM `member`
				WHERE id = #{id}
			""")
	Member getMemberById(int id);
}
