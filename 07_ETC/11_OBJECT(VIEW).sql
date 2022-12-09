-- 먼저 저장

/*
    < VIEW 뷰 >
    
    SELECT문(쿼리문)을 저장해둘 수 있는 객체
    (자주 쓰는 긴 SELECT문을 저장해두면 SELECT문을 매번 다시 기술할 필요 없음0
    임시테이블 같은 존재 (실제로 존재하는 것이 아님) => 그냥 보여주기용
    물리적인 테이블 : 실제!
    논리적인 테이블 : 가상! => 뷰는 논리적인 테이블
*/

-- 뷰 만들기 위한 복잡한 쿼리문 작성
-- 관리자 페이지

-- '한국'에서 근무하는 사원들의 사번, 이름, 부서명, 급여, 근무국가명 조회
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
JOIN NATIONAL USING (NATIONAL_CODE)
WHERE NATIONAL_NAME = '한국';

-- '러시아'에서 근무하는 사원들의 사번, 이름, 부서명, 급여, 근무국가명 조회
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
JOIN NATIONAL USING (NATIONAL_CODE)
WHERE NATIONAL_NAME = '러시아';

-- '일본'에서 근무하는 사원들의 사번, 이름, 부서명, 급여, 근무국가명 조회
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
JOIN NATIONAL USING (NATIONAL_CODE)
WHERE NATIONAL_NAME = '일본';

--------------------------------------------------------------------------------
/*
    1. VIEW 생성 방법
    
    [ 표현법 ]
    CREATE [OR REPLACE] VIEW 뷰명 
    AS 서브쿼리;
    
    [OR REPLACE] : 뷰 생성시 기존에 중복된 이름의 뷰가 없다면 새로이 뷰를 생성하고,
                            기존에 중복된 이름의 뷰가 있다면 해당 뷰를 변경(갱신)하는 옵션
*/

CREATE VIEW VW_EMPLOYEE
AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
    FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
    JOIN NATIONAL USING (NATIONAL_CODE);
-- ORA-01031: insufficient privileges
-- privileges : 권한
-- > 뷰를 생성할 권한이 없다

-- 관리자 계정에 접속해서 권한 부여
GRANT CREATE VIEW TO KH;

-- 실제 있는 테이블이 아님! 그래서 가상, 그래서 논리테이블이다
SELECT *
FROM VW_EMPLOYEE;

-- 아래와 같은 맥락
SELECT *
FROM (SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
        FROM EMPLOYEE
        JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
        JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
        JOIN NATIONAL USING (NATIONAL_CODE)); -- 이건 인라인뷰 / 위에거는 뷰!!
        
-- 뷰는 논리적인 가상 테이블! 실질적인 데이터를 저장하고 있지 않음!

-- 한국 러시아 일본에 근무하는 사원
SELECT *
FROM VW_EMPLOYEE
WHERE NATIONAL_NAME = '한국';

SELECT *
FROM VW_EMPLOYEE
WHERE NATIONAL_NAME = '러시아';

SELECT *
FROM VW_EMPLOYEE
WHERE NATIONAL_NAME = '일본';

-- [참고]
SELECT *
FROM USER_VIEWS;

-- 만약에 뷰에 정보를 추가하고 싶음
CREATE OR REPLACE VIEW VW_EMPLOYEE
AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME, BONUS
    FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
    JOIN NATIONAL USING (NATIONAL_CODE);
-- ORA-00955: name is already used by an existing object
-- 이미 해당 이름을 가진 뷰가 있다고 에러남!!
-- > OR REPLACE 추가
-- > 없으면 만들고 없으면 변경해라

--------------------------------------------------------------------------------
/*
    * VIEW 컬럼에 별칭 부여
    서브쿼리의 SELECT절에 함수식이나 산술연산식이 기술되어 있을 경우
    반드시 별칭을 지정해야됨!!
*/

-- 전 사원의 사번, 이름, 직급명, 성별, 근무년수를 조회할 수 있는 SELECT문을 뷰(VW_EMP_JOB)로 정의
CREATE OR REPLACE VIEW VW_EMP_JOB
AS SELECT EMP_ID, EMP_NAME, JOB_NAME, 
          DECODE(SUBSTR(EMP_NO, 8, 1), '1', '남', '2', '여') AS "성별",
          EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) AS "근무년수"
    FROM EMPLOYEE
    JOIN JOB USING (JOB_CODE);
