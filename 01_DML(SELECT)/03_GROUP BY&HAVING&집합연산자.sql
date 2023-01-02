-- 먼저 저장

/*
    < GROUP BY 절 >
    그룹 기준을 제시할 수 있는 구문 (해당 그룹 기준별로 여러 그룹을 묶을 수 있음)
    여러 개의 값들을 하나의 그룹으로 묶어서 처리할 목적으로 사용
*/

SELECT SUM(SALARY)
FROM EMPLOYEE; --> 전체 사원을 하나의 그룹으로 묶어서 총합을 구한 결과

-- 각 부서별 총 급여합
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- 각 부서별 사원수
SELECT DEPT_CODE, COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- 실행 순서
SELECT DEPT_CODE, SUM(SALARY) --3
FROM EMPLOYEE -- 1
GROUP BY DEPT_CODE -- 2
ORDER BY DEPT_CODE; -- 4

SELECT JOB_CODE, SUM(SALARY), COUNT(*) AS "(명)"
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY JOB_CODE;

-- 각 직급별 총 사원수, 보너스를 받는 사원수, 급여합, 평균급여, 최저급여, 최대급여
SELECT JOB_CODE, COUNT(*) || '명' AS "총 사원수", COUNT(BONUS) || '명' AS "보너스를 받는 사원수", 
       SUM(SALARY) || '원' AS "총 급여", ROUND(AVG(SALARY)) || '원' AS "평균 급여", 
       MIN(SALARY) || '원' AS "최저 급여", MAX(SALARY) || '원' AS "최대 급여"
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY 1;

-- 부서별
SELECT DEPT_CODE, COUNT(*) || '명' AS "총 사원수", COUNT(BONUS) || '명' AS "보너스를 받는 사원수", 
       SUM(SALARY) || '원' AS "총 급여", ROUND(AVG(SALARY)) || '원' AS "평균 급여", 
       MIN(SALARY) || '원' AS "최저 급여", MAX(SALARY) || '원' AS "최대 급여"
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY 1;

-- GROUP BY 절에 함수식 기술 가능!!
SELECT DECODE(SUBSTR(EMP_NO, 8, 1), '1', '남', '2', '여') AS "성별", COUNT(*)
FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO, 8, 1);

-- GROUP BY 절에 여러 컬럼 기술 가능!!
SELECT DEPT_CODE, JOB_CODE, COUNT(*), SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE
ORDER BY DEPT_CODE;

-------------------------------------------------------------------------------
/*
    < HAVING 절 >
    그룹에 대한 조건을 제시할 때 사용되는 구문(주로 그룹 함수식을 가지고 조건을 제시함)
*/

-- 각 부서별 평균 급여 조회
SELECT DEPT_CODE, ROUND(AVG(SALARY)) AS "평균급여"
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;

-- 부서별 평균 급여가 300만원 이상인 부서들만 조회
SELECT DEPT_CODE, ROUND(AVG(SALARY)) AS "평균급여"
FROM EMPLOYEE
WHERE ROUND(AVG(SALARY)) >= 3000000 -- 오류발생!! => GROUP BY 절에서는 WHERE 절 사용 불가
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;

SELECT DEPT_CODE, ROUND(AVG(SALARY)) AS "평균급여" -- 4
FROM EMPLOYEE -- 1
GROUP BY DEPT_CODE -- 2
HAVING AVG(SALARY) >= 3000000 -- 3
ORDER BY DEPT_CODE; -- 5

-- 직급별 총 급여합 (단, 직급별 급여 합이 1000만원 이상인 직급 조회)
SELECT JOB_CODE, SUM(SALARY) AS "총 급여합"
FROM EMPLOYEE
GROUP BY JOB_CODE
HAVING SUM(SALARY) >= 10000000;

-- 부서별 보너스를 받는 사원이 없는 부서만을 조회
SELECT DEPT_CODE
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING COUNT(BONUS) = 0;

