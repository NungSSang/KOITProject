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
	public List<Item> itemDrop(String enemyType) {
		return itemService.itemDrop(enemyType);
	}
	
	

}
