SELECT * from mytbl;

INSERT into mytbl values('1', '1234');
commit; 
-- �����϶�

SELECT * from myTbl;

-- �� �� �ּ� : ���α׷����� �ؼ����� �ʴ� ����
/*
������ �ּ�

*/

-- 1. HR ���� ���� : Oracle 12 �������� ������ ���� ��  ���� �� �տ� C##�� �ٿ��� �Ѵ�.
--  system�������� ������ ����â���� ����� ����Ѵ�.
-- HR : ������ , ��ȣ : 1234
create user C##HR identified by 1234;

-- 2. HR ������ ���� �ο� 
/*
connect : ���ݿ��� DB�� ������ �� �ִ� ����
resource : ��ü(resource) - Table, index, view store procedure, triger, funtion
�� ����, ����, ���� �� �� �ִ� ����
*/
grant connect, resource to C##HR;
-- 3.���̺� �����̽��� ����� ���� �ο� 
    -- USERS ���̺� �����̽��� ��뷮�� ������ ����� �� �ֵ��� ���Ѻο�
alter user C##HR quota unlimited on USERS;
-- 4. HR ���� ���� - ���� ������ �Ǿ��ִ� ��� ������ �ȵ� ������ ���� ���� �� ���� ����
drop user C##HR1;

show user;

select * from tab;
