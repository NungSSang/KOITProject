<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<%@ include file="../../common/header.jsp"%>
<style>
        @keyframes shake {
            0% { transform: translateX(-5px); }
            25% { transform: translateX(5px); }
            50% { transform: translateX(-5px); }
            75% { transform: translateX(5px); }
            100% { transform: translateX(0); }
        }

        /* Shaking animation class */
        .shake {
            animation: shake 0.1s linear;
        }
		<style>
   	 /* 오버레이 애니메이션 */
	    .black-visible {
	        display: block;
	        opacity: 0;
	        animation: fadeIn 0.5s forwards;
	    }
	
	    .black-hidden {
	        opacity: 1;
	        animation: fadeOut 0.5s forwards;
	    }
	
	    @keyframes fadeIn {
	        from {
	            opacity: 0;
	        }
	        to {
	            opacity: 1;
	        }
	    }
	
	    @keyframes fadeOut {
	        from {
	            opacity: 1;
	        }
	        to {
	            opacity: 0;
	        }
	    }
</style>
<script>
		$( document ).ready(function() {
			showBlackScreen(1000);
			 setTimeout(() => {
				 startBattleBtnClick();
			 }, 1000);
		});

		function showBlackScreen(duration = 3000) {
		    const blackScreen = document.getElementById('black');
		
		    // 검은 화면 보이기
		    blackScreen.classList.remove('hidden');
		    blackScreen.style.opacity = '0';
		    blackScreen.style.transition = 'opacity 1s ease-in-out';
		
		    // 점점 검게 덮기
		    setTimeout(() => {
		        blackScreen.style.opacity = '1';
		    }, 10);
		
		    // 지정된 시간(duration) 후 검은 화면 숨기기
		    setTimeout(() => {
		        blackScreen.style.opacity = '0';
		        setTimeout(() => {
		            blackScreen.classList.add('hidden');
		        }, 1000); // 사라지는 애니메이션 시간 (1초)
		    }, duration);
		}
	//=======캐릭터 정보 저장========
		let id;
		let characterName;
		let memberId;
		let characterHp;
		let characterAttackPower;
		let characterBerrior;	
		let enemyId;
		let enemyName;
		let enemyHp;
		let enemyAttackPower;
		let enemyBerrior;
		let enemyType;
		let randomAttack;
		let dropedItem;
		let dropedItemId;
		let cost;
		let stageNum;
		let enemyWeakAttr;
		let enemyStrongAttr;
		let changeSkillId;
		let isGetItem = false;
		let isAttack = false;
//=======================키보드 이벤트 처리=========================
	
		const equipItemSubMenuOpen = () => {
			itemSubmenu.classList.add('hidden');
			craftSubmenu.classList.add('hidden');
			settingSubmenu.classList.add('hidden');
			equipItemSubMenu.classList.remove('hidden');
			showEquippedItemsByCharacterId();
		}
	
		const settingSubmenuOpen = function(){
			itemSubmenu.classList.add('hidden');
			craftSubmenu.classList.add('hidden');
			settingSubmenu.classList.remove('hidden');
			equipItemSubMenu.classList.add('hidden');
		}
		
//============ 토글 사이드바 ================= 
		document.addEventListener('DOMContentLoaded', () => {
			const sidebar = document.getElementById('sidebar');
			const overlay = document.getElementById('overlay');
			const toggleMenuBtn = document.getElementById('toggleMenuBtn');
			const closeMenuBtn = document.getElementById('closeMenuBtn');
	            
// 메뉴 토글
			toggleMenuBtn.addEventListener('click', () => {
				sidebar.classList.remove('-translate-x-full'); // 사이드바 열기
				sidebar.classList.add('translate-x-0');
				overlay.classList.remove('hidden'); // 오버레이 표시
			});
	
// 사이드바 닫기
			const closeSidebar = () => {
				sidebar.classList.add('-translate-x-full'); // 사이드바 닫기
				sidebar.classList.remove('translate-x-0');
				itemSubmenu.classList.add('hidden'); // 2차 메뉴 숨기기
				settingSubmenu.classList.add('hidden'); // 2차 메뉴 숨기기
				craftSubmenu.classList.add('hidden');
				overlay.classList.add('hidden'); // 오버레이 숨기기
				equipItemSubMenu.classList.add('hidden');
			};
			closeMenuBtn.addEventListener('click', closeSidebar);
			overlay.addEventListener('click', closeSidebar);
// 2차 메뉴 열기

			function handlePotionClick(potionCost, hpIncrease) {
			    // 전역 변수 cost 업데이트
			    cost = potionCost;

			    // 캐릭터 HP 증가
			  if(characterHp >= 100){
				  alert('이미 최대체력 입니다.');
			  }
			   characterHp += hpIncrease;	
			   if(characterHp > 100){
				   characterHp = 100;
			   } 
			    // 텍스트 콘텐츠 업데이트
			    const content = `
			        <div id="ballteTextBox" class="w-1/2 h-1/2 bg-gray text-white text-lg font-medium flex items-center justify-center">
			            <div>\${characterName}의 Hp가 \${hpIncrease}만큼 상승하였습니다.</div> 	                    
			        </div>
			    `;

			    // HP 바 업데이트
			    const hpBar = `
			        <div class="relative w-36 h-3 bg-gray-300 rounded-full">
			            <div id="characterHPBar" class="h-full bg-green-500 rounded-full transition-all duration-300 ease-out" style="width: \${characterHp}%;"></div>
			        </div>
			    `;

			    // 텍스트 박스와 HP 바 업데이트
			    $('#battleTextBox').empty().append(content);
			    $('#characterHPBar').empty().append(hpBar);
			    // 아이템 구매 처리
		    	buyItem();
			    setTimeout(() => {
			    	finishBattleBtnClick();
			    }, 2000); // 딜레이 후 애니메이션 실행
			    setTimeout(() => {
			    	startBattleBtnClick();
			    }, 3000); // 딜레이 후 애니메이션 실행

			}
			// 각 버튼에 이벤트 추가
			const potions = [
			    { id: 'potion30', cost: 30, hpIncrease: 30 },
			    { id: 'potion50', cost: 50, hpIncrease: 50 },
			    { id: 'potion100', cost: 100, hpIncrease: 100 }
			];

			potions.forEach(potion => {
			    document.getElementById(potion.id).addEventListener('click', () => {
			        handlePotionClick(potion.cost, potion.hpIncrease);
			    });
			});
		});
