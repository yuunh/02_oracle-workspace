/*
    < SELECT >
    데이터 조회할 때 사용되는 구문
    
    >> RESULT SET : SELECT문을 통해 조회된 결과물(즉, 조회된 행들의 집합을 의미)
    
    [표현법]
    SELECT 조회하고자 하는 컬럼1, 컬럼2, 컬럼3, .... 
    FROM 테이블명;
    
    * 반드시 존재하는 컬럼으로 써야한다!! 없는 컬럼 쓰면 오류남!!
*/

-- EMPLOYEE 테이블의 모든 컬럼 조회
-- SELECT EMP_ID, EMP_NAME, EMP_NO, ....
SELECT *
FROM EMPLOYEE;

-- EMPLOYEE 테이블의 사번, 이름, 급여 조회
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE;

-- JOB 테이블의 모든 컬럼 조회
SELECT *
FROM JOB;

-------------------- 실습문제 ------------------------------
-- 1. JOB 테이블의 직급명만 조회
SELECT JOB_NAME
FROM JOB;

-- 2. DEPARTMENT 테이블의 모든 컬럼 조회
SELECT *
FROM DEPARTMENT;

-- 3. DEPARTMENT 테이블의 부서코드, 부서명만 조회
SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT;

-- 4. EMPLOYEE 테이블의 사원명, 이메일, 전화번호, 입사일, 급여 조회
SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE, SALARY
FROM EMPLOYEE;

/*
    <컬럼값을 통한 산술연산>
    SELECT절 컬럼명 작성부분에 산술연산 기술 가능(이때, 산술연산된 결과 조회)
*/

-- EMPLOYEE 테이블의 사원명, 사원의 연봉(급여*12) 조회
SELECT EMP_NAME, SALARY * 12
FROM EMPLOYEE;

-- EMPLOYEE 테이블의 사원명, 급여, 보너스 조회
SELECT EMP_NAME, SALARY, BONUS
FROM EMPLOYEE;

-- EMPLOYEE 테이블의 사원명, 급여, 보너스, 연봉, 보너스 포함된 연봉((급여 + 보너스 * 급여)*12) 조회
SELECT EMP_NAME, SALARY, BONUS, SALARY * 12, ((SALARY + BONUS * SALARY) * 12)
FROM EMPLOYEE;
--> 산술연산 과정 중 NULL 값이 존재할 경우 산술연산한 결과값 무조건 NULL로 나옴

-- EMPLOYEE 테이블의 사원명, 입사일 조회
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE;

-- EMPLOYEE 테이블의 사원명, 입사일, 근무일수(오늘날짜 - 입사일) 조회
-- * 오늘날짜 : SYSDATE
SELECT EMP_NAME, HIRE_DATE, SYSDATE - HIRE_DATE
FROM EMPLOYEE;
-- DATE - DATE : 뺄 수 있음 => 결과값은 맞긴함(일 단위로)
-- 단, 값이 지저분한 이유는 DATE 형식은 년/월/일/시/분/초 단위로 시간 정보까지도 관리하기 때문!
-- 함수 적용하면 깔끔한 결과 확인 가능 => 나중에 배우자

-----------------------------------------------------------------------------------
/*
    < 컬럼명에 별칭 지정하기>
    산술연산을 하게 되면 컬럼명이 지저분함.. 이때 컬럼명에 별칭을 부여해서 깔끔하게 보여줌
    
    [표현법]
    컬럼명 별칭 / 컬럼명 AS 별칭 / 컬럼명 "별칭" / 컬럼명 AS "별칭"
    
    AS 붙이든 안붙이든 부여하고자 하는 별칭에 띄어쓰기 혹은 특수문자가 포함될 경우
    반드시!! 쌍따옴표("")로 기술해야됨
*/

SELECT EMP_NAME 사원명, SALARY AS 급여, SALARY * 12 "연봉(원)", ((SALARY + BONUS * SALARY) * 12) AS "보너스 포함 연봉"
FROM EMPLOYEE;

--------------------------------------------------------------------------------------------------------------------
/*
    <리터럴>
    임의로 지정한 문자열('')
    
    SELECT절에 리터럴을 제시하면 테이블상에 존재하는 데이터처럼 조회 가능
    조회된 RESULT SET의 모든 행에 반복적으로 같이 출력
*/

-- EMPLOYEE 테이블의 사번, 사원명, 급여 조회
SELECT EMP_ID, EMP_NAME, SALARY, '원' AS "단위"
FROM EMPLOYEE;

