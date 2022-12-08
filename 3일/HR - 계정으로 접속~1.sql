-- HR 계정으로 접속
show user;

--5. 일반함수
-- nvl. nvl2, nullif
--coalesce, 

--nvl 함수 ; null을 처리하는 함수
    --nvl(컬럼명, 값) : 컬럼에 null이 존재할 때 값으로 대치
    -- 연봉운 = 월급 *12 +보너스
select ename, salary, commission
from employee;

select ename , salary , commission ,salary *12 + nvl(commission,0) 연봉
from employee;

--nvl2 함수 : null을 처리하는 함수
    --nvl2(컬럼, null아닐경우 처리,null경우 처리)

--nvl2 함수를 상용해서 총 연봉 계산
select ename, salary , commission 
    ,nvl2(commission, salary*12+commission, salary*12)연봉
from employee;



--nullif함수 : 두 인자를 비교해서 동일한 경우 null을 반환, 
    --아닌 경우 첫번째 표현식으로 반환
    --nullif (expr1, expr2)
select nullif('a','a'), nullif('A','a')
from dual;
    
-- coalesce 함수
coalesce (expr1. expr2, expr3...expr-n):
    --expr1 : null아니면 expr1 을 반환
    --expr1 이 null이며 expr2가 아니면 expr2를 반환
    --ecpr1 이 null이며 expr2가 null이면 expr3가 아니면 expr3반환
select coalesce(null, 'bcd', 'cde', 'def', 'efg')
from dual;

select coalesce(null, null, 'cde', 'def', 'efg')
from dual;

select coalesce(null, null, null, 'def', 'efg')
from dual;

/*
decode 함수 : swtich case문과 동일한 함수

    decode(표현식, 조건1, 결과1.
            조건2, 결과2
            조건3, 결과3,
            ....
            기본결과n
            )
*/
--dno 부서 번호
--10 : 'ACCOUNTING'
--20 : 'ERREARCH'
--30 : 'SALES'
--40 : 'OPERATIONS'
--  'DEEAULT'
select ename, dno, 
    decode(dno, 10, 'ACCOUNTING',
                20, 'ERREATCH',
                30, 'SALES',
                40, 'OPERATIONS',
                'DEEAULT') 부서명
from employee;

/*
case : if ~ else if , else if 와 비슷한 구문
    
    case wHEN 조건1 THEN 결과1
        wHEN 조건2 THEN 결과2
        wHEN 조건3 THEN 결과3
        ELSE 결과 n
    END
*/
--부서 번호에 대한 부서명 출력: case
select ename, dno,
    case when dno=10 then 'ACCOUNTING'
        when dno=20 then 'ERREATCH'
        when dno=30 then 'SALES'
        else 'DEEAULT'
    end 부서명
from employee;

chapter94 : 그룹 함수
 /*
 그룹함수 : 동일할 값에 대해서 그룹핑해서 처리하는 함수
    group by 절에 특정 컬럼을 정의 할 경우, 해당 컬럼의 동이한 값을 그룹칭해서 연산처리
 
 집계합수 : 연산을 처리하는 함수
    sum : 합계를 구하는 함수
    avg : 평군을 구하는 함수
    max : 최대값을 출력
    min : 최소값을 출력
    count : 레코드 수(한 라인의 값이 저장된), row(행) 
 
select  컬럼명 
from    테이블 명, 뷰(가상으로 생성된 테이블)
where   조건  <== 테이블에서 원하는 조건을 가지고 올때 
group by   그룹핑할 컬럼
having  group by를 사용해서 나온 결과에서 조건을 처리
order by    정렬 

 */
 
 -- 집계합수를 컬럼에 사용하묜 단일행으로 출력
select  sum(salary) 합계, round(avg(salary),2) 평균, 
    max(salary) 최대값, min(salary) 최소값
from employee;

--집계함수는 null을 0으로 자동으로 처리해서 연산
select commission
from employee;

select sum(commission), avg(commission), max(commission), min(commission)
from employee;

--count 함수 : 레코드 수, row(행) 수, 
    --null은 카운트 되지 않는다
select count(eno) 레코드수
from employee;

select count(commission), count(manager)
from employee;

--특정 컬럼을 count 함수를 사용하면 전체 헤코드 수를 부정확학 출력할 수 있다. 
    -- not null정의된 컬럼으 카운트 해야한다.
desc employee;

--테이블의 전체 레코드 수를 출력 시 : not null 지정된 컬럼이나, *를 사용해서 count해야한다
select count(eno) from employee;    --not null
select count(*) from employee;      --모든 컬럼 카운터

--직업의 갯수를 출력
select count( distinct job) 
from employee;

--부서의 갯수
select count(distinct dno)부서수
from employee;

--부서별로 급여의 합계 평균 최대값 최솟값 구하기 : group by <== 컬럼에 동일한 값을 그룹핑헤서 처리
select * from employee
order by dno ;

select sum(salary) "부서별 월급 합계", round(avg(salary),3) "부서별 월급 평균",
    max(salary) "부서별 최대 월급", min(salary) "부서별 최소 월급", dno 부서
from employee
group by dno        -- dno 컬럼의 동일한 값을 그룹핑
order by dno;

--직책별로 월급의 합계 평균 최대값 최솟값 출력
select sum(salary) "직책별 월급 합계", round(avg(salary),3) "직책별 월급 평균",
    max(salary) "직책별 최대 월급", min(salary) "직책별 최소 월급", job 직책
from employee
group by job
order by job;

select *
from employee
where job = 'ANALYST';

