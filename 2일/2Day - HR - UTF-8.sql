
-- HR 계정으로 접속한 쿼리
show user;      

--현재 접속한 계정에서 모든 테이블을 출력
select * from tab;

-- 각 테이블의 구조 확인 : 컬럼(자료형)
desc employee;
desc department;
desc salgrade;

--테이블의 각 컬럼에 저장된 값을 출력
select * 
from employee;

select *
from department;

select *
from salgrade;

--컬럼응ㄹ 여러번 출력, 연산, 별칭 ; 컬럼을 종료
select ename 사원명, salary 월급, salary*12 연봉
from employee;

--전체 연봉 출력 : null값을 처리, nvl(commission, 0)
select ename 사원명, salary 월급, salary*12+nvl(commission, 0) 전체연봉
from employee;

--IN 연산자 : where 조건에서 사용
select * from employee;

    -- IN 연산자를 사용하지 않고, commission (보너스) : 300, 500, 1400를 출력
    select * from employee
    where commission = 300 or commission = 500 or commission = 1400;

    --IN 연산자를 사용해서 출력
     select * from employee
    where commission IN (300, 500, 1400);
     
-- Between A and B : A와 B 사이의 값을 출력    
-- 입사월이 81/01/01 ~81/12/31 까지 입사한 사원들을 출력
select ename, hiredate
from employee
where hiredate >='81/01/01' and hiredate <='81/12/31';
    
select ename, hiredate
from employee
where hiredate Between '81/01/01' and '81/12/31';    
    
--Like : 컬럼의 값을 문자, 문자열 검색해서 출력할 때 사용
    --_ : 한글자가 어떤값이 와도 상관없다.
    --% : 모든 글자를 대치
--이름이 A로 시작되는 모든 사원 출려
select ename
from employee
where ename Like 'A%';

-- 한 글자가 어떤 글자가 오든 상관없다. 글자 이름에 LL이 들어간 사원 찾기
select ename
from employee
where ename like '%LL%';

-- 두번째 자릿수에 A 문자가 들어있는 사람찾기
select ename
from employee
where ename like '_A%';

--job 컬럼에 MAN이 들어간 내용을 출력
select Job
from employee
where Job like '%MAN%';


--정렬해서 출력 : order by 정렬할 컬럼 정렬방식 <== select 절에서 제일 마지막에서 
    --asc : 내림차순 : 작은 값에서 큰 값으로 A -> Z , 기본값 : 생략
    --desc : 오름차순 : 큰 값에서 작은 값으로  Z -> A

-- 사원 이름을 기준으로 ASC 
select * from employee
order by ename asc;

select * from employee
order by ename desc;

-- hiredate (입사날짜를 기준으로 정렬)
-- 내림차순
select * 
from employee
order by hiredate ;

-- 오름차순
select * 
from employee
order by hiredate desc;

--eno (사원 번호) 를 기중으로 내림차순 정렬
--내림차순
select *
from employee
order by eno ;

--오름차순
select *
from employee
order by eno desc;

-- 조건을 적용해서 나온 결과를 정렬해서 출력
--81년 입사한 사원만 출력하되 월급이 많은 순으로 출력
select eno, ename, hiredate, salary
from employee
where hiredate like '81%'
order by salary desc;

-- 보너스가 없는 사원들만 출력하되 이름을 내림차순
select ename, commission
from employee
where commission is null
order by ename desc;


--부서번호(DNO)가 20인 사원명 월급이 1500 이상인 사원을 출력 월급이 많은 순으로 출력
select eno, ename, salary,dno
from employee
where dno = 20 and salary >= 1500
order by salary desc;

--여러 컬럼을 정렬할 경우 : 처음 컬럼을 모두 정렬 후 , 같은 값이 존재할 경우 그 컬럼을 뒤에서 정렬
select dno, manager, ename
from employee
order by dno, manager , ename;

