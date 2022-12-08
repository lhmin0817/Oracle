
-- 1. HR 계정으로 접속 확인 : resoure : 테이블 생성, 수정, 삭제,
show user;

-- 2. 테이블 생성,   ; <== 까지가 하나의 명령어가 처리되는 블락
CREATE TABLE myTbl2(
    id VARCHAR2 (20),
    pass VARCHAR2 (20)
    );
-- 3. 테이블에 값 넣기 : commit (저장)
INSERT INTO myTbl2 VALUES ('1', '1234');
commit;     --DB 에 영구적으로 저장(insert, update, delete 구문에서 사용)

-- 4. 테이블의 값 출력
SELECT * FROM myTbl2;

-- 5. 테이블 삭제
drop TABLE myTbl2;

--원격 접속한 Oracle 버전 확인
select * from v$version;

--접속한 DataBase 에 조잰하는 모든 테이블 보기
select * from tab;
