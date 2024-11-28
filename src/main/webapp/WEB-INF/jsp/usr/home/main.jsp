<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<c:set var="pageTitle" value="메인" />
<%@ include file="../../common/header.jsp"%>

<script>
	document.addEventListener('DOMContentLoaded', () => {
	    const box = document.querySelector('.box');
		console.log("들어옴");
	    // 초기 좌표
	    let x = 0;
	    let y = 0;
	
	    // 키보드 이벤트 처리
	    document.addEventListener('keydown', (event) => {
	      switch (event.key) {
	        case 'ArrowUp':    // 위쪽 방향키
	        console.log("위쪽 방향키");
	          y += 10;
	          break;
	        case 'ArrowDown':  // 아래쪽 방향키
	          y -= 10;
	          break;
	        case 'ArrowLeft':  // 왼쪽 방향키
	          x -= 10;
	          break;
	        case 'ArrowRight': // 오른쪽 방향키
	          x += 10;
	          break;
	        default:
	          return; // 다른 키는 무시
	      }
	
	      // 좌표에 따라 이동
	      box.style.transform = `translate(${x}px, ${-y}px)`;
	    });
	  });
</script>

<section>
	<div>
<!-- 		<img src="/images/testCharacter.png"> -->
		<img src="${pageContext.request.contextPath}/images/testCharacter.png" alt="Test Character">
	</div>
</section>
   <div class="container">
    <div class="box"></div>
  </div>

<%@ include file="../../common/footer.jsp"%>