/*
    < 연결 연산자 : || >
    여러 컬럼값들을 하나의 컬럼인 것처럼 연결하거나, 컬럼값과 리터럴을 연결할 수 있음
    System.out.println("num의 값 : " + num);
*/

-- EMPLOYEE 테이블의 사번, 이름, 급여를 하나의 칼럼으로 조회
SELECT EMP_ID || EMP_NAME || SALARY
FROM EMPLOYEE;

-- 컬럼값과 리터럴 연결
-- XXX의 월급은 XXX원 입니다. => 별칭 : 급여정보
SELECT EMP_NAME || '의 월급은 ' || SALARY || '원 입니다.' AS "급여정보"
FROM EMPLOYEE;

--------------------------------------------------------------------
/*
    < DISTINCT >
    컬럼에 중복된 값들을 한 번씩만 표시하고자 할 때 사용(즉, 중복제거)
*/

-- 현재 우리 회사에 어떤 직급의 사람들이 존재하는지 궁금함

-- EMPLOYEE 테이블의 직급코드 조회
SELECT JOB_CODE
FROM EMPLOYEE; -- 23행

-- EMPLOYEE 테이블의 중복 제거된 직급코드 조회
SELECT DISTINCT JOB_CODE
FROM EMPLOYEE; -- 7행

-- 사원들이 어떤 부서에 속해있는지 궁금하다
SELECT DISTINCT DEPT_CODE
FROM EMPLOYEE; -- NULL : 아직 부서 배치 안된 사람

-- DISTINCT 유의사항 : DISTINCT는 SELECT절에 단 한번만 기술 가능!!
/* 구문 오류
SELECT DISTINCT JOB_CODE, DISTINCT EDPT_CODE
FROM EMPLOYEE;
*/
SELECT DISTINCT JOB_CODE, DEPT_CODE
FROM EMPLOYEE; -- 13행
-- JOB_CODE, DEPT_CODE 한 쌍으로 묶어서 중복 판별

-- =========================================================

/*
    < WHERE 절 >
    조회하고자 하는 테이블로부터 특정 조건에 만족하는 데이터만을 조회하고자 할 때 사용
    이때 WHERE 절에는 조건식을 제시하게 됨!
    조건식에서는 다양한 연산자들 사용가능!!
    
    [표현법] * 순서 변경 불가
    SELECT 컬럼1, 컬럼2, ....
    FROM 테이블명
    WHERE 조건식;
    
    [비교연산자]
    >, <, >=, <=    --> 대소비교
    =               --> 동등비교
    !=, ^=, <>      --> 동등하지 않은지 비교
*/

-- EMPLOYEE 테이블에서 부서코드가 'D9'인 사원들만 조회 (이때, 모든 컬럼 조회)
SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- EMPLOYEE 테이블에서 부서코드가 'D1'인 사원들의 사원명, 급여, 부서코드만 조회
SELECT EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';

-- EMPLOYEE 테이블에서 부서코드가 'D1'이 아닌 사원들의 사번, 사원명, 부서코드 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE
-- WHERE DEPT_CODE != 'D1';
-- WHERE DEPT_CODE ^= 'D1';
WHERE DEPT_CODE <> 'D1';

-- EMPLOYEE 테이블에서 급여가 400만원 이상인 사원들의 사원명, 부서코드, 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= 4000000;

-- EMPLOYEE에서 재직중(ENT_YN 컬럼값이 'N')인 사원들이 사번, 이름, 입사일 조회
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE ENT_YN = 'N';

---------------------- 실습문제 ----------------------------------------
-- 1. 급여가 300만원 이상인 사원들의 사원명, 급여, 입사일, 연봉(보너스미포함) 조회
SELECT EMP_NAME AS "사원명", SALARY AS "급여", HIRE_DATE "입사일", SALARY * 12 AS "연봉"
FROM EMPLOYEE
WHERE SALARY >= 3000000;

-- 2. 연봉이 500만원 이상인 사원들의 사원명, 급여, 연봉, 부서코드 조회
SELECT EMP_NAME AS "사원명", SALARY AS "급여", SALARY * 12 AS "연봉", DEPT_CODE AS "부서코드"
FROM EMPLOYEE
WHERE SALARY * 12 >= 5000000;
-- WHERE 연봉 >= 5000000; // 오류!! (WHERE 절에서는 SELECT 절에 작성된 별칭 사용 불가!!) => 쿼리 실행 순서 때문에
-- 쿼리 실행 순서
-- FROM절 => WHERE절 => SELECT절

