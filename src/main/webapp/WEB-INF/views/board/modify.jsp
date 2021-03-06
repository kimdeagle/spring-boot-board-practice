<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 위 3개의 메타 태그는 *반드시* head 태그의 처음에 와야합니다; 어떤 다른 콘텐츠들은 반드시 이 태그들 *다음에* 와야 합니다 -->
<title>Board Modify</title>

<!-- IE8 에서 HTML5 요소와 미디어 쿼리를 위한 HTML5 shim 와 Respond.js -->
<!-- WARNING: Respond.js 는 당신이 file:// 을 통해 페이지를 볼 때는 동작하지 않습니다. -->
<!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>
	<%@ include file="../inc/header.jsp"%>
	
	<div class="container">

		<div class="panel panel-default">
			<div class="panel-heading">
				<h3>게시글 수정</h3>
			</div>
			<form action="/board/modify" method="post">
				<div class="panel-body">
					<div class="form-group">
						<label>제목</label> <input type="text" class="form-control" id="title" name="title" value="${board.title}">
					</div>
					<div class="form-group">
						<label>내용</label>
						<textarea class="form-control" rows="3" id="content" name="content">${board.content}</textarea>
					</div>
					
					<input type="hidden" name="bno" value="${board.bno}">
				</div>
				<div class="panel-footer text-right">
					<c:if test="${board.userid == userid}">
						<button type="submit" class="btn btn-success">수정</button>					
					</c:if>
					<button id="cancelBtn" class="btn btn-default">취소</button>
				</div>
				
				<input type="hidden" name="pageNum" value="${pagination.pageNum}">
				<input type="hidden" name="amount" value="${pagination.amount}">
				<input type="hidden" name="type" value="${pagination.type}">
				<input type="hidden" name="keyword" value="${pagination.keyword}">
			</form>
		</div>

	</div>
	
	<script type="text/javascript">
		$(document).ready(function() {
			$("#title").focus();
			
			$("#cancelBtn").click(function(e) {
				e.preventDefault();
				
				history.back();
			});
		});
	</script>
</body>
</html>