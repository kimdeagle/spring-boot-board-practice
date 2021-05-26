<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Join</title>
</head>
<body>
	<%@ include file="inc/header.jsp" %>

	<div class="container">
	
		<div class="row">
			<div class="col-md-4 col-md-offset-4">
				<form action="/join" method="post">
					<h2 class="page-header">회원가입</h2>
					<div class="form-group input-group">
						<input type="text" id="userid" name="userid" class="form-control" placeholder="Userid" required autofocus>
						<span class="input-group-btn">
							<button id="checkUserIdBtn" class="btn btn-warning">중복검사</button>
						</span>
					</div>
					<div class="form-group">
						<input type="password" id="userpw" name="userpw" class="form-control" placeholder="Password" required>
					</div>
					<div class="form-group">
						<input type="text" id="name" name="name" class="form-control" placeholder="Name" required>
					</div>
					<div class="form-group">
						<input type="text" id="email" name="email" class="form-control" placeholder="Email(option)">
					</div>
					<button class="btn btn-lg btn-primary btn-block" type="submit">회원가입</button>
					<button id="returnBtn" class="btn btn-lg btn-default btn-block">돌아가기</button>
				</form>
			</div>
		</div>

	</div>
	<!-- /container -->
	
	<script type="text/javascript">
		$(document).ready(function() {
			$("#returnBtn").click(function(e) {
				e.preventDefault();
				history.back();
			});
			
			$("#checkUserIdBtn").click(function(e) {
				e.preventDefault();
				
				var userid = $("#userid");
				
				$.ajax({
					type: "GET",
					url: "/checkUserId",
					data: "userid=" + userid.val(),
					success: function(result) {
						if (result) {
							//중복
							alert("중복된 아이디입니다.");
							userid.focus();
						} else {
							//중복X
							if (confirm("사용 가능한 아이디입니다. 사용하시겠습니까?")) {
								$("#userpw").focus();								
							} else {
								userid.focus();
							}
						}
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