-- 3. 직급코드가 'J3'이 아닌 사원들의 사번, 사원명, 직급코드, 퇴사여부 조회
SELECT EMP_ID AS "사원번호", EMP_NAME AS "사원명", JOB_CODE AS "직급코드", ENT_YN AS "퇴사여부"
FROM EMPLOYEE
WHERE JOB_CODE != 'J3';

-- 부서코드가 'D9'이면서 급여가 500만원 이상인 사원들의 사번, 사원명, 급여, 부서코드 조회
SELECT EMP_ID, EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9' AND SALARY >= 5000000;

-- 부서코드가 'D6'이거나 급여가 300만원 이상인 사원들의 사원명, 부서코드, 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6' OR SALARY >= 3000000;

-- 급여가 350만원 이상 600만원 이하를 받는 사원들의 사원명, 사번, 급여 조회
SELECT EMP_NAME, EMP_ID, SALARY
FROM EMPLOYEE
-- WHERE 3500000 <= SALARY <= 6000000; // 오류 발생!!
WHERE SALARY >= 3500000 AND SALARY <= 6000000;

--------------------------------------------------------------------
/*
    < BETWEEN A AND B >
    조건식에서 사용 되는 구문
    몇 이상 몇 이하인 범위에 대한 조건을 제시할 때 사용되는 연산자
    
    [표현법]
    비교대상컬럼 BETWEEN A(값1) AND B(값2)
    -> 해당 컬럼값이 A이상이고 B이하인 경우
*/

SELECT EMP_NAME, EMP_ID, SALARY
FROM EMPLOYEE
WHERE SALARY BETWEEN 3500000 AND 6000000;

-- 위의 쿼리 범위 밖의 사람을 조회하고 싶다면? (350만원 미만 + 600만원 초과인 사람)
SELECT EMP_NAME, EMP_ID, SALARY
FROM EMPLOYEE
-- WHERE SALARY < 3500000 OR SALARY > 6000000;
-- WHERE NOT SALARY BETWEEN 3500000 AND 6000000;
WHERE SALARY NOT BETWEEN 3500000 AND 6000000;
-- NOT : 논리부정연산자
-- 컬럼명 앞 또는 BETWEEN 앞에 기입 가능

-- 입사일이 '90/01/01' ~ '01/01/01' 모든 컬럼 조회
SELECT *
FROM EMPLOYEE
-- WHERE HIRE_DATE >= '90/01/01' AND HIRE_DATE <= '01/01/01';
WHERE HIRE_DATE BETWEEN '90/01/01' AND '01/01/01'; -- DATE 형식도 대소비교 가능!!

-----------------------------------------------------------------------------------
/*
    < LIKE >
    비교하고자 하는 컬럼값이 내가 제시한 특정 패턴에 만족될 경우 조회
    
    [표현법]
    비교대상컬럼 LIKE '특정패턴';
    
    - 특정 패턴 제시 시 '%', '_'를 와일드 카드로 사용할 수 있음
    >> '%' : 0글자 이상
    EX) 비교대상컬럼 LIKE '문자%'   => 비교대상의 컬럼값이 문자로 "시작"되는걸 조회
        비교대상컬럼 LIKE '%문자'   => 비교대상의 컬럼값이 문자로 "끝"나는걸 조회
        비교대상컬럼 LIKE '%문자%'  => 비교대상의 컬럼값에 문자가 "포함"되는 걸 조회 (키워드 검색)
   
    >> '_' : 1글자
    EX) 비교대상컬럼 LIKE '_문자'   => 비교대상의 컬럼값에 문자 앞에 무조건 한글자가 올 경우 조회
        비교대상컬럼 LIKE '문자_'   => 비교대상의 컬럼값에 문자 뒤에 무조건 한글자가 올 경우 조회
        비교대상컬럼 LIKE '_문자_'  => 비교대상의 컬럼값에 문자 앞뒤에 무조건 한글자가 올 경우 조회
*/

-- 사원들 중 성이 전씨인 사원들의 사원명, 급여, 입사일 조회
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '전%';

-- 이름 중에 '하'가 포함된 사원들의 사원명, 주민번호, 전화번호 조회
SELECT EMP_NAME, EMP_NO, PHONE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%하%';

-- 이름의 가운데 글자가 '하'인 사원들의 사원명, 전화번호 조회
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '_하_';

