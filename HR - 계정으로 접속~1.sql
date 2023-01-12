select * from guestboard;

/*최신글을 제일 먼저 출력하는 쿼리*/
select * from guestboard order by inputdat desc;

select * from guestlab;
select * from guestlab order by ename desc;

select * from guestboard order by inputdat desc;


-------게시판 (질문 답변형 게시판)-----------
create table freeboard(
    id number constraint PK_freeboard_id Primary key,
    name varchar2(100) not null,
    password varchar2(100) not null,
    email varchar2(100) null,
    subject varchar2(100)not null,
    content varchar2(2000) not null,
    inputdate varchar2(100) not null,
    --답변 글을 처리하는 컬럼
    masterid number default 0,
    readcount number default 0,
    replaynum number default 0,
    step number default 0
);

select * from freeboard;
select max(id) as id from freeboard;

select id from freeboard;
select * from freeboard order by id desc;
--더미 값 insert
insert into freeboard (id, name, password, email, subject, content, inputdate,
    masterid, readcount, replaynum, step)
values(1,'홍길동','123','aaa@aaa.com','제목','내용','23-01-12 11:59 오전',
    1,0,0,0);
    
insert into freeboard (id, name, password, email, subject, content, inputdate,
    masterid, readcount, replaynum, step)
values(3,'홍길동','123','aaa@aaa.com','제목','내용','23-01-12 11:59 오전',
    3,0,0,0);
    
select * from freeboard 
where id =14;

commit;