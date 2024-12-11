package com.example.demo.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MapDto {
	private int id;
	private int stageNum;
	private String enemyType;
	private String mapName;
}
