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

<div class="well well-lg">
	<c:if test="${empty userid}">
		<h2>Board <button class="btn btn-default pull-right" onclick="location.href='/login'">Login</button></h2>	
	</c:if>
	<c:if test="${not empty userid}">
		<h2>Board <button id="logoutBtn" class="btn btn-default pull-right">Logout</button></h2>	
	</c:if>
</div>

<script type="text/javascript">
	$("#logoutBtn").click(function(e) {
		if (confirm("로그아웃 하시겠습니까?")) {
			self.location = "/logout";
		}
	});
</script>