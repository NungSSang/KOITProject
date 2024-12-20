package com.example.demo.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Item {

	private int id;
	private String itemName;
	private String itemType;
	private String enemyType;
	private int characterId;
	private int itemCount;
	private boolean isCreate;
	private String needItem;
	private String needItemInt;
	private int itemId;
	private String itemInfo;
	private String type;
	
	private int head;
	private int body;
	private int foot;
	private int rightHand;
	private int leftHand;
	private int attack;
	private int def;
	private int hp;
}