//==================게임 시작?=====================

		const insertGold = () => {
			const randomGold = randomNum(80,30);
			$.ajax({
			       url: "/usr/item/insertGold",
			       type: "GET",
			       data: { 
			    	   characterId : 1, 
			    	   gold : randomGold
			       },
			       error: function (xhr, status, error) {
			            console.log(error);
			       }
			   });
		}
		
		const updateSkills = async (skillId) => {
			await $.ajax({
				       url: "/usr/skill/updateSkills",
				       type: "GET",
				       data: { 
				    	   id: ${rq.getLoginedMemberId() }, 
				    	   skillId: skillId,
				    	   changeSkillId: changeSkillId
				       },
				       error: function (xhr, status, error) {
				            console.log(error);
				       }
				   });	
			itemPopUp.classList.add('hidden');
 	 		itemPopUpOverlay.classList.add('hidden');
	 		skillItem.classList.add('hidden');
	 		document.getElementById('skillChangePopUp').classList.add('hidden');
	 		setTimeout(() => {
		    	finishBattleBtnClick();
		    }, 2000); // 딜레이 후 애니메이션 실행
		    setTimeout(() => {
		    	startBattleBtnClick();
		    }, 3000); // 딜레이 후 애니메이션 실행
		}
		
		const getSkills = (skillId) => {
			changeSkillId = skillId;
	 		document.getElementById('skillChangePopUp').classList.add('hidden');
			$.ajax({
		        url: "/usr/character/getSkills",
		        type: "GET",
		        data: {	
		        	id: ${rq.getLoginedMemberId()},
		        	skillId: skillId
				},
				dataType: 'json',
    			success: function (data) {
			 		if(data == 1){
						itemPopUp.classList.add('hidden');
 				 		itemPopUpOverlay.classList.add('hidden');
				 		skillItem.classList.add('hidden');
				 		setTimeout(() => {
					    	finishBattleBtnClick();
					    }, 2000); // 딜레이 후 애니메이션 실행
					    setTimeout(() => {
					    	startBattleBtnClick();
					    }, 3000); // 딜레이 후 애니메이션 실행
			 		}else if(data == 0){
			 			updateSkill();
			 		}
    			},
		        error: function (xhr, status, error) {
					console.log(error);			  
				 	return;
			    }
		    });
		}
		
		const updateSkill = () => {
	 		document.getElementById('itemPopUp').classList.add('hidden');
			document.getElementById('skillItem').classList.add('hidden');
	 		document.getElementById('skillChangePopUp').classList.remove('hidden');
	 		let content = "";
			for (let i = 0; i < 3; i++){
		 		showMySkills()
				.then((response) => {
					    content += `
						    <div id="changeSkillItem" class="flex flex-col items-center space-y-2">
						        <div class="text-white text-sm inline-block">속성 : <img src="/usr/imgFile/getImgPath?imgName=\${response.data[i].skillEffectName}" class="w-6 h-8 inline-block"></div>
						        <button id="skill" class="popup-btn w-32 h-32 rounded-lg flex items-center justify-center hover:bg-green-100" onClick="updateSkills(\${response.data[i].id})">
						            <img src="/usr/imgFile/getImgPath?imgName=\${response.data[i].skillName}" class="w-24 h-28">
						        </button>
						        <div class="text-white text-sm">\${response.data[i].skillName}</div>
						        <div class="text-white text-sm">\${response.data[i].skillInfo}</div>
						    </div>
					    `;
				    $('#skillChangePopUp').empty().append(content);
				});
			}			
		}
		
		
		const getSkillInfo = async() => {
			itemPopUpOverlay.classList.remove('hidden');
			return $.ajax({
			        url: "/usr/skill/getSkillInfo",
			        type: "GET",
			        dataType: "json",
			        success: function (data) {
			        	const random = randomNum(data.length -1 , 0);
			        	let content = `
			                <div class="text-white text-sm inline-block">속성 : <img src="/usr/imgFile/getImgPath?imgName=\${data[random].skillAttr}" class="w-16 h-16 inline-block"></div>
			                <button id="skill"  class="popup-btn w-32 h-32 rounded-lg flex items-center justify-center hover:bg-green-100" onClick="getSkills(\${data[random].id})">
			                    <img src="/usr/imgFile/getImgPath?imgName=\${data[random].skillName }" class="w-24 h-28">
			                </button>
			                <!-- 버튼 아래 텍스트 -->
			                <div class="text-white text-sm">\${data[random].skillInfo }</div>
			                <div class="text-white text-sm">100 Gold</div>
			            `;
			        	 $('#skillItem').empty().append(content);
			        },
			    });
			
		}
	 	const itemPopUpOpen = () => {
	 		const skillItem = document.getElementById('skillItem');
	 		const itemPopUp = document.getElementById('itemPopUp');
	 		const overlay = document.getElementById('overlay');
// 	 		if(randomNum(10,1) < 6){
		 		skillItem.classList.remove('hidden');
		 		getSkillInfo();
// 	 		}
	 		itemPopUp.classList.remove('hidden');
	 		itemPopUpOverlay.classList.remove('hidden');
	 	}
	 	
	 	const showGold = () => {
	 		 $.ajax({
			        url: "/usr/item/showGold",
			        type: "GET",
			        data: { characterId: ${rq.getLoginedMemberId()} },
			        dataType: "json",
			        success: function (data) {
 			        	gold = data.itemCount;
			        	let content = `
			        		<span id="goldAmount">\${data.itemCount}</span>
			            `;
			        	 $('#goldAmount').empty().append(content);
			        },
			    });
	 		itemPopUpOpen();
	 	}
	 	const buyItem = () => {
	 		const skillItem = document.getElementById('skillItem');
	 		const itemPopUp = document.getElementById('itemPopUp');
	 		const overlay = document.getElementById('overlay');
		 	return	$.ajax({
			        url: "/usr/item/buyItem",
			        type: "GET",
			        data: { 
			        	characterId : 1,
			        	gold : cost
			        },
			        success: function (data) {
			        	itemPopUp.classList.add('hidden');
				 		itemPopUpOverlay.classList.add('hidden');
			        },
			        error: function (xhr, status, error) {
			            alert("골드가 부족합니다.");
			            itemPopUp.classList.add('hidden');
				 		itemPopUpOverlay.classList.add('hidden');
				 		return;
			        }
			    });
		 	skillItem.classList.add('hidden');
	 	}

       		
        let firstBattle = true;
        //이미지 로드
        const loadImages = (name,type) => {
        	let img = $('#' + type +'Img');
        	img.attr("src", "/usr/imgFile/getImgPath?imgName=" + name);
        	if(type === 'enemy'){
        	img.css("width", "400px");
        	img.css("height", "400px");
        	}
        };
        
