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