-- manager asc 정렬 ename 컬럼을 asc정렬
select manager, ename
from employee
order by manager desc, ename;

select * from employee;

--부서 별로 월급이 많은 사용자부터 출력
select *
from employee
order by dno , salary desc;

--보너스 별로 월급이 많은 순으로 출력
select ename,nvl(commission,0)commission,salary
from employee
order by commission , salary desc;

--직책별로 입사일이 빠른 순으로 출력
select ename, job, hiredate
from employee
order by job, hiredate;

--중복 재거 후 출력 : distinct : 중복을 제거할 컬럼앞에 넣는 키 /  다른 컬럼과 같이 쓰면 안됨
    -- select distinct
    -- 회사에 존재하는 직책 : 중복을 제거하고 출력
select distinct job
from employee;

--회사에 존재하는 부서
select distinct dno
from employee
order by dno;

-- 사수를 중복 제거 후 출력
select distinct manager
from employee
order by manager;

--오라클에서 기본 제겅해 주는 함수
--1. 문자 처리 함수
--2. 숫자 함수
--3. 날짜 함수
--4. 변환 함수
--5. 일반 함수


/*
1. 문자 처리 함수
LOWER : 소문자로 변환
UPPER : 대문자로 변환
INITCAP : 첫 글자만 대문자로 나머지는 소문자로 변환
*/
select 'Oracle mania' 원본
,UPPER('Oracle mania') 대문자
,LOWER('Oracle mania') 소문자
,INITCAP('Oracle mania') "첫자만 대문자"
from dual;      --가상 테이블

--값을 가져올때는 대소문자 구별 
select * 
from employee
where ename = UPPER('smith');

/*
  글자의 길이를 출력해주는 함수
  LENGTH : 글자수를 반환(한글 1byte)
  LENGTHB : 글자 수를 반환(한글 3byte)      UTF-8
*/
select length ('Oracle mania')      --12byte : 12자
,length('오라클 매니아')              --7byte : 7자
from dual;

select lengthb ('Oracle mania')      --12byte : 12자
,lengthb('오라클 매니아')              --19byte : 19자
from dual;

select ename,length (ename) 글자수, job, length(job) 글자수
from employee;
/*
  CONCAT ; 문자열을 연결 함수
  SUBSTR : 문자를 잘라주는 함수  (한글 1byte)
  SUBSTRB : 문자를 잘라주는 함수 (한글 3byte)
  INSTR : 특정 문자의 위치값을 반환  (한글 1byte)
  INSTRB : 특정 문자의 위치값을 반환 (한글 3byte)
  LPAD : 글자 자릿수를 입력받고 나머지는 특정기호로 채움 (왼쪽)
  RPAD : 글자 자릿수를 입력받고 나머지는 특정기호로 채움 (오른쪽)
  TRIM : 공백을 제거
*/
select 'Oracle', 'mania', concat('Oeacle', 'mania')
from dual;

select substr('오라클 매니아', 4,3)  --4번째 자리에서 3자를 잘라서 출력
    , substrb('오라클 매니아', 4,3)  -- 한글을 3byte
from dual;

select ename, substr(ename, 3,3) 잘라온값
from employee;

--instr 해당 문자가 존재하는 위치를 출력
select 'Oracle mania'
    , instr('Oracle mania', 'a')
from dual;

select 'Oracle mania'
    , instr('Oracle mania', 'a',4) --4번째 자릿수에서 a를 검색
from dual;

select ename, instr(ename, 'K')
from employee;

select ename, instr(ename, UPPER('k'))
from employee;

--LPAD
select LPAD(salary, 10,'*')
from employee;

--RPAD
select RPAD(salary, 10,'*')
from employee;

--TRIM : 앞뒤의 겅백을 제거 
select '   Oracle Manai   ' 원본
, trim('   Oracle Manai   ') 공백제거
from dual;

