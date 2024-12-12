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

	@Select("""
			SELECT savedPath
					FROM imgFile AS i
					RIGHT JOIN 	map AS m	
					ON i.imgName = m.mapName
					WHERE m.stageNum = #{stageNum}
			""")
	String getMapImgPath(int stageNum);
}
