package com.example.demo.service;

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
	
	public List<Item> getItemsByCharacterId(int id) {
		return itemDao.getItemsByCharacterId(id);
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
		return	itemDao.getItemStorageByItemName(characterId, itemName);
	}

	public void goldInsertToCharacter(int characterId, int gold) {
		itemDao.goldInsertToCharacter(characterId, gold);
	}

	public void goldUpdateToCharacter(int characterId, int gold) {
		itemDao.goldUpdateToCharacter(characterId, gold);
	}
}
