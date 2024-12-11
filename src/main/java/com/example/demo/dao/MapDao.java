package com.example.demo.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface MapDao {

	@Select("""
			SELECT *
					FROM map
					WHERE stageNum = #{stageNum}
			""")
	void getMap(int stageNum);

}
