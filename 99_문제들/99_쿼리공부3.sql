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

---------- QUIZ3 ----------
-- JOIN

-- 아래의 SQL구문은 부서별 월급 합계가 15,000,000을 초과하는 부서를 조회한 것이다
-- 그 결과가 올바르지 않다
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
WHERE SALARY > 15000000
GROUP BY DEPT_CODE;

SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) > 15000000;

---------- QUIZ4 ----------
-- 제약 조건
CREATE TABLE QUIZ4(
    QNO NUMBER PRIMARY KEY,
    QNAME VARCHAR2(10),
    SCORE NUMBER
);

INSERT INTO QUIZ4 VALUES (1, '퀴즈1번', 30);
INSERT INTO QUIZ4 VALUES (1, '퀴즈2번', 50);
INSERT INTO QUIZ4 VALUES (NULL, '퀴즈1번', 30);

-- JOIN => DECODE
-- J7인 사원은 급여를 10% 인상
-- J6인 사원은 급여를 15% 인상

-- '21/09/28' 문자열 => '2021-09-28'
-- '210908' => 2021년 9월 8일

-- CASE WHEN
-- 초급개발자 중급개발자 고급개발자

