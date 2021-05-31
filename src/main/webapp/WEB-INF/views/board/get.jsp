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
				<h3>게시글 조회</h3>
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
					<label>조회수</label> <input type="text" class="form-control" name="readcnt" value="${board.readcnt}" readonly>
				</div>
				<div class="form-group">
					<label>작성자</label> <input type="text" class="form-control" name="userid" value="${board.userid}" readonly>
				</div>
				<div class="form-group">
					<label>작성일</label> <input type="text" class="form-control" name="regdate" value="<fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${board.regdate}" />" readonly>
				</div>
			</div>
			<div class="panel-footer text-right">
				<c:if test="${board.userid == userid}">
					<button class="btn btn-success" onclick="location.href='/board/modify?bno=${board.bno}&pageNum=${pagination.pageNum}&amount=${pagination.amount}&type=${pagination.type}&keyword=${pagination.keyword}'">수정</button>
					<button id="removeBtn" class="btn btn-danger">삭제</button>				
				</c:if>
				<button class="btn btn-default" onclick="location.href='/board/list?pageNum=${pagination.pageNum}&amount=${pagination.amount}&type=${pagination.type}&keyword=${pagination.keyword}'">목록</button>
			</div>
		</div>
		
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3>댓글</h3>
			</div>
			<div class="panel-body">
				<table id="tblReply" class="table">
					<thead>
						<tr>
							<th width="15%">작성자</th>
							<th width="60%">내용</th>
							<th width="25%">작성일</th>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
				<c:if test="${not empty userid}">
				<div class="input-group">
					<input type="text" class="form-control" id="reply" name="reply" placeholder="최대 200자 작성 가능" >
					<span class="input-group-btn">
						<button id="addReplyBtn" class="btn btn-primary">작성</button>
					</span>
				</div>
				</c:if>
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
						<button type="button" id="removeConfirmBtn" class="btn btn-danger">삭제</button>
						<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
					</div>
				</div>
			</div>
		</div>
	
	</div>
	
	<script type="text/javascript">
		$(document).ready(function() {
			
			var bno = "${board.bno}";
			var userid = "${userid}";
			var replycnt = "${board.replycnt}";
			
			//댓글 조작 관련 변수 선언
			var parent, oldHtml, oldReply, rno, reply;
			
			//댓글 리스트 가져오기
			getReplyList();
			
			//게시글 삭제 버튼
			$("#removeBtn").click(function(e) {
				$("#myModal").modal("show");
			});
			
			//게시글 삭제 모달 > 삭제 버튼
			$("#removeConfirmBtn").click(function(e) {
				if (replycnt != 0) {
					alert("댓글 있는 게시글은 삭제할 수 없습니다.");
					$("#myModal").modal("hide");
					return;
				}
				self.location = "/board/remove?bno=${board.bno}";
			});
			
			//댓글 작성 버튼 클릭
			$("#addReplyBtn").click(function(e) {
				registerReply();
			});
			
			//댓글 입력창에서 엔터 입력
			$("#reply").keyup(function(e) {
				if (e.keyCode == 13) {
					registerReply();
				}
			});
			
			//댓글 수정 버튼 클릭
			$(document).on("click", "#modifyReplyBtn", function(e) {
				parent = $(this).closest("td");
				oldHtml = parent.html();
				oldReply = parent.children("span").text();

				//수정할 수 있도록 입력컨트롤로 변경
				parent.children("span").html("<input type='text' class='form-control' value='"+ oldReply +"'>");
				
				//수정내용 작성 후 수정할 수 있도록 버튼 id 변경
				$(this).prop("id", "modifyConfirmReplyBtn");
				
				//삭제 버튼 대신 취소 버튼으로 변경
				parent.children("button[id='removeReplyBtn']").prop("class", "btn btn-sm btn-default").prop("id", "cancelBtn").text("취소");
			});
			
			//수정내용 작성 후 수정 버튼 클릭
			$(document).on("click", "#modifyConfirmReplyBtn", function(e) {
				
				rno = $(this).data("rno");
				reply = $(this).closest("td").children("span").children("input").val();
				
				modifyReply(rno, reply);
			});
			
			//댓글 수정 -> 취소 버튼 클릭
			$(document).on("click", "#cancelBtn", function(e) {
				//기존 내용으로 교체
				parent.html(oldHtml);
			});
			
			//댓글 삭제 버튼 클릭
			$(document).on("click", "#removeReplyBtn", function(e) {
				rno = $(this).data("rno");
				removeReply(rno, bno);
			});
			
			function getReplyCnt() {
				$.ajax({
					type:"get",
					url: "/board/getReplyCnt",
					data: "bno=" + bno,
					success: function(result) {
						replycnt = result;
					},
					error: function() {
						alert("error");
					}
				});
			}
			
			function getReplyList() {
				//댓글 리스트 초기화
				$("#tblReply tbody").html("");
				
				$.ajax({
					type: "get",
					url: "/replies",
					data: "bno=" + bno,
					success: function(result) {
						
						if (result.length == 0) {
							$("#tblReply tbody").append("<tr><td colspan='3' class='text-center'><b>댓글이 없습니다.</b></td></tr>");
							return;
						}
						
						$.each(result, function(index, item) {
							
							var str = "";
							
							str += "<tr>";
							str += "<td>";
							str += item.replyer;
							str += "</td>";
							str += "<td>";
							str += "<span>"+ item.reply +"</span>";
							if (item.replyer == userid) {
								//로그인한 본인이 작성한 댓글에 수정/삭제 버튼 추가
								str += " <button class='btn btn-sm btn-success' id='modifyReplyBtn' data-rno='"+ item.rno +"'>수정</button>";							
								str += " <button class='btn btn-sm btn-danger' id='removeReplyBtn' data-rno='"+ item.rno +"'>삭제</button>";
							}
							str += "</td>";
							str += "<td>";
							str += item.regdate;
							str += "</td>";
							str += "</tr>";
							
							$("#tblReply tbody").append(str);
						});
						
					},
					error: function(a, b, c) {
						alert(a, b, c);
					}
				});	
			} //getReplyList();
			
			function registerReply() {
				
				//댓글 입력하지 않은 경우(공백 포함)
				if ($("#reply").val().trim() == "") {
					alert("댓글을 입력해주세요.");
					$("#reply").val("").focus();
					return;
				}
				
				$.ajax({
					type: "post",
					url: "/replies",
					data: { reply: $("#reply").val(), replyer: userid, bno: bno },
					success: function(result) {
						alert(result); //성공 or 실패
						$("#reply").val("");
						getReplyList(); //댓글 목록 갱신
						getReplyCnt(); //댓글수 갱신
					},
					error: function() {
						alert("error");
					}
				});
			} //registerReply()
			
			function modifyReply(rno, reply) {
				$.ajax({
					type: "patch",
					url: "/replies/" + rno,
					data: "reply=" + reply,
					success: function(result) {
						alert(result); //성공 or 실패 알림
						getReplyList(); //댓글 목록 갱신
					},
					error: function() {
						alert("error");
					}
				});
			} //modifyReply()
			
			function removeReply(rno, bno) {
				//삭제 여부 확인
				if (confirm("삭제하시겠습니까?")) {
					
					$.ajax({
						type: "delete",
						url: "/replies/" + rno,
						data: "bno=" + bno,
						success: function(result) {
							alert(result); //성공 or 실패 알림
							getReplyList(); //댓글 목록 갱신
							getReplyCnt(); //댓글수 갱신
						},
						error: function() {
							alert("error");
						}
						
					});
				}
			} //removeReply()
			
		});
	</script>

</body>
</html>