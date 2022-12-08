
--��� ���̺� ��� �ϱ� 
select * from tab; 

-- ���̺��� ���� Ȯ�� �ϱ�
  -- select : ����ϱ� 
  /* 
    select �÷��� 
    from ���̺��̸� 
    
  */
-- 1. employee ���̺��� ��� �÷��� ����϶�. 
    -- �ٷ���(�����) ������ ������ ���� 
select *
from employee; 

-- 2. department ���̺��� ��� �÷��� ���. 
    -- �μ��� ���� ������ �����ϴ� ���̺� 
select * 
from department; 

--3. salgrade ���̺��� ��� �÷�(�ʵ�,��ƼƼ)�� ��� 
    -- �Ǹ� ������ �����ϴ� ���̺�. 
select * 
from salgrade; 


-- ===============================================
-- �� ���̺��� ������ �÷� ���� 
--1. employee ���̺� 
select * from employee; 
/*
  ENO : �����ȣ 
  ENAME : ����� 
  JOB  :��å
  MANAGER : ��� �� �����ȣ (����� �����ȣ)
  HIREDATE : �Ի��� 
  SALARY   : ���� 
  COMMISSION : ���ʽ� 
  DNO : �μ���ȣ 
*/

-- 2. �μ������� �����ϴ� ���̺� 
select * from department; 
/*
  DNO : �μ���ȣ
  DNAME : �μ���
  LOC : �μ��� ��ġ 
*/

--3. ������  ������ �����ϴ� ���̺� 
select * from salgrade; 
/*
  GRADE : ����   <-- ������ ���� :  
  LOSAL : ���� ���� ����
  HISAL : ���� ���� ����
*/ 

---------------------------------------
-- Select : ����϶�.
-- �÷�, �ʵ�, ��ƼƼ 
-- ���ڵ� : �� �÷��� �� ��, 1����  
-- ���ڵ� �� : ���ڵ���� ����
select * 
from employee; 

-- Ư�� �÷��� ��� �ϱ� 
select eno
from employee; 

-- Ư�� �÷� ������ ��� �ϱ� (�ϳ��� �÷��� ������� , ���� ) 
select eno, ename, salary
from employee; 

-- ��� �÷� ��� �ϱ� 
select eno,eno,eno, ename, job, manager,hiredate, salary, commission,dno,eno
from employee; 

-- Ư�� �÷��� ��½� ������ ��� �ϱ� 
select eno, ename, salary, ename, ename
from employee; 

-- ���̺��� ���� Ȯ�� �ϱ� : ���̺��� �÷����� Ȯ�� 
DESCRIBE employee; 
DESC employee; 

-- �÷��� ��Ī���� ��� �ϱ� ( as ��Ī )  
select eno as �����ȣ , ename as �����, job as ��å
from employee; 


select eno  �����ȣ , ename  �����, job  ��å
from employee; 

-- employee ���̺��� ��� �÷��� ��Ī���� ����ϱ� 
select eno �����ȣ, ename �����, job ��å, manager �����ȣ,
    hiredate �Ի���, salary "��#��", commission ���ʽ�, dno "�μ� ��ȣ"
from employee; 

-- ������ ����Ͽ� ����ϱ� : where 

select * 
from employee
where eno = 7499;   -- ������ ����ؼ� ��� �� ��� , eno �÷��� ���� 7499

desc employee;     -- <== employee ���̺��� ������ Ȯ�� 

-- ���� ��½� : number ������ Ÿ���� ���� '' ���� ��� 
--              number �̿��� ������ Ÿ���� ''  : char, varchar2, date  

select * from employee
where job = 'MANAGER' ;   -- job (varchar2), ���� �����ö��� ��ҹ��ڸ� ������.
  -- job 
  
desc employee; 

select * from employee

-- �μ���ȣ�� 20���� ��� �÷��� ����϶�. 
select * from employee 
where dno = 20; 