-- ORA-00998: must name this expression with a column alias
-- ALIAS : 별칭
-- SELECT절에 함수식이나 산술연산식이 있을 경우 별칭 지정 필수!
  
SELECT *
FROM VW_EMP_JOB; -- 실제로 만들어진 테이블 아님 그냥 보여주는 논리적인 테이블일뿐...

-- 아래와 같은 방법으로도 별칭 부여 가능
-- 단 모든 컬럼에 대해서 별칭 부여해야함
CREATE OR REPLACE VIEW VW_EMP_JOB(사번, 이름, 직급명, 성별, 근무년수)
AS SELECT EMP_ID, EMP_NAME, JOB_NAME, 
          DECODE(SUBSTR(EMP_NO, 8, 1), '1', '남', '2', '여'),
          EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) 
    FROM EMPLOYEE
    JOIN JOB USING (JOB_CODE);

-- 성별이 여자인 사원들의 이름, 직급명 조회
SELECT 이름, 직급명
FROM VW_EMP_JOB
WHERE 성별 = '여';

-- 근무년수가 20년 이상된 사원들의 사번, 이름, 직급명, 성별, 근무년수를 조회해라
SELECT *
FROM VW_EMP_JOB
WHERE 근무년수 >= 20;

-- VIEW 삭제하고 싶다면?
DROP VIEW VW_EMP_JOB;

--------------------------------------------------------------------------------
-- 생성된 뷰를 이용해서 DML(INSERT, UPDATE, DELETE) 사용 가능
-- 뷰를 통해서 조작하더라도 실제 데이터가 담겨있는 베이스테이블 반영됨
-- 근데 잘 안되는 경우가 많아서 실제로 많이 쓰이지는 않음

CREATE OR REPLACE VIEW VW_JOB
AS SELECT JOB_CODE, JOB_NAME
FROM JOB;

SELECT *
FROM VW_JOB; -- 논리적인 테이블 (실제 데이터가 담겨있지는 않음)

SELECT *
FROM JOB; -- 베이스 테이블 (실제 데이터가 담겨있음)

-- 뷰를 통해서 INSERT
INSERT INTO VW_JOB VALUES ('J8', '인턴');

-- 뷰를 통해서 UPDATE
UPDATE VW_JOB
SET JOB_NAME = '알바'
WHERE JOB_CODE = 'J8';

-- 뷰를 통해서 DELETE
DELETE FROM VW_JOB
WHERE JOB_CODE = 'J8';

--------------------------------------------------------------------------------
/*
    * 단, DML 명령어로 조작이 불가능한 경우가 더 많음!!
    1) VIEW에 정의되어 있지 않은 컬럼을 조작하려고 하는 경우
    2) VIEW에 정의되어 있지 않은 컬럼 중에 베이스 테이블상에 NOT NULL 제약 조건이 지정되어 있는 경우
    3) 산술연산식 또는 함수식으로 정의되어 있는 경우
    4) 그룹함수나 GROUP BY 절이 포함된 경우
    5) DISTINCT 구문이 포함된 경우
    6) JOIN을 이용해서 여러 테이블을 연결 시켜 놓은 경우
*/

-- 1) VIEW에 정의되어 있지 않은 컬럼을 조작하려고 하는 경우
CREATE OR REPLACE VIEW VW_JOB
AS SELECT JOB_CODE
FROM JOB;

SELECT *
FROM VW_JOB;

SELECT *
FROM JOB;

-- INSERT 
INSERT INTO VW_JOB(JOB_CODE, JOB_NAME) VALUES ('J8', '인턴');)
-- ORA-00904: "JOB_NAME": invalid identifier
-- JOB_NAME을 알 수 없다 -> 없는 컬럼

-- UPDATE
UPDATE VW_JOB
SET JOB_NAME = '인턴'
WHERE JOB_CODE = 'J7';
-- ORA-00904: "JOB_NAME": invalid identifier

-- DELETE 
DELETE FROM VW_JOB
WHERE JOB_NAME = '사원';
-- ORA-00904: "JOB_NAME": invalid identifier

