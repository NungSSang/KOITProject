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
	//팝업 예시========================
//	@GetMapping("/usr/game/itemPop")
//	public String itemPop(Model model,HttpServletRequest req) {
//		Rq rq = (Rq) req.getAttribute("rq");
//		List<Item> items = itemService.getItemsByCharacterId(rq.getLoginedMemberId());
//	   	model.addAttribute("items",items);
//		return "usr/game/itemPop";
//	}
	@GetMapping("/usr/game/addItem")
	@ResponseBody
	public String getMethodName() {
		itemService.getItem();
		return Util.jsReturn("아이템이 추가되었습니다.","field");
	}
	
	

}
