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


}
