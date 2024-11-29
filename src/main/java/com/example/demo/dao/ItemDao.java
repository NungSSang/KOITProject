package com.example.demo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.example.demo.dto.Item;

@Mapper
public interface ItemDao {

	@Select("""
			SELECT  i.itemName
					FROM item AS i
					INNER JOIN `character` AS c
					ON i.characterId = c.#{id}
			""")
	public List<Item> getItemsByCharacterId(int id);

	@Select("""
			SELECT  i.itemName
					FROM item AS i
					INNER JOIN `character` AS c
					ON i.characterId = c.#{id}
					WHERE i.id = #{index}
			""")
	public Item getItemsByCharacterId(int id, int index);

}
