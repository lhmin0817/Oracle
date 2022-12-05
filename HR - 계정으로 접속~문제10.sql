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