-- <����> 
-- salary (����) 2000���� �̻��� ����ڸ� ��� �÷� ���. 
select * 
from employee
where salary >= 2000 ; 
-- �̸��� CLARK �� ������� ���޸� ��� 
select salary as ����, ename �̸� , eno �����ȣ 
from employee
where ename = 'CLARK'; 

-- ��� ��ȣ (ENO) 7788�� �̸��� �Ի糯¥�� ���.   <== �÷��̸��� ��Ī���� ���
select ename �̸�, hiredate �Ի糯¥
from employee
where eno = 7788; 

desc employee; 

---Select ���� ��ü ���� ----------------------------
/* 

select  -- �÷��� :  * (����÷�), 
distinct    -- �ߺ��� ���� �����ؼ� ��� �ض� (���� ����) 
from    -- ���̺��, ���̸�
where   -- ����
group by    -- �÷��� : Ư�� �÷��� ������ ���� �׷��� 
Having      -- group by ���� ���� ����� ������ ó��
Order by    -- �����ؼ� ��� �� �÷� , asc : �������� ����, desc : �������� ���� 

*/

select * from employee; 

select distinct dno �μ���ȣ     
    -- disctinct �ߺ��� ���� ������ ��� , �ٸ� �÷��� ���ÿ� �۵��ϸ� ���� �߻� 
from employee; 

select distinct dno   -- �ߺ��� ������ �÷� 1���� ���
from employee; 

-- �÷��� ������ ���� : �÷����� ������, alias(��Ī)�ؼ� ��� 
select eno, ename, salary as ����, salary * 12 as ���� , commission ���ʽ�
from employee; 

-- null �÷��� ����(+, -, *, /)�� �ϰԵǸ� ��ü�� NULL
-- ��ü ���� ���ϱ� : ���� *12 + ���ʽ� = ��ü ���� 
select eno, ename, salary, commission , salary * 12 as ����, (salary *12) + commission as ��ü���� 
from employee

-- ��ü ������ ����Ҷ� null �� �÷��� 0���� ������ ������ �����ؾ� �Ѵ�. 
    -- nvl �Լ� : null �� �� �÷��� �ٸ� ������ ��ȯ �ؼ� ó���� �ִ� �Լ� 
    -- nvl (commission , 0)  <== commission �÷��� null�� 0���� �����ؼ� ó���ض� 

select eno, ename, salary, commission , salary * 12 as ����, 
    (salary *12) + nvl(commission,0) as ��ü���� 
from employee

--- null �� �� �÷��� ��� �ϱ� <== ���� 
    -- null�� �˻� �Ҷ��� is �� ��� , = �� ����ϸ� ���� 

select * 
from employee 
where commission is null;   -- 

select * 
from employee 
where commission is  not null;

--where ���ǿ��� and , or ��� �ϱ� 

-- �μ���ȣ�� 20���� 30 ��� �÷� ��� 
select * 
from employee
where dno = 20 or dno = 30; 

select * 
from employee
where dno = 20 or salary > = 2000


select * 
from employee
where dno = 20 and salary <= 1500; 

-- job(��å) MANAGER �̸鼭 ������ 2000 �̻��� ����ڸ� ��� , 
select * 
from employee
where job = 'MANAGER' and salary >= 2000 ; 