----------------------------------------------------------------------------------
/*
    < SELECT 문 실행 순서 >
    5. SELECT * | 조회하고자 하는 컬럼 별칭 | 산술실 "별칭" | 함수식 AS "별칭"
    1. FROM 조회하고자 하는 테이블명
    2. WHERE 조건식 (주로 연산자를 가지고 기술)
    3. GROUP BY 그룹 기준으로 삼을 컬럼 | 함수식
    4. HAVING 조건식 (그룹 함수를 가지고 기술)
    6. ORDER BY 컬럼명 | 별칭 | 순번 | [ASC|DESC] [NULLS FIRST | NULLS LAST]
*/
-----------------------------------------------------------------------------
/*
    < 집계 함수 >
    그룹별 산출된 결과값에 중간 집계를 계산해주는 함수
    
    * ROLLUP
    
    => GROUP BY 절에 기술하는 함수
*/

-- 각 직급별 급여합
-- 마지막 행으로 전체 총 급여합까지 같이 조회하고 싶을 때
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(JOB_CODE)
ORDER BY JOB_CODE;
-- ROLLUP : GROUP BY를 통해 묶은 그룹의 중간 집계를 계산해주는 함수

------------------------------------------------------------------------
/*
    < 집합 연산자 == SET OPERATION >
    
    여러 개의 쿼리문을 가지고 하나의 쿼리문으로 만드는 연산자
    
    - UNION     : 합집합 | OR (두 쿼리문을 수행한 결과값을 더한 후 중복되는 값은 한번만 더해지도록)
    - INTERSECT : 교집합 | AND (두 쿼리문을 수행한 결과값에 중복된 결과값)
    - UNION ALL : 합집합 + 교집합 (중복되는 부분이 두번 표현될 수 있음)
    - MINUS     : 차집합 ( 선행 결과값에서 후행 결과값을 뺀 나머지)
*/

-- 1. UNION (합집합)
-- 부서코드가 D5인 사원 또는 급여가 300만원 초과인 사원들 조회 (사번, 이름, 부서코드, 급여)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' -- 6개행 (박나라, 하이유, 김해술, 심봉선, 윤은해, 대북혼)
UNION -- 중복되는 2개행 제거되고 12개행 나옴 
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000; -- 8개행 (선동일, 송종기, 노옹철, 유재식, 정중하, *심봉성, *대북혼, 전지연)

-- 위의 합집합 쿼리문 대신 아래처럼 WHERE 절에 OR 써도 해결 가능!!
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' OR SALARY > 3000000; -- 12개행 나옴

-- 2. INTERSECT (교집합)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' -- 6개행 (박나라, 하이유, 김해술, 심봉선, 윤은해, 대북혼)
INTERSECT -- 중복되는 2개행 나옴 ( 심봉선, 대북혼)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000; -- 8개행 (선동일, 송종기, 노옹철, 유재식, 정중하, *심봉성, *대북혼, 전지연)

-- 위의 교집합 쿼리문 대신 아래처럼 WHERE 절에 AND 써도 해결 가능!!
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' AND SALARY > 3000000;

------------------------------------------------------------------------------------------------
-- 집합 연산자 유의사항
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY -- 컬럼 4개
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' 
UNION 
SELECT EMP_ID, EMP_NAME, DEPT_CODE -- 컬럼 3개
FROM EMPLOYEE
WHERE SALARY > 3000000; 
-- 각 쿼리문의 SELECT 절에 작성되어 있는 컬럼 개수 동일해야됨!

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' 
UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE SALARY > 3000000; 
-- 각 쿼리문의 SELECT 절에 작성되어 있는 컬럼 타입 동일해야됨!

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
-- ORDER BY EMP_NAME 
UNION 
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000 
ORDER BY EMP_NAME;
-- ORDER BY 절을 붙이고자 한다면 마지막에 기술해야됨!!

----------------------------------------------------------------------------------------
-- 3. UNION ALL : 여러 개의 쿼리 결과를 무조건 다 더하는 연산자 (중복값 나옴)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY -- 6개행
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' 
UNION ALL -- 중복값 나와서 14행 나옴
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY -- 8개행
FROM EMPLOYEE
WHERE SALARY > 3000000;

-------------------------------------------------------------------------------
-- 4. MINUS : 선행 SELECT 결과에서 후행 SELECT 결과를 뺀 나머지 (차집합)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' 
MINUS -- 선행 결과값 6개행 중에 중복되는 후행 결과값 빠져서 4행 나옴 (박나라, 하이유, 김해술, 윤은해)
SELECT EMP_ID, EMP_NAME,DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

-----------------------------------------------------------------------------------------
