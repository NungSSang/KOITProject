package com.example.demo.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.Util.Util;
import com.example.demo.dto.Item;
import com.example.demo.service.ItemService;


@Controller
public class ItemController {
	ItemService itemService;
	
	public ItemController(ItemService itemService) {
		this.itemService = itemService;
	}
	@GetMapping("/usr/item/getItems")
	@ResponseBody
	public List<Item> getItemsByCharacterId(int id) {
		return itemService.getItemsByCharacterId(id);
	}
	
	
	@GetMapping("/usr/item/itemDrop")
	@ResponseBody
	public List<Item> itemDropByEnemyType(String enemyType) {
		return itemService.itemDropByEnemyType(enemyType);
	}
	
	@GetMapping("/usr/item/itemInsertToCharacter")
	@ResponseBody
	public void itemInsertToCharacter(int characterId, String itemName) {
		Item item = itemService.getItemStorageByItemName(characterId, itemName);
		if(item != null) {
			itemService.itemUpdateToCharacter(characterId, itemName);
		}else {
			itemService.itemInsertToCharacter(characterId, itemName);
		}
	}
	@GetMapping("/usr/item/insertGold")
	@ResponseBody
	public void insertGold(int characterId, int gold) {
		Item item = itemService.getItemStorageByItemName(characterId, "gold");
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
	public  Item showGold(int characterId) {
		return itemService.getItemStorageByItemName(characterId, "gold");
	}
	
}
