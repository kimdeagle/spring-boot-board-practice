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
<title>Board View</title>

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
				<h3 class="panel-title">게시글 조회</h3>
			</div>
			<div class="panel-body">
				<div class="form-group">
					<label>번호</label> <input type="text" class="form-control" name="bno" value="${board.bno}" readonly>
				</div>
				<div class="form-group">
					<label>제목</label> <input type="text" class="form-control" name="title" value="${board.title}" readonly>
				</div>
				<div class="form-group">
					<label>내용</label>
					<textarea class="form-control" rows="3" name="content" readonly>${board.content}</textarea>
				</div>
				<div class="form-group">
					<label>글쓴이</label> <input type="text" class="form-control" name="userid" value="${board.userid}" readonly>
				</div>
				<div class="form-group">
					<label>작성일</label> <input type="text" class="form-control" name="regdate" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${board.regdate}" />" readonly>
				</div>
			</div>
			<div class="panel-footer text-right">
				<button class="btn btn-success" onclick="location.href='/board/modify?bno=${board.bno}'">수정</button>
				<button id="removeBtn" class="btn btn-danger">삭제</button>
				<button class="btn btn-default" onclick="location.href='/board/list'">목록</button>
			</div>
		</div>
	
	</div>
	
	<!-- Modal -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-sm">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">게시글 삭제</h4>
				</div>
				<div class="modal-body">삭제하시겠습니까?</div>
				<div class="modal-footer">
					<button type="button" id="removeCheckBtn" class="btn btn-danger">삭제</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
				</div>
			</div>
		</div>
	</div>
	
	<script type="text/javascript">
		$(document).ready(function() {
			$("#removeBtn").click(function(e) {
				$("#myModal").modal("show");
			});
			
			$("#removeCheckBtn").click(function(e) {
				self.location = "/board/remove?bno=${board.bno}";
			});
			
		});
	</script>

</body>
</html>