<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<%@ include file="../../common/header.jsp"%>

<script>
		let x = 0;
		let y = 0;
		
		$(document).ready(function() {
			var hero = document.getElementById("hero");
		})
		
		//키보드 이벤트 처리
		document.addEventListener('keydown', (event) => {
		switch (event.key) {
		 case 'ArrowUp':    // 위쪽 방향키
			 hero.style.position="relative";
			 hero.style.top="-00px";
		   y += 10;
		   break;
		 case 'ArrowDown':  // 아래쪽 방향키
			 hero.style.position="relative";
			 hero.style.top="+20px";
		   y -= 10;
		   break;
		 case 'ArrowLeft':  // 왼쪽 방향키
			 hero.style.position="relative";
			 hero.style.left="-20px";
		   x -= 10;
		   break;
		 case 'ArrowRight': // 오른쪽 방향키
			 hero.style.position="relative";
			 hero.style.left="+20px";
		   x += 10;
		   break;
		 default:
		   return; // 다른 키는 무시
		}
	});
		
		function test() {
			$.ajax({
				url : "/usr/item/getItem",
				type : 'GET',
				data : {
					id : 1,
					index : 1
				},
				dataType : 'json',
				success : function(data) {
					console.log(data);
// 			 		$('#apiTestContent').html(data.response.body.items[0].districtName);
				},
				error : function(xhr, status, error) {
					console.log(error);
				}
			})
		}
		test();'
</script>

<section class="">
	<div>
        <img id="hero" src="${pageContext.request.contextPath}/images/testCharacter.png" >
    </div>
		<button class="btn" onclick="test()">테스트</button>
</section>


	
<%@ include file="../../common/footer.jsp"%>