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
}
