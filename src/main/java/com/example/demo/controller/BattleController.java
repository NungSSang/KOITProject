package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class BattleController {
   CharacterController characterController;
   
   public BattleController(CharacterController characterController) {
	   this.characterController = characterController;
   }

   @GetMapping("/usr/game/field")
   public String field() {
       return "usr/game/field";
   }
   
   
}

	
	

