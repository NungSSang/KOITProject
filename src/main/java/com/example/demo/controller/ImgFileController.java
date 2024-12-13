package com.example.demo.controller;

import java.io.IOException;

import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.service.ImgFileService;


@Controller
public class ImgFileController {

	ImgFileService imgFileService;
	public ImgFileController(ImgFileService imgFileService) {
		this.imgFileService = imgFileService;
	}
	
	@GetMapping("/usr/imgFile/getImgPath")
	@ResponseBody
	public Resource getImgPath(String imgName) throws IOException {
		String filePath = imgFileService.getImgPath(imgName);
        return new UrlResource("file:" + filePath);		
	}
	@GetMapping("/usr/imgFile/getMapImgPath")
	@ResponseBody
	public Resource getMapImgPath(int stageNum) throws IOException {
		int adjustedStageNum = (stageNum / 5) * 5; 
		if(adjustedStageNum == 0) {
			adjustedStageNum = 1;
		}
	    String filePath = imgFileService.getMapImgPath(adjustedStageNum);
        return new UrlResource("file:" + filePath);		
	}
}