//         const getItemImgPath = (imgName) => {
//         	let img = 
//         }
        const getMapImgPath = () => {
        	let img = $('#map');
            img.attr("src", "/usr/imgFile/getMapImgPath?stageNum=" + stageNum);
        }
		//게임시작 버튼 누르면 하단 박스 바뀌는것
		const startBattleBtnClick = async function () {
			
			$('#enemyZone').removeClass("hidden");
			content = `
                <div id="ballteTextBox" class="w-1/2 h-1/2 bg-gray text-white text-lg font-medium flex items-center justify-center">
					<div>전투에 진입했습니다.</div> 	                    
                </div>
        	`;
			$('#battleTextBox').empty().append(content);
		    // 버튼 상태 전환
		    document.getElementById('UnderTextBox').classList.remove('flex');
		    document.getElementById('UnderTextBox').classList.add('hidden');
		    document.getElementById('underBattleBtn').classList.remove('hidden');
		    document.getElementById('underBattleBtn').classList.add('flex');
		    // 캐릭터 상태 다시 불러오기
		    if(firstBattle){
		    	await getCharacterStatus();	
		    	getMapImgPath();
		    }
		    if(!firstBattle)stageNum = stageNum + 1;
		    firstBattle = false;
			if(stageNum  % 5 == 0){
				getMapImgPath();
			}
            let updateStageNum = `
            	<div id="stageDisplay" class="fixed top-4 right-4 bg-gray-700 text-white text-sm font-bold py-2 px-4 rounded-lg shadow-md z-50">
                	Stage: <span id="stageNum">\${stageNum}</span>
            	</div>	
            `;
            $('#stageDisplay').empty().append(updateStageNum);
			 // 적 상태 다시 불러오기
		    await getEnemyStatus();
		    // 캐릭터와 적 이미지 표시 및 애니메이션 초기화
 		     loadImages('character','hero');
		     const heroImg = document.getElementById("heroImg");
		     const heroStatus = document.getElementById("characterInfo");
		     const enemyImg = document.getElementById("enemyImg");
		     const enemyStatus = document.getElementById("enemyInfo");
		
		    // 캐릭터 초기화
		    heroImg.classList.remove("hidden");
		    heroImg.classList.add("-translate-x-full"); // 초기 위치 왼쪽
		    heroStatus.classList.remove("hidden");
		    heroStatus.classList.add("-translate-x-full");
		    // 적 초기화
		    enemyImg.classList.remove("hidden");
		    enemyImg.classList.add("translate-x-full"); // 초기 위치 오른쪽
		    enemyStatus.classList.remove("hidden");
		    enemyStatus.classList.add("translate-x-full");

		    // 애니메이션 실행
		    setTimeout(() => {
		        heroImg.classList.remove("-translate-x-full");
		        heroImg.classList.add("translate-x-0", "transition-transform", "duration-500", "ease-out");
		        heroStatus.classList.remove("-translate-x-full");
			    heroStatus.classList.add("translate-x-0", "transition-transform", "duration-500", "ease-out");
		        enemyImg.classList.remove("translate-x-full");
		        enemyImg.classList.add("translate-x-0", "transition-transform", "duration-500", "ease-out");
			    enemyStatus.classList.remove("translate-x-full");
		        enemyStatus.classList.add("translate-x-0", "transition-transform", "duration-500", "ease-out");
		    }, 10); // 딜레이 후 애니메이션 실행
		}; 
		const finishBattleBtnClick = function () {
			if((stageNum + 1) % 5 === 0)showBlackScreen(1000);
			$('#battleTextBox').empty();
		    const heroImg = document.getElementById("heroImg");
		    const heroStatus = document.getElementById("characterInfo");
		    const enemyImg = document.getElementById("enemyImg");
		    const enemyStatus = document.getElementById("enemyInfo");

		    // 캐릭터와 HP 바, 이름이 함께 이동
		    heroImg.classList.remove("translate-x-0");
		    heroImg.classList.add("transition-transform", "duration-500", "ease-out", "-translate-x-full");
			
		    heroStatus.classList.remove("translate-x-0");
		    heroStatus.classList.add("transition-transform", "duration-500", "ease-out", "-translate-x-full");

		    // 적 정보와 이미지는 숨기기만 처리
		    enemyImg.classList.add("hidden");
		    enemyStatus.classList.add("hidden");
		    // 애니메이션 후 숨기기
		    setTimeout(() => {
		        heroImg.classList.add("hidden");
		        heroStatus.classList.add("hidden");
		    }, 500); // 애니메이션 시간 (500ms)

		    // 버튼 상태 전환
		    document.getElementById('UnderTextBox').classList.remove('hidden');
		    document.getElementById('UnderTextBox').classList.add('flex');
		    document.getElementById('underBattleBtn').classList.remove('flex');
		    document.getElementById('underBattleBtn').classList.add('hidden');
		};

		//======랜덤숫자======
		const randomNum = (max, min) => {
	    	return Math.floor(Math.random() * (max - min + 1) + min);
		};
		//=== 캐릭터 스탯 불러오기 ===
		const getCharacterStatus = function () {
		   return $.ajax({
			        url: "/usr/character/getCharacter",
			        type: "GET",
			        data: { memberId: ${rq.getLoginedMemberId() } },
			        dataType: "json",
			        success: function (data) {
						id = data[0].id;
						characterName = data[0].characterName;
						memberId = data[0].memberId;
						characterHp = data[0].characterHp;
						characterAttackPower = data[0].characterAttackPower;
						characterBerrior = data[0].characterBerrior;
						stageNum = data[0].stageNum;
			            let content = `
			                <div id="heroStatus" class="relative w-full flex flex-col items-center justify-center space-y-2">
			                    <!-- 캐릭터 이름 -->
			                    <div class="text-center font-bold text-lg text-black">\${data[0].characterName}</div>
			                    
			                    <!-- HP Bar -->
			                    <div class="relative w-36 h-3 bg-gray-300 rounded-full">
			                        <div id="characterHPBar" class="h-full bg-green-500 rounded-full transition-all duration-300 ease-out"
			                            style="width: \${data[0].characterHp}%;"></div>
			                    </div>
			                </div>
			            `;
	
			            // 기존 캐릭터 정보 제거 후 새로 추가
			            $('#characterInfo').empty().append(content);
			        },
			        error: function (xhr, status, error) {
			            console.error(error);
			        }
			    });
		}; 
		
		//=============== 적군 생성  ===============
		const getEnemyStatus = function () {
		   return $.ajax({
			        url: "/usr/enemy/getEnemy",
			        type: "GET",
			        data: { stageNum: stageNum }, // Id 값 전달
			        dataType: "json",
			        success: function (data) {
			        	const i = randomNum(data.length -1,0);
						enemyId = data[i].id;
						enemyName = data[i].enemyName;
						loadImages(enemyName,'enemy');
						enemyHp = data[i].enemyHp;
						enemyAttackPower = data[i].enemyAttackPower;
						enemyBerrior = data[i].enemyBerrior;
						enemyType = data[i].enemyType;
						enemyWeakAttr = data[i].weakAttr;
						enemyStrongAttr = data[i].strongAttr;
			            let content = `
			                <div id="enemyStatus" class="relative w-full flex flex-col items-center justify-center space-y-2">
			                    <!-- 적 이름 -->
			                    
			                    <div class="text-center text-white font-bold text-lg text-black"><img src="/usr/imgFile/getImgPath?imgName=\${data[i].weakAttr}" class="w-14 h-14 inline"> \${data[i].enemyName}</div>
			                    
			                    <!-- HP Bar -->
			                    <div class="relative w-36 h-3 bg-gray-300 rounded-full">
			                        <div id="enemyHPBar" class="h-full bg-red-500 rounded-full transition-all duration-300 ease-out" style="width: \${data[0].enemyHp}%;"></div>
			                    </div>
			                </div>
			            `;
	
					    isAttack = false;
			            // 기존 적 정보 제거 후 새로 추가
			            $('#enemyInfo').empty().append(content);
			        },
			        error: function (xhr, status, error) {
			            console.error(error);
			        }
			    });  
		}; 
		const updateHPBars = () => {
			// HP 비율 계산 (max 100%)
			const heroHPPercentage = Math.max(0, Math.min(characterHp, 100)); // 0~100% 제한
			const enemyHPPercentage = Math.max(0, Math.min(enemyHp, 100));
			
			// HP 바 업데이트
			const characterHPBar = document.getElementById("characterHPBar");
			const enemyHPBar = document.getElementById("enemyHPBar");
			
			// 체력에 따라 너비 조정
			characterHPBar.style.width = `${heroHPPercentage}%`;
			enemyHPBar.style.width = `${enemyHPPercentage}%`;

		};
		const enemyAttack = async function(){
			await getEnemyPattern();
			let content;
			let hpBar;
			let damage = enemyAttackPower - characterBerrior;
			await addCharacterStatusAndItem()
			.then((response) => {
				for(let i = 0; i < response.length; i++){
					if(response[i].type != null && response[i].type != 'rightHand'){
						damage = damage - response[i].def;
					}
				}		
			});
			if(damage < 0){
				damage = 1;
			}
			characterHp = characterHp - damage;
			if(characterHp <= 0){
				content = `
	                <div id="ballteTextBox" class="w-1/2 h-1/2 bg-gray text-white text-lg font-medium flex items-center justify-center">
						<div>\${characterName}이(가) \${damage} 만큼의 데미지를 입어 HP가 0이되었습니다.</div> 	                    
	                </div>
            `;
           		 hpBar = `
           			<div class="relative w-36 h-3 bg-gray-300 rounded-full">
                		<div id="characterHPBar" class="h-full bg-green-500 rounded-full transition-all duration-300 ease-out" style="width: 0%;"></div>
             	</div>
             `;
				await dieAnimation('hero');
				$('#characterHPBar').empty().append(hpBar);
	            $('#battleTextBox').empty().append(content);
	            dieCharacter();
			}else if(characterHp >= 0){
				updateHPBars();
				attackAnimation('enemy');
				shake('hero');
            	content = `
                	<div id="ballteTextBox" class="w-1/2 h-1/2 bg-gray text-white text-lg font-medium flex items-center justify-center">
						<div>\${enemyName}가 \${characterName}에게 \${randomAttack}의 공격을 사용하여 \${damage} 만큼의 데미지를 입혔습니다.</div> 	                    
               		</div>
            	`;
            	hpBar = `
            		<div class="relative w-36 h-3 bg-gray-300 rounded-full">
                   		<div id="characterHPBar" class="h-full bg-green-500 rounded-full transition-all duration-300 ease-out" style="width: \${characterHp}%;"></div>
                	</div>
             `;
            //텍스트박스 업데이트
            $('#characterHPBar').empty().append(hpBar);
            $('#battleTextBox').empty().append(content);
			isAttack = false;
			}
		};
		// === 캐릭터공격 스크립트 ====
 		const attack = async function (attackAttr) {
			if(isAttack) return;
			let damage = 0;
			isAttack = true;
			let content;
			let hpBar;
        	 if(enemyHp <= 0){return;}
        		damage = characterAttackPower - enemyBerrior;
        		if(attackAttr == enemyWeakAttr){
        			damage = damage + (damage * 0.2);
        		}else if(attackAttr == enemyStrongAttr){
        			damage = damage - (damage * 0.2);
        		}
        		if(damage < 1){
        			damage = 1;
        		}
        		await addCharacterStatusAndItem()
    			.then((response) => {
    				for(let i = 0; i < response.length; i++){
    					if(response[i].type != null && response[i].type == 'rightHand'){
    						damage = damage + response[i].attack;
    					}
    				}		
    			});
				
	        	enemyHp = enemyHp - damage;
	        		if(enemyHp <= 0){
	        			attackAnimation('hero');
	        			await itemDrop();
	        			await insertGold()
	        			content = `
			                <div id="ballteTextBox" class="w-1/2 h-1/2 bg-gray text-white text-lg font-medium flex items-center justify-center">
								<div>\${enemyName}이(가) \${damage}만큼의 데미지를 입어 HP가 0이되었습니다.  \${dropedItem}을 획득했습니다.</div> 	                    
			                </div>
			            `;
			            hpBar = `
								<div class="relative w-36 h-3 bg-gray-300 rounded-full">
									<div id="enemyHPBar" class="h-full bg-red-500 rounded-full transition-all duration-300 ease-out" style="width: 0%;"></div>
								</div>
	               				 `;
			            
			            //적 죽는 애니메이션 텍스트박스 업데이트
							await getDropItem();
							dieAnimation('enemy');
				            showGold();
				            finishSkillAttack();
							$('#enemyHPBar').empty().append(hpBar);
				            $('#battleTextBox').empty().append(content);
	        		}else{
		        		attackAnimation('hero');
		        		shake('enemy');
		        		updateHPBars();
		            	content = `
		                <div id="ballteTextBox" class="w-1/2 h-1/2 bg-gray text-white text-lg font-medium flex items-center justify-center">
							<div>\${characterName}가 \${enemyName}에게 \${damage} 만큼의 데미지를 입혔습니다.</div> 	                    
		                </div>
		            	`;
		            	hpBar = `
								<div class="relative w-36 h-3 bg-gray-300 rounded-full">
									<div id="enemyHPBar" class="h-full bg-red-500 rounded-full transition-all duration-300 ease-out" style="width: \${enemyHp}%;"></div>
								</div>
	               				 `;
		            //텍스트박스 업데이트
			            finishSkillAttack();   
			            $('#battleTextBox').empty().append(content);
			            $('#enemyHPBar').empty().append(hpBar);
		       	 }
	        		// 캐릭터 공격 후 상대 공격 기다리는 시간
        			if(enemyHp > 0){
		        		setTimeout(() => {
	        				enemyAttack();	
			            }, 1000);
        			}
		}; 
		
		const addCharacterStatusAndItem = () => {
			return $.ajax({
			        url: "/usr/item/addCharacterStatusAndItem",
			        type: "GET",
			        data: {	
			        	characterId: ${rq.getLoginedMemberId()},
					}
			    });
		}
		
		const showMySkills = () => {
        	document.getElementById('itemPopUp').classList.add('hidden');
			document.getElementById('overlay').classList.add('hidden');
	 		return $.ajax({
			        url: "/usr/skill/showMySkills",
			        type: "GET",
			        data: {	
			        	id: ${rq.getLoginedMemberId()},
					}
			    });
		}	
			

		function characterSkillAttack() {
		    document.getElementById('underBattleBtn').classList.add('hidden');
		    document.getElementById('underBattleBtn').classList.remove('flex');
		    document.getElementById('underAttackBtn').classList.remove('hidden');
		    document.getElementById('underAttackBtn').classList.add('flex');

		    showMySkills()
		    .then((response) => {
		        let content = `
		            <div id="underAttackBtn"
		                class="fixed bottom-0 left-0 w-full h-1/5 bg-gray-800 flex flex-wrap">
		        `;
		        for (let i = 0; i < 3; i++) {
		            if (response.data && response.data[i]) {
		                content += `
		                    <button id="skill${i + 1}"
		                        class="w-1/2 h-1/2 bg-gray text-white text-lg font-medium flex items-center justify-center gap-2 hover:bg-gray-200 hover:text-black"
		                        onclick="attack('\${response.data[i].skillAttr}');">
		                        <img src="/usr/imgFile/getImgPath?imgName=\${response.data[i].skillEffectName}" 
		                            class="h-8 w-8 object-contain -mt-6"> 
		                        <div class="text-left">
		                            <span class="font-bold">\${response.data[i].skillName}</span><br />
		                            <span class="text-sm">\${response.data[i].skillInfo}</span>
		                        </div>
		                    </button>
		                `;
		            } else {
		                content += `
		                    <button id="skill${i + 1}"
		                        class="w-1/2 h-1/2 bg-gray text-white text-lg font-medium flex items-center justify-center hover:bg-gray-200 hover:text-black">
		                        스킬이 없습니다.
		                    </button>
		                `;
		            }
		        }
		        content += `
		            <button id="back"
		                class="w-1/2 h-1/2 bg-gray text-white text-lg font-medium flex items-center justify-center gap-2 hover:bg-gray-200 hover:text-black"
		                onclick="finishSkillAttack()">
		                <i class="fa-solid fa-rotate-left"></i>
		                <span>돌아가기</span>
		            </button>
		        `;
		        content += `</div>`;
		        $('#underAttackBtn').empty().append(content);
		    })
		}
		
		function finishSkillAttack(){
		    document.getElementById('underAttackBtn').classList.add('hidden');
		    document.getElementById('underAttackBtn').classList.remove('flex');
			document.getElementById('underBattleBtn').classList.remove('hidden');
		    document.getElementById('underBattleBtn').classList.add('flex');
		}	
			
		function itemDrop(){
			return $.ajax({
				        url: "/usr/item/itemDrop",
				        type: "GET",
				        data: { enemyType : enemyType }, 
				        dataType: "json",
				        success: function (data) {
				        	const random = randomNum(data.length,1);
				        	if(random === 1){
				        		dropedItem = data[0].itemName;
				        		dropedItemId = data[0].id; 
				        	}else if(random === 2){
				        		dropedItem = data[1].itemName;
				        		dropedItemId = data[1].id;
				        	}else if(random === 3){
				        		dropedItem = data[2].itemName;
				        		dropedItemId = data[2].id;
				        	}else{
				        		dropedItemId = '드롭된 아이템이 없습니다.';
				        	}
				        },
				        error: function (xhr, status, error) {
				            console.error(error);
				        }
				    }); 
		}
		
		function getDropItem() {
			return $.ajax({
		        url: "/usr/item/itemInsertToCharacter",
		        type: "GET",
		        data: { 
		        	characterId : id,
		        	itemId : dropedItemId	
		        }
		    }); 
		}
		
		function closedCrateMenu() {
			craftSubmenu.classList.add('hidden');
		}
		
		function showEquippedItemsByCharacterId() {
			$.ajax({
				url: "/usr/item/showEquippedItemsByCharacterId",
				type: 'GET',
				data: { characterId: ${rq.getLoginedMemberId() },
				},
				success: function(data) {
					for(let i = 0; i < data.length; i ++){
						if(data[i] != null){
					        const content = `
	                            <img src="/usr/imgFile/getImgPath?imgName=\${data[i].itemName}" alt="Image" class="w-full h-full object-cover">
					        `;
					        $('#'+data[i].type).empty().append(content);
						}   
					}
				},
				error: function(xhr, status, error) {
					console.error(error);
				}
			});
		} 
		
		function insertItemToCharacterEquip(id,itemId,itemType) {
			let isTrue = confirm("이미 장착중인 아이템이 있다면 기존 아이템은 삭제됩니다. 아이템을 장착 하시겠습니까?");
			if(isTrue){
				$.ajax({
					url: "/usr/item/insertItemToCharacterEquip",
					type: 'GET',
					data: { characterId: ${rq.getLoginedMemberId() },
							itemId: itemId,
							id: id,
							itemType: itemType
					},
				});
				alert('아이템을 장착했습니다.');
				getItemsByCharacterId();
			}else {
				return;
			}
		}
		
		function useItem(id,itemId) {
			$.ajax({
				url: "/usr/item/useItem",
				type: 'GET',
				data: { characterId: ${rq.getLoginedMemberId() },
						itemId: itemId,
						id: id
				},
				dataType: 'json',
				success: function(data) {
					characterHp = characterHp + data;
					if(characterHp >= 100){
						characterHp = 100;
					}
					let HpBar = `
						<div class="relative w-36 h-3 bg-gray-300 rounded-full">
			            	<div id="characterHPBar" class="h-full bg-green-500 rounded-full transition-all duration-300 ease-out" style="width: \${characterHp}%;"></div>
			       		</div>
		            `;
		            // 기존 캐릭터 정보 제거 후 새로 추가
		             $('#characterHPBar').empty().append(HpBar);
					 getItemsByCharacterId();
					 alert("캐릭터의 Hp가 " + data + "만큼 회복되었습니다.");
				},
				error: function(xhr, status, error) {
					console.error(error);
				}
			});
			
		}
		
		function craftableItems() {
			settingSubmenu.classList.add('hidden');
			itemSubmenu.classList.add('hidden');
			craftSubmenu.classList.remove('hidden');
			equipItemSubMenu.classList.add('hidden');
			$('#craftSubmenu').empty();
			$.ajax({
				url: "/usr/item/craftableItems",
				type: 'GET',
				data: { characterId: ${rq.getLoginedMemberId() } }, 
				dataType: 'json',
				success: function(data) {
					if(data.length > 0){
						const content = `
							<button class="btn w-full mb-2">제작 가능한 아이템 목록</button>
				    	`;
					    $('#craftSubmenu').append(content);
					    for (let i = 0; i < data.length; i++) {
					        const content = `
					            <div class="flex items-center mb-2">
					                <!-- 첫 번째 버튼 -->
					                <button class="btn flex-1 w-full" onclick=""><img src="/usr/imgFile/getImgPath?imgName=\${data[i]}" class="h-full object-contain max-h-6"> \${data[i]}</button>
					                <!-- 제작 버튼 -->
					                <button class="btn ml-2 text-xs px-2 py-1 bg-black text-white rounded" onclick="craftItem('\${data[i]}')">제작</button>
					            </div>
					        `;
					        $('#craftSubmenu').append(content);
					    }
					}else{
						const content = `
							<button class="btn w-full mb-2">제작 가능한 아이템이 없습니다.</button>
				    	`;
				   		 $('#craftSubmenu').append(content);
					}
				},
				error: function(xhr, status, error) {
					console.error(error);
				}
			});
		}
		
		function craftItem(itemName){
			$.ajax({
				url: "/usr/item/craftItem",
				type: 'GET',
				data: { characterId: ${rq.getLoginedMemberId() },
						itemName: itemName
				}, 
				error: function(xhr, status, error) {
					console.error(error);
				}
			});
			alert(itemName +" 을 성공적으로 제작했습니다.");
			craftSubmenu.classList.add('hidden');
		}
		
		function getItemsByCharacterId(){
			settingSubmenu.classList.add('hidden');
			craftSubmenu.classList.add('hidden');
			itemSubmenu.classList.remove('hidden');
			equipItemSubMenu.classList.add('hidden');
			$.ajax({
					url: "/usr/item/getItemsByCharacterId",
					type: 'GET',
					data: { characterId: ${rq.getLoginedMemberId() } }, 
					dataType: 'json',
					success: function(data) {
						$('#itemSubmenu').empty();
						for (let i = 0; i < data.length; i++) {
						    if (data[i].itemId == 0) {
						        const content = `
						            <a class="btn w-full mb-2"><img src="/usr/imgFile/getImgPath?imgName=gold" class="h-full object-contain max-h-6"> 보유중인 골드: \${data[i].itemCount}</a>
						        `;
						        $('#itemSubmenu').append(content);                        						
						    } else {
						        // 장비 아이템
						        if (data[i].itemType == '장비 아이템' && data[i].type == 'rightHand') {
						            const content = `
						                <div class="relative group flex items-center mb-2">
						                    <!-- 메인 버튼 -->
						                    <button class="btn flex-1"><img src="/usr/imgFile/getImgPath?imgName=\${data[i].itemName}" class="h-full object-contain max-h-6"> \${data[i].itemName}: \${data[i].itemCount}개</button>
						                    <!-- 장착 버튼 -->
						                    <button class="btn ml-2 text-xs px-2 py-1 bg-black text-white rounded" onclick="insertItemToCharacterEquip(\${data[i].id}, \${data[i].itemId}, '\${data[i].type}')">장착</button>
						                    <!-- 팝업창 -->
						                    <div class="absolute hidden group-hover:block bottom-full left-1/2 transform -translate-x-1/2 mb-2 w-48 p-2 bg-gray-800 text-white text-sm rounded shadow-lg z-10">
						                        <p class="font-bold">아이템 설명</p>
						                        <p>장착시 공격력이 \${data[i].attack}만큼 증가합니다.</p>
						                    </div>
						                </div>
						            `;
						            $('#itemSubmenu').append(content);
						        } else if(data[i].itemType == '장비 아이템' && data[i].type != 'rightHand'){
						            const content = `
						                <div class="relative group flex items-center mb-2">
						                    <!-- 메인 버튼 -->
						                    <button class="btn flex-1"><img src="/usr/imgFile/getImgPath?imgName=\${data[i].itemName}" class="h-full object-contain max-h-6"> \${data[i].itemName}: \${data[i].itemCount}개</button>
						                    <!-- 장착 버튼 -->
						                    <button class="btn ml-2 text-xs px-2 py-1 bg-black text-white rounded" onclick="insertItemToCharacterEquip(\${data[i].id},\${data[i].itemId},'\${data[i].type}')">장착</button>
						                    <!-- 팝업창 -->
						                    <div class="absolute hidden group-hover:block bottom-full left-1/2 transform -translate-x-1/2 mb-2 w-48 p-2 bg-gray-800 text-white text-sm rounded shadow-lg z-10">
						                        <p class="font-bold">아이템 설명</p>
						                        <p>장착시 방어력이 \${data[i].def}만큼 증가합니다.</p>
						                    </div>
						                </div>
						            `;
						            $('#itemSubmenu').append(content);
						        }
						        // 소비 아이템
						        else if (data[i].itemType == '소비 아이템') {
						            const content = `
						                <div class="relative group flex items-center mb-2">
						                    <button class="btn flex-1"><img src="/usr/imgFile/getImgPath?imgName=\${data[i].itemName}" class="h-full object-contain max-h-6"> \${data[i].itemName}: \${data[i].itemCount}개</button>
						                    <button class="btn ml-2 text-xs px-2 py-1 bg-black text-white rounded" onclick="useItem(\${data[i].id},\${data[i].itemId})">사용</button>
						                    <!-- 팝업창 -->
						                    <div class="absolute hidden group-hover:block bottom-full left-1/2 transform -translate-x-1/2 mb-2 w-48 p-2 bg-gray-800 text-white text-sm rounded shadow-lg z-10">
						                        <p class="font-bold">아이템 설명</p>
						                        <p>사용시 HP를 \${data[i].hp}만큼 회복 합니다.</p>
						                    </div>
						                </div>
						            `;
						            $('#itemSubmenu').append(content);
						        } 
						        // 일반 아이템
						        else {
						            const content = `
						                <button class="btn w-full mb-2"><img src="/usr/imgFile/getImgPath?imgName=\${data[i].itemName}" class="h-full object-contain max-h-6"> \${data[i].itemName}: \${data[i].itemCount}개</button>
						            `;
						            $('#itemSubmenu').append(content);
						        }
						    }
						}
					},
					error: function(xhr, status, error) {
						console.error(error);
					}
				});
		}
		
        //데미지 입는 애니메이션
		function shake(name) {
		    let enemyImg;
		    if (name === 'enemy') {
		        enemyImg = document.getElementById("enemyImg");
		    } else if (name === 'hero') { 
		        enemyImg = document.getElementById("heroImg");
		    }
		
		    enemyImg.classList.add("shake");
		
		    // 0.1초 후 클래스 제거
		    setTimeout(() => {
		        enemyImg.classList.remove("shake");
		    }, 1000);
		}

	    
	    //죽는 애니메이션
	    const dieAnimation = (name) => {
	    	$('#enemyImg').empty();
	        let img; 
			if(name === 'enemy'){
				img = document.getElementById("enemyImg");
			}else if(name === 'hero'){
				img = document.getElementById("heroImg");
			}
	        // 적 이미지가 위로 사라지는 애니메이션
	        img.classList.add("translate-y-[-30px]", "transition-transform", "duration-500", "ease-out");

	        setTimeout(() => {
	        	img.classList.remove("translate-y-[-30px]");
	        	img.classList.add("hidden"); // 애니메이션 후 숨김 처리
	           if(name ==='enemy'){
	        	   $('#enemyInfo').empty(); // 적 정보 삭제
	           }
	        }, 500); // 애니메이션 시간 (500ms)
	        
	    };
	    
	    //공격하는 애니메이션
	    const attackAnimation = function(name){
	    	let img 
	    	if(name === 'enemy'){
	    		img = document.getElementById("enemyImg");
	    	}else if(name === 'hero'){
	    		img = document.getElementById("heroImg");
	    	}
	    	img.classList.add("translate-y-[-30px]", "transition-transform", "duration-500", "ease-out");

	        // 500ms 후 제자리로 복귀
	        setTimeout(() => {
	        	img.classList.remove("translate-y-[-30px]");
	        	img.classList.add("translate-y-[0]"); // 제자리로 돌아오는 애니메이션

	            // 500ms 후 다시 원래 상태로 복구
	            setTimeout(() => {
	            	img.classList.remove("translate-y-[0]");
	            }, 50);
	        }, 50);
		
	    }
	    
	    const getEnemyPattern = async function(){
	    	const random = randomNum(4,1);
		    await $.ajax({
					url: "/usr/enemy/getEnemyAttack",
					type: 'GET',
					data: { enemyType: enemyType }, 
					dataType: 'json',
					success: function(data) {
						if(random === 1){
							randomAttack = data[0].firstAttack
						}else if(random === 2){
							randomAttack = data[0].secondAttack
						}else if(random === 3){
							randomAttack = data[0].thirdAttack
						}else if(random === 4){
							randomAttack = data[0].defaultAttack
						}
					},
					error: function(xhr, status, error) {
						console.error(error);
					}
				});
	    }

		const finishGame = function(){
			$.ajax({
				url: "/usr/character/updateCharacterStatus",
				type: 'GET',
				data: { 
					id: id,
					characterName : characterName,
					memberId : memberId,
					characterHp : characterHp,
					characterAttackPower : characterAttackPower,
					characterBerrior : characterBerrior,
					stageNum : stageNum
				}, 
			});
			alert("데이터가 저장되었습니다.");
		};
		
		const dieCharacter = function(){
			alert("로비로 돌아갑니다.")
			finishGame();
			window.location.href = "/usr/home/main";
		}
			 

