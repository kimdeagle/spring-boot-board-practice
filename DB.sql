-- 회원 테이블
create table tbl_member(
    userid varchar(50) not null,
    userpw varchar(50) not null,
    name varchar(50) not null,
    email varchar(100) null,
    regdate datetime default now(),
    primary key (userid)
);

-- 게시판 테이블
create table tbl_board(
    bno int not null auto_increment,
    title varchar(100) not null,
    content text not null,
    image varchar(255) null,
    readcnt int default 0,
    regdate datetime default now(),
    updatedate datetime default now(),
    userid varchar(50) not null,
    primary key (bno),
    foreign key (userid) references tbl_member (userid)
);

-- 댓글 테이블
create table tbl_reply(
    rno int not null auto_increment,
    bno int not null,
    replyer varchar(50) not null,
    reply varchar(500) not null,
    regdate datetime default now(),
    primary key (rno),
    foreign key (bno) references tbl_board (bno),
    foreign key (replyer) references tbl_member (userid)
);

-- 댓글수 컬럼 추가
alter table tbl_board
add replycnt int default 0;

-- 댓글수 업데이트
update tbl_board b
set replycnt = (select count(*) from tbl_reply where bno = b.bno);