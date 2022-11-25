-- 저장 먼저 하기
--------------------------------- QUIZ 1 -----------------------------
-- 보너스를 안 받지만 부서배치는 된 사원 조원
SELECT *
FROM EMPLOYEE
WHERE BONUS = NULL AND DEPT_CODE != NULL;
-- NULL 값에 대해 정상적으로 비교 처리 되지 않음

-- 문제점 : NULL 값을 비교할 때는 단순한 일반 비교연산자를 통해 비교할 수 없다
-- 해결방법 : IS NULL / IS NOT NULL 연산자를 이용해서 비교해야 한다

-- 조치한 SQL문
SELECT *
FROM EMPLOYEE
WHERE BONUS IS NULL AND DEPT_CODE IS NOT NULL;

--------------------------------- QUIZ 2 -----------------------------
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

-- 문제점 
-- 1. 연산자 우선순위에 따라서 AND 연산자가 먼저 수행됨
-- 2. 보너스가 없는 데이터만 나오고 있음
-- 3. 여자가 아닌 데이터가 나오고 있음
-- 4. 와일드카드 _가 데이터의 값과 중복되어 결과가 이상하게 나오고 있음
-- 5. 월급이 200만원이 안되는 데이터가 나오고 있음

-- 정답 쿼리
SELECT EMP_NAME, EMP_NO, JOB_CODE, DEPT_CODE, SALARY, BONUS
FROM EMPLOYEE
WHERE JOB_CODE IN ('J7', 'J6') AND SALARY >= 2000000
AND BONUS IS NOT NULL AND SUBSTR(EMP_NO, 8, 1) IN ('2', '4')
AND EMAIL LIKE '___$_%' ESCAPE '$';

SELECT EMP_NAME, EMP_NO, JOB_CODE, DEPT_CODE, SALARY, BONUS
FROM EMPLOYEE
WHERE (JOB_CODE = 'J7' OR JOB_CODE = 'J6') AND SALARY >= 2000000
AND EMAIL LIKE '___$_%' ESCAPE '$' AND BONUS IS NOT NULL
AND SUBSTR(EMP_NO, 8, 1) IN ('2', '4');


