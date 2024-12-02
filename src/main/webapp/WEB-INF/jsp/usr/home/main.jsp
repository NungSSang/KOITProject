<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<%@ include file="../../common/header.jsp"%>


<script>
	const test = function(){
		console.log("들어옴?");
	}
</script>
<section>
	<div>
		<a class="btn" href="../game/field">필드</a>
		<c:if test="${rq.getLoginedMemberId() == -1 }">
		<a class="btn" href="../member/join">회원가입</a>
		<a class="btn" href="../member/login">로그인</a>
		</c:if>
	</div>
	<div>
		<button class="btn" onclick="test()">테스트 버튼</button>
	</div>
</section>

<%@ include file="../../common/footer.jsp"%>