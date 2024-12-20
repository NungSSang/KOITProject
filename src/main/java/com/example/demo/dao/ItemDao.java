package com.example.demo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.example.demo.dto.Item;

@Mapper
public interface ItemDao {
	@Select("""
			SELECT * 
				FROM itemStorage AS `is`
				LEFT JOIN item AS i
				ON `is`.itemId = i.id
				LEFT JOIN itemInfo AS ii
				ON `is`.itemId = ii.itemId
				WHERE characterId = 1
				ORDER BY `is`.itemId
			""")
	List<Item> getItemsByCharacterId(int characterId);
    

	@Select("""
			SELECT *
					FROM item
					WHERE enemyType = #{enemyType}
			""")
	List<Item> itemDropByEnemyType(String enemyType);
	//아이템 네임 -> 아이템 번호
	@Insert("""
			INSERT INTO itemStorage
						SET itemId = #{itemId}
							,characterId = #{characterId}
							,itemCount = 1
			""")
	void itemInsertToCharacter(int characterId, int itemId);
	//아이템 네임 -> 아이템 번호
	@Update("""
			UPDATE itemStorage
						SET itemCount = itemCount + 1
						WHERE itemId = #{itemId} AND characterId = #{characterId}
			""")
	void itemUpdateToCharacter(int characterId, int itemId);
	//아이템 네임 -> 아이템 번호
	@Select("""
			SELECT * 
					FROM itemStorage
					WHERE itemId = #{itemId} AND characterId = #{characterId}
			""")
	Item getItemStorageByItemName(int characterId, int itemId);
	
	@Insert("""
			INSERT INTO itemStorage
					SET itemCount = #{gold}
						,characterId = #{characterId}
						,itemId = 0
						WHERE characterId = #{characterId}
			""")
	void goldInsertToCharacter(int characterId, int gold);

	@Update("""
			UPDATE itemStorage
					SET itemCount = itemCount + #{gold}
						WHERE characterId = #{characterId} AND itemId = 0
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
		            WHERE characterId = #{characterId} AND itemId = #{itemId}
        """)
        List<Item> getItemStorageByCharacterId(int characterId, int itemId);
//    수정필요
    @Select("""
    		SELECT * 
					FROM item AS i
					LEFT JOIN itemStorage AS `is`
					ON i.id = `is`.itemId
					WHERE i.id = #{needItemId}
					AND `is`.itemCount >= #{needItemCount}
					AND `is`.characterId = #{characterId}
    		""")
	List<Item> craftableItems(int characterId, int needItemId, int needItemCount);

    @Select("""
    		SELECT * 
    				FROM item
    				WHERE itemName = #{itemName}
    		""")
	Item getItemByItemName(String itemName);
    
    
    @Select("""
    		SELECT *
    				FROM itemStorage
    					where characterId = #{characterId} AND itemId = #{itemId}
    		""")
    Item getItemByCharacterId(int characterId, int itemId);
    
    @Update("""
    		UPDATE itemStorage
						SET itemCount = itemCount - #{needItemInt}
						WHERE itemId = #{itemId}
    		""")
    void craftItemCountDown(int needItemInt, int itemId);

    @Delete("""
    		DELETE FROM itemStorage
    					WHERE itemId = #{neededItemId}
    		""")
	void craftItemDeleteItem(int neededItemId);


    @Update("""
    		UPDATE characterEquippedItem
					SET itemId = #{itemId} 			
					WHERE characterId = 1 AND itemType = #{itemType}
    		""")
	void insertItemToCharacterEquip(int characterId, int itemId, String itemType);
	
	@Select("""
			SELECT * 
					FROM itemStorage AS `is`
					INNER JOIN itemInfo AS ii
					ON `is`.itemId = ii.itemId
					WHERE `is`.id = #{id}
			""")
	Item getItemInfoByItemStorageId(int id);
	
	@Delete("""
			DELETE 
					FROM itemStorage
					WHERE id = #{id}
			""")
	void deleteItemStorageById(int id);


	@Select("""
			SELECT characterId,head,`body`,foot,rightHand,leftHand 
					FROM characterEquippedItem
					WHERE characterId = #{characterId}
			""")
	Item showEquippedItemsByCharacterId(int characterId);
	
	@Select("""
			SELECT *
				FROM item AS i
				INNER JOIN itemInfo AS ii
				ON i.id = ii.itemId
				WHERE id = #{itemId}
			""")
	Item getItemByItemId(int itemId);

	@Delete("""
			DELETE FROM itemStorage
						WHERE characterId = #{characterId}
							 AND id = #{id}
							 AND itemId = #{itemId}
			""")
	void useItem(int characterId, int id, int itemId);
	
	@Select("""
			SELECT * FROM itemInfo
				WHERE itemId = #{itemId}
			""")
	Item getItemInfoByItemId(int itemId);
	
	@Select("""
			SELECT * 
				FROM item AS i
				INNER JOIN characterEquippedItem AS c
				ON i.id = c.itemId
				INNER JOIN itemInfo AS ii
				ON i.id = ii.itemId
				WHERE c.characterId = 1
			""")
	List<Item> getItemByCharacterIdFOREquippedItem(int characterId);
}