</script>
<!-- 검은색 패널 -->
<div id="black" class="hidden fixed inset-0 bg-black bg-opacity-100 z-30"></div>
<div class="w-full h-4/5 top-0 absolute">
	<img id="map" src="" class="w-full h-full" />
</div>
<div id="stageDisplay" class="fixed top-4 right-4 bg-gray-700 text-white text-sm font-bold py-2 px-4 rounded-lg shadow-md z-50">
    Stage: <span id="stageNum"></span>
</div>
<section class="container">
	<div id="ourZone" class="fixed">
		<div id="characterInfo" class="relative"></div>
		<img id="heroImg" src=""class="hidden ">
	</div>
	<div id="enemyZone" class="fixed right-20 bottom-40">
		<div id="enemyInfo" class="relative"></div>
		<img id="enemyImg" src="" class="hidden">
	</div>
</section>
<!--   		====하단 버튼 4개 ==== -->
<div id="underAttackBtn"
	class="fixed bottom-0 left-0 w-full h-1/5 bg-gray-800 hidden flex-wrap">
	<!-- 상단 버튼 두 개 -->
	<button id="skill1"
		class="w-1/2 h-1/2 bg-gray text-white text-lg font-medium flex items-center justify-center hover:bg-gray-200 hover:text-black"
		onclick=""><img src="" class="h-full object-contain max-h-6"> 스킬1</button>
	<button id="skill2" class=" w-1/2 h-1/2 bg-gray text-white text-lg font-medium flex items-center justify-center hover:bg-gray-200 hover:text-black" >스킬2</button>
	<!-- 하단 버튼 두 개 -->
	<button id="skill3" class="w-1/2 h-1/2 bg-gray text-white text-lg font-medium flex items-center justify-center hover:bg-gray-200 hover:text-black" onclick="" >스킬3</button>
	<button id="back" class="w-1/2 h-1/2 bg-gray text-white text-lg font-medium flex items-center justify-center cursor-default hover:bg-gray-200 hover:text-black" onclick="finishSkillAttack()"><i class="fa-solid fa-rotate-left"></i>돌아가기</button>
