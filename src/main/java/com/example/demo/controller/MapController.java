package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.service.MapService;

@Controller
public class MapController {
	MapService mapService;
	public MapController(MapService mapService) {
		this.mapService = mapService;
	}
	@GetMapping("/usr/map/getMap")
	@ResponseBody
	public void getMap(int stageNum) {
		mapService.getMap(stageNum);
	}
	
	
}
