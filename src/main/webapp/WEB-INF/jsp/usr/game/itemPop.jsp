<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<%@ include file="../../common/header.jsp"%>

<script>
	let currentIndex = 0; // 현재 선택된 요소의 인덱스
	let items = [];
	$(document).ready(function() {
		items = $("#items div").toArray();
		   if (items.length > 0) {
		        $(items[currentIndex]).css("background-color", "pink");
		    }
	});
	
	document.addEventListener('keydown', (event) => {
		$(items[currentIndex]).css("background-color", "");
		switch (event.key) {
		case 'ArrowUp':    // 위쪽 방향키
			 currentIndex = (currentIndex - 1 + items.length) % items.length;
		  break;
		case 'ArrowDown':  // 아래쪽 방향키
			 currentIndex = (currentIndex + 1) % items.length;
	
		  break;
		default:
		  return; // 다른 키는 무시
		}
		$(items[currentIndex]).css("background-color", "pink");
	});
</script>

<section>
		<div id="items">
			<c:forEach var="item" items="${items }">
				<div id="${item.getId() }">${item.getItemName() }</div>
			</c:forEach>
		</div>
</section>


<%@ include file="../../common/footer.jsp"%>