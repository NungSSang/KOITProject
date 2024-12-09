<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<%@ include file="../../common/header.jsp"%>

<style>
        @keyframes attack-ani {
	from {
		transform: translate(0, 0);
	}
	to {
		transform: translate(100px, 100px);
	}
}
</style>

<script>
const test = function(){
    const element = document.getElementById("images");
	
    // getBoundingClientRect 값을 로그로 출력
    const rect = element.getBoundingClientRect();
    console.log(rect);
    const projectile = document.getElementById("attackImg");
    const images = document.getElementById("enemyImg");

    // 클릭된 이미지의 위치 가져오기
    const targetRect = images.getBoundingClientRect();

    // 발사체 초기 위치 설정 (예: 화면 중앙)
    const startX = window.innerWidth / 2;
    const startY = window.innerHeight / 2;

    projectile.style.left = `${startX}px`;
    projectile.style.top = `${startY}px`;
    projectile.style.position = "fixed";
    projectile.classList.remove("hidden");

    // 애니메이션 실행
//     projectile.animate([
//         { transform: `translate(${startX}px, ${startY}px)` },
//         { transform: `translate(${targetRect.left}px, ${targetRect.top}px)` }
//     ], {
//         duration: 1000, // 1초 동안 이동
//         easing: "ease-out"
//     });
    document.getElementById("attackImg").classList.add('attack-ani');

    // 애니메이션 종료 후 숨기기
    setTimeout(() => {
        projectile.classList.add("hidden");
    }, 1000);
}

</script>


<section>
	<div>
		<c:if test="${rq.getLoginedMemberId() == -1 }">
		<a class="btn" href="../member/join">회원가입</a>
		<a class="btn" href="../member/login">로그인</a>
		</c:if>
		<c:if test="${rq.getLoginedMemberId() != -1 }">
		<a class="btn" href="../game/field">필드</a>
		<a id="images" class="btn" href="../member/doLogout">로그아웃</a>
		</c:if>
	</div>
	<div>
		<img id="attackImg" src="/usr/imgFile/getImgPath?imgName=attack" class="w-2 h-2" />
	</div>
<button onclick="test()">테스트</button>
</section>

<%@ include file="../../common/footer.jsp"%>