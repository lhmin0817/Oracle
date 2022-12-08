--��� ���̺� ����ϱ�
select * from tab;

--���̺��� ���� Ȯ���ϱ�

-- select : ����ϱ�
/*
  selsct �÷���
  from ���̺� �̸�
  
*/
--1. employee ���̺��� ��� �÷��� ���
    -- �ٷ���(�����)�� ���� ������ ����
select * 
from employee;


--2. department ���̺��� ��� �÷��� ���
    -- �μ��� ���� ������ �����ϴ� ���̺� 
SELECT *
from department;

--3. salgrade ���̺��� ��� �÷�(�ʵ�, ��ƼƼ)�� ���
    --�Ǹ� ������ �����ϴ� ���̺� 
SELECT *
from salgrade;

--===================================================================
--�� ���̺��� ������ �÷� ����
--1.  employee
select * from employee;
/*
  ENO : ��� ��ȣ
  ENAME : �����
  JOB : ��å
  MANAGER : ���
  HIREDATE : �Ի���
  SALARY : ����
  COMMISSION : ���ʽ� 
  DNO : �μ���ȣ

*/
-- 2. �μ������� �����ϴ� ���̺�
SELECT * from department;
/*
   DNO : �μ���ȣ
   DNAME : �μ���
   LOC : �μ� ��ġ 
*/

--3. ���޼����� �����ϴ� ���̺�
SELECT * from salgrade;

/*
  GRADE : ���� ���� 
  LOSAL : ���� ���� ����
  HISAL : ���� ���� ����
*/

-- SELSECT : ����ض�
--�÷�, �ʵ�, ��ƼƼ
-- ���ڵ� : �� �÷��� �� �� (��)
-- ���ڵ� �� : ���ڵ���� ����
SELECT * 
from employee;

--Ư�� �÷��� ���
SELECT eno
FROM employee;

--Ư�� �÷� ������ ��� (�ϳ��� �÷��� ���� ��� , ����)
SELECT eno, ename, job
from employee;

--��� �÷� ���
SELECT eno, ename, job, manager , commission, hiredate , salary, dno
from employee;

--Ư�� �÷��� ��� �� ������ ���
SELECT eno, ename, salary, ename, ename
from employee;

-- ���̺��� ���� Ȯ�� �ϱ�
DESCRIBE employee;
DESC employee;

-- �÷��� ��Ī���� ����ϱ� (as��Ī)
SELECT eno as �����ȣ, ename as �����, job as ��å
from employee;

SELECT eno  �����ȣ, ename  �����, job  ��å
from employee;

--employee ���̺��� ��� �÷��� ��Ī���� ���
SELECT eno �����ȣ, ename �����, job ��å, manager �����ȣ, 
    hiredate �Ի���, salary "��#��", commission ���ʽ�, dno "�μ� ��ȣ"
from employee;

-- ������ ����Ͽ� ��� : where
SELECT *
from employee
where eno = 7499; -- ������ ����ؼ� ��� �� ���, eno �÷��� ���� 7499�� �͸� ���

desc employee;
-- <== empolyee ���̺��� ������ Ȯ��
--���� ��� �� : number ������ Ÿ���� ���� '' ���� ���
--              number �̿��� ������ Ÿ���� '' : char, varchar, data

--job (varchar2) ���� ���� �ö� ��ҹ��� ����
SELECT * from employee
where job = 'MANAGER';

desc employee;

--SELECT * from employee

--�μ� ��ȣ�� 20���� ��� �÷��� ���
SELECT * from employee
where dno = 20;

--<����>
-- salary (���� ) 2000���� �̻����ڸ� ��� �÷� ���
-- �̸��� CLARK�� ������� ���޸� ���
-- ��� ��ȣ (ENO)7788�� ������� �̸��� �Ի� ��¥�� ��� <== �÷��̸��� ��Ī

-- salary (���� ) 2000���� �̻����ڸ� ��� �÷� ���
SELECT * FROM employee
WHERE salary >=2000;

-- �̸��� CLARK�� ������� ���޸� ���
SELECT salary FROM employee
WHERE ename = 'CLARK';

-- ��� ��ȣ (ENO)7788�� ������� �̸��� �Ի� ��¥�� ��� <== �÷��̸��� ��Ī
SELECT ENO �����ȣ, ENAME �����, hiredate �Ի��� FROM employee
WHERE ENO = 7788;

--SELECT ���� ��ü ����---
/*
select -- �÷� �� : * (��� �÷�),
DISTINCT -- �ߺ� �� �� ����
from   -- ���̺� ��, �� �̸� 
WHERE  -- ����
GROUP BY -- Ư�� �÷��� ������ ���� �׷����� �� 
Having  -- group by ���� ���� ����� ������ ó��
Order by -- �����ؼ� ����� �÷�, asc : �������� ����, desc : �������� ����
*/

