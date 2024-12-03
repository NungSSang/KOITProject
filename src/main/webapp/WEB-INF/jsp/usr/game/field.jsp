<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<%@ include file="../../common/header.jsp"%>

<script>
		let j = 0;
		let currentIndex = 0; // 현재 선택된 요소의 인덱스
		let items = [];
		let x = 0;
		let y = 0;
		var i = 1;
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
				y += 10;
				break;
				case 'ArrowDown':  // 아래쪽 방향키
				currentIndex = (currentIndex + 2) % items.length;
				y -= 10;
				break;
				case 'ArrowLeft':  // 왼쪽 방향키
				currentIndex = (currentIndex - 1) % items.length;
				x -= 10;
				break;
				case 'ArrowRight': // 오른쪽 방향키
				currentIndex = (currentIndex + 1) % items.length;
				x += 10;
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
		const startBattleBtnClick = function(){
			document.getElementById('UnderTextBox').classList.remove('flex');
			document.getElementById('UnderTextBox').classList.add('hidden');
			document.getElementById('underBattleBtn').classList.remove('hidden');
			document.getElementById('underBattleBtn').classList.add('flex');
		}
		const finishBattleBtnClick = function(){
			document.getElementById("enemyImg").classList.remove('flex');
			document.getElementById("enemyImg").classList.add('hidden');
			document.getElementById("heroImg").classList.remove('flex');
			document.getElementById("heroImg").classList.add('hidden');
			document.getElementById('UnderTextBox').classList.remove('hidden');
			document.getElementById('UnderTextBox').classList.add('flex');
			document.getElementById('underBattleBtn').classList.remove('flex');
			document.getElementById('underBattleBtn').classList.add('hidden');
		}
		
		const getCharacterStauts = function(){
			$.ajax({
				url: "/usr/character/getCharacter",
				type: 'GET',
				data: { memberId : 1 }, // memberId 값 전달
				dataType: 'json',
				success: function(data) {
					console.log(data);
					let content = `
					    <div id="heroStatus" class="relative w-1/2 h-1/2 whitespace-nowrap">
					        <!-- 캐릭터 이름 -->
					        <div class="inline-block text-center">\${data[0].characterName}</div>
					        
					        <!-- HP Bar -->
					        <div class="absolute bottom-[-20px] left-1/2 transform -translate-x-1/2 w-36 h-3 bg-gray-300 rounded-full">
					            <div id="characterHPBar" class="h-full bg-green-500 rounded-full transition-all duration-300 ease-out" style="width: \${data[0].characterHp}%;"></div>
					        </div>
					    </div>
					`;
						$('#characterInfo').append(content);
					
				},
				error: function(xhr, status, error) {
					console.error(error);
				}
			});
		} 
		const getEnemyStatus = function(){
			$.ajax({
				url: "/usr/enemy/getEnemy",
				type: 'GET',
				data: { id : 1 }, // Id 값 전달
				dataType: 'json',
				success: function(data) {
					console.log(data)
						let content = `
							<div id="enemyStatus" class="relative w-1/2 h-1/2 whitespace-nowrap">
							<div class="inline-block text-center ml-8">\${data[0].enemyName}</div>
							<div class="absolute bottom-[-20px] left-1/2 transform -translate-x-1/2 w-36 h-3 bg-gray-300 rounded-full">
				            <div id="enemyHPBar" class="h-full bg-green-500 rounded-full transition-all duration-300 ease-out" style="width: \${data[0].enemyHp}%;"></div>
				        </div>
						</div>
						`;
						$('#enemyInfo').append(content);
				},
				error: function(xhr, status, error) {
					console.error(error);
				}
			});
			
		} 
		
		const loadImages = () => {
	        // AJAX 요청
	        $.ajax({
	            url: "${pageContext.request.contextPath}/images/testCharacter.png",
	            type: "GET",
	            success: function () {
	                const enemyImg = document.getElementById("enemyImg");
	                enemyImg.src = "${pageContext.request.contextPath}/images/testEnemyData.png"; // 이미지 경로 설정
	                enemyImg.classList.remove("hidden"); // 이미지 숨김 해제
	                enemyImg.classList.add("translate-x-full"); // 초기 위치 설정 (화면 밖)
	                
	            	const heroImg = document.getElementById("heroImg");
	                heroImg.src = "${pageContext.request.contextPath}/images/testCharacter.png"; // 이미지 경로 설정
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
	        // AJAX 통신으로 이미지 로드
	        $.ajax({
	            url: "${pageContext.request.contextPath}/images/testEnemyData.png",
	            type: "GET",
	            success: function () {
	                const enemyImg = document.getElementById("enemyImg");

	                // 1. 위로 20px 올라가는 애니메이션
	                enemyImg.classList.add("translate-y-[-30px]", "transition-transform", "duration-500", "ease-out");

	                // 2. 0.5초 후 아래로 내려오는 애니메이션
	                setTimeout(() => {
	                    enemyImg.classList.remove("translate-y-[-30px]");
	                    enemyImg.classList.add("translate-y-[30px]", "ease-in");
	                }, 500);

	                // 3. 1초 후 숨김 처리 및 삭제
	                setTimeout(() => {
	                    enemyImg.classList.add("hidden");
	                    enemyImg.src = ""; // 이미지 제거
	                }, 700);
	            },
	            error: function (xhr, status, error) {
	                console.error("이미지 로드 실패:", error);
	            }
	        });
	    };
	    
	    
</script>

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
        <button id="attackBtn" class="w-1/2 h-1/2 bg-gray text-white text-lg font-medium flex items-center justify-center hover:bg-gray-200 hover:text-black" onclick="dieAnimation();">
            공격하기
        </button>
        <button class="w-1/2 h-1/2 bg-gray text-white text-lg font-medium flex items-center justify-center hover:bg-gray-200 hover:text-black">
            버튼 2
        </button>

        <!-- 하단 버튼 두 개 -->
        <button class="w-1/2 h-1/2 bg-gray text-white text-lg font-medium flex items-center justify-center hover:bg-gray-200 hover:text-black">
            버튼 3
        </button>
        <button class="w-1/2 h-1/2 bg-gray text-white text-lg font-medium flex items-center justify-center hover:bg-gray-200 hover:text-black" onclick="finishBattleBtnClick();">
            돌아가기
        </button>
    </div>
<!--     		=====하단 텍스트 박스 ===== -->
<div id="UnderTextBox" class="fixed bottom-0 left-0 w-full h-1/5 bg-gray-800 flex flex-wrap">
        <button class="w-1/2 h-full bg-gray text-white text-lg font-medium flex items-center justify-center hover:bg-gray-200 hover:text-black" 
        onclick="startBattleBtnClick(); getCharacterStauts(); getEnemyStatus(); loadImages();">
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