-- 2) VIEW에 정의되어 있지 않은 컬럼 중에 베이스 테이블상에 NOT NULL 제약 조건이 지정되어 있는 경우
CREATE OR REPLACE VIEW VW_JOB
AS SELECT JOB_NAME
FROM JOB;

SELECT *
FROM VW_JOB;

SELECT *
FROM JOB;

-- INSERT
INSERT INTO VW_JOB VALUES ('인턴');
-- 실제 베이스 테이블에 INSERT 시 (NULL, '인턴') 추가
-- ORA-01400: cannot insert NULL into ("KH"."JOB"."JOB_CODE")
-- JOB_CODE에 NULL을 넣을 수 없다

-- UPDATE
UPDATE VW_JOB
SET JOB_NAME = '알바'
WHERE JOB_NAME = '사원';
-- 정의되어 있는 컬럼은 수정잘된다

ROLLBACK;

-- DELETE
DELETE FROM VW_JOB
WHERE JOB_NAME = '사원';
-- ORA-02292: integrity constraint (KH.SYS_C007172) violated - child record found
-- 제약 조건 위반 -> 자식 테이블에서 데이터 사용 중이기 때문에 삭제 안됨, 없었다면 삭제 됐을거임

-- 3) 산술연산식 또는 함수식으로 정의되어 있는 경우
CREATE OR REPLACE VIEW VW_EMP_SAL
AS SELECT EMP_ID, EMP_NAME, SALARY, SALARY * 12 AS "연봉" 
FROM EMPLOYEE;

SELECT *
FROM VW_EMP_SAL;

SELECT *
FROM EMPLOYEE;

-- INSERT (에러)
INSERT INTO VW_EMP_SAL VALUES (400, '차은우', 3000000, 36000000); -- 에러    
-- ORA-01733: virtual column not allowed here
-- EMPLOYEE에 연봉이라는 컬럼 없음

-- UPDATE
-- 200 사원의 연봉을 8000만원으로 
UPDATE VW_EMP_SAL
SET 연봉 = 80000000
WHERE EMP_ID = 200; -- 에러

-- 200 사원의 급여를 700만원으로
UPDATE VW_EMP_SAL
SET SALARY = 7000000
WHERE EMP_ID = 200; -- 성공

SELECT *
FROM EMPLOYEE
WHERE EMP_ID = 200;

ROLLBACK;

-- DELETE
DELETE FROM VW_EMP_SAL
WHERE 연봉 = 72000000; -- 성공

ROLLBACK;

-- 4) 그룹함수나 GROUP BY 절이 포함된 경우
CREATE OR REPLACE VIEW VW_GROUPDEPT
AS SELECT DEPT_CODE, SUM(SALARY) AS "합계", FLOOR(AVG(SALARY)) AS "평균"
FROM EMPLOYEE
GROUP BY DEPT_CODE;

SELECT *
FROM VW_GROUPDEPT;

-- INSERT
INSERT INTO VW_GROUPDEPT VALUES('D3', 8000000, 4000000); -- 에러
-- 실제 EMPLOYEE에 넣을 컬럼이 없음 

-- UPDATE
UPDATE VW_GROUPDEPT
SET 합계 = 8000000
WHERE DEPT_CODE = 'D1'; -- 에러
-- 딱히 어디를 수정하기 애매함...

-- 5) DISTINCT 구문이 포함된 경우
CREATE OR REPLACE VIEW VW_DT_JOB
AS SELECT DISTINCT JOB_CODE
FROM EMPLOYEE;

SELECT *
FROM VW_DT_JOB;

-- INSERT
INSERT INTO VW_DT_JOB VALUES ('J8'); -- 에러

-- UPDATE
UPDATE VW_DT_JOB
SET JOB_CODE = 'J8'
WHERE JOB_CODE = 'J7'; -- 에러
-- 뷰에 DISTINCT 구문이 있어서 안된다

-- 6) JOIN을 이용해서 여러 테이블을 연결 시켜 놓은 경우
CREATE OR REPLACE VIEW VW_JOINEMP 
AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

SELECT *
FROM VW_JOINEMP;

-- INSERT
INSERT INTO VW_JOINEMP VALUES (300, '장원영', '러브다이부'); -- 에러

