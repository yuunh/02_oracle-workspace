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
-- 1. OR 연산자와 AND 연산자가 나열되어 있을 경우
--    연산자 우선순위에 따라서 AND 연산자가 먼저 수행됨
-- 2. IS NULL을 사용해서 보너스가 없는 데이터만 나오고 있음 -> IS NOT NULL 사용해야됨
-- 3. 여자를 뽑는 조건이 누락되어 있어 여자가 아닌 데이터가 나오고 있음
-- 4. 이메일에 대한 비교시 네번째 자리에 있는 _를 데이터 값으로 취급해 
--    데이터의 값과 중복되어 결과가 이상하게 나오고 있음 
--    -> 새 와일드 카드를 제시하고 ESCAPE로 등록해야됨
-- 5. > 로 월급이 200만원이 안되는 데이터가 나오고 있어 >= 로 비교해야됨

-- 정답 쿼리
SELECT EMP_NAME, EMP_NO, JOB_CODE, DEPT_CODE, SALARY, BONUS
FROM EMPLOYEE
WHERE (JOB_CODE = 'J7' OR JOB_CODE = 'J6') AND SALARY >= 2000000
AND EMAIL LIKE '___$_%' ESCAPE '$' AND BONUS IS NOT NULL 
AND SUBSTR(EMP_NO, 8, 1)IN ('2', '4');

--------------------------------- QUIZ 3 -----------------------------
-- [계정생성수문] CREATE USER 계정명 IDENTIFIED BY 비밀번호

-- 계정명 : SCOTT, 비밀번호 : TIGER 계정을 생성하고 싶다
-- 이때 일반사용자 계정인 KH 계정에 접속해서 CREATE USE SCOTT;실행하니 문제 발생

-- 문제점1. 사용자 계정 생성은 무조건 관리자 계정에서만 가능하다
-- 문제점2. SQL문이 잘못되어있음 비번까지 입력해야된다

-- 조치내용1. 관리자 계정에 접속해야됨
-- 조치내용2. CREATE USER SCOTT IDENTIFIED BY TIGER;

-- 위의 SQL(CREATE)만 실행 후 접속을 만들어서 접속을 하려고 했더니 실패..
-- 뿐만 아니라 해당 계정에 테이블 생성 같은 것도 되지 않음.. 왜 그럴까?

-- 문제점1. 사용자 계정 생성 후 최소한의 권한 부여가 안됐다
-- 조치내용. GRANT CONNECT, RESOURCE TO SCOTT;









