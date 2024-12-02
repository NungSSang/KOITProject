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
	
	//키보드 이벤트 처리
	document.addEventListener('keydown', (event) => {
		$(items[currentIndex]).css("background-color", "");
		switch (event.key) {
		 case 'ArrowUp':    // 위쪽 방향키
			 currentIndex = (currentIndex - 1 + items.length) % items.length;
		   y += 10;
		   break;
		 case 'ArrowDown':  // 아래쪽 방향키
			 currentIndex = (currentIndex + 1) % items.length;
		   y -= 10;
		   break;
		 case 'ArrowLeft':  // 왼쪽 방향키
			 currentIndex = (currentIndex - 2) % items.length;
		    x -= 10;
		   break;
		 case 'ArrowRight': // 오른쪽 방향키
			 currentIndex = (currentIndex + 2) % items.length;
		   x += 10;
		   break;
		 default:
		   return; // 다른 키는 무시
		}
		$(items[currentIndex]).css("background-color", "pink");
	});
	const test = function(){
		console.log(j + "들어옴?");
		if(j == 0){
		$.ajax({
		    url: "/usr/item/getItems",
		    type: 'GET',
		    data: { id: i }, // id 값 전달
		    dataType: 'json',
		    success: function(data) {
	        	for (let t = 0; t < data.length; t++) {
	        		let content = `
	        			<div id="items">
	        				<div class="inline-block">\${data[t].itemName}</div>
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
		console.log(j + "들어옴22?");
		$('#testContent div').remove();
		j = 0 ;
	}
// 	=== 토글 사이드바 === 
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
</script>

<section class="container">
	<div class="ourZone fixed ">
        <img id="hero" src="${pageContext.request.contextPath}/images/testCharacter.png" >
    </div>
    <div class="enemyZone fixed top-9 right-9">
   	 <img id="hero" src="${pageContext.request.contextPath}/images/testEnemyData.png" >
    </div>
    <div id="testContent"></div>
</section>

<div id="battleBtn" class="fixed bottom-0 left-0 w-full h-1/5 bg-gray-800 flex flex-wrap">
        <!-- 상단 버튼 두 개 -->
        <button class="w-1/2 h-1/2 bg-gray text-white text-lg font-medium flex items-center justify-center hover:bg-gray-200 hover:text-black">
            버튼 1
        </button>
        <button class="w-1/2 h-1/2 bg-gray text-white text-lg font-medium flex items-center justify-center hover:bg-gray-200 hover:text-black">
            버튼 2
        </button>

        <!-- 하단 버튼 두 개 -->
        <button class="w-1/2 h-1/2 bg-gray text-white text-lg font-medium flex items-center justify-center hover:bg-gray-200 hover:text-black">
            버튼 3
        </button>
        <button class="w-1/2 h-1/2 bg-gray text-white text-lg font-medium flex items-center justify-center hover:bg-gray-200 hover:text-black">
            버튼 4
        </button>
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
                <a href="#" class="btn w-full text-black whitespace-nowrap hover:text-gray-200">아이템</a>
            </li>
            <li class="p-2 testMenu">
                <a href="#" class="btn w-full text-black whitespace-nowrap hover:text-gray-200">테스트</a>
            </li>
        </ul>
    </div>

    <!-- 2차 메뉴 -->
    <div id="submenu" class="hidden fixed top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2 w-72 h-72 bg-white shadow-lg border border-gray-300 z-40">
        <!-- 비어 있는 2차 메뉴 -->
    </div>
	
<%@ include file="../../common/footer.jsp"%>