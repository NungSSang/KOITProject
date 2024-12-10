package com.example.demo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.example.demo.dto.Item;

@Mapper
public interface ItemDao {
	@Select("""
			SELECT * 
					FROM itemStorage
					WHERE characterId = #{characterId}
			""")
	List<Item> getItemsByCharacterId(int characterId);
    
	@Insert("""
			INSERT INTO item
					SET itemName = 'test'
						,itemType = 1
						,enemyType = 0
						,characterId = 1;
			""")
	void getItem();

	@Select("""
			SELECT itemName
					FROM item
					WHERE enemyType = #{enemyType}
			""")
	List<Item> itemDropByEnemyType(String enemyType);

	@Insert("""
			INSERT INTO itemStorage
						SET itemName = #{itemName}
							,characterId = #{characterId}
							,itemCount = 1
			""")
	void itemInsertToCharacter(int characterId, String itemName);

	@Update("""
			UPDATE itemStorage
						SET itemCount = itemCount + 1
						WHERE itemName = #{itemName} AND characterId = #{characterId}
			""")
	void itemUpdateToCharacter(int characterId, String itemName);
	
	@Select("""
			SELECT * 
					FROM itemStorage
					WHERE itemName = #{itemName} AND characterId = #{characterId}
			""")
	Item getItemStorageByItemName(int characterId, String itemName);

	@Insert("""
			INSERT INTO itemStorage
					SET itemCount = #{gold}
						,characterId = #{characterId}
						,itemName = 'gold'
						WHERE characterId = #{characterId}
			""")
	void goldInsertToCharacter(int characterId, int gold);

	@Update("""
			UPDATE itemStorage
					SET itemCount = itemCount + #{gold}
						WHERE characterId = #{characterId} AND itemName = 'gold'
			""")
	void goldUpdateToCharacter(int characterId, int gold);

    @Select("""
            SELECT * 
		            FROM item
		            WHERE isCreate = 1
        """)
    List<Item> showCreateItem();
    
    @Select("""
            SELECT * 
		            FROM itemStorage
		            WHERE characterId = #{characterId} AND id = #{itemId}
        """)
        List<Item> getItemStorageByCharacterId(int characterId, int itemId);

    @Select("""
    		SELECT * 
					FROM item AS i
					LEFT JOIN itemStorage AS `is`
					ON i.itemName = `is`.itemName
					WHERE i.id = #{needItemId}
					AND `is`.itemCount >= #{needItemCount}
					AND `is`.characterId = #{characterId}
    		""")
	List<Item> craftableItems(int characterId, int needItemId, int needItemCount);
}
