$(document).ready(function(e) {
	getReplyList();
	
	function getReplyList() {
		
		$("#tblReply tbody").html("");
		
		$.ajax({
			type: "get",
			url: "/replies",
			data: "bno=" + "${board.bno}",
			success: function(result) {
				
				$.each(result, function(index, item) {
					
					var replyer = item.replyer;
					
					var str = "";
					
					str += "<tr>";
					str += "<td>";
					str += item.replyer;
					str += "</td>";
					str += "<td>";
					str += "<span>"+ item.reply +"</span>";
					if (item.replyer == "${userid}") {
						str += " <button class='btn btn-xs btn-success' id='modifyReplyBtn' data-rno='"+ item.rno +"'>수정</button>";							
						str += " <button class='btn btn-xs btn-danger' id='removeReplyBtn' data-rno='"+ item.rno +"'>삭제</button>";
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
	}
	
	var parent, oldHtml, oldReply;
	
	$(document).on("click", "#modifyReplyBtn", function(e) {
		parent = $(this).closest("td");
		oldHtml = parent.html();
		oldReply = parent.children("span").text();

		parent.children("span").html("<input type='text' class='form-control' value='"+ oldReply +"'>");
		
		$(this).prop("id", "modifyConfirmReplyBtn");
		parent.children("button[id='removeReplyBtn']").prop("class", "btn btn-xs btn-default").prop("id", "cancelBtn").text("취소");
	});
	
	$(document).on("click", "#modifyConfirmReplyBtn", function(e) {
		var reply = $(this).closest("td").children("span").children("input").val();
		
		$.ajax({
			type: "patch",
			url: "/replies/" + $(this).data("rno"),
			data: "reply=" + reply,
			success: function(result) {
				alert(result);
				getReplyList();
			},
			error: function(a, b, c) {
				alert(a, b, c);
			}
		});
	});
	
	$(document).on("click", "#removeReplyBtn", function(e) {
		if (confirm("삭제하시겠습니까?")) {
			
			$.ajax({
				type: "delete",
				url: "/replies/" + $(this).data("rno"),
				success: function(result) {
					alert(result);
					getReplyList();
				},
				error: function(a, b, c) {
					alert(a, b, c);
				}
				
			});
		}
	});
	
	$(document).on("click", "#cancelBtn", function(e) {
		parent.html(oldHtml);
	});
	
	$("#addReplyBtn").click(function(e) {
		var reply = $("#reply");
		
		$.ajax({
			type: "post",
			url: "/replies",
			data: { reply: reply.val(), replyer: "${userid}", bno: "${board.bno}" },
			success: function(result) {
				alert(result);
				getReplyList();
			},
			error: function(a, b, c) {
				alert(a, b, c);
			}
		});
		
	});
});