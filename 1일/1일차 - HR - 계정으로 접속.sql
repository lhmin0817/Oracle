
-- 1. HR �������� ���� Ȯ�� : resoure : ���̺� ����, ����, ����,
show user;

-- 2. ���̺� ����,   ; <== ������ �ϳ��� ��ɾ ó���Ǵ� ���
CREATE TABLE myTbl2(
    id VARCHAR2 (20),
    pass VARCHAR2 (20)
    );
-- 3. ���̺� �� �ֱ� : commit (����)
INSERT INTO myTbl2 VALUES ('1', '1234');
commit;     --DB �� ���������� ����(insert, update, delete �������� ���)

-- 4. ���̺��� �� ���
SELECT * FROM myTbl2;

-- 5. ���̺� ����
drop TABLE myTbl2;

--���� ������ Oracle ���� Ȯ��
select * from v$version;

--������ DataBase �� �����ϴ� ��� ���̺� ����
select * from tab;
