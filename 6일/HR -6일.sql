--조인, 뷰, 인덱스

--조인(Join) : 두개 이상의 테이블의 컬럼을 출력 시 Join을 사용해서 컬럼의 정보를 가져온다
    --employee depeartment 테이블은 원래 하나의 테이블이다.
    -- 모델링(중복제거, 성능향상)을 사용해서 두 테이블로 분리
    -- 두 개이상의 테이블에 컬럼을 가져오기 위해선 join문을 사용해서 출력
    -- 두 테이블을 join하기 위해서는 두 테이블에서 공통의 키 컬럼이 존재해야함
    -- ANSI 호환 JOIN : 모든 SQL에서 공통으로 사용하는 JOIN 구문
    -- Oracle, My_SQL(MariaDB), MS-SQL, IBM DB2,.....<== DBMS
    -- 두 테이블의 공통의 키 컬럼을 select 문에서 출력할 때 반드시 테이블명을 명시
        -- 명시하지 않으면 오류발생
    
select * from employee;
select * from department;

-- EQUI JOIN : 오라클에서 제일 많이 사용하는 join, <== Oracle에서만 사용
    -- ANSI호환의 SQL구문에서 INNER JOIN과 같은 구문
        -- 두 테이블에서 공통으로 적용된 값만 출력 <교집합>
        
    -- from 절에 join 할 테이블을 명시,   ',' 를 사용해서 나열
    -- where 절에 두 테이블의 공통의 키 컬럼 '='
    -- and 절에서 조건을 처리 
    

select eno 사원번호, ename 사원명, employee.dno 부서번호, dname 부서명, loc 부서위치
from employee, department                   -- 조인할 테이블 나열 ','
where employee.dno = department.dno         -- 두 테이블의 공통의 키럼럼을 참아서 : '=' 처리
and employee.dno >= 20;                     -- 조건을 처리


--위 구문의 전체 구문을 출력
select employee.eno, employee.ename, employee.dno,
    department.dname, department.loc
from employee, department
where employee.dno = department.dno
and employee.dno >=20;

--테이블 이름을 알리엇(별칭) 해서 사용 <== 주로 사용
select eno, ename, salary, hiredate, e.dno, dname, loc
from employee e, department d --테이블 이름을 별칭 이름으로 사용
where e.dno = d.dno;

-- ANSI호환의 SQL구문에서 INNER JOIN과 같은 구문
    -- Oracle  EQUI 조인과 동일한 구문
    -- 주의 : select 절에 공통 키 컬럼을 출력 시 테이블을 명시
    -- 두 테이블에서 공통으로 적용된 값만 출력 <교집합>
    -- from 절 : INNER JOIN 키를 사용해서 JOIN
    -- on 절에 공통의 키 컬럼을 '=' 로 처리
    -- where 에서 조건을 처리
        
select eno 사원번호, ename 사원명, e.dno 부서번호, dname 부서명, loc 부서위치
from employee e INNER JOIN department d     --INNER JOIN
on e.dno = d.dno                            -- 두 테이블의 공통의 키 컬럼을 '=' 처리
where e.dno >=20;                           -- where로 조건 처리


-- 전체 내용 출력
select e.eno 사원번호, e.ename 사원명, e.dno 부서번호, d.dname 부서명, d.loc 부서위치
from employee e INNER JOIN department d     --INNER JOIN
on e.dno = d.dno                            -- 두 테이블의 공통의 키 컬럼을 '=' 처리
where e.dno >=20;                           -- where로 조건 처리

-- employuee  department 테이블의 사원명과 월급과 입사일, 부서명, 부서위치 부서명 출력 / 월급이 2000이상
select  ename 사원명, hiredate 입사일, salary 월급, dname 부서명, loc 부서위치, employee.dno 
from employee, department                   
where employee.dno = department.dno         
and employee.salary >= 2000;  

select  ename 사원명, hiredate 입사일, salary 월급, dname 부서명, loc 부서위치, e.dno 
from employee e INNER JOIN department d     
on e.dno = d.dno                            
where e.salary >=2000;

