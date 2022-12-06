-- 먼저 저장
---------------------------------- QUIZ 1-------------------------------------
-- ROWNUM을 활용해서 급여가 가장 높은 5명을 조회하고 싶었으나 제대로 조회가 안되었음
-- 이때 작성한 SQL문이 아래와 같음
SELECT ROWNUM, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE ROWNUM <= 5
ORDER BY SALARY DESC;

-- 어떤 문제점이 있는지, 해결된 SQL문 작성
-- SELECT 절이 먼저 실행되기 때문에 ROWNUM이 부여되고 정렬이 됨
SELECT ROWNUM, E.*
FROM (SELECT EMP_NAME, SALARY
      FROM EMPLOYEE
      ORDER BY SALARY DESC) E
WHERE ROWNUM <= 5;

---------------------------------- QUIZ 2-------------------------------------
-- 부서별 평균 급여가 270만원을 초과하는 부서들에 대해 부서코드, 부서별 총급여합, 부서별 평균 급여, 부사별 사원수
-- 이때 작성된 SQL문이 아래와 같음
SELECT DEPT_CODE, SUM(SALARY) 총합, FLOOR(AVG(SALARY)) 평균, COUNT(*) 인원수
FROM EMPLOYEE
WHERE SALARY > 2700000
GROUP BY DEPT_CODE
ORDER BY 1;

-- 어떤 문제점이 있는지, 해결된 SQL문 작성
-- GROUP BY 절이 있으면 WHERE가 아니라 HAVING 절이 들어가야 한다
SELECT DEPT_CODE, SUM(SALARY) 총합, FLOOR(AVG(SALARY)) 평균, COUNT(*) 인원수
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING AVG(SALARY) > 2700000
ORDER BY 1;

--------------------------------------------------------------------------------
-- 서술형 대비
-- JOIN 종류 (내부조인, 외부조인, 등등....)별 특징, 역할
-- 함수 종류(TRIM, ....) 별 각각의 역할

-- 직원의 급여 조회시 각 직급별로 인상해서 조회
-- J7인 사원은 급여를 10% 인상 (SALARY * 1.1)
-- J6인 사원은 급여를 15% 인상 (SALARY * 1.15)
-- J4인 사원은 급여를 20% 인상 (SALARY * 1.2)
-- 그 외의 사원은 급여를 5% 인상 (LALART * 1.05)

SELECT EMP_NAME, JOB_CODE, SALARY,
DECODE(JOB_CODE, 'J7', SALARY * 1.1,
                 'J6', SALARY * 1.15,
                 'J5', SALARY * 1.2,
                 SALARY * 1.05) AS "인상된 급여"
FROM EMPLOYEE;

-- '21/09/28'와 같은 문자열을 가지고 '2021-09-28'로 표현해보기
-- TO_DATE('문자열', [포맷]) : DATE
-- TO_CHAR(날짜, [포맷]) : CHARACTER
SELECT TO_CHAR(TO_DATE('21/09/28'), 'YYYY-MM-DD')
FROM DUAL;

-- '210908'와 같은 문자열을 가지고 2021년 9월 8일 표현해보기
SELECT TO_CHAR(TO_DATE('210908'), 'YYYY"년" FMMM"월" DD"일"')
FROM DUAL;
-- FM !!



