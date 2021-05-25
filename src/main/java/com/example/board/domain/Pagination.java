package com.example.board.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Pagination {

	private int pageNum; //현재 페이지 번호
	private int amount; //페이지당 게시글 수
	private int startIdx; //mysql limit 시작 숫자

	private String type; //검색 조건
	private String keyword; //검색어
	
	private int totalBoardCnt; //총 게시글 수
	private int totalPageCnt; //총 페이지 수
	
	private int startPage; //시작 페이지
	private int endPage; //끝 페이지
	
	private int lastPage; //실제 끝나는 페이지
	
	private boolean prev; //이전 페이지
	private boolean next; //다음 페이지
	
	public Pagination() {
		//기본 페이지 번호 : 1번, 게시글 수 : 10개
		this.pageNum = 1;
		this.amount = 10;
	}

	public void setPagination(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
		this.startIdx = (pageNum - 1) * amount;
		
		this.totalPageCnt = (int)Math.ceil(this.totalBoardCnt / 10.0);
		
		this.endPage = (int)Math.ceil(this.pageNum / 10.0) * amount;
		this.startPage = this.endPage - amount + 1;
		
		this.lastPage = (int)Math.ceil(this.totalBoardCnt / 10.0);
		
		if (this.lastPage < this.endPage) {
			this.endPage = this.lastPage;
		}
		
		this.prev = this.startPage > 1;
		this.next = this.endPage < this.lastPage;
		
		
	}
	
}