-- 두 테이블을 join 해서 부서별 월급의 최대값을 출력( employee, dapartment)
    -- 부서 이름과 부서 번호를 출력
select max(salary) 월급, dname 부서명, d.dno 부서번호,count(*)
from employee e INNER JOIN department d     --INNER JOIN    
on e.dno = d.dno                            -- ON 절에 두 테이블의 공통의 키 컬럼을 적용
group by dname, d.dno;

-- NATURAL JOIN : Oracle 9i 지원
    -- 두 테이블을 join 시 두 테이블에서 공통의 키 컬럼을 찾아야 한다.
    -- 두 테이블의 공통의 키 컬럼을 oracle 내부에서 찾아서 처리
    -- EQUI JOIN 에서 where 절의 두 테이블의 공통의 키 컹엄을 명시하지 않아도 됨(where 절 없앰)
    -- where 절 생략 시 오라클에서 두 테이블의 공통 키 컬럼을 자동으로 찾아줌
    -- 두 테이블의 공통 키 컬럼은 동일한 타입이어야 한다.
    -- select 절에서 공통 키 컬럼을 출력 시 테이블명을 명시하면 오류 발생
    -- from 절에 natural join 을 사용

-- NATURAL JOIN 을 사용해서 출력
-- select 문에서 두 테이블의 공통의 키 컬럼을 출력 시 테이블 이름을 명시하면 오류 발생
select eno, ename, salary, dno, dname, loc
from employee e NATURAL JOIN department d;
 -- where 절 생략 / 자동으로 오라클 내부에서 키 컬럼을 자동으로 찾음
 
 --select 절에서 두 테이블의 공통의 키 컬럼출력 시 
    -- EQUO JOIN (INNER JOIN) -- 반드시 키 컬럼 앞에 테이블 명 명시
    -- NATURAL JOIN 키 컬럼 앞에 테이블 명 명시 X
    
--사원 이름, 월급, 부서이름, 부서 번호를 출력 / 월급이 2000 이상인 사람만 출력
--EQUI JOIN
select ename 사원명, salary 월급, dname 부서이름, employee.dno 부서번호
from employee, department
where employee.dno = department.dno
and employee.salary >=2000;
 
--NATURAL JOIN
select ename 사원명, salary 월급, dname 부서이름, dno 부서번호
from employee e NATURAL JOIN department d
where e.salary >=2000;

--ANSI
select ename 사원명, salary 월급, dname 부서이름, e.dno 부서번호
from employee e INNER join department d
on e.dno=d.dno
where salary >=2000;

-- not equi join : oeacle 에서만 적용
-- from 절에서 테이블을 , 로 나열
 --where 절에서 '='을 사용하지 않는  join구문 <== 공통 키 컬럼 없이 join
 
 --월급에 대해서 등급을 출력하는 테이블
 select * from salgrade;
 
 --사원 정보를 출력하는 테이블
 select * from employee;
 
 --사원의 부서 정보를 저장하는 테이블
 select * from department;
 
 --non equi join : equi join 구문에서 where 절의 공통 키 컬럼 없이 join : '='
 --employee , salgrade 테이블을 join해서 각 사원의 월급의 등급을 출력
 select ename, salary, grade
 from employee e, salgrade s
 where salary between losal and hisal;
 
 --3개 테이블 join 
 --employee department salgrade 테이블을 join
    --사원이름, 부서이름, 월급, 월급등급

select ename 사원명, salary 급여, dname 부서명, grade 급여등급
from employee e, salgrade s, department d
where e.dno=d.dno
and salary between losal and hisal;

--사원번호 입사일 부서번호 월급 월급의 등급 부서명
select eno 사원번호, hiredate 입사일, e.dno 부서번호,  salary 월급, grade 월급등급, dname 부서명
from employee e, salgrade s, department d
where e.dno=d.dno
and salary between losal and hisal;

