<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
</head>
<body>
	<%@ include file="inc/header.jsp" %>

	<div class="container">
	
		<div class="row">
			<div class="col-md-4 col-md-offset-4">
				<form action="/login" method="post">
					<h2 class="page-header">로그인</h2>
					<input type="text" id="userid" name="userid" class="form-control" placeholder="Userid" required autofocus>
					<input type="password" id="password" name="userpw" class="form-control" placeholder="Password" required>
					<div class="checkbox">
						<label><input type="checkbox" value="remember-me">Remember me</label>
					</div>
					<button class="btn btn-lg btn-primary btn-block" type="submit">로그인</button>
				</form>
			</div>
		</div>

	</div>
	<!-- /container -->
	
	<script type="text/javascript">
		$(document).ready(function() {
			var result = "${result}";
			
			if (result != null && result != "") {
				alert(result);
			}
		});
	</script>
</body>
</html>