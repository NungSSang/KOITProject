package com.example.demo.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.example.demo.dao.ItemDao;
import com.example.demo.dto.Item;

@Service
public class ItemService {

	ItemDao itemDao;

	public ItemService(ItemDao itemDao) {
		this.itemDao = itemDao;
	}

	public List<Item> getItemsByCharacterId(int characterId) {
		return itemDao.getItemsByCharacterId(characterId);
	}

	public void getItem() {
		itemDao.getItem();
	}

	public List<Item> itemDropByEnemyType(String enemyType) {
		return itemDao.itemDropByEnemyType(enemyType);
	}

	public void itemInsertToCharacter(int characterId, String itemName) {
		itemDao.itemInsertToCharacter(characterId, itemName);
	}

	public void itemUpdateToCharacter(int characterId, String itemName) {
		itemDao.itemUpdateToCharacter(characterId, itemName);
	}

	public Item getItemStorageByItemName(int characterId, String itemName) {
		return itemDao.getItemStorageByItemName(characterId, itemName);
	}

	public void goldInsertToCharacter(int characterId, int gold) {
		itemDao.goldInsertToCharacter(characterId, gold);
	}

	public void goldUpdateToCharacter(int characterId, int gold) {
		itemDao.goldUpdateToCharacter(characterId, gold);
	}

	public List<Item> craftableItems(int characterId) {
		List<Item> creatableItemsName = new ArrayList<>();
		List<Item> creatableItems = itemDao.showCreateItem();
		if (creatableItems == null || creatableItems.isEmpty()) {
		       return null;
		  }
		try {
			for (Item item : creatableItems) {
	            String[] neededItemIds = item.getNeedItem().split(",");
	            String[] neededItemCounts = item.getNeedItemInt().split(",");

	            for (int i = 0; i < neededItemIds.length; i++) {
	                int neededItemId = Integer.parseInt(neededItemIds[i]);
	                int neededItemCount = Integer.parseInt(neededItemCounts[i]);
	                creatableItemsName.addAll(itemDao.craftableItems(characterId, neededItemId, neededItemCount));
	            }
			}
		} catch (Exception e) {
			e.printStackTrace(); 
		}
		return creatableItemsName;
	}

}
