-- 먼저 저장

---------- QUIZ1 ----------
-- CREATE USER TEST INDENTIFIED BY 1234; 실행
-- User TEST이(가) 생성됐습니다.
-- 계정 생성만 하고 접속 => 에러!!

-- 왜 오류가 났는지?
-- 문제점 : 계정 생성만 하고 접속 권한을 부여하지 않았기 때문에
-- 조치 : GRANT CONNECT, RESOURCE TO TEST;

---------- QUIZ2 ----------
-- JOIN
CREATE TABLE TB_JOB(
    JOBCODE NUMBER PRIMARY KEY,
    JOBNAME VARCHAR2(10) NOT NULL
);

CREATE TABLE TB_EMP(
    EMPNO NUMBER PRIMARY KEY,
    EMPNAME VARCHAR2(10) NOT NULL,
    JOBNO NUMBER REFERENCES TB_JOB(JOBCODE)
);

-- 위의 두 테이블이 있다는 가정하에
-- 두 테이블을 조인해서 EMPNO, EMPNAME, JOBNO, JOBNAME 컬럼을 조회할거임
-- 이때 실행한 SQL문
SELECT EMPNO, EMPNAME, JOBNO, JOBNAME
FROM TB_EMP
JOIN TB_JOB USING (JOBNO);
-- 에러 발생
-- ORA-00904: "TB_JOB"."JOBNO": invalid identifier

-- 문제점 : JOBNO 컬럼이 TB_EMP에는 존재하지만 TB_JOB에는 존재하지 않기 때문에 USING 구문 사용 불가
-- 조치 : USING(JOBNO)이 아니라 ON절 사용해서 ON (JOBNO = JOBCODE)로 한다
SELECT EMPNO, EMPNAME, JOBNO, JOBNAME
FROM TB_EMP
JOIN TB_JOB ON (JOBNO = JOBCODE);

--------------------------------------------------------------------------------
-- 테이블 생성 관련해서 데이터 타입 (CHAR, VARCHAR2) 차이점

-- 오라클 객체 (SEQUENCE, VIEW, ....) 정의

-- 제약 조건 종류 => 뒤늦게 제약 조건을 추가할 수 있는 ALTER문 작성

-- DCL ?

-- COMMIT / ROLLBACK
