package com.example.demo.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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
	public List<Item> getItemsByCharacterId() {
		return itemService.getItemsByCharacterId(1);
	}
	@GetMapping("/usr/item/getItem")
	@ResponseBody
	public Item getItemByCharacterId(int id, int index) {
		return itemService.getItemByCharacterId(id,index);
	}
	
	
}
