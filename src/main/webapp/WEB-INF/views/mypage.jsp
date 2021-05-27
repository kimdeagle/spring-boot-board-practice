<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MyPage</title>
</head>
<body>
	<%@ include file="inc/header.jsp" %>

	<div class="container">
	
		<div class="row">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h3>마이페이지</h3>
				</div>
				<div class="panel-body">
					<div class="form-group">
						<label>아이디</label>
						<input type="text" class="form-control" id="userid" name="userid" value="${member.userid}" readonly>
					</div>
					<div class="form-group">
						<label>비밀번호</label>
						<div class="input-group userpw-group">
							 <input type="password" class="form-control" id="userpw" name="userpw" value="${member.userpw}" readonly>
							 <span class="input-group-btn">
							 	<button class="btn btn-info" id="userpwModifyBtn">수정</button>
							 </span>
						</div>
					</div>
					<div class="form-group">
						<label>이름</label>
						<div class="input-group name-group">
							<input type="text" class="form-control" id="name" name="name" value="${member.name}" readonly>
							<span class="input-group-btn">
								<button class="btn btn-info" id="nameModifyBtn">수정</button>
							</span>
						</div>
					</div>
					<div class="form-group">
						<label>이메일</label>
						<div class="input-group email-group">
							<input type="text" class="form-control" id="email" name="email" value="${member.email}" readonly>
							<span class="input-group-btn">
								<button class="btn btn-info" id="emailModifyBtn">수정</button>
							</span>
						</div>
					</div>
					<div class="form-group">
						<label>가입일</label>
						<input type="text" class="form-control" id="regdate" name="regdate" value='<fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${member.regdate}"/>' readonly>
					</div>
				</div>
				<div class="panel-footer text-right">
					<button class="btn btn-default" onclick="location.href='/board/list'">목록</button>
				</div>
			</div>
		</div>

	</div>
	<!-- /container -->
	
	<script type="text/javascript">
		$(document).ready(function() {
			
			var result = "${result}";
			
			if (result != null && result != "") {
				alert(result);
				self.location = "/login";
			}
			
			var userid = $("#userid");
			
			//변경 버튼 클릭
			$(document).on("click", "#userpwModifyBtn", function(e) {
				$("#userpw").prop("readonly", "").focus();
				$(".userpw-group span").html("<button class='btn btn-success' id='userpwConfirmBtn'>완료</button>");
			});
			
			$(document).on("click", "#nameModifyBtn", function(e) {
				$("#name").prop("readonly", "").focus();
				$(".name-group span").html("<button class='btn btn-success' id='nameConfirmBtn'>완료</button>");
			});
			
			$(document).on("click", "#emailModifyBtn", function(e) {
				$("#email").prop("readonly", "").focus();
				$(".email-group span").html("<button class='btn btn-success' id='emailConfirmBtn'>완료</button>");
			});
			
			//완료 버튼 클릭
			$(document).on("click", "#userpwConfirmBtn", function(e) {
				var userpw = $("#userpw").val();
				
				$.ajax({
					type: "post",
					url: "/modifyUserpw",
					data: { userid: userid.val(), userpw: userpw },
					success: function(result) {
						alert(result);
						$(".userpw-group span").html("<button class='btn btn-info' id='userpwModifyBtn'>수정</button>");
						$("#userpw").prop("readonly", "readonly");
					},
					error: function(a, b, c) {
						alert(a, b, c);
					}
				});
				
			});
			
			$(document).on("click", "#nameConfirmBtn", function(e) {
				var name = $("#name").val();
				
				$.ajax({
					type: "post",
					url: "/modifyName",
					data: { userid: userid.val(), name: name },
					success: function(result) {
						alert(result);
						$(".name-group span").html("<button class='btn btn-info' id='nameModifyBtn'>수정</button>");
						$("#name").prop("readonly", "readonly");
					},
					error: function(a, b, c) {
						alert(a, b, c);
					}
				});
				
			});
			
			$(document).on("click", "#emailConfirmBtn", function(e) {
				var email = $("#email").val();
				
				$.ajax({
					type: "post",
					url: "/modifyEmail",
					data: { userid: userid.val(), email: email },
					success: function(result) {
						alert(result);
						$(".email-group span").html("<button class='btn btn-info' id='emailModifyBtn'>수정</button>");
						$("#email").prop("readonly", "readonly");
					},
					error: function(a, b, c) {
						alert(a, b, c);
					}
				});
				
			});
			
		});
	</script>
</body>
</html>