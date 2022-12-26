/*
    SQL (Structured Query Language : 구조화된 질의 언러, (시쿨)
        select 컬럼
        from 테이블 명, 뷰 명
        where 조건
        group by 그룹핑할 컬럼 명
        having 나온결과에 대한 조건
        order by 정렬할 컬럼
    
    DDL (Data Definition Language)      객체를 생성 수정 삭제
        객체(Object) - Table, View, Function, Index, Srore Procudure, Triger.....
        CTEATE(생성)  ALTER(수정)  DROP(삭제)
        RENAME(객체이름변경). TRUNCATE(레코드삭제)
        
    DML (Data Manipulation Language) : 데이터 조작 언어, 레코드를 생성, 수정 삭제
        INSERT(생성), UPDATE(수정), DELETE(삭제)
        --트랜잭션을 발생 commit(DB에 영구 저장), rollback(원래 상태로 복구)
    DCL (Data COntrol Language) : 데이터 제어 언어, 계정을 생성, 권한을 부여, 삭제할 때 사용
        GRANT(권한을 부여) REVOKE(권한을 취소)
    
    DQL(Data Query Language) : 데이터 질의 언어(출력) : SELECT
     
    TCL (Transaction Control Laguage) : 트랜잭션 제어 언어
        BEGIN TRANSACTION   <== 트랜잭션 시작 (INSERT  UPDATE  DELETE  <==DML)
        
        COMMIT              <== 트랜잭션을 종료(DateBase에 영구 저장)
        ROLLBACK            <== 트랜잭션을 종료(원래 상태로 되돌림, 트랜잭션 시작전 상태로 복구)
        SAVEPOINT           <== (트랜잰션내의 임시 저장 시점 설정)

*/
-- 테이블 생성 (Create Table)
CREATE TABLE dept(                --생성할 테이블 명
    dno number(2) not null,       -- 컬럼명 자료형 number
    dname VARCHAR2(4) not null,
    loc VARCHAR2(13) null
    );
-- 테이블 구조 확인
desc dept;