-- 전화번호의 3번재 자리가 1인 사원들의 사번, 사원명, 전화번호, 이메일 조회
SELECT EMP_ID, EMP_NAME, PHONE, EMAIL
FROM EMPLOYEE
WHERE PHONE LIKE '__1%';

-- ** 특이케이스
-- 이메일 중 _ 기준으로 앞글자가 3글자인 사원들의 사번, 이름, 이메일 조회
-- EX) sim_bs@kh.or.kr, sun_di@kh.or.kr
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
-- WHERE EMAIL LIKE '___%'; // 원했던 결과 도출 못함
-- 와일드 카드로 사용되고 있는 문자와 컬럼값에 담긴 문자가 동일하기 때문에 제대로 조회 안됨!!
--> 어떤게 와일드 카드고 어떤게 데이터 값인지 구분지어야함!!
--> 데이터 값으로 취급하고자 하는 값 앞에 나마의 와일드 카드를 제시하고
--> 나만의 와일드 카드를 ESCAPE OPTION으로 등록해야됨!!
WHERE EMAIL LIKE '___$_%' ESCAPE '$';


-- 위의 사원들이 아닌 그 외의 사원들을 조회해보자
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE NOT EMAIL LIKE '___$_%' ESCAPE '$';
-- NOT은 칼럼명 앞 또는 LIKE 앞에 기입 가능

---------------------- 실습문제 ----------------------------------
-- 1. EMPLOYEE 테이블에서 이름이 '연'으로 끝나는 사원들의 사원명, 입사일 조회
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%연';

-- 2. EMPLOYEE 테이블에서 이름에 '하'가 포함되어있고, 급여가 240만원 이상인 사원들의 사원명, 급여 조회
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%하%' AND SALARY >= 2400000;

-- 3. EMPLOYEE 테이블에서 전화번호 처음 3자리가 010이 아닌 사원들의 사원명, 전화번호 조회
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE PHONE NOT LIKE '010%';

-- 4. DEPARTMENT 테이블에서 해외영업부인 부서들의 부서코드, 부서명 조회
SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT
WHERE DEPT_TITLE LIKE '해외영업%';

--------------------------------------------------------------------------------------
/*
    < IS NULL / IS NOT NULL >
    컬럼값에 NULL이 있을 경우 NULL 값 비교에 사용되는 연산자
*/

-- 보너스를 받지 않는 사원(BONUS의 값이 NULL)들의 사번, 사원명, 급여, 보너스 조회
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
-- WHERE BONUS = NULL; // 오류남!
WHERE BONUS IS NULL;

-- 보너스를 받는 사원(BONUS의 값이 NULL이 아닌)들의 사번, 사원명, 급여, 보너스 조회
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
-- WHERE BONUS != NULL; // 오류남!
WHERE BONUS IS NOT NULL;
-- NOT은 컬럼명 앞 또는 IS 뒤에서 사용 가능하다

-- 부서배치를 아직 받지는 않지만 보너스는 받는 사원들의 사원명, 보너스, 부서코드 조회
SELECT EMP_NAME, BONUS, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;

------------------------------------------------------------------------
/*
    < IN >
    배교대상 컬럼값이 내가 제시한 목록 중에 일치하는 값이 있는지
    
    [표현법]
    비교대상컬럼 IN ('값1', '값2', ....)
*/

-- 부서코드가 'D6'이거나 'D8'이거나 'D5'인 부서원들의 이름, 부서코드, 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
-- WHERE DEPT_CODE = 'D6' OR DEPT_CODE = 'D8' OR DEPT_CODE = 'D5';
WHERE DEPT_CODE IN ('D6', 'D8', 'D5');

-- 그 외의 사원들
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE NOT IN ('D6', 'D8', 'D5');

-- ==================================================================
/*
    < 연산자 우선 순위 >
    0. ()
    1. 산술연산자
    2. 연결연산자
    3. 비교연산자
    4. IS NULL / LIKE / IN
    5. BTWEEN A AND B
    6. NOT(논리연산자)
    7. AND(논리연산자)
    8. OR(논리연산자)
*/

-- ** OR보다 AND가 먼저 연산이 됨!!
-- 직급코다가 'J7'이거나 'J2'인 사원들 중 급여가 200만원 이상인 사원들의 모든 컬럼 조회
SELECT *
FROM EMPLOYEE
WHERE (JOB_CODE = 'J7' OR JOB_CODE = 'J2') AND SALARY >= 2000000;

------------------------- 실습문제 ---------------------------------
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
