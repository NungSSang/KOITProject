package com.example.demo.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.dto.Item;
import com.example.demo.service.ItemService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;



@Controller
public class ItemController {
	ItemService itemService;
	
	public ItemController(ItemService itemService) {
		this.itemService = itemService;
	}
	//아이템 전체 조회 만들어야 함
	@GetMapping("/usr/item/itemDrop")
	@ResponseBody
	public List<Item> itemDropByEnemyType(String enemyType) {
		return itemService.itemDropByEnemyType(enemyType);
	}
	
	@GetMapping("/usr/item/itemInsertToCharacter")
	@ResponseBody
	public void itemInsertToCharacter(int characterId, int itemId) {
		Item item = itemService.getItemStorageByItemName(characterId, itemId);
		if(item != null) {
			itemService.itemUpdateToCharacter(characterId, itemId);
		}else {
			itemService.itemInsertToCharacter(characterId, itemId);
		}
	}
	@GetMapping("/usr/item/insertGold")
	@ResponseBody
	public void insertGold(int characterId, int gold) {
		Item item = itemService.getItemStorageByItemName(characterId, 0);
		if(item != null) {
			itemService.goldUpdateToCharacter(characterId, gold);
		}else {
			itemService.goldInsertToCharacter(characterId, gold);
		}
	}
	@GetMapping("/usr/item/buyItem")
	@ResponseBody
	public void buyItem(int characterId, int gold) {
		itemService.goldUpdateToCharacter(characterId, -gold);
	}
	@GetMapping("/usr/item/showGold")
	@ResponseBody
	public Item showGold(int characterId) {
		return itemService.getItemStorageByItemName(characterId, 0);
	}
	@GetMapping("/usr/item/getItemsByCharacterId")
	@ResponseBody
	public List<Item> getItemsByCharacterId(int characterId) {
		return itemService.getItemsByCharacterId(characterId);
	}
	
	@GetMapping("/usr/item/craftableItems")
	@ResponseBody
	public List<String> craftableItems(int characterId) {
		return itemService.craftableItems(characterId);
	}
	@GetMapping("/usr/item/craftItem")
	@ResponseBody
	public void craftItem(int characterId, String itemName) {
		itemService.craftItem(characterId, itemName.toString());
	}
	@GetMapping("/usr/item/insertItemToCharacterEquip")
	@ResponseBody
	public void insertItemToCharacterEquip(int characterId, int itemId, int id) {
		itemService.insertItemToCharacterEquip(characterId, itemId, id);
		itemService.deleteItemStorageById(id);
	}
	@GetMapping("/usr/item/showEquippedItemsByCharacterId")
	@ResponseBody
	public Item showEquippedItemsByCharacterId(int characterId) {
		return itemService.showEquippedItemsByCharacterId(characterId);
	}
	
}