--group by 에서 나온 결고라르 조건으로 처리해서 출력 : having <조건>
    --별칭이름을 사용해서 조건을 처리라면 오류 발생
    
--직책 별 평균월급이 2000 이상인것만 출력
select sum(salary) "직책별 월급 합계", round(avg(salary),3) "직책별 월급 평균",
    max(salary) "직책별 최대 월급", min(salary) "직책별 최소 월급", job 직책,count(*)
from employee
group by job
having round(avg(salary),3) >=2000 --group by 를 사용해서 나온 결과에 대한 조건 처리
order by job;

--having 절에서 별칭이름을 사용할 경우 오류 발생

select sum(salary) "직책별 월급 합계", round(avg(salary),3) "직책별 월급 평균",
    max(salary) "직책별 최대 월급", min(salary) "직책별 최소 월급", job 직책
from employee
group by job
having "직책별 월급 평균" >=2000 --group by 를 사용해서 나온 결과에 대한 조건 처리
order by job;

--where : 테이블의 값을 조건을 주어서 다지고 올때 사용
-- having : group by를 사용해서 나온 결과를 조건으로 출력

--20번 부서는 제외하고 부서별 합계, 평균 최대값 최소값을구하되 부서별 최소 월급이 1000이상인것만 출력

select sum(salary) "부서별 월급 합계", round(avg(salary)) "부서별 월급 평균",
    max(salary) "부서별 최대 월급", min(salary) "부서별 최소 월급", dno 부서
from employee
where dno !=20
group by dno        
having  min(salary) >=1000
order by dno;

-- 두 컬럼이상을 그룹핑 하기 : 두 컬럼 모두 동일할 때 그룹핑 처리됨
select dno, job
from employee
order by dno, job;

--,count(*) 를 사용하면 중복된 레코드가 몇개인지 확인 가능
select sum(salary), round(avg(salary)), max(salary), min(salary),dno,job,count(*)
from employee
group by dno, job
order by dno, job;

--group by를 사용하면서 select 절에 출력할 컬럼
    --집계함수(sum, avg, max, min), count(*),

--rollup : 마지막 라인에 전체 합계, 전체 평균을 추가젇으로 출력 : group by 절에서 사용
select sum(salary), round(avg(salary)), max(salary), min(salary),dno, count(*)
from employee
group by dno
order by dno desc;

--rollup 사용 : 그룹핑한 집계함수도 출력, 마지막 라인에 전체에 대한 집계함수도 같이 출력됨
select sum(salary), round(avg(salary)), max(salary), min(salary),dno, count(*)
from employee
group by rollup(dno) 
order by dno desc;

--cube : 부서별 함계와 평균을 출력 후 마지막 라인에 전체 합계 평균 출력
select sum(salary), round(avg(salary)), max(salary), min(salary),dno, count(*)
from employee
group by cube(dno) 
order by dno desc;

--============
/*
서브 쿼리 : (sub Query) : select문 내에 select 문이 들어있는 쿼리

*/
--ename이 scott인 사원과 동일한 부서의 사원을 출력
select * from employee;
    --sub query 를 사용하지 않고 출력
     -- 1. SCOTT의 부서를 확인 
     select ename, job 
     from employee 
     where ename = 'SCOTT';
     
     --2. SCOTT의 부서와 동일한 부서를 조건을 사용해서 출력
     select ename, job 
     from employee 
     where job=(select job 
                from employee 
                where ename='SCOTT');

--smith 와 동일한 부서의 사원들을 sub query를 사용해서 출력
select ename, job , dno
     from employee 
     where dno=(select dno 
                from employee 
                where ename='SMITH');
                
--SCOTT보다 월급이 많은 사용자, 서브쿼리한 결과 값이 단일 값으로 출력되어야 한다.
select ename, salary
from employee
where salary > (select salary
                from employee
                where ename='SCOTT');

--SCOTT과 동일한 부서에 근무하는 사원 출력
select ename,  dno
     from employee 
     where dno=(select dno 
                from employee 
                where ename='SCOTT');
                
--최소급여를 받는 사원의 이름, 담당 업무, 급여 출력
select ename, job, salary
from employee
where salary = (select min(salary) 
                from employee);

-- 각 부서의 최소급여가 부서번호 30 의 최소급여보다 큰 부서를 출력
select dno, min(salary),count(*)
from employee
group by dno
having min(salary) >(select min(salary)
                    from employee 
                    where dno =30)               --30번 부서의 최소급여를 
order by dno;

--sub query 에서 단일 값이 아니라 여러개의 값이 출력될 경우 : IN 연산자를 사용

-- 각 부서별로 최소 급여를 받는 사원의 사원번호와 이름을 출력
select ename,eno ,salary, dno
from employee
where salary in (select min(salary)
                    from employee
                    group by dno); --sub query : 부서별로 최소 월급을 출력

--All 연산자 : sub query에서 반환하는 모든 값을 비교
--  '>all' : 최대값 보다 큼을 나타냄
--  '<all' : 최소값 보다 작음을 나타냄
-- 직급이 SALESMAN 이 아니면서 직급이 SALESMAN 인 사원보다 급여가 적은 사원을 모두 출력

select eno, ename, job, salary
from employee
where salary < all (select salary
                    from employee
                    where job = 'SALESMAN')
        and job <> 'SALESMAN';

--담당 업무가 분석가(ANALYST)인 사원보다 급여가 적으면서 업무 분석가가 아님 사원들을 출력
select *
from employee 
where salary < all(select salary
                    from employee
                    where job = 'ANALYST')
        and job <> 'ANALUST';
