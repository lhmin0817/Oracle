-- View , Index 
show user;

--View 의 정보를 저장하는 데이터 사전
select * from user_views;

--Index 정보를 저장하는 데이터 사전
select * from user_indexes;

--Views : 가상의 테이블, 데아터가 저장되어 있지 않다.
    -- 실제 테이블의 값을 select 하는 코드만 들어가 있다. 
    -- 목적 : 1. 보안을 위해서 사용하는 경우 - 실제 테이블의 특정 컬럼을 숨겨서 처리를 할 수 있다.
    --       2. 편의성을위해서 사요아하는 경우 - 복잡한 구문을 뷰로 만들어서 처리
    --          JOIN 구문, 복잡한 구문,

-- View 실습을 위한 샘플 테이블 생성
create table emp100
as 
select * from employee;

select * from emp100;

--view 생성 : 1. 보안을 위해서 사용하는 경우
    --view 는 실제 테이블의 주로 select 구문을 저장하고 있다.
    --view 는 가상의 테이블, 데이터를 저장하고 있지 않다.
    -- 실제 테이블의 실행 코드만 들어 있다.
    
-- 보안을 위해서 생성한 view  : 실제이블의 특정 컬럼을 출력하지 않을 수 있다.
create view V_emp
as
select eno, ename, salary from employee;

--view 를 실행 : select * from 뷰명
select * from V_emp;

--view 정보를 담은 데이터 사전
select * from user_views;

--view 의 내용을 수정 ; 주의 : oracle 에소는 alter view가 없다.
    --create or replace view 구문을 사용

create or replace view V_emp
as
(select eno, ename, salary from employee);


--view 의 삭제
drop view V_emp;

--2. 편의성을 위해서 view 를 사용 : 복잡한 JOIN구문을 VIEW로 생성하고 
    --VIEW를 select 하면 된다.
-- 사원이름. 상사 이름을 바로 출력하는 쿼리 : self 조인을 사용해서 
create view v_emp02
as
select e.ename 사원이름,e2.ename 상사이름 
from employee e, employee e2
where e.manager = e2.eno;

select * from user_views;

select * from v_emp02;

-- 사원명, 월급, 부서번호, 부서명, 부서위치를 출력하는 view를 생성 : v_emp_dept
create view v_emp_dept
as
select eno 사원번호, ename 사원명, e.dno 부서번호, dname 부서명, loc 부서위치
from employee e INNER JOIN department d     
on e.dno = d.dno;

select * from v_emp_dept;

-- 뷰의 처리 과정 
    -- view 는 가상의 테이블이고 값을 가지고 있지 않다. (select, join)
    -- 실행 쿼리만 가지고 있다. (select)
    
    -- 1, user_views의 데이터 사전에서 뷰 이름에 대한 쿼리를 조회
    -- 2. 접속한 계정이 실제 테이블에 접근할 수 있는 권한이 있는 확인
    -- 3. 각 테이블의 권한이 있으면 쿼리를 실행
    -- 4. 검색 (값을 가지고 온다.)
    -- 5. 출력

-- view 를 사용해서 값을 넣을  수 있다.
    -- view 에는 값이 저장되지 않는다. 코드만 존재,
    -- 값을 실제 테이블에 저장
    -- 실제 테이블의 제약조건에 따라서 값이 저장될 수 있고 안될 수 있다.

select * from emp100;  -- 테이블을 복사 했으므로 제약 조건이 모두 빠져있다.

-- 테이블의 제약조건 을 확인하는 데이터 사전
select * from user_constraints
where table_name in('EMP100');

--view 생성
create or replace view v_emp10
as
select eno, ename, salary
from emp100;

select *from v_emp10;

--view 에 값 넣기 <== 실제 테이블에 저장 (emp100)
insert into v_emp10
values (8888, 'KORNAN',6000);

commit;

--view 의 값을 넣으면 실제 테이블에 값이 저장됨
select * from emp100;

--view 에 값을 저장 시 실제 테이블에 저장이 되면서 실제 테이블에 제약 조건에 따라서
    --값이 저장될 수도 있고 그렇지 않을 수 있다.

--view 를 사용해서 값을 삭제 : 실제 테이블 : emp100
delete v_emp10
where eno = 8888;
commit;

select * from emp100;

-- alter table 을 사용해서 hiredate 컬럼에 NOT NULL 제약 조건을 추가
    -- not null / default 수정할 때는 modify를 사용
