-- 1. 사수가 없고 부서배치도 받지 않은 사원들의 (사원명, 사수사번, 부서코드) 조회
SELECT EMP_NAME, MANAGER_ID, DEPT_CODE
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL AND DEPT_CODE IS NULL;

-- 2. 연봉(보너스미포함)이 3000만원 이상이고 보너스를 받지 않는 사원들의 (사번, 사원명, 급여, 보너스) 조회
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE SALARY * 12 >= 30000000 AND BONUS IS NULL;

-- 3. 입사일이 '95/01/01' 이상이고 부서배치를 받은 사원들의 (사번, 사원명, 입사일, 부서코드) 조회
SELECT EMP_ID, EMP_NAME, HIRE_DATE, DEPT_CODE
FROM EMPLOYEE
WHERE HIRE_DATE >= '95/01/01' AND DEPT_CODE IS NOT NULL;

-- 4. 급여가 200만원 이상 500만원 이하이고 입사일이 '01/01/01' 이상이고 보너스를 받지 않는 사원들의
-- (사번, 사원명, 급여, 입사일, 보너스) 조회
SELECT EMP_ID, EMP_NAME, SALARY, HIRE_DATE, BONUS
FROM EMPLOYEE
WHERE SALARY BETWEEN 2000000 AND 5000000 AND HIRE_DATE >= '01/01/01' AND BONUS IS NULL;

-- 5. 보너스포함연봉이 NULL이 아니고 이름에 '하'가 포함되어있는 사원들의 (사번, 사원명, 급여, 보너스포함연봉) 조회 (별칭부여)
SELECT EMP_ID, EMP_NAME, SALARY, ((SALARY + BONUS * SALARY) * 12) AS "보너스 포함 연봉"
FROM EMPLOYEE
WHERE ((SALARY + BONUS * SALARY) * 12) IS NOT NULL AND EMP_NAME LIKE '%하%' ;

--------------------------------------------------------------------------------
-- 보너스를 안 받지만 부서배치는 된 사원 조원
SELECT *
FROM EMPLOYEE
WHERE BONUS = NULL AND DEPT_CODE != NULL;

-- NULL 값을 비교할 때는 =을 쓰면 안됨
SELECT *
FROM EMPLOYEE
WHERE BONUS IS NULL AND DEPT_CODE IS NOT NULL;
--------------------------------------------------------------------------------
-- 검색하고자 하는 내용
-- JOB_CODE가 J7이거나 J6이면서 SALARY 값이 200만원 이상이고
-- BONUS가 있고 여자이며 이메일 주소는 _ 앞에 3글자만 있는 사원의
-- EMP_NAME, EMP_NO, JOB_CODE, DEPT_CODE, SALARY, BONUS 조회
-- 정상적으로 조회가 잘 된다면 실행 결과는 2행임

-- 위의 내용을 실행시키고자 작성한 SQL문은 아래와 같다.
SELECT EMP_NAME, EMP_NO, JOB_CODE, DEPT_CODE, SALARY, BONUS
FROM EMPLOYEE
WHERE JOB_CODE = 'J7' OR JOB_CODE = 'J6' AND SALARY > 2000000
AND EMAIL LIKE '___%' AND BONUS IS NULL;

-- 위의 SQL문 실행시 원하는 결과가 제대로 조회가 되지 않는다.
-- 이때 어떤 문제점들이 있는지 모두 찾아서 서술하시오.
-- 그리고 조치한 완벽한 SQL문을 작성해 볼 것

-- AND와 OR이 같이 기술되어 있으면 연산자 우선 순위에 따라 AND가 먼저 적용됨
-- > 연산자는 200만원 초과의 값이 구해진다
-- 보너스가 있는 사원은 NULL 값이 담겨있지 않다
-- 여자를 구하는 조건이 없음
-- 이메일 비교시 네번째 자리에 있는 _를 데이터 값으로 취급해 데이터의 값과 중복됨

SELECT EMP_NAME, EMP_NO, JOB_CODE, DEPT_CODE, SALARY, BONUS
FROM EMPLOYEE
WHERE (JOB_CODE = 'J7' OR JOB_CODE = 'J6') AND SALARY >= 2000000
AND EMAIL LIKE '___$_%' ESCAPE '$' AND BONUS IS NOT NULL
AND SUBSTR(EMP_NO, 8, 1) IN ('2', '4');
--------------------------------------------------------------------------------
-- ROWNUM을 활용해서 급여가 가장 높은 5명을 조회하고 싶었으나 제대로 조회가 안되었음
-- 이때 작성한 SQL문이 아래와 같음
SELECT ROWNUM, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE ROWNUM <= 5
ORDER BY SALARY DESC;

-- 어떤 문제점이 있는지, 해결된 SQL문 작성

-- 실행 순서상 SELECT 절이 먼저 실행되기 때문에 ROWNUM이 부여되고 정렬됨
SELECT ROWNUM, EMP_NAME, SALARY
FROM (SELECT *
        FROM EMPLOYEE
        ORDER BY SALARY DESC)
WHERE ROWNUM <= 5;
--------------------------------------------------------------------------------
-- 부서별 평균 급여가 270만원을 초과하는 부서들에 대해 부서코드, 부서별 총급여합, 부서별 평균 급여, 부사별 사원수
-- 이때 작성된 SQL문이 아래와 같음
SELECT DEPT_CODE, SUM(SALARY) 총합, FLOOR(AVG(SALARY)) 평균, COUNT(*) 인원수
FROM EMPLOYEE
WHERE SALARY > 2700000
GROUP BY DEPT_CODE
ORDER BY 1;

-- 어떤 문제점이 있는지, 해결된 SQL문 작성

-- GROUP BY 절을 사용할 때는 WHERE가 아니라 HAVING 절을 사용한다
SELECT DEPT_CODE, SUM(SALARY) 총합, FLOOR(AVG(SALARY)) 평균, COUNT(*) 인원수
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING AVG(SALARY) > 2700000
ORDER BY 1;
--------------------------------------------------------------------------------
-- 직원의 급여 조회시 각 직급별로 인상해서 조회
-- J7인 사원은 급여를 10% 인상 (SALARY * 1.1)
-- J6인 사원은 급여를 15% 인상 (SALARY * 1.15)
-- J4인 사원은 급여를 20% 인상 (SALARY * 1.2)
-- 그 외의 사원은 급여를 5% 인상 (LALART * 1.05)

SELECT EMP_NAME, JOB_CODE, SALARY,
        DECODE(JOB_CODE, 'J7', SALARY * 1.1,
                         'J6', SALARY * 1.15,
                         'J4', SALARY * 1.2,
                               SALARY * 1.05)
FROM EMPLOYEE;
--------------------------------------------------------------------------------
-- '21/09/28'와 같은 문자열을 가지고 '2021-09-28'로 표현해보기
SELECT TO_CHAR(TO_DATE('21/09/28'), 'YYYY-MM-DD')
FROM DUAL;

-- '210908'와 같은 문자열을 가지고 2021년 9월 8일 표현해보기
SELECT TO_CHAR(TO_DATE('210908'), 'YYYY"년" FMMM"월" DD"일"')
FROM DUAL;