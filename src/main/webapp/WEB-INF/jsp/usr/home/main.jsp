<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<%@ include file="../../common/header.jsp"%>


<section>
	<div>
		<c:if test="${rq.getLoginedMemberId() == -1 }">
		<a class="btn" href="../member/join">회원가입</a>
		<a class="btn" href="../member/login">로그인</a>
		</c:if>
		<c:if test="${rq.getLoginedMemberId() != -1 }">
		<a class="btn" href="../game/field">필드</a>
		<a class="btn" href="../member/doLogout">로그아웃</a>
		</c:if>
	</div>
</section>

<%@ include file="../../common/footer.jsp"%>