<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="today" class="java.util.Date" />
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 위 3개의 메타 태그는 *반드시* head 태그의 처음에 와야합니다; 어떤 다른 콘텐츠들은 반드시 이 태그들 *다음에* 와야 합니다 -->
<title>Board List</title>

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
				<h3>게시판 목록
				<c:if test="${not empty pagination.keyword}">
					<small>(검색 결과 : ${pagination.totalBoardCnt}건)</small>
				</c:if>
				<c:if test="${empty pagination.keyword}">
					<small>(총 게시글 : ${pagination.totalBoardCnt}건)</small>					
				</c:if>
					<button class="btn btn-primary pull-right" onclick="location.href='/board/register'">작성</button>
				</h3>
				<div class="clearfix"></div>
			</div>
			<div class="panel-body">
				<table class="table">
					<thead>
						<tr>
							<th>번호</th>
							<th>제목</th>
							<th>작성일</th>
							<th>조회수</th>						
							<th>작성자</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${list}" var="board">
						<tr>
							<fmt:parseNumber var="nowHour" value="${today.time / 1000 / 60 / 60}" integerOnly="true"></fmt:parseNumber>
							<fmt:parseNumber var="regdateHour" value="${board.regdate.time / 1000 / 60 / 60}" integerOnly="true"></fmt:parseNumber>
							<td width="15%">${board.bno}</td>
							<td width="30%">
								<a href="/board/get?bno=${board.bno}&pageNum=${pagination.pageNum}&amount=${pagination.amount}&type=${pagination.type}&keyword=${pagination.keyword}">${board.title}</a>
								<c:if test="${board.replycnt != 0}">
									<span class="badge">${board.replycnt}</span>
								</c:if>
								<c:if test="${nowHour - regdateHour < 24}">
									<span class="label label-danger">new</span>
								</c:if>
							</td>
							<td width="25%"><fmt:formatDate pattern="yyyy/MM/dd" value="${board.regdate}"/></td>
							<td width="15%">${board.readcnt}</td>
							<td width="15%">${board.userid}</td>
						</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div class="panel-footer text-right">
				<nav>
					<ul class="pager" style="margin: 5px;">
						<c:if test="${not empty pagination.keyword}">
							<li><a href="/board/list?type=${pagination.type}&keyword=${pagination.keyword}">처음으로</a></li>
							<li><a href="/board/list?pageNum=${pagination.totalPageCnt}&amount=${pagination.amount}&type=${pagination.type}&keyword=${pagination.keyword}">끝으로</a></li>						
						</c:if>
						<c:if test="${empty pagination.keyword}">
							<li><a href="/board/list">처음으로</a></li>
							<li><a href="/board/list?pageNum=${pagination.totalPageCnt}&amount=${pagination.amount}">끝으로</a></li>						
						</c:if>
					</ul>
				</nav>
				<nav>
					<ul class="pagination">
						<c:if test="${not empty pagination.keyword}">
							<c:if test="${pagination.prev}">
								<li><a href="/board/list?pageNum=${pagination.startPage - 1}&amount=${pagination.amount}" aria-label="Previous"> <span aria-hidden="true">&laquo;</span></a></li>						
							</c:if>
							<c:forEach var="num" begin="${pagination.startPage}" end="${pagination.endPage}">
								<li class="${pagination.pageNum == num ? 'active' : ''}"><a href="/board/list?pageNum=${num}&amount=${pagination.amount}&type=${pagination.type}&keyword=${pagination.keyword}">${num}</a></li>
							</c:forEach>
							<c:if test="${pagination.next}">
								<li><a href="/board/list?pageNum=${pagination.endPage + 1}&amount=${pagination.amount}&type=${pagination.type}&keyword=${pagination.keyword}" aria-label="Next"> <span aria-hidden="true">&raquo;</span></a></li>
							</c:if>
						</c:if>
						<c:if test="${empty pagination.keyword}">						
							<c:if test="${pagination.prev}">
								<li><a href="/board/list?pageNum=${pagination.startPage - 1}&amount=${pagination.amount}" aria-label="Previous"> <span aria-hidden="true">&laquo;</span></a></li>						
							</c:if>
							<c:forEach var="num" begin="${pagination.startPage}" end="${pagination.endPage}">
								<li class="${pagination.pageNum == num ? 'active' : ''}"><a href="/board/list?pageNum=${num}&amount=${pagination.amount}">${num}</a></li>
							</c:forEach>
							<c:if test="${pagination.next}">
								<li><a href="/board/list?pageNum=${pagination.endPage + 1}&amount=${pagination.amount}" aria-label="Next"> <span aria-hidden="true">&raquo;</span></a></li>
							</c:if>
						</c:if>
					</ul>
				</nav>
				<div class="form-inline">
					<select class="form-control" id="type" name="type">
						<option value="T" ${pagination.type == 'T' ? 'selected' : ''}>제목</option>
						<option value="C" ${pagination.type == 'C' ? 'selected' : ''}>내용</option>
						<option value="TC" ${pagination.type == 'TC' ? 'selected' : ''}>제목+내용</option>
						<option value="U" ${pagination.type == 'U' ? 'selected' : ''}>작성자</option>
					</select>
					<input type="text" class="form-control" id="keyword" name="keyword" value="${pagination.keyword}">
					<button class="btn btn-default" id="searchBtn">검색</button>
					<c:if test="${not empty pagination.keyword}">
						<button class="btn btn-default" id="resetBtn" onclick="location.href='/board/list'">초기화</button>
					</c:if>
				</div>
			</div>
		</div>

	</div>
	
	<script type="text/javascript">
		$(document).ready(function() {
			
			var result = "${result}";
	
			if (result != null && result != "") {
				alert(result);
			}
			
			$("#searchBtn").click(function(e) {
				search();
			});
			
			$("#keyword").keyup(function(e) {
				if (event.keyCode == 13) {
					search();
				}
			});
			
			function search() {
				var type = $("#type").val();
				var keyword = $("#keyword").val().trim();
				
				if (keyword == null || keyword == "") {
					alert("검색어를 입력해주세요.");
					$("#keyword").val("").focus();
					return;
				}
				
				self.location = "/board/list?pageNum=1&amount=${pagination.amount}&type=" + type + "&keyword=" + keyword;
			}
			
		});
	</script>
	
</body>
</html>