</div>
<div id="underBattleBtn"
	class="fixed bottom-0 left-0 w-full h-1/5 bg-gray-800 hidden flex-wrap">
	<!-- 상단 버튼 두 개 -->
	<button id="attackBtn"
		class="w-1/2 h-1/2 bg-gray text-white text-lg font-medium flex items-center justify-center hover:bg-gray-200 hover:text-black"
		onclick="attack();"><i class="fa-solid fa-gavel"></i>공격하기</button>
	<button id="battleTextBox" class="w-1/2 h-1/2 bg-gray text-white text-lg font-medium flex items-center justify-center cursor-default">필드 텍스트</button>
	<!-- 하단 버튼 두 개 -->
	<button id="next" class="w-1/2 h-1/2 bg-gray text-white text-lg font-medium flex items-center justify-center hover:bg-gray-200 hover:text-black" onclick="characterSkillAttack()">스킬</button>
	<button id="back" class=" w-1/2 h-1/2 bg-gray text-white text-lg font-medium flex items-center justify-center hover:bg-gray-200 hover:text-black"><i class="fa-solid fa-rotate-left"></i>돌아가기</button>
</div>
<!--     		=====하단 텍스트 박스 ===== -->
<div id="UnderTextBox" class="fixed bottom-0 left-0 w-full h-1/5 bg-gray-800 flex flex-wrap">
	<button	class="w-1/2 h-full bg-gray text-white text-lg font-medium flex items-center justify-center hover:bg-gray-200 hover:text-black"	onclick="startBattleBtnClick();"><i class="fa-solid fa-play mr-2"></i>게임 시작</button>
	<a href="../home/main" onclick="return finishGame()" class="w-1/2 h-full bg-gray text-white text-lg font-medium flex items-center justify-center hover:bg-gray-200 hover:text-black"><i class="fa-solid fa-house mr-2"></i>메인페이지</a>
