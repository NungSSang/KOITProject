package com.example.demo.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface ImgFileDao {
	@Select("""
			SELECT savedPath
						FROM imgFile
						WHERE imgName = #{imgName}
			""")
	String getImgPath(String imgName);
}
