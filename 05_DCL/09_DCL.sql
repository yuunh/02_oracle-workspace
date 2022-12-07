-- 먼저 저장

/*
    < DCL : DATA CONTROL LANGUAGE > : 데이터 제어 언어
    
    계정에게 시스템 권한 또는 객체접근권한을 부여(GRANT)하거나 회수(REVOKE)하는 구문
    
    >> 시스템 권한 : DB에 접근하는 권한, 객체들을 생성할 수 있는 권한
    >> 객체접근권한 : 특정 객체들을 조작할 수 있는 권한
*/

/*
    * 시스템 권한 종류
    - CREATE SESSION  : 접속할 수 있는 권한
    - CREATE TABLE    : 테이블을 생성할 수 있는 권한
    - CREATE VIEW     : 뷰를 생성할 수 있는 권한
    - CREATE SEQUENCE : 시퀀스 생성할 수 있는 권한
    ... CONNECT : 일부는 커넥트 안에 다 포함되어있음!!
*/

-- 1. SAMPLE / SAMPLE 계정 생성
CREATE USER SAMPLE IDENTIFIED BY SAMPLE;
-- 상태: 실패 -테스트 실패: ORA-01045: user SAMPLE lacks CREATE SESSION privilege; logon denied

-- 2. 접속을 위해 CREATE SESSION 권한 부여
GRANT CREATE SESSION TO SAMPLE;

-- 3_1 CREATE TABLE 권한 받기
GRANT CREATE TABLE TO SAMPLE;

-- 3_2 TABLE SPACE 할당 받기
ALTER USER SAMPLE QUOTA 2M ON SYSTEM;

--------------------------------------------------------------------------------
/*
    * 객체 접근 권한 종류
    특정 객체에 접근해서 조작할 수 있는 권한
    
    권한 종류            특정객체
    SELECT          TABLE, VIEW, SEQUENCE
    INSERT          TABLE, VIEW
    UPDATE          TABLE, VIEW
    DELETE          TABLE, VIEW
    ....
    
    [ 표현법 ]
    GRANT 권한종류 ON 특정객체 TO 계정
*/

GRANT SELECT ON KH.EMPLOYEE TO SAMPLE;
GRANT INSERT ON KH.DEPARTMENT TO SAMPLE;

GRANT CONNECT, RESOURCE TO 계정명;