</div>
<!--     ===토글 사이드바=== -->
<button id="toggleMenuBtn" class="fixed top-4 left-4 bg-blue-500 text-white py-2 px-4 rounded-lg hover:bg-blue-600"><i class="fa-solid fa-bars mr-1"></i>메뉴 열기</button>

<!-- 오버레이 -->
<div id="overlay"
	class="hidden fixed inset-0 bg-black bg-opacity-50 z-20"></div>
<div id="itemPopUpOverlay"
	class="hidden fixed inset-0 bg-black bg-opacity-50 z-20"></div>
<!-- 사이드바 -->
<div id="sidebar"
	class="fixed top-0 left-0 w-64 h-full bg-gray-800 text-white transform -translate-x-full transition-transform duration-1000 z-30">
	<div class="p-4 flex justify-between items-center">
		<h2 class="text-lg font-bold">메뉴</h2>
		<button id="closeMenuBtn" class="text-gray-400 hover:text-white">
			닫기</button>
	</div>
	<ul class="mt-4">
		<li class="p-2 settingMenu">
			<button id="settingPopUpBtn" class="btn w-full text-black whitespace-nowrap hover:text-gray-200" onclick="settingSubmenuOpen()"><i class="fa-solid fa-gear"></i>설정</button>
		</li>
		<li class="p-2 itemMenu">
			<button id="itemPopUpBtn" class="btn w-full text-black whitespace-nowrap hover:text-gray-200" onclick="getItemsByCharacterId()"><i class="fa-solid fa-suitcase"></i>인벤토리</button>
		</li>
		<li class="p-2 craftItemMenu">
			<button id="craftItemPopUpBtn" class="btn w-full text-black whitespace-nowrap hover:text-gray-200" onclick="craftableItems()"><i class="fa-solid fa-hammer"></i>아이템 제작</button>
		</li>
		<li class="p-2 epuipItemMenu">
			<button id="epuipItemMenuPopUpBtn" class="btn w-full text-black whitespace-nowrap hover:text-gray-200" onclick="equipItemSubMenuOpen()"><i class="fa-solid fa-vest-patches"></i>장착 아이템</button>
		</li>
		<li class="p-2 menuBtn"><a href="../home/main" onclick="return finishGame()" class="btn w-full text-black whitespace-nowrap hover:text-gray-200"><i class="fa-solid fa-house"></i>메인페이지</a>
		</li>
		
	</ul>