--2. 숫자 함수
/*
ROUND : 특정 자릿수에서 반올림
    ROUND (대상) : 수숫점 뒤자리에서 반올림
    ROUND (대상, 소수점 자릿수) :
        양수일 때 : 소숫점을 기준으로 오른쪽으로 이동해서 그 뒷자이에서 반올임 <== 주의
        음수일 때 : 소숫점을 기준으로 왼쪽으로 이동하고 그 자리에서 반올림
             점수를 반올림 그 뒤는 모두 버림
TRUNC : 특정 자릿수에서 잘라냄
MOD : 입력받능 수를 나누고 나머지 값만 반환
*/
select 98.7654 원본,
    round(98.7654),
    round(98.7654, 2),  -- 98.77 소숫점기준으로 오른쪽으로 2자리 이동 후 뒷에서 반올림
    round(98.7654, -1), --100    소숫점 기준으로 왼쪽으로 이동 후 그 자리에서 반올림
    round(98.7654, -2),
    round(98.7654, -3),
    round(98.7654, 3)
from dual;

select 12345.798 원본,
    round(12345.6789),
    round(12345.6789, -3),
    round(12345.6789, 3)
from dual;

--TRUNC : 잘라서 버림
select 98.7654 원본,
    trunc(98.7654),
    trunc(98.7654,2),
    trunc(98.7654,-1)
from dual;

--MOD (대상, 나누는 수 ) : 대상을 나누는 수로 나눠서 나머지 
select mod(31,2), mod(31,5), mod(31,8)
from dual;

--eno (사원번호) 가 짝수인 사원만 출력
select eno, ename
from employee
where mod(eno,2)=0;     --조건예

/*
3. 날짜 함수
    sysdate : 현재 시스템의 날짜와 시간을 출력
    months_between : 두 날짜 사이의 개월 수를 출력
    add_months : 특정 날짜에 개월수를 더할 때
    next_day : 특정날짜에서 최초로 도래하는 인자로 받은 요일의 날짜를 반환
    last_day : 달의 마지막 날짜를 반환
    round : 날짜를 반올림 15일 이상은 반올림, 15일 미만은 버림
    trunc : 날짜를 버림
*/
select sysdate
from dual;

select sysdate -1 어제날짜, sysdate 오늘, sysdate +1 내일
from dual;

select hiredate 입사날짜, hiredate -1, hiredate +10
from employee;

--입사일에서 현재까지의 근일일수 구하기
select round((sysdate -hiredate),2) "총 근무 일수"
from employee;

select trunc(sysdate -hiredate) "총 근무 일수"
from employee;

--특정 날짜에서 월(Month)을 기준으로 버리기 월은 출력하되 날짜는 모두 버림 01
select hiredate 원본, trunc(hiredate, 'MONTH')
from employee;

--특정 날짜에서 월을 기준으로 반올림 하기 15일 이상은 반올림 15일 미만은 버림
select hiredate 원본, round(hiredate, 'month')
from employee;

--month_between(date1, date2) : 두 날짜사이의 개월수를 출력
--입사일에서 현재까지 몇개월간 근무 했는지 출력
select ename, hiredate, months_between(sysdate, hiredate) "근무개월 수"
from employee;

select ename, hiredate,trunc(months_between(sysdate, hiredate)) "근무개월 수"
from employee;

--add_months (date1, 개월수) : date1에 개월수를 더해서 출력
select ename, hiredate, add_Months(hiredate, 6)
from employee;

--입사 후 100일이 지난 시점의 날짜
select hiredate, hiredate+100 "입사 100일 시점"
from employee;

--next_day(date, 요일) : date의 도래하는 요일을 출력
--오늘 날자에서 도해라는 토요일의 날짜는 몇일 인지 출력
select sysdate, next_day(sysdate, '토요일')
from dual;


-- last_day(date) : date에 월의 마지막 날
select hiredate, last_day(hiredate) "월의 마지막 날짜"
from employee;