-- UPDATE
UPDATE VW_JOINEMP
SET DEPT_TITLE = '회계부'
WHEE EMP_ID = '200'; -- 에러

-- DELETE
DELETE FROM VW_JOINEMP
WHERE EMP_ID = 200; -- 성공

ROLLBACK;

--------------------------------------------------------------------------------
/*
    * VIEW 옵션
    
    [ 상세표현식 ]
    CREATE [OR REPLACE] [FORCE | NOFORCE (생략하면 이게 기본)] VIEW 뷰명
    AS 서브쿼리
    [WITH CHECK OPTION]
    [WITH READ ONLY] => 오로지 조회만 가능
    
    1) OR REPLACE : 기존에 동일한 뷰가 있을 경우 갱신시키고, 존재하지 않으면 새로이 생성시킨다
    2) FORCE | NOFORCE 
        > FORCE   : 서브쿼리에 기술된 테이블이 존재하지 않아도 뷰가 생성되게 하는
        > NOFORCE : 서브쿼리에 기술된 테이블이 존재하는 테이블이어야만 뷰가 생성되게 하는(생략시 기본값)
    3) WITH CHECK OPTION : DML시 서브쿼리에 기술된 조건에 부합한 값으로만 DML 가능하도록
    4) WHTH READ ONLY : 뷰에 대해 조회만 가능 (DML 수행 불가)
*/

-- 2) FORCE | NOFORCE 
-- NOFORCE : 서브쿼리에 기술된 테이블이 존재하는 테이블이어야만 뷰가 생성되게 하는(생략시 기본값)
CREATE OR REPLACE /*NOFORCE*/ VIEW VW_EMP
AS SELECT TCODE, TNAME, TCONTENT
FROM TT;
-- ORA-00942: table or view does not exist
-- 해당 테이블이 없어서 오류남

-- FORCE   : 서브쿼리에 기술된 테이블이 존재하지 않아도 뷰가 생성되게 하는
CREATE OR REPLACE FORCE VIEW VW_EMP
AS SELECT TCODE, TNAME, TCONTENT
FROM TT;
-- 경고: 컴파일 오류와 함께 뷰가 생성되었습니다.

SELECT *
FROM VW_EMP;
-- 만들어지긴 했지만 조회는 안됨
-- TT 테이블 생성해야만 그때부터 VIEW 활용 가능

CREATE TABLE TT(
    TCODE NUMBER,
    TNAME VARCHAR(20),
    TCONTENT VARCHAR(30)
);

DROP TABLE TT;

-- 3) WITH CHECK OPTION : 서브쿼리에 기술된 조건에 부합하지 않는 값으로 수정시 오류 발생
-- WITH CHECK OPTION 안 쓰고
CREATE OR REPLACE VIEW VW_EMP
AS SELECT *
FROM EMPLOYEE
WHERE SALARY >= 3000000;

SELECT *
FROM VW_EMP;

-- 200번 사원의 급여를 200만원으로 변경
UPDATE VW_EMP
SET SALARY = 2000000
WHERE EMP_ID = 200;

ROLLBACK;

-- WITH CHECK OPTION 쓰고
CREATE OR REPLACE VIEW VW_EMP
AS SELECT *
FROM EMPLOYEE
WHERE SALARY >= 3000000
WITH CHECK OPTION;

SELECT *
FROM VW_EMP;

UPDATE VW_EMP
SET SALARY = 2000000
WHERE EMP_ID = 200; -- 오류남
-- 서브쿼리에 기술한 조건에 부합되지 않기 때문에 변경 불가

UPDATE VW_EMP
SET SALARY = 4000000
WHERE EMP_ID = 200;

ROLLBACK;

-- 4) WHTH READ ONLY : 뷰에 대해 조회만 가능 (DML 수행 불가)
CREATE OR REPLACE VIEW VW_EMP
AS SELECT EMP_ID, EMP_NAME, BONUS
    FROM EMPLOYEE
    WHERE BONUS IS NOT NULL
WITH READ ONLY;

SELECT *
FROM VW_EMP;

DELETE FROM VW_EMP
WHERE EMP_ID = 200;
-- ORA-42399: cannot perform a DML operation on a read-only view
-- 이 뷰는 읽기 전용임