</div>

<!-- 2차 메뉴 -->
<div id="itemSubmenu" class="hidden fixed top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2 w-72 h-72 bg-white shadow-lg border border-gray-300 z-40 overflow-auto">
	<!-- 비어 있는 2차 메뉴 -->
</div>
<div id="craftSubmenu" class="hidden fixed top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2 w-72 h-72 bg-white shadow-lg border border-gray-300 z-40 overflow-auto">
</div>
<div id="settingSubmenu"
	class="hidden fixed top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2 w-72 h-72 bg-white shadow-lg border border-gray-300 z-40 overflow-auto">
	<!-- 비어 있는 2차 메뉴 -->
</div>

<div id="equipItemSubMenu"
    class="hidden fixed top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2 w-72 h-72 bg-white shadow-lg border border-gray-300 z-40 flex items-center justify-center">
    <!-- 십자가 네모칸 -->
    <div class="relative w-full h-full">
        <!-- 네모칸 예시 (반복 구조) -->
        <!-- 상단 네모칸 -->
        <div id="head" class="absolute top-0 left-1/2 transform -translate-x-1/2 w-16 h-16 bg-gray-300 flex items-center justify-center">
            <span class="text-gray-500" id="top-box-text">머리</span>
        </div>
        
        <!-- 중앙 네모칸 -->
        <div id="body"  class="absolute top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2 w-16 h-16 bg-gray-300 flex items-center justify-center">
            <span class="text-gray-500" id="center-box-text">옷</span>
        </div>

        <!-- 왼쪽 네모칸 -->
        <div id="leftHand"  class="absolute top-1/2 left-0 transform -translate-y-1/2 w-16 h-16 flex bg-gray-300  items-center justify-center">
            <span class="text-gray-500" id="left-box-text">방패</span>
        </div>

        <!-- 오른쪽 네모칸 -->
        <div id="rightHand"  class="absolute top-1/2 right-0 transform -translate-y-1/2 w-16 h-16 bg-gray-300  flex items-center justify-center">
            <span class="text-gray-500" id="right-box-text">무기</span>
        </div>

        <!-- 하단 네모칸 -->
        <div id="foot"  class="absolute bottom-0 left-1/2 transform -translate-x-1/2 w-16 h-16 bg-gray-300 flex items-center justify-center">
            <span class="text-gray-500" id="bottom-box-text">신발</span>
        </div>
    </div>