SELECT * FROM employee;

SELECT DNO 
FROM employee;

SELECT DISTINCT DNO �μ���ȣ        
--DIERINCT �ߺ��� ���� ���� �� ��� �ٸ� �÷��� ���ÿ� �۵��ϸ� �����߻� 
-- �ߺ��� ������ �÷� 1���� ���
FROM employee;

SELECT DISTINCT DNO, ENO
FROM employee;

--�÷��� ������ ���� : �÷����� ������, alias(��Ī)�ؼ� ���
select eno, ename, salary ����, salary * 12 ����, commission ���ʽ�
from employee;

-- null �÷��� ����(+, -, *, /)�� �ϰԵǸ� ��ü�� null
--��ü ���� ���ϱ� ; ���޿��� *12 �� �� + ���ʽ� = ��ü ����
select eno as �����ȣ, ename as �����, salary as ����, commission as ���ʽ�, salary * 12 as ����,
(salary*12)+commission as ��ü����
from employee;

--��ü ������ ���� �� null �� �÷��� 0�Ѥ��� ���� �� ������ �����ؾ� �Ѵ�.
    -- nvl �Լ� : null�� �� �÷��� �ٸ� ������ ��ȯ�ؼ� ó��
    -- nvl(commission , 0) <== commission �÷��� null�� 0���� �����ؼ� ó���ض�
select eno �����ȣ, ename as �����, salary ����, nvl(commission ,0) ���ʽ�, 
salary* 12 ����, (salary*12)+nvl(commission,0) ��ü����
from employee;

--null�� �� �÷��� ����ϱ� <== ����
    -- null�� �˻� �Ҷ��� is �� ���, = �� ����ϸ� ����
select *
from employee
where commission is null;

select * 
from employee
where commission is not null;

-- where ���ǿ��� and, or ����ϱ�
--�μ� ��ȣ�� 20���� 30���� ��� �÷� ���
select *
from employee
where dno = 20 or dno = 30;

select *
from employee
where dno = 20 or salary >=2000;

select *
from employee
where dno = 20 and salary <=1500;

-- job(��å)��  MANAGER�̸鼭 ������ 2000���� �̻� ����ڸ� ���
select *
from employee
where job = 'MANAGER' and salary >=2000;

SELECT * from employee;
--  <����1> �÷� �˸��ƽ�(��Ī), commission(���ʽ�) �÷��� null�� ���� ����ϵ� ��� ��ȣ �̸� �Ի� ��¥ ���
select eno �����ȣ, ename �����, hiredate �Ի糯¥, commission ���ʽ�
from employee
where commission is null;

--  <����2> dno(�μ���ȣ) 20�̰� �Ի糯¥�� 81/04/ ���� ����� �̸��� ��å, �Ի糯¥ ���
select ename �����, job ��å, hiredate �Ի糯¥
from employee
where dno = 20 and hiredate >= '81/04/01';

--  <����3> ������ ����ؼ� ��� ��ȣ , ��� �̸�, ����, ���ʽ�, ��ü ���� ���
select eno �����ȣ, ename as �����, salary ����, nvl(commission ,0) ���ʽ�, 
salary* 12 ����, (salary*12)+nvl(commission,0) ��ü����
from employee;

--  <����4> commission�� null�� �ƴ� ������� �̸��� ���
select ename �����
from employee
where commission is not null;

--  <����5>  MANAGER (���޻��) 7698 �� ����̸��� ��å�����
select ename �����, job ��å
from employee
where MANAGER = 7698; 

--  <����6> ������ 1500 �̻� �̰� �μ��� 20�� ����� ����̸�, �Ի糯¥ �μ� ��ȣ ���� ���
select ename �����, hiredate �Ի糯¥, dno �μ���ȣ, salary ����
from employee
where salary >=1500 and dno = 20;

--  <����7> �Ի糯¥�� 81/04/01 �̻��̰� 81/12 ���� ��� �̸� �Ի糯¥���� ���
select ename �����, hiredate �Ի糯¥
from employee
where hiredate >= '81/04/01' and hiredate <= '81/12/30';

--  <����8> ��å(job)salesman �̸鼭 ������ 1500�̻��̸鼭 �μ� ��ȣ�� 30�� ����� ���
select ename �����
from employee
where job = 'SALESMAN' and salary >=1500 and dno =30;

--  <����9> ������ 1500���� �̸鼭 �μ���ȣ�� 20�� �ƴ� �����, ���� �μ���ȣ ���
select ename �����, salary ����, dno �μ���ȣ
from employee
where salary <=1500 and dno != 20;
  
--  <����10> �����ȣ(eno) �� 7788, 7782 �� �μ� ��ȣ�� ����� ��ä�� ���
select dno �μ���ȣ, ename �����, job ��å
from employee
where eno = 7788 or eno = 7782;

