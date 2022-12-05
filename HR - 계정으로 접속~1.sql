--모든 테이블 출력하기
select * from tab;

--테이블의 구조 확인하기

-- select : 출력하기
/*
  selsct 컬럼명
  from 테이블 이름
  
*/
--1. employee 테이블의 모든 컬럼을 출력
    -- 근로자(고용자)에 대한 정보를 저장
select * 
from employee;


--2. department 테이블의 모든 컬럼을 출력
    -- 부서에 대한 정보를 더장하는 테이블 
SELECT *
from department;

--3. salgrade 테이블의 모든 컬럼(필드, 엔티티)을 출력
    --판매 순위를 저장하는 테이블 
SELECT *
from salgrade;

--===================================================================
--각 테이블의 각각의 컬럼 정보
--1.  employee
select * from employee;
/*
  ENO : 사원 번호
  ENAME : 사원명
  JOB : 직책
  MANAGER : 상관
  HIREDATE : 입사일
  SALARY : 월급
  COMMISSION : 보너스 
  DNO : 부서번호

*/
-- 2. 부서정보를 저장하는 테이블
SELECT * from department;
/*
   DNO : 부서번호
   DNAME : 부서명
   LOC : 부서 위치 
*/

--3. 월급순위를 저장하는 테이블
SELECT * from salgrade;

/*
  GRADE : 월급 순위 
  LOSAL : 제일 낮은 월급
  HISAL : 제일 높은 월급
*/

-- SELSECT : 출력해라
--컬럼, 필드, 엔티티
-- 레코드 : 각 컬럼에 들어간 값 (행)
-- 레코드 셋 : 레코드들의 집합
SELECT * 
from employee;

--특정 컬럼만 출력
SELECT eno
FROM employee;

--특정 컬럼 여러개 출력 (하나의 컬럼이 끝날 경우 , 구별)
SELECT eno, ename, job
from employee;

--모든 컬럼 출력
SELECT eno, ename, job, manager , commission, hiredate , salary, dno
from employee;

--특정 컬럼만 출력 시 여러번 출력
SELECT eno, ename, salary, ename, ename
from employee;

-- 테이블의 구조 확인 하기
DESCRIBE employee;
DESC employee;

-- 컬럼을 별칭으로 출력하기 (as별칭)
SELECT eno as 사원번호, ename as 사원명, job as 직책
from employee;

SELECT eno  사원번호, ename  사원명, job  직책
from employee;

--employee 테이블의 모든 컬럼을 별칭으로 출력
SELECT eno 사원번호, ename 사원명, job 직책, manager 사수번호, 
    hiredate 입사일, salary "월#급", commission 보너스, dno "부서 번호"
from employee;

-- 조건을 사용하여 출력 : where
SELECT *
from employee
where eno = 7499; -- 조건을 사용해서 출력 할 경우, eno 컬럼의 값이 7499인 것만 출력

desc employee;
-- <== empolyee 테이블의 구조를 확인
--값을 출력 시 : number 데이터 타입의 값은 '' 없이 출력
--              number 이외의 데이터 타입은 '' : char, varchar, data

--job (varchar2) 값을 가져 올땐 대소문자 구별
SELECT * from employee
where job = 'MANAGER';

desc employee;

--SELECT * from employee

--부서 번호가 20번인 모든 컬럼을 출력
SELECT * from employee
where dno = 20;

--<문제>
-- salary (월급 ) 2000만원 이상상용자만 모든 컬럼 출력
-- 이름이 CLARK인 사용자의 월급만 출력
-- 사원 번호 (ENO)7788인 사용자의 이름과 입사 날짜를 출력 <== 컬럼이름을 별칭

-- salary (월급 ) 2000만원 이상상용자만 모든 컬럼 출력
SELECT * FROM employee
WHERE salary >=2000;

-- 이름이 CLARK인 사용자의 월급만 출력
SELECT salary FROM employee
WHERE ename = 'CLARK';

-- 사원 번호 (ENO)7788인 사용자의 이름과 입사 날짜를 출력 <== 컬럼이름을 별칭
SELECT ENO 사원번호, ENAME 사원명, hiredate 입사일 FROM employee
WHERE ENO = 7788;

--SELECT 문의 전체 구조---
/*
select -- 컬럼 명 : * (모든 컬럼),
DISTINCT -- 중복 된 것 제거
from   -- 테이블 명, 뷰 이름 
WHERE  -- 조건
GROUP BY -- 특정 컬럼의 동일한 값을 그룹핑할 때 
Having  -- group by 에서 나온 결과를 조건을 처리
Order by -- 정렬해서 출력할 컬럼, asc : 내림차순 정렬, desc : 오름차순 정렬
*/

