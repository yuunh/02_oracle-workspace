-- 한 줄 짜리 주석
/*
    여러줄
    주석
*/

-- 현재 모든 계정들에 대해서 조회하는 명령문
SELECT * FROM DBA_USERS;
-- 명령문 하나 실행(위쪽의 재생버튼 클릭 | ctrl + enter)

-- 일반 사용자계정 생성하는 구문(오로지 관리자 계정에서만 할 수 있음)
-- [표현법] CREATE USER 계정명 IDENTIFIED BY 비밀번호;

CREATE USER kh IDENTIFIED BY kh; -- 계정명은 대소문자 안가림
-- 계정 추가해보기 => 오류남 => 왜? 권한 부여가 되지 않음

-- 위에서 생성된 일반 사용자 계정에게 최소한의 권한(접속, 데이터 관리) 부여
-- [표현법] GRANT 권한1, 권한2, .... TO 계정명

GRANT CONNECT, RESOURCE TO kh;

CREATE USER SCOTT IDENTIFIED BY TIGER;

GRANT CONNECT, RESOURCE TO SCOTT;

CREATE USER DDL IDENTIFIED BY DDL;

GRANT CONNECT, RESOURCE TO DDL;

CREATE USER FINAL IDENTIFIED BY FINAL;

GRANT CONNECT, RESOURCE TO FINAL;

CREATE USER JDBC IDENTIFIED BY JDBC;

GRANT CONNECT, RESOURCE TO JDBC;