/*
4. 변환 함수

to_char : 날짜형 숫자형을 문자형으로 변환하는 함수
to_date : 문자형을 날짜형으로 변환하는 함수
to-number : 문자형을 숫자로 변환하는 함수
*/
--to_char(date, 'yyyymmdd')
    -- YYYY : 년도
    -- MM : 월
    -- DD : 일
    -- DAY : 요일의 자세한 정보 (월요일 화요일)
    -- DY : 요일
    
    -- HH : 시간
    -- MI : 분
    -- SS ; 초
    
select ename, hiredate, to_char(hiredate, 'YYYYMMDD'),to_char(hiredate, 'YY-MM/DD')
    ,to_char(hiredate, 'yyyy--mm--dd dy')
   , to_char(hiredate, 'yyyy-mm-dd day hh:mi:ss')
from employee;


--현재 시스템의 오늘날짜를 출력하되 시간 : 분 : 초  요일까지 출력
select sysdate, to_char(sysdate, 'yyyy-mm-dd hh:mi:ss day')
from dual;

--to_char : 숫자를 char형식으로 변환
-- 0 : 자릿수를 나타내고 자릿수가 맞지 않으면 0으로 채움
-- 9 : 자릿수를 나타내고 자릭수가 맞지 않으면 빈칸으올 채움
-- L : 각 지역의 통화 기호를 출력
-- . : 소숫점으로 표현
-- , : 천단위 구분자

--salary : NMBER(숫자) ==> char(문자)
desc employee;
select ename, salary, to_char(salary, 'L999,9999'), to_char(salary, 'L000,000')
from employee;

--to_date('char', 'format') : char (문자) ==> 날짜 형식으로 변환
--to_date (number, 'format') : 숫자를 ==> 날짜형식으로 변환

select sysdate, 
    sysdate - to_date(20000101, 'yyyymmdd')      --sysdate : date . 20000101 : number 
from dual;

--두 포멧 방식이 맞지 않아서 오류발생
select sysdate.
    sysdate - '2000-01-01' --날짜 - 문자 <== 두 타입을 맞춰야 하낟.
from dual;

select sysdate,
    sysdate - to_date('2000-01-01', 'yyyy-mm-dd')
from dual;

-- 2000년 1월 1일 부터 2022년 01월 10일 까지의 지난 날짜
--'02/10/22' : 22년 02월 10일을 date형식으로 바꿈 '2000/01/01'
select to_date('12/06/22', 'mm-dd-yy') - to_date('2000/01/01', 'yyyy/mm/dd')
from dual;

select sysdate - to_date(20000101,'yyyymmdd')
from dual;


--employee 테이블에서 81년 2월 22일 입사한 사원을 검색
    --'1981-02-22' 문자열 포멧을 date형식으로 변환해서 검색
select ename, hiredate
from employee
where hiredate ='81/02/22';

--2000년 12월 25일 부터 오늘까지 총 몇달이 지났는 지 출력 소숫점이하는 모드 잘라내기 sysdate

select trunc( months_between( sysdate, to_date( '2000/12/25', 'yyyy/mm/dd')))
from dual;

--문자열('2022-12-07') ==> date타입으로 변환
select to_date('2022-12-07', 'yyyy-mm-dd')
from dual;

select sysdate, to_char(sysdate, 'yyyy mon dd dy hh:mi:ss')
from dual;

--숫자를 ==> date타입으로 변환
select to_date(12072022, 'mmddyyyy')
from dual;

--to_number : 문자형 데이터를 숫자혀응로 변환
select 10000-5000
from dual;

select '10000'-'5000'   --자동으로 변환 : 문자열 ==> 숫자형으로
from dual;

select '10,000' - '5,000'   --to_number 로 변환이 필요
from dual;

select to_number ('10,000', '99,999') - to_number ('5,000', '9,999') 숫자변환계산
from dual;








--5. 일반 함수