-- INNER JOIN : 90% / 두 테이블에서 공통의 내용을 출력(e.dno = d.dno)
    -- EQUI JOIN, NATUAL JOIN : Oracle 
    -- INNER JOIN : ANSI 호환 (모든 DBMS 에서 공통으로 사용되는 구문)

--self join : 자신의 테이블(원본테이블)을 가상의 테이블(원본을 복사한 테이블) join 함
    -- 자신의 테이블을 다시 한번 join
    -- 반드시 테이블을 별칭이름을 만글고 별칭이름을 사용해서 join
    -- 회사의 조직도를 SQL구문으로 출력할 때 직급 상사가 누구인지 출력할 때 주로 사용
 
--관리자가 7788인 eno ename manager
select eno 사원번호, ename 사원명, manager 직속상관
from employee
where manager = 7788
order by ename asc;

--직속 상관의 정보를 출력
select eno 사원번호, ename 사원명, manager 직속상관
from employee
where eno = 7788;

--
select *from employee;

--self join 을 사용해서 자신의테이블 join해서 사원에 대한 직속상관 정보를 한번에 출력
--equie join 을 사용해서 출력
select e.ename 사원이름 ,e.manager 직속상관번호,e2.eno 직속상관번호, e2.ename 직속상관
from employee e , employee e2 -- 두 테이블 모두 employee 테이블 반드시 별칭이름 사용
where e.manager = e2.eno
order by e.ename;

select eno, ename, manager , eno, ename, manager
from employee;

select * from employee
order by ename;

--ANSI 호환 구문을 사용해서 SELF JOIN
--employee 테이블을 self join해서 사원에 대한 직속 상관을 출력
select e.ename ||'의 직속 상관은' || e2.ename ||'입니다.'
from employee e inner join employee e2
on e.manager = e2.eno
order by e.ename;

select * from employee;

select eno, ename, manager, eno, ename, manager
from employee;

--Outer JOIN : 
    -- 특정 컬럼의 내용은 두 테이블의 공통적이지 않는 내용도 출력 해야할 때 사용
    -- null 출력 
    -- + 를 사용해서 outer join : oracle
    -- ANSI 호환 구문을 사용할 때는 Outer join을 사용
        --Left Outer Join, LEFT JOIN  
        --Right Outer Join, RIFHT JOUN
        --Full Outer Join, FULL JOIN
--EQUI JOIN 을 사용하여 Outer Join
select  e.ename||' 의 직속상관은 '|| e2.ename||'입니다'
from employee e, employee e2
where e.manager = e2.eno            --e.manager와 e2.eno의 값이 일치하는 내용만 출력, (13개 레코드 출력)
order by e.ename;


select  e.ename||' 의 직속상관은 '|| e2.ename||'입니다'
from employee e, employee e2
where e.manager = e2.eno (+)       -- e2.eno 컬럼의 내용은 e.manager의 값이 없더라도 무조건 출력
order by e.ename;

--ANSI 호환에서 Outer Join
    --Left Outer Join   : Left Join     : 왼쪽 테이블의 내용은 매칭되지 않더라도 무조건 출력
    --Right Outer Join  : Right Join    : 오른쪽 테이블의 내용은 매칭되지 않더라도 무조건 출력
    --Full Outer Join   : Full Join     : 왼쪽 오른쪽 테이블의 내용은 매칭되지 않더라도 무조건 출력
    
select e.ename||'의 직속 상관은 '||e2.ename||'입니다'
from employee e left outer join employee e2
on e.manager = e2.eno
order by e.ename;

--카디시안 곱 : 왼쪽 테이블의 하나의 레코드에서 오르쪽 테이블의 모든 레코드를 곱한다.
-- employee : 14 / department : 4
-- 카디시안 곱 : 14 * 4 = 56 레코드 출력
select count(*) from employee;
select count(*) from department;

--employee , department  카디시안 곱 : 56

--INNER JOIN : e.dno = d.dno 가 맹치되는 내용만 출력
--EQIUE JOIN : Oracle 구문으로 출력 
select *
from employee e, department d
where e.dno = d.dno (+)




