SELECT * FROM employee;

SELECT DNO 
FROM employee;

SELECT DISTINCT DNO 부서번호        
--DIERINCT 중복된 값을 제거 후 출력 다른 컬럼과 동시에 작동하면 오류발생 
-- 중복을 제거할 컬럼 1개만 사용
FROM employee;

SELECT DISTINCT DNO, ENO
FROM employee;

--컬럼에 연산을 적용 : 컬럼명이 없어짐, alias(별칭)해서 출력
select eno, ename, salary 월급, salary * 12 연봉, commission 보너스
from employee;

-- null 컬럼과 연산(+, -, *, /)을 하게되면 전체가 null
--전체 연봉 구하기 ; 월급에서 *12 한 후 + 보너스 = 전체 연봉
select eno as 사원번호, ename as 사원명, salary as 월급, commission as 보너스, salary * 12 as 연봉,
(salary*12)+commission as 전체연봉
from employee;

--전체 연봉을 구할 때 null 들어간 컬럼을 0ㅡㅇ로 변경 후 연산을 적용해야 한다.
    -- nvl 함수 : null이 들어간 컬럼을 다른 값으로 변환해서 처리
    -- nvl(commission , 0) <== commission 컬럼에 null을 0으로 수정해서 처리해라
select eno 사원번호, ename as 사원명, salary 월급, nvl(commission ,0) 보너스, 
salary* 12 연봉, (salary*12)+nvl(commission,0) 전체연봉
from employee;

--null이 들어간 컬럼을 출려하기 <== 주의
    -- null을 검색 할때는 is 를 사용, = 을 사용하면 오류
select *
from employee
where commission is null;

select * 
from employee
where commission is not null;

-- where 조건에서 and, or 사용하기
--부서 번호가 20번과 30번인 모든 컬럼 출력
select *
from employee
where dno = 20 or dno = 30;

select *
from employee
where dno = 20 or salary >=2000;

select *
from employee
where dno = 20 and salary <=1500;

-- job(직책)이  MANAGER이면서 월급이 2000만원 이상 사용자만 출력
select *
from employee
where job = 'MANAGER' and salary >=2000;

SELECT * from employee;
--  <문제1> 컬럼 알리아스(별칭), commission(보너스) 컬럼의 null인 값만 출력하되 사원 번호 이름 입사 날짜 출력
select eno 사원번호, ename 사원명, hiredate 입사날짜, commission 보너스
from employee
where commission is null;

--  <문제2> dno(부서번호) 20이고 입사날짜가 81/04/ 이후 사원의 이름과 직책, 입사날짜 출력
select ename 사원명, job 직책, hiredate 입사날짜
from employee
where dno = 20 and hiredate >= '81/04/01';

--  <문제3> 연봉을 계산해서 사원 번호 , 사원 이름, 월급, 보너스, 전체 연봉 출력
select eno 사원번호, ename as 사원명, salary 월급, nvl(commission ,0) 보너스, 
salary* 12 연봉, (salary*12)+nvl(commission,0) 전체연봉
from employee;

--  <문제4> commission이 null이 아닌 사용자의 이름만 출력
select ename 사원명
from employee
where commission is not null;

--  <문제5>  MANAGER (지급상사) 7698 인 사원이름과 직책을출력
select ename 사원명, job 직책
from employee
where MANAGER = 7698; 

--  <문제6> 월급이 1500 이상 이고 부서가 20인 사원의 사원이름, 입사날짜 부서 번호 월급 출력
select ename 사원명, hiredate 입사날짜, dno 부서번호, salary 월급
from employee
where salary >=1500 and dno = 20;

--  <문제7> 입사날짜가 81/04/01 이상이고 81/12 까지 사원 이름 입사날짜들을 출력
select ename 사원명, hiredate 입사날짜
from employee
where hiredate >= '81/04/01' and hiredate <= '81/12/30';

--  <문제8> 직책(job)salesman 이면서 연봉이 1500이상이면서 부서 번호가 30인 사원명만 출력
select ename 사원명
from employee
where job = 'SALESMAN' and salary >=1500 and dno =30;

--  <문제9> 월급이 1500이하 이면서 부서번호가 20이 아닌 사원명, 월급 부서번호 출력
select ename 사원명, salary 월급, dno 부서번호
from employee
where salary <=1500 and dno != 20;
  
--  <문제10> 사원번호(eno) 가 7788, 7782 인 부서 번호와 사원명 직채을 출력
select dno 부서번호, ename 사원명, job 직책
from employee
where eno = 7788 or eno = 7782;

