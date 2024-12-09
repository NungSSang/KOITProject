package com.example.demo.service;

import org.springframework.stereotype.Service;

import com.example.demo.dao.ImgFileDao;

@Service
public class ImgFileService {

	ImgFileDao imgFileDao;
	public ImgFileService(ImgFileDao imgFileDao) {
		this.imgFileDao = imgFileDao;
	}
	public String getImgPath(String imgName) {
		return imgFileDao.getImgPath(imgName);
	}

}