alter table emp100
modify hiredate constraint EMP100_HIREDATE_NN not null ;

select * from user_constraints
where table_name = 'EMP100';

--테이블에 제약 조건위배로 view에서 값을 넣을 때 오류가 발생
select * from v_emp10;

insert into v_emp10
values (9999, 'KENDY', 7000);

--view를 사용해서 INSERT, UPDATE, DELETE 할 때 실제 테이블의 제약 조건에 따라 달라진다.

-- 뷰 
    -- 1. 단순뷰(Simple view) : 하나의 테이블로 생성된 view
    -- 2. 복합뷰(Complex view) : 두개이상의 테이블로 생성된 view
        --뷰 내에서는 DISTINC,그룹함수(SUM, AVG, MAX ,MIN), Group by 사용 시 오류
        -- ROWNUM을 사용하지 못한다.
        -- 단, 그룹함수를 사용 할 경우 반드시 별칭이름을 사용하면 사용할 수 있다.
    -- ROWNUM : 레코드의 숫자를 출력 해줌, ROW의 넘버를 출력
    -- MS-SQL, MYSQL : TOp n
    
--출력 중 10개만 출력  <== 레코드가 많을 때 조건을 사용해서 출력
select rownum, eno, ename, salary
from employee
where rownum <10;


--중복된 값을 제거 : DISTINCT 
select distinct job from employee;

--view 내부에 Rownum컬럼 때문에 오류 발생 / 별칭 사용 시 해결
create or replace view v_emp30
as
select rownum 행번호, eno, ename from emp100;

select * from v_emp30;
drop table v_emp30;

--view 내부에 Distinct 를 사용하면 별칭이름 없이 잘 생성
create or replace view v_emp31
as
select distinct job from emp100;

--view 내부에서 그룹 함수를 사용했을 때 : sum ,avg , max, min , conut(*)
    -- 오류 발생 : 별칭이름을 사용해서 뷰를 생성
create or replace view v_emp32
as
select sum(salary), round(avg(salary)), max(salary), min(salary)
from emp100;

-- 뷰에서 그룹함수 사용 시 별칭이름을 부여해서 사용 : 오류가 발생되지 않느다.
create or replace view v_emp32
as
select sum(salary) 합계, round(avg(salary)) 표균,
        max(salary) 최대값, min(salary) 최소값
from emp100;
select * from v_emp32;

-- view 내부에서 group by 사용 <== 별칭이름을 사용하지 않아 오류
create or replace view v_emp33
as
select sum(salary), round(avg(salary),2), max(salary), min(salary), count(*)
from emp100
group by dno;

-- view 내부에서 group by 사용 <== 별칭이름을 사용 : 오류 없음
create or replace view v_emp33
as
select sum(salary) 합계, round(avg(salary),2) 표균,
        max(salary) 최대값, min(salary) 최소값, count(*) 그룹된갯수
from emp100
group by dno;

--뷰를 생성 시 옵션을 사용
    -- force 옵션 : 기존 테이블 생성 유무에 상관없이 뷰를 생성
    -- noforce 옵션 : 반드시 기존 테이블이 존재해야만 생성 (기본값)
    
create or replace force view v_emp34
as
select * from emp101;       --eml01 테이블은 존재하지 않으므로 뷰 생성 시 오류

select * from user_views;

-- view 생성 이후에 테이블 생성
create table emp101
as
select * from employee;


