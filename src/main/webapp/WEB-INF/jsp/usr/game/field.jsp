<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<%@ include file="../../common/header.jsp"%>

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
		
		const getItemList = function(){
			if(j == 0){
				$.ajax({
					url: "/usr/item/getItems",
					type: 'GET',
					data: { id: i }, // id 값 전달
					dataType: 'json',
					success: function(data) {
						console.log(data);
						for (let t = 0; t < data.length; t++) {
							let content = `
							<div id="items" class="w-1/2 h-1/2 inline-block whitespace-nowrap">
								<div>\${data[t].itemName}</div>
							</div>
							`;
			        		
							$('#testContent').append(content);
							items = $("#items div").toArray();
							if (items.length > 0) {
								$(items[currentIndex]).css("background-color", "pink");
							}
						}
	
					},
					error: function(xhr, status, error) {
						console.error(error);
					}
				});
			}
			j = 1;
		} 
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
		});
//==================게임 시작?=====================

	 
//게임시작 버튼 누르면 하단 박스 바뀌는것
		const startBattleBtnClick = function () {
		    // 버튼 상태 전환
		    document.getElementById('UnderTextBox').classList.remove('flex');
		    document.getElementById('UnderTextBox').classList.add('hidden');
		    document.getElementById('underBattleBtn').classList.remove('hidden');
		    document.getElementById('underBattleBtn').classList.add('flex');
		
		    // 캐릭터 상태 다시 불러오기
		    getCharacterStauts();
		
		    // 적 상태 다시 불러오기
		    getEnemyStatus();
		
		    // 캐릭터와 적 이미지 표시 및 애니메이션 초기화
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
		let isBattle = true;
		//=== 캐릭터와 적 스탯 불러오기 ===
		const getCharacterStauts = function () {
		    $.ajax({
		        url: "/usr/character/getCharacter",
		        type: "GET",
		        data: { memberId: 1 }, // memberId 값 전달
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
		
		//=============== 전투 시작 적군 생성 후 while문 작성 ===============
		const getEnemyStatus = async function () {
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
					enemyHp = data[0].enemyHp;
					enemyAttackPower = data[0].enemyAttackPower;
					enemyBerrior = data[0].enemyBerrior;
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
		}; 
// 		===넥스트 버튼 클릭 감지===
	
		window.onload = function () {
			document.getElementById("next").addEventListener('click', function() {
	 	    });
		};	
		// === battle 스크립트 ====
		const battle = () => {
			while (true){
				if(characterHp <= 0){
					 $.ajax({
					        success: function (data) {
					            let content = `
					                <div id="ballteTextBox" class="w-1/2 h-1/2 bg-gray text-white text-lg font-medium flex items-center justify-center hover:bg-gray-200 hover:text-black">
										<div>\${characterName}의 HP가 0이되어 게임을 종료합니다.</div> 	                    
					                </div>
					            `;
					            //텍스트박스 업데이트
					            $('#battleTextBox').empty().append(content);
					        }
					});
					 break;
				}else if(enemyHp <= 0){
					 $.ajax({
					        success: function (data) {
					            let content = `
					                <div id="ballteTextBox" class="w-1/2 h-1/2 bg-gray text-white text-lg font-medium flex items-center justify-center hover:bg-gray-200 hover:text-black">
										<div>\${enemyName}의 HP가 0이되었습니다.</div> 	                    
					                </div>
					            `;
					            //적 죽는 애니메이션 텍스트박스 업데이트
					            dieAnimation();
					            $('#battleTextBox').empty().append(content);
					        }
					});
					 break;
				}
				 $.ajax({
				        success: function (data) {
				        	enemyHp = enemyHp - characterAttackPower;
				        	console.log("적의 HP는 = " + enemyHp);
				            let content = `
				                <div id="ballteTextBox" class="w-1/2 h-1/2 bg-gray text-white text-lg font-medium flex items-center justify-center hover:bg-gray-200 hover:text-black">
									<div>\${characterName}가 \${enemyName}에게 \${characterAttackPower}만큼의 데미지를 입혔습니다.</div> 	                    
				                </div>
				            `;
				            //텍스트박스 업데이트
				            $('#battleTextBox').empty().append(content);
				        },
				        error: function (xhr, status, error) {
				            console.error(error);
				        }
				    }); 
			}
		}
		
		const loadImages = () => {
	        $.ajax({
 	            //url: "${pageContext.request.contextPath}/images/testCharacter.png",
	            type: "GET",
	            success: function () {
	                const enemyImg = document.getElementById("enemyImg");
 	                //enemyImg.src = "${pageContext.request.contextPath}/images/testEnemyData.png";
	                enemyImg.classList.remove("hidden"); // 이미지 숨김 해제
	                enemyImg.classList.add("translate-x-full"); // 초기 위치 설정 (화면 밖)
	                
	            	const heroImg = document.getElementById("heroImg");
 	                //heroImg.src = "${pageContext.request.contextPath}/images/testCharacter.png";
	                heroImg.classList.remove("hidden"); // 이미지 숨김 해제
	                heroImg.classList.add("-translate-x-full"); // 초기 위치 설정 (화면 밖)
	                setTimeout(() => {
	                	heroImg.classList.add("transition-transform", "duration-500", "ease-out", "translate-x-0");
	                    enemyImg.classList.add("transition-transform", "duration-500", "ease-out", "translate-x-0");
	                }, 10); // 딜레이를 줘서 애니메이션 적용
	            },
	            error: function (xhr, status, error) {
	                console.error("이미지 로드 실패:", error);
	            }
	        });
	    };
	    const dieAnimation = () => {
	        const enemyImg = document.getElementById("enemyImg");

	        // 적 이미지가 위로 사라지는 애니메이션
	        enemyImg.classList.add("translate-y-[-30px]", "transition-transform", "duration-500", "ease-out");

	        setTimeout(() => {
	            enemyImg.classList.remove("translate-y-[-30px]");
	            enemyImg.classList.add("hidden"); // 애니메이션 후 숨김 처리
	            $('#enemyInfo').empty(); // 적 정보 삭제
	        }, 500); // 애니메이션 시간 (500ms)
	    };
	    
</script>

<div class="w-full h-full absolute">
	<img src="${pageContext.request.contextPath}/images/background.jpg" class="w-full h-full"/>
</div>

<section class="container">
	<div id="ourZone" class="fixed ">
		<div id="characterInfo">
			<div id="characterInfo" class="relative">
        	</div>
		</div>
        <img id="heroImg" src="${pageContext.request.contextPath}/images/testCharacter.png" class="hidden">
    </div>
    <div id="enemyZone" class="fixed top-9 right-9">
    <div id="enemyInfo"></div>
   	 	<img id="enemyImg" src="${pageContext.request.contextPath}/images/testEnemyData.png" class="hidden" >
    </div>
</section>
<!--   		====하단 버튼 4개 ==== -->
<div id="underBattleBtn" class="fixed bottom-0 left-0 w-full h-1/5 bg-gray-800 hidden flex-wrap">
        <!-- 상단 버튼 두 개 -->
        <button id="attackBtn" class="w-1/2 h-1/2 bg-gray text-white text-lg font-medium flex items-center justify-center hover:bg-gray-200 hover:text-black" onclick="battle();">
            공격하기
        </button>
        <button id="back" class="w-1/2 h-1/2 bg-gray text-white text-lg font-medium flex items-center justify-center hover:bg-gray-200 hover:text-black" onclick="finishBattleBtnClick();">
            돌아가기
        </button>
        <!-- 하단 버튼 두 개 -->
        <button id="next" class="w-1/2 h-1/2 bg-gray text-white text-lg font-medium flex items-center justify-center">다음</button>
        <button id="battleTextBox" class="w-1/2 h-1/2 bg-gray text-white text-lg font-medium flex items-center justify-center">필드 텍스트</button>
    </div>
<!--     		=====하단 텍스트 박스 ===== -->
<div id="UnderTextBox" class="fixed bottom-0 left-0 w-full h-1/5 bg-gray-800 flex flex-wrap">
        <button class="w-1/2 h-full bg-gray text-white text-lg font-medium flex items-center justify-center hover:bg-gray-200 hover:text-black" 
        onclick="startBattleBtnClick(); ">
        	게임 시작
        </button>
         <div class="w-1/2 h-full bg-gray text-white text-lg font-medium flex items-center justify-center ">
            테스트 텍스트 박스
        </div>
</div>        
<!--     ===토글 사이드바=== -->
<button id="toggleMenuBtn" class="fixed top-4 left-4 bg-blue-500 text-white py-2 px-4 rounded-lg hover:bg-blue-600">
        메뉴 열기
    </button>

    <!-- 오버레이 -->
    <div id="overlay" class="hidden fixed inset-0 bg-black bg-opacity-50 z-20"></div>

    <!-- 사이드바 -->
    <div id="sidebar" class="fixed top-0 left-0 w-64 h-full bg-gray-800 text-white transform -translate-x-full transition-transform duration-1000 z-30">
        <div class="p-4 flex justify-between items-center">
            <h2 class="text-lg font-bold">메뉴</h2>
            <button id="closeMenuBtn" class="text-gray-400 hover:text-white">
                닫기
            </button>
        </div>
        <ul class="mt-4">
            <li class="p-2 settingMenu">
                <a href="#" class="btn w-full text-black whitespace-nowrap hover:text-gray-200">설정</a>
            </li>
            <li class="p-2 itemMenu">
<!--                 <a href="#" class="btn w-full text-black whitespace-nowrap hover:text-gray-200">아이템</a> -->
					 <button class="btn w-full text-black whitespace-nowrap hover:text-gray-200" onclick="getItemList()">아이템</button>
            </li>
            <li class="p-2 testMenu">
                <a href="../home/main" class="btn w-full text-black whitespace-nowrap hover:text-gray-200">메인페이지</a>
            </li>
        </ul>
    </div>

    <!-- 2차 메뉴 -->
    <div id="submenu" class="hidden fixed top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2 w-72 h-72 bg-white shadow-lg border border-gray-300 z-40">
        <!-- 비어 있는 2차 메뉴 -->
        <div id="testContent"></div>
    </div>
	
<%@ include file="../../common/footer.jsp"%>