--테이블에 값넣기 (insert into 테이블 명(명시할 컬럼명)values (넣을 값);
    --Begin tranction   <==트랜잭션이 자동시작
--begin TRANSACTION
insert into dept(dno, dname, loc)
VALUES(10, 'ACCO', 'SEOUL');


commit;     --Data Base 에 영구적으로 저장
rollback;   --트랜잭션 시작 시점으로 복구

--데이터 검색
select * from dept;
--컬럼과 값의 순서가 맞아야 한다.
insert into dept(dno,loc,dname)
values(20,'PUSAN','SALE');


--트랜잭션 (TEANTION) : 작업(일)을 처리하는 최소 단위
    -- DML (Insert, Update, Delete 문을 사용하면 자동으로 트랜잭션이 시작됨
    -- 트랜잭션을 종료하지 않으면 외부에서 다른 사용자가 접근을 못함(Lock)
    -- 트랜잭션 종료
        --commit : DB에 영구저장
        -- rollvack : 원래 상태로 복구
    --트랜잭션의 4가지 특장
        --원자성(Aromiciy) : 여러 구문을 하나의 작업 단위로 처리
        --일관성(Consistency) : 트랜잭션에서 처리한 결과는 일관성을 가져야 함
        --독립성(Isolation) : 하나의 트랜잭션이 처리되기 전까지 다른 트랜잭션과 격리
        --지속성(Durability) : commit 된 트랜잭션은 DB에 영구적으로 저장

select * from dept;
--컬럼과 값의 순서가 맞아야 한다.
insert into dept(dno,loc,dname)
values(20,'PUSAN','SALE');

--컬럼명을 생략 값넣기
insert into dept
values(30,'abc');

desc dept;

commit;

--회원 정보를 저장하는 테이블 생성
CREATE TABLE member01(
    id VARCHAR2(50) not null PRIMARY key,
    pass VARCHAR2(50) not null,
    addr VARCHAR2(100) null,
    phone VARCHAR(30) null,
    age number(3) not null,
    weight NUMBER(5, 2) not null
    );

--제약 조건 : 데이터의 무결성을 확보하기 위해서 테이블의 컬럼에 부여
            -- 무결설 : 오류없는 데니터, 원하는 데이터
    --not null :
    --Foreign key : 
    --primary key : 테이블에서 하나만 존재
        --적용된 컬럼은 중복된 값을 넣을 수 없다.
        --데이터를 수정할 때 삭제 시 조건을 사용하는 컬럼
        --인텓스가 자동으로 생성 <== 검색을 빠르게할 때 사용
        --null 을 넣을 수 없다.
        
    --unique : 중복된 값을 넣을 수 없다 테이블에서 여러번 넣을 수 있다.
        --null 을 넣을 수 있다. 1번만 넣을 수 있다.
        -- 인섹스가 자동으로 생성 <== 검색 빠르게 함
        
    --check : 값을 넣을 때 체크해서 값을 넣는다.
    --not null : 컬럼에 null을 넣을 수 없다.
show user
select * from user_constraints;         -- 현재 접속한 계정에서 생성된 객체의 모든 제약 조건을 확인

--원하는 테이블의 제약 조건 확인
select 8 from user_constraints
where table_name = 'EMPLOYEE';


desc member01;

insert into member01(id, pass, addr, phone, age, weight)
VALUES('aaaa','1234','서울 종로구','010-1111-1111',20,50.55);
insert into member01(id, pass, addr, phone, age, weight)
VALUES('bbbb','1234','서울 종로구','010-1111-1111',20,50.55);
insert into member01(id, pass, addr, phone, age, weight)
VALUES('ccc','1234','서울 종로구','010-1111-1111',20,50.55);
    
select * from member01;
    
--null 허용 컬럼에 null넣기
desc member01;

insert into member01
values('dddd', '1234', null, null, 30, 70.557);
    
insert into member01(pass, age, weight,id)
VALUES('1234',40, 88.888,'ee');
    
--수정 (update) <== 반드시 where 절을 사용해서 수정해야함 
    --where 절에 사용더ㅣ는 컬럼은 중복되지 않는 컬럼을 사용해서 수정 : primary key, unique
    --update 테이블 명
    --set 컬럼명 = 바꿀값, 컬럼명 = 바꿀값
    --where 조건
    
update member01
set phone = '010-2222-2222', age=55, weight=90.55
where id = 'bbbb';

rollback;

--update  시 중복되지 않는 컬럼을 조건을 준 경우
update member01
set phone='010-3333-3333',age=80
where id ='eee';

commit;

--delete : 반드시 shere 조건을 사용해야 한다. 조건없이 삭제하면 모든 데이터가 삭제
    --중복되지 않는 컬럼을 조건에 적용
select * from member01;
    
delete member01
where id = 'ccc';

rollback;
commit;

--테이블 복사 (EMP)
create table emp
as
select * from employee;

--복사된 테이블
select * from emp;

desc emp;

1. 값을 3 레코드 입력, 모든 값 입력, null이 허용된 컬럼에 null 넣기;

insert into emp
VALUES(7999,'이환민','SALESMAN',7566,'22/11/01',1800,null,10);

insert into emp
VALUES(null,'이환민',null,null,null,null,null,null);

insert into emp(ename)
VALUES('이환민');

2.update 를 사용해서 데이터 수정 scott의 보너스 500으로 수정
    영업사원들의 보너스를 300으로 수정
    ward의 부서를 10으로 수정
    allen의 manager를 7839, 월급을 1800, 입사월 22/01/01로 수정;
    
update emp
set commission = 500
where ename = 'SCOTT';
    
update emp 
set commission = 300
where job = 'SALESMAN';

update emp
set dno = 10
where ename = 'WARD';

update emp
set manager = '7839', salary='1800', hiredate='22/01/01'
where ename='ALLEN';
    
3. delete : eno 7788 와 6798의 레코드를 삭제
delete emp
where eno in (7788, 7698);

--Unique 제약 조건 : 중복된 데이터를 넣을 수 없다.
    --null을 넣을 수 있다 1번만 넣을 수 있다.
    --테이블에 특정 컬렁에 여러번 넣을 수 있다.
    --인덱스를 자동으로 생성 <== 검색을 아주 빠르게 함
    -- JOIN 시 ON 절, where 조건
    
create table customer1(
    id varchar(20) not null primary key,    --오류방생, primary key : not null
    pass varchar(20) not null unique,    -- 중복되지 않는 컬럼
    name varchar(20) null unique,        -- null허용 테이블에 여러번 넣을 수 있다.
    phone varchar(20) null unique,
    addr varchar(20) null
    );
desc customer1;

insert into customer1(id, pass, name, phone, addr)
values('aaa', '1234', '홍길동', '010-1111-1111','서울 종로');

select * from customer1;

insert into customer1(id, pass, name, phone, addr)
values('bbb', '1235', '홍길동1', '010-1112-1111','서울 종로');

--제약 조건 확인 하기 
SELECT * FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'CUSTOMER1';

--check 제약 조건 : 값을 컬럼에 넣을 때 체크해서 값을 넣는다.
--테이블 생성 시 제약조건의 이름을 부여하면서 테이블 생성
--제약조건 이름 생성 규칙 : 테이블 이름_컬럼명_제약조건유형
create table emp3(
    eno number(4) constraint emp3_eno_PK primary key,
    ename varchar2(10),
    salary number(7,2) constraint emp3_salary_CK check(salary >0)
    );

--emp3 테이블에 할당된 제약 조건 확인 하기
select * from USER_CONSTRAINTS
where table_name = 'EMP3';

insert into emp3 (eno, ename, salary)
values (1111,'SMITH', 10);

select * from emp3;


create table emp4(
    eno number(4) constraint emp4_eno_PK primary key,
    ename varchar2(10),
    salary number(7,2) constraint emp4_salary_CK check(salary >0),
    dno number(2) constraint emp4_dno_ck check(dno in (10,20,30,40))
    );

select * from USER_CONSTRAINTS
where table_name = 'EMP3';

insert into emp4
values (3333, 'SCOTT', 300,20);

select * from emp4;
commit;

select * from USER_CONSTRAINTS
where table_name = 'EMP4';

--foreing key (참조키) : 다른 테이블(부모의) Primary key, unique컬럼을 참조해서 값을 할당
select * from employee;     --dno : FK (department 테이블의 dno를 참조)

select * from department;   --부모, dno

insert into employee
values (8888,'aaaa', 'aaaa', 7788, '22/12/08', 6000, null, 40);

select * from employee; 
rollback;

--부모 테이블 생성 : Forening key가 참조하는 컬럼은 Primary key, unique키컬럼을 참조함
create table ParentTb1(
    name varchar2(20),
    age number(3) constraint ParentTb1_age_CK check(age>0 and age<200),
    gender varchar2(3) constraint ParentTb1_gender_CK check(gender IN('M', 'W')),
    infono number constraint ParentTb1_infono_PK Primary key
    );
    
create table ChiledTb1(
    id varchar2(40) constraint ChildTb1_id_PK primary key,
    pw varchar2(40),
    infono number,
    constraint ChildTb1_infono_FK foreign key (infono) references ParentTb1(infono)
    );
    
insert into ParentTb1 values ('홍길동',30,'M',1);
insert into ParentTb1 values ('김똘똘',20,'M',2);
insert into ParentTb1 values ('원빈',25,'M',3);
insert into ParentTb1 values ('홍길순',40,'W',4);

select * from ParentTb1;

--자식 테이블에 값 넣기
insert into ChiledTb1 values('aaa', '1234',1);
insert into ChiledTb1 values('bbb', '1234',2);
insert into ChiledTb1 values('ccc', '1234',2);
insert into ChiledTb1 values('cd', '1234',4);
    
select * from ChiledTb1;

--default : 컬럼의 값을 넣지 않을 때 default 로 설정된 값이 기본적으로 돌아간다.
    --제약 조건은 아니어서 제약 조건이름을 할당 할 수 없다.

create table emp5(
    eno number (4) constraint emp5_eno_PK primary key,
    ename varchar(10),
    slary number(7,2) default 1000           --값을 넣지 않은면 default로 설정된 값이 들어감
);

insert into emp5 (eno, ename, slary)
values (1111,'aaaa',5000);

nsert into emp5 (eno, ename)
values (2222,'aaaa');

select * from emp5;

--테이블 삭제
drop table member01;





