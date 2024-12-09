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

</style>
<script>
		let j = 0; // 아이템 로드? 나중에 다시 확인
		let currentIndex = 0; // 현재 선택된 요소의 인덱스
		let items = [];
		$(document).ready(function() {
			var hero = document.getElementById("hero");
			items = $("#items div").toArray();
			if (items.length > 0) {
				$(items[currentIndex]).css("background-color", "pink");
			}
		});
	
//=======================키보드 이벤트 처리=========================
		document.addEventListener('keydown', (event) => {
			$(items[currentIndex]).css("background-color", "");
			switch (event.key) {
				case 'ArrowUp':    // 위쪽 방향키
				currentIndex = (currentIndex - 2 + items.length) % items.length;
				break;
				case 'ArrowDown':  // 아래쪽 방향키
				currentIndex = (currentIndex + 2) % items.length;
				break;
				case 'ArrowLeft':  // 왼쪽 방향키
				currentIndex = (currentIndex - 1) % items.length;
				break;
				case 'ArrowRight': // 오른쪽 방향키
				currentIndex = (currentIndex + 1) % items.length;
				break;
				default:
				return; // 다른 키는 무시
			}
			$(items[currentIndex]).css("background-color", "pink");
		});
		
// 		const getItemList = function(){
// 			if(j == 0){
// 				$.ajax({
// 					url: "/usr/item/getItems",
// 					type: 'GET',
// 					data: { id: 1 }, // id 값 전달
// 					dataType: 'json',
// 					success: function(data) {
// 						console.log(data);
// 						for (let t = 0; t < data.length; t++) {
// 							let content = `
// 							<div id="items" class="w-1/2 h-1/2 inline-block whitespace-nowrap">
// 								<div>\${data[t].itemName}</div>
// 							</div>
// 							`;
			        		
// 							$('#testContent').append(content);
// 							items = $("#items div").toArray();
// 							if (items.length > 0) {
// 								$(items[currentIndex]).css("background-color", "pink");
// 							}
// 						}
	
// 					},
// 					error: function(xhr, status, error) {
// 						console.error(error);
// 					}
// 				});
// 			}
// 			j = 1;
// 		} 
		const testRemove = function(){
			$('#testContent div').remove();
			j = 0 ;
		}
