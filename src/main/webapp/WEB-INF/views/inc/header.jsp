<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- jQuery CDN -->
<script src="https://code.jquery.com/jquery-1.12.4.min.js" integrity="sha256-ZosEbRLbNQzLpnKIkEdrPv7lOy9C27hHQ+Xp8a4MxAQ=" crossorigin="anonymous"></script>
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<style>
	.btn {
		outline: none !important;
	}
	
	input[readonly], textarea[readonly] {
		cursor: default !important;
	}
	
</style>
<div class="well well-lg">
	<h2 class="pull-left">Board</h2>
	<c:if test="${empty userid}">
		<div class="pull-right">
			<button class="btn btn-default" onclick="location.href='/login'">Login</button>
			<button class="btn btn-default" onclick="location.href='/join'">Join</button>
		</div>
	</c:if>
	<c:if test="${not empty userid}">
		<div class="pull-right">
			<button id="mypageBtn" class="btn btn-default" onclick="location.href='/mypage'">MyPage</button>
			<button id="logoutBtn" class="btn btn-default">Logout</button>
		</div>
	</c:if>
	<div class="clearfix"></div>
</div>

<script type="text/javascript">
	$("#logoutBtn").click(function(e) {
		if (confirm("로그아웃 하시겠습니까?")) {
			self.location = "/logout";
		}
	});
</script>