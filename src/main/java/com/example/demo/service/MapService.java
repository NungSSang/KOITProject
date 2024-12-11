package com.example.demo.service;

import org.springframework.stereotype.Service;

import com.example.demo.dao.MapDao;

@Service
public class MapService {
	MapDao mapDao;
	public MapService(MapDao mapDao) {
		this.mapDao = mapDao;
	}
	public void getMap(int stageNum) {
		mapDao.getMap(stageNum);
	}
	
}