</div>
<div id="overlay" class="hidden fixed inset-0 bg-black bg-opacity-50 z-30"></div>

    <!-- 아이템팝업 -->
<div id="itemPopUp" class="hidden fixed top-1/3 left-1/2 transform -translate-x-1/2 -translate-y-1/2 w-full h-96 bg-gray-800 bg-opacity-50 shadow-lg border rounded border-gray-300 z-40 p-4 flex items-center justify-around space-x-4">
    <div class="absolute top-2 right-16 text-white text-lg font-bold">
        Gold: <span id="goldAmount"></span>
    </div>
    <!-- 버튼 1 -->
    <div class="flex flex-col items-center space-y-2">
        <!-- 버튼 위 텍스트 -->
        <div class="text-white text-sm">포션 30%</div>
        <button id="potion30" class="popup-btn w-32 h-32 rounded-lg flex items-center justify-center hover:bg-green-100">
            <img src="/usr/imgFile/getImgPath?imgName=potion30" class="w-24 h-24">
        </button>
        <!-- 버튼 아래 텍스트 -->
        <div class="text-white text-sm">사용 시 체력 30% 회복</div>
        <div class="text-white text-sm">30 Gold</div>
    </div>

    <!-- 버튼 2 -->
    <div class="flex flex-col items-center space-y-2">
        <!-- 버튼 위 텍스트 -->
        <div class="text-white text-sm">포션 50%</div>
        <button id="potion50"  class="popup-btn w-32 h-32 rounded-lg flex items-center justify-center hover:bg-green-100">
            <img src="/usr/imgFile/getImgPath?imgName=potion50" class="w-28 h-36">
        </button>
        <!-- 버튼 아래 텍스트 -->
        <div class="text-white text-sm">사용 시 체력 50% 회복</div>
        <div class="text-white text-sm">50 Gold</div>
    </div>

    <!-- 버튼 3 -->
    <div class="flex flex-col items-center space-y-2">
        <!-- 버튼 위 텍스트 -->
        <div class="text-white text-sm">포션 100%</div>
        <button id="potion100"  class="popup-btn w-32 h-32 rounded-lg flex items-center justify-center hover:bg-green-100">
            <img src="/usr/imgFile/getImgPath?imgName=potion100" class="w-24 h-28">
        </button>
        <!-- 버튼 아래 텍스트 -->
        <div class="text-white text-sm">사용 시 체력 100% 회복</div>
        <div class="text-white text-sm">100 Gold</div>
    </div>
  <!-- 버튼 4 -->
    <div id="skillItem" class="flex flex-col items-center space-y-2 hidden">
<!--         버튼 위 텍스트 -->
        <div class="text-white text-sm inline-block">속성 : <img src="/usr/imgFile/getImgPath?imgName=fire" class="w-6 h-8 inline-block"></div>
        <button id="skill"  class="popup-btn w-32 h-32 rounded-lg flex items-center justify-center hover:bg-green-100">
            <img src="/usr/imgFile/getImgPath?imgName=fireSword" class="w-24 h-28">
        </button>
<!--         버튼 아래 텍스트 -->
        <div class="text-white text-sm">plant 타입의 몬스터에게 20%의 추가 데미지를 줍니다.</div>
        <div class="text-white text-sm">100 Gold</div>
    </div>
</div>

<div id="skillChangePopUp" class="hidden fixed top-1/3 left-1/2 transform -translate-x-1/2 -translate-y-1/2 w-full h-96 bg-gray-800 bg-opacity-50 shadow-lg border rounded border-gray-300 z-40 p-4 flex items-center justify-around space-x-4">
</div>
<%@ include file="../../common/footer.jsp"%>