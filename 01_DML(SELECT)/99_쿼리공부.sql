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