//============ 토글 사이드바 ================= 
		document.addEventListener('DOMContentLoaded', () => {
			const sidebar = document.getElementById('sidebar');
			const submenu = document.getElementById('submenu');
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
				submenu.classList.add('hidden'); // 2차 메뉴 숨기기
				overlay.classList.add('hidden'); // 오버레이 숨기기
			};
			closeMenuBtn.addEventListener('click', closeSidebar);
			overlay.addEventListener('click', closeSidebar);
// 2차 메뉴 열기
			document.querySelectorAll('.btn').forEach((btn) => {
				btn.addEventListener('click', () => {
					submenu.classList.remove('hidden');
				});
			});

			function handlePotionClick(potionCost, hpIncrease) {
				console.log("전투 끝난 후 포션 선택");
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
			    console.log("텍스트 박스 및 HP 바 업데이트");
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
			console.log(randomGold + "전투 후 골드 획득");
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
		
	 	const itemPopUpOpen = () => {
	 		console.log("전투 후 포션창 보여주기");
	 		const itemPopUp = document.getElementById('itemPopUp');
	 		const overlay = document.getElementById('overlay');
	 		itemPopUp.classList.remove('hidden');
	 		itemPopUpOverlay.classList.remove('hidden');
	 	}
	 	
	 	const showGold = () => {
	 		console.log("전투 후 포션 팝업에서 보유중인 골드 보여주기");
	 		 $.ajax({
			        url: "/usr/item/showGold",
			        type: "GET",
			        data: { characterId: 1 },
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
			            return;
			        }
			    });
	 	}

       		
        let firstBattle = true;
        //이미지 로드
        const loadImages = (name,type) => {
        	console.log(3 + " 캐릭터,적군 이미지 불러오기 불러오기");
        	let img = $('#' + type +'Img');
        	img.attr("src", "/usr/imgFile/getImgPath?imgName=" + name);
        	if(type === 'enemy'){
        	img.css("width", "400px");
        	img.css("height", "400px");
        	}
        	console.log( "=============== 캐릭터,적군 이미지 불러오기 불러오기끝===============");
        };
//게임시작 버튼 누르면 하단 박스 바뀌는것
		const startBattleBtnClick = function () {
			console.log("게임 시작");
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
		    	getCharacterStatus();	
		    }
		    firstBattle = false;
		    // 적 상태 다시 불러오기
		    getEnemyStatus();
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
			    console.log("=======================================애니메이션 실행=====================");
		        enemyImg.classList.remove("translate-x-full");
		        enemyImg.classList.add("translate-x-0", "transition-transform", "duration-500", "ease-out");
			    enemyStatus.classList.remove("translate-x-full");
		        enemyStatus.classList.add("translate-x-0", "transition-transform", "duration-500", "ease-out");
		    }, 10); // 딜레이 후 애니메이션 실행
		}; 
		const finishBattleBtnClick = function () {
			console.log("적군 사망시 들어옴")
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
		    console.log("적 정보와 이미지 숨기기 처리");
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
		//=======캐릭터 정보 저장========
		let id;
		let characterName;
		let memberId;
		let characterHp;
		let characterAttackPower;
		let characterBerrior;	
		let a = 1;
		let enemyId;
		let enemyName;
		let enemyHp;
		let enemyAttackPower;
		let enemyBerrior;
		let enemyType;
		let randomAttack;
		let dropedItem;
		let cost;
		let isAttack = false;
		//======랜덤숫자======
		const randomNum = (max,min) => {
			return Math.floor(Math.random() * max + min);
		}
		//=== 캐릭터와 적 스탯 불러오기 ===
		const getCharacterStatus = function () {
			console.log(1 + " 캐릭터 스텟 불러오기");
		    $.ajax({
		        url: "/usr/character/getCharacter",
		        type: "GET",
		        data: { memberId: ${rq.getLoginedMemberId() } }, // memberId 값 전달
		        dataType: "json",
		        success: function (data) {
					id = data[0].id;
					characterName = data[0].characterName;
					memberId = data[0].memberId;
					characterHp = data[0].characterHp;
					characterAttackPower = data[0].characterAttackPower;
					characterBerrior = data[0].characterBerrior;
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
			console.log(2 + " 적군 스텟 불러오기");
			if (a > 5){
				a = 1;
			}
		    $.ajax({
		        url: "/usr/enemy/getEnemy",
		        type: "GET",
		        data: { id: a }, // Id 값 전달
		        dataType: "json",
		        success: function (data) {
					enemyId = data[0].id;
					enemyName = data[0].enemyName;
					loadImages(enemyName,'enemy');
	               	console.log("=======================지금 이미지 scr 적용 되었습니다 =============================")
					enemyHp = data[0].enemyHp;
					enemyAttackPower = data[0].enemyAttackPower;
					enemyBerrior = data[0].enemyBerrior;
					enemyType = data[0].enemyType;
		            let content = `
		                <div id="enemyStatus" class="relative w-full flex flex-col items-center justify-center space-y-2">
		                    <!-- 적 이름 -->
		                    <div class="text-center font-bold text-lg text-black">\${data[0].enemyName}</div>
		                    <!-- HP Bar -->
		                    <div class="relative w-36 h-3 bg-gray-300 rounded-full">
		                        <div id="enemyHPBar" class="h-full bg-red-500 rounded-full transition-all duration-300 ease-out"
		                            style="width: \${data[0].enemyHp}%;"></div>
		                    </div>
		                </div>
		            `;

		            // 기존 적 정보 제거 후 새로 추가
		            $('#enemyInfo').empty().append(content);
		        },
		        error: function (xhr, status, error) {
		            console.error(error);
		        }
		    });  
		    a = a + 1;
		    isAttack = false;
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
			console.log("적군 공격 애니메이션");
			await getEnemyPattern();
			let content;
			let hpBar;
			let damage = enemyAttackPower - characterBerrior;
			if(damage < 0){
				damage = 1;
			}
			characterHp = characterHp - damage;
			if(characterHp <= 0){
				console.log("캐릭터 HP 0 될시 ");
				content = `
	                <div id="ballteTextBox" class="w-1/2 h-1/2 bg-gray text-white text-lg font-medium flex items-center justify-center">
						<div>\${characterName}이 \${damage} 만큼의 데미지를 입어 HP가 0이되었습니다.</div> 	                    
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
			}else if(characterHp >= 0){
				console.log("적군 공격시 캐릭터 데미지 입는 것");
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
		// === battle 스크립트 ====
 		const attack = async function () {
 			console.log(4 + " 캐릭터 공격");
			if(isAttack) return;
			isAttack = true;
			let content;
			let hpBar;
        	 if(enemyHp <= 0){return;}
        		let damage = characterAttackPower - enemyBerrior;
        		if(damage < 0){
        			damage = 1;
        		}
	        	enemyHp = enemyHp - damage;
	        		if(enemyHp <= 0){
	        			console.log(" 적군 죽기 입기");
	        			await itemDrop();
	        			await insertGold()
	        			content = `
			                <div id="ballteTextBox" class="w-1/2 h-1/2 bg-gray text-white text-lg font-medium flex items-center justify-center">
								<div>\${enemyName}이 \${damage}만큼의 데미지를 입어 HP가 0이되었습니다. , \${dropedItem}을 획득했습니다.</div> 	                    
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
							$('#enemyHPBar').empty().append(hpBar);
				            $('#battleTextBox').empty().append(content);
	        		}else{
	        			console.log(" 적군 데미지 입기");
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
		
		
		function itemDrop(){
			console.log("적군 사망시 아이템 드롭");
			return $.ajax({
				        url: "/usr/item/itemDrop",
				        type: "GET",
				        data: { enemyType : enemyType }, 
				        dataType: "json",
				        success: function (data) {
				        	const random = randomNum(data.length,1);
				        	if(random === 1){
				        		dropedItem = data[0].itemName; 
				        	}else if(random === 2){
				        		dropedItem = data[1].itemName;
				        	}else if(random === 3){
				        		dropedItem = data[2].itemName;
				        	}
				        },
				        error: function (xhr, status, error) {
				            console.error(error);
				        }
				    }); 
		}
		function getDropItem(){
			console.log("적군 사망시 아이템 드롭한것 저장");
			return $.ajax({
		        url: "/usr/item/itemInsertToCharacter",
		        type: "GET",
		        data: { 
		        	characterId : id,
		        	itemName : dropedItem	
		        }
		    }); 
		}
        //데미지 입는 애니메이션
		function shake(name) {
			console.log("데미지 입는 애니메이션");
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
	    	console.log("적군 HP 0 될시 죽는 애니메이션");
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
	    	console.log("공격 애니메이션");
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
					data: { id: enemyId }, // id 값 전달
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
					characterBerrior : characterBerrior
				}, 
			});
			alert("데이터가 저장되었습니다.");
		};
		
			 

</script>

<div class="w-full h-full absolute">
	<img src="/usr/imgFile/getImgPath?imgName=background" class="w-full h-full" />
</div>
<div id="imgtest">
</div>
<section class="container">
	<div id="ourZone" class="fixed ">
		<div id="characterInfo" class="relative"></div>
		<img id="heroImg" src=""class="hidden">
	</div>
	<div id="enemyZone" class="fixed top-9 right-56">
		<div id="enemyInfo" class="relative"></div>
		<img id="enemyImg" src="" class="hidden">
	</div>
</section>
<!--   		====하단 버튼 4개 ==== -->
<div id="underBattleBtn"
	class="fixed bottom-0 left-0 w-full h-1/5 bg-gray-800 hidden flex-wrap">
	<!-- 상단 버튼 두 개 -->
	<button id="attackBtn"
		class="w-1/2 h-1/2 bg-gray text-white text-lg font-medium flex items-center justify-center hover:bg-gray-200 hover:text-black"
		onclick="attack();">공격하기</button>
	<button id="back" class=" w-1/2 h-1/2 bg-gray text-white text-lg font-medium flex items-center justify-center hover:bg-gray-200 hover:text-black" >돌아가기</button>
	<!-- 하단 버튼 두 개 -->
	<button id="next" class="w-1/2 h-1/2 bg-gray text-white text-lg font-medium flex items-center justify-center hover:bg-gray-200 hover:text-black" onclick="test()" >다음</button>
	<button id="battleTextBox" class="w-1/2 h-1/2 bg-gray text-white text-lg font-medium flex items-center justify-center cursor-default">필드 텍스트</button>
</div>
<!--     		=====하단 텍스트 박스 ===== -->
<div id="UnderTextBox"
	class="fixed bottom-0 left-0 w-full h-1/5 bg-gray-800 flex flex-wrap">
	<button
		class="w-1/2 h-full bg-gray text-white text-lg font-medium flex items-center justify-center hover:bg-gray-200 hover:text-black"
		onclick="startBattleBtnClick(); ">게임 시작</button>
	<div
		class="w-1/2 h-full bg-gray text-white text-lg font-medium flex items-center justify-center ">
		테스트 텍스트 박스</div>
</div>
<!--     ===토글 사이드바=== -->
<button id="toggleMenuBtn"
	class="fixed top-4 left-4 bg-blue-500 text-white py-2 px-4 rounded-lg hover:bg-blue-600">
	메뉴 열기</button>

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
		<li class="p-2 settingMenu"><a href="#" class="btn w-full text-black whitespace-nowrap hover:text-gray-200">설정</a>
		</li>
		<li class="p-2 itemMenu">
			<!--                 <a href="#" class="btn w-full text-black whitespace-nowrap hover:text-gray-200">아이템</a> -->
			<button
				class="btn w-full text-black whitespace-nowrap hover:text-gray-200"
				onclick="getItemList()">아이템</button>
		</li>
		<li class="p-2 testMenu"><a href="../home/main" onclick="return finishGame()" class="btn w-full text-black whitespace-nowrap hover:text-gray-200">메인페이지</a>
		</li>
	</ul>
</div>

<!-- 2차 메뉴 -->
<div id="submenu"
	class="hidden fixed top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2 w-72 h-72 bg-white shadow-lg border border-gray-300 z-40">
	<!-- 비어 있는 2차 메뉴 -->
	<div id="testContent"></div>
</div>
    <div id="overlay" class="hidden fixed inset-0 bg-black bg-opacity-50 z-30"></div>

    <!-- 아이템팝업 -->
<div id="itemPopUp" class="hidden fixed top-1/3 left-1/2 transform -translate-x-1/2 -translate-y-1/2 w-full h-96 bg-gray-800 bg-opacity-50 shadow-lg border rounded border-gray-300 z-40 p-4 flex items-center justify-around space-x-4">
    <div class="absolute top-2 right-16 text-white text-lg font-bold">
        Gold: <span id="goldAmount">100</span>
    </div>
    <!-- 버튼 1 -->
    <div class="flex flex-col items-center space-y-2">
        <!-- 버튼 위 텍스트 -->
        <div class="text-white text-sm">포션 30%</div>
        <button id="potion30" class="popup-btn w-32 h-32 rounded-lg flex items-center justify-center hover:bg-gray-100">
            <img src="/usr/imgFile/getImgPath?imgName=potion30" class="w-24 h-24">
        </button>
        <!-- 버튼 아래 텍스트 -->
        <div class="text-white text-sm">사용 시 체력 30% 회복 <br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;30 GOLD</div>
    </div>

    <!-- 버튼 2 -->
    <div class="flex flex-col items-center space-y-2">
        <!-- 버튼 위 텍스트 -->
        <div class="text-white text-sm">포션 50%</div>
        <button id="potion50"  class="popup-btn w-32 h-32 rounded-lg flex items-center justify-center hover:bg-gray-100">
            <img src="/usr/imgFile/getImgPath?imgName=potion50" class="w-28 h-36">
        </button>
        <!-- 버튼 아래 텍스트 -->
        <div class="text-white text-sm">사용 시 체력 50% 회복 <br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;50 GOLD</div>
    </div>

    <!-- 버튼 3 -->
    <div class="flex flex-col items-center space-y-2">
        <!-- 버튼 위 텍스트 -->
        <div class="text-white text-sm">포션 100%</div>
        <button id="potion100"  class="popup-btn w-32 h-32 rounded-lg flex items-center justify-center hover:bg-gray-100">
            <img src="/usr/imgFile/getImgPath?imgName=potion100" class="w-24 h-28">
        </button>
        <!-- 버튼 아래 텍스트 -->
        <div class="text-white text-sm">사용 시 체력 100% 회복 <br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;100 GOLD</div>
    </div>

</div>

<%@ include file="../../common/footer.jsp"%>