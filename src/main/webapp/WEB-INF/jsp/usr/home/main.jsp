<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<c:set var="pageTitle" value="메인" />
<%@ include file="../../common/header.jsp"%>

<section>
	<div class="container">
		<img src="${pageContext.request.contextPath}/images/testCharacter.png">
	</div>
</section>

<%@ include file="../../common/footer.jsp"%>