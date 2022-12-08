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
