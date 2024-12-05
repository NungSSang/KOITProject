package com.example.demo.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.dto.CharacterDto;
import com.example.demo.dto.Rq;
import com.example.demo.service.CharacterService;
import com.example.demo.service.EnemyService;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class BattleController {
   CharacterService characterService;
   EnemyService enemyService;
   ItemController itemController;
   public BattleController(CharacterService characterService, EnemyService enemyService, ItemController itemController) {
	   this.characterService = characterService;
	   this.enemyService = enemyService;
	   this.itemController = itemController;
   }

   @GetMapping("/usr/game/field")
   public String field(HttpServletRequest req,Model model) {
	   Rq rq = (Rq) req.getAttribute("rq");
	   model.addAttribute(rq);
       return "usr/game/field";
   }
   //HP바 만들기 
   @GetMapping("/usr/game/getHPStatus") // memberId , enemyId
   @ResponseBody
   public Map<String, Integer> getHPStatus(int memberId, int id) {
       Map<String, Integer> hpStatus = new HashMap<>();
       int characterHp = characterService.getCharacterInfo(memberId).getCharacterHp();
       int enemyHp = enemyService.getEnemyInfoById(id).getEnemyHp();
       hpStatus.put("heroHP", characterHp);  // 주인공 체력
       hpStatus.put("enemyHP", enemyHp); // 적 체력
       return hpStatus;
   }
   
}

	
	