select * from employee; 
/*   employee ���̺��� �۾� , Select ���� ���, where ������ ����ؼ� ��� . 
6�� 20�б���. p.jangwoo@gmail.com 
<����1> �÷� �˸��(��Ī) , commission(���ʽ�) �÷��� null �� ���� ����ϵ� �����ȣ, ����̸�,�Ի糯¥�� ��� 
<����2> dno(�μ���ȣ) �� 20�̰� �Ի糯¥�� 81�� 4�� ���� ����� �̸��� ��å�� �Ի糯¥�� ���
<����3> ������ ����ؼ� �����ȣ, ����̸�, ����, ���ʽ�, ��ü ������ ���
<����4> commission�� null �� �ƴ� ������� �̸��� ��� 
<����5> manager (���޻��) 7698 �� ����̸��� ��å�� ���.
<����6> ������ 1500 �̻��̰� �μ��� 20�� ����� ����̸��� �Ի糯¥, �μ���ȣ, ������ ���
<����7> �Ի糯¥�� 81�� 4�� 1�� �̻��̰� 81�� 12�� ���ϱ����� ��� �̸��� �Ի糯¥�� ���
<����8> ��å(job) salesman �̸鼭 ������ 1500 �̻��̸鼭 �μ���ȣ�� 30�� ������� ���
<����9> ������ 1500 �����̸鼭 �μ���ȣ�� 20�� �� �ƴ� ����̸���, ���ް�, �μ���ȣ�� ���
<����10> �����ȣ(eno) �� 7788, 7782 �� �μ���ȣ�� �̸��� ��å�� ��� 
*/ 

-- ���� Ǯ�� 
/*   employee ���̺��� �۾� , Select ���� ���, where ������ ����ؼ� ��� . 
<����1> �÷� �˸��(��Ī) , commission(���ʽ�) �÷��� null �� ���� ����ϵ� �����ȣ, ����̸�,�Ի糯¥�� ��� */
select eno �����ȣ, ename ����̸�, hiredate �Ի糯¥, commission ���ʽ�
from employee
where commission is null

<����2> dno(�μ���ȣ) �� 20�̰� �Ի糯¥�� 81�� 4�� ���� ����� �̸��� ��å�� �Ի糯¥�� ���
select ename ����̸�, job ��å, hiredate �Ի糯¥
from employee
where hiredate >= '81/04/01'; 

<����3> ������ ����ؼ� �����ȣ, ����̸�, ����, ���ʽ�, ��ü ������ ���
select eno �����ȣ,  ename ����̸�, salary ����, commission ���ʽ�, 
    (salary * 12) + nvl(commission , 0) ��ü����
from employee ; 

<����4> commission�� null �� �ƴ� ������� �̸��� ��� 
select ename ����̸�, commission ���ʽ� 
from employee 
where commission is not null ; 

<����5> manager (���޻��) 7698 �� ����̸��� ��å�� ���.
select ename ����̸�, job ��å , manager ���޻��
from employee
where manager = 7698 ; 
<����6> ������ 1500 �̻��̰� �μ��� 20�� ����� ����̸��� �Ի糯¥, �μ���ȣ, ������ ���
select ename ����̸�, hiredate �Ի糯¥, dno �μ���ȣ, salary ���� 
from employee 
where salary >= 1500; 

<����7> �Ի糯¥�� 81�� 4�� 1�� �̻��̰� 81�� 12�� ���ϱ����� ��� �̸��� �Ի糯¥�� ���
select ename ����̸�, hiredate �Ի糯¥ 
from employee
where hiredate >= '81/04/01' and hiredate <= '81/12/31'; 

<����8> ��å(job) salesman �̸鼭 ������ 1500 �̻��̸鼭 �μ���ȣ�� 30�� ������� ���
select ename ����� , job, salary, dno 
from employee 
where job = 'SALESMAN' and salary >= 1500 and dno = 30; 
<����9> ������ 1500 �����̸鼭 �μ���ȣ�� 20�� �� �ƴ� ����̸���, ���ް�, �μ���ȣ�� ���
select ename ����̸�, salary ����, dno �μ���ȣ 
from employee
where salary <1500 and dno = 20; 

<����10> �����ȣ(eno) �� 7788, 7782 �� �μ���ȣ�� �̸��� ��å�� ��� 
select dno �μ���ȣ, ename ����̸�, job ��å
from employee
where eno = 7788 or eno = 7782 ; 

*/ 

select * from employee; 






















