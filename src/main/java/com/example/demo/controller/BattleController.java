package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class BattleController {
   CharacterController characterController;
   ItemController itemController;
   public BattleController(CharacterController characterController,ItemController itemController) {
	   this.characterController = characterController;
	   this.itemController = itemController;
   }

   @GetMapping("/usr/game/field")
   public String field() {
       return "usr/game/field";
   }
   
}

	
	