-- index (인덱스, 색인) : 테이블의 컬럼에 검색을 빠르게 하기위해 컬럼에 index를 생성
    --select 를 빠르게 하기 위해서 사용
    -- 테이블 스캔 : 검색할 내용을 첫 레코드부터 마지막 레코드까지 순차적으로 검색
    -- 검색할 내용을 찾기 위해서 책의 첫장부터 마지막 장까지 검색
    --  index 가 생성되어있지 않은 컬럼의 내용을 검색할 때는 테이블 스캔을 한다.
    -- index 정보를 사용한 스캔 : 검색이 빠름
        -- index 를 사용해서 정보를 검색
        -- 책의 색인, 목차(index)
        
    -- 자주 검색에서 사용되는 컬럼은 index를 생성해서 검색을 빠르게 한다.
        -- where 절에서 사용되는 컬럼
        -- join 시 on절에서 사용되는 컬럼

        -- 테이블의 index 정보를 출력하는 데이터 사전
        -- select * from user_indexes
            --where table_name in ('EMPLOYEE', DEPARTMENT');
        -- select * from user_columns
            --where table_name in ('EMPLOYEE', DEPARTMENT');
        -- select * from user_ind_columns
            --where table_name in ('EMPLOYEE', DEPARTMENT');
        
        -- 테이블의 primary key, unique컬럼은 자동으로 index가 생성
        
--ename 컬럼은 index가 생성되지 않아서 테이블 스캔한다.
select * from employee
where ename = 'KING';


select * from user_ind_columns
    where table_name in ('TBL1', 'TBL2');
    
-- 테이블의 primary key, unique컬럼은 자동으로 index가 생성
create table tbl1(
    a number(4) constraint tbl1_a_pk primary key,
    b number(4),
    c number(4)
    );

create table tbl2(
    a number(4) constraint tbl2_a_pk primary key,
    b number(4) constraint tbl2_b_uk unique,
    c number(4) constraint tbl2_c_uk unique
    );

-- 특정 컬럼에 index부여하기, where 절, join 시 on 절에서 사용되는 컬럼
select * from employee;

--employee 테이블의 ename컬럼은 검색을 자주 사용한다. 레코드가 10만개 존재
    --컬럼에 index를 생성하면 컬럼의 값을 가지고 index페이지를 생성
    -- 부하가 굉장히 많이 걸리느 작업 / 야간에 index를 생성
    
    --DBA 과정에서 전문적으로 다룬다.
        -- index는 DBMS를 장 이해하고 잘 생성해야 한다.
        -- index는 잘못 만들면 오히려 성능이 떨어진다
        -- 주기적으로 index정보를 업데이트 (insert. update, delete)
            --rebuild

--index 가 테이블의 어떤 컬럼에 index 가 생성되었는 지 확인 
select * from user_ind_columns
where table_name = 'EMPLOYEE';

-- index 자세한 정보를 출력
select * from user_indexes
where table_name = 'EMPLOYEE';

create index inx_employee_ename
on employee(ename);


--index 는 생성 후 지속적인 관리가 필요
    -- employee 테이블의 ename컬럼에 index를 생성함 
        -- ename컬럼에 insert, update, delete 빈번하게 일어난 경우 index페이지가 조각난다.
        -- 주기적으로 rebuild 해줘야한다. (index 페이지를 업데이트해야 한다.)
        
--생성된 index정보를 새로이 업데이트
alter index inx_employee_ename rebuild;    
--ename커럶의 수정된 정보를 index페이지에 새로이 업데이트

--employee  테이블에서 job 컬럼을 빈번하게 검색
create index idx_employee_job
on employee(job);

--employee 테이블의 job컬럼에 insert, update, delete 빈번하게 일어난 경우 index페이지가 조각난다.
    -- 주기적으로 수정될 경우 업데이트가 필요 : 1주, 1달....
    -- 레코드가 적을 때는 생성할 필요가 없다 10만 건 이상되면 테이블 스캔으로 검색
        --시간이 오래 걸릴 경우 index 생성의 필요성이 있음
alter index idx_employee_job rebuild;

--index 정보 출력
select * from user_ind_columns
where table_name = 'EMPLOYEE';

-- 생성된 index 삭제
drop index inx_employee_ename;
drop index idx_employee_job;


--ERD(Entity Telatioship Diagram) : DB 모델링, 설계도
    --테이블과 테이블의 관계 
    --ER-WIN : 전 세계적으로 제일 많이 사용한는 모델링 툴


/*
모델링
    요구사항 분석 ==> 논리적 모델링 ==> 물리적 모델링 ==> 구현 
    
    요구사항 분석 : 업무 파악, 고객과 협의, 프로잭트의 범위를 지정(비용, 기간) <== 주의
        어떤 테이블을 만들지, 각 테이블의 속성, 테이블간의 관계, 
    
            DB 설계 ==> APP을 개발
            
    논리적 모델링 
        엔티티(논리적 모델링) : 테이블 (물리적 모델링)
        속성  (논리적 모델링) : 컬럼  (물리적 모델링)
        관계  (논리적 모델링) : 1:1관계, 1:다 관계, 다:다 관계
    
    물리적 모델링 (영문으로, 테이블 명, 컬럼명, 컬럼의 자료형을 적용, 테이블간의 관계)
        
    구현(Oracle ) <== 물리적 모델링을 기반으로 테이블 생성


*/







