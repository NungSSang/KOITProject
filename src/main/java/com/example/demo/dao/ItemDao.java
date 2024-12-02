package com.example.demo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.example.demo.dto.Item;

@Mapper
public interface ItemDao {
	@Select("""
			SELECT * 
					FROM item
					WHERE characterId = #{id}
			""")
	List<Item> getItemsByCharacterId(int id);

	@Insert("""
			INSERT INTO item
					SET itemName = 'test'
				,itemType = 1
				,enemyType = 0
				,characterId = 1;
			""")
	void getItem();

}
