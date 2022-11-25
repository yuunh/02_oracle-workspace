-- 먼저 저장

/*
    < 함수 FUNCTION >
    전달된 컬럼값을 읽어들여서 함수를 실행한 결과를 반환함
    
    - 단일행 함수 : N개의 값을 읽어들여서 N개의 결과값을 리턴(매 행마다 함수 실행 결과 반환)
    - 그룹 함수 : N개의 값을 읽어들여서 1개의 결과값을 리턴(그룹을 지어 그룹별로 함수 실행 결과 반환)
    
    >> SELECT 절에 단일행 함수랑 그룹 함수 함께 사용 못함!!
        왜? 결과 행의 개수가 다르기 때문!!!
        
    >> 함수식을 기술할 수 있는 위치 : SELECT절, WHERE절, ORDER BY절, GROUP BY절, HAVING절
*/

/*
    < 문자 처리 함수 >
    
    * LENGTH / LENGTHB      => 결과값 NUMBER 타입
    
    LENGTH(컬럼|'문자열의값') : 해당 문자열 값의 글자수 반환
    LENGTHB(컬럼|'문자열의값') : 해당 문자열 값의 바이트수 반환
    
    '김', '나', 'ㄱ' 한글자당 3BYTE 김시연 -> 9바이트
    영문자, 숫자, 특문 한글자당 1BYTE
*/

-- DUAL : 가상 테이블! 테이블 쓸거 없을 때 씀
SELECT SYSDATE
FROM DUAL;

SELECT LENGTH('오라클'), LENGTHB('오라클')
FROM DUAL; 

SELECT LENGTH('oracle'), LENGTHB('oracle')
FROM DUAL;

SELECT EMP_NAME, LENGTH(EMP_NAME), LENGTHB(EMP_NAME), EMAIL, LENGTH(EMAIL), LENGTHB(EMAIL)
FROM EMPLOYEE; -- 매행마다 실행되고 있음 => 단일행 함수

/*
    * INSTR
    문자열로부터 특정 문자의 시작 위치를 찾아서 반환
    
    INSTR(컬럼 | '문자열', '찾고자하는 문자', ['찾을위치의 시작값', [순번]]) => 결과값은 NUMBER 타입
    
    찾을 위치의 시작값
    1 : 앞에서부터 찾겠다
    -1 : 뒤에서부터 찾겠다
*/

SELECT INSTR('AABAACAABBAA', 'B') -- 찾을 위치의 시작값은 1이 기본값 => 앞에서부터 찾음. 순번도 1이 기본값
FROM DUAL; -- 3

SELECT INSTR('AABAACAABBAA', 'B', 1)
FROM DUAL;

SELECT INSTR('AABAACAABBAA', 'B', -1) -- 뒤에서부터 찾음
FROM DUAL; -- 10

SELECT INSTR('AABAACAABBAA', 'B', 1, 2) -- 앞에서부터 두번째 B를 찾음
FROM DUAL; -- 9

SELECT INSTR('AABAACAABBAA', 'B', -1, 3) -- 뒤에서부터 세번째 B를 찾음
FROM DUAL; -- 3

SELECT EMAIL, INSTR(EMAIL, '_', 1, 1) AS "_위치", INSTR(EMAIL, '@') AS "@위치"
FROM EMPLOYEE;

-----------------------------------------------------------------------------------
/*
    * SUBSTR
    문자열에서 특정 문자열을 추출해서 반환 (자바에서 subString() 메소드와 유사)
    
    SUBSTR(STRING, POSITION, [LENGTH])  => 결과값이 CHARACTER 타입
    - STRING : 문자타입컬럼 또는 '문자열값'
    - POSITION : 문자열을 추출할 시작위치값
    - LENGTH : 추출할 문자 개수 (생략시 끝까지 의미)
*/

SELECT SUBSTR('SHOWMETHEMONEY', 7) -- 7번째부터 끝까지 추출
FROM DUAL; -- THEMONEY

SELECT SUBSTR('SHOWMETHEMONEY', 5, 2) -- 5번째부터 2글자 추출
FROM DUAL; -- ME

SELECT SUBSTR('SHOWMETHEMONEY', 1, 6)
FROM DUAL; -- SHOWME

SELECT SUBSTR('SHOWMETHEMONEY', -8, 3) -- 뒤에서 8번째부터 3글자 추출
FROM DUAL; --THE

SELECT EMP_NAME, EMP_NO, SUBSTR(EMP_NO, 8, 1) AS "성별"
FROM EMPLOYEE;

-- 여자 사원들만 조회
SELECT EMP_NAME, EMP_NO
FROM EMPLOYEE
-- WHERE SUBSTR(EMP_NO, 8, 1) = '2' OR SUBSTR(EMP_NO, 8, 1) = '4';
WHERE SUBSTR(EMP_NO, 8, 1) IN ('2', '4');

-- 남자 사원들만 조회
SELECT EMP_NAME, EMP_NO
FROM EMPLOYEE
WHERE SUBSTR (EMP_NO, 8, 1) IN ('1', '3')
-- WHERE SUBSTR (EMP_NO, 8, 1) IN (1, 3); -- 내부적으로 자동 형변환해줘서 가능하긴함
ORDER BY EMP_NAME; -- 기본적으로 오름차순

-- 함수 중첩 사용
SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL, 1, INSTR(EMAIL, '@') - 1) AS "아이디"
FROM EMPLOYEE;

-----------------------------------------------------------------------------------
/*
    * LPAD / RPAD
    문자열을 조회할 때 통일감 있게 조회하고자 할 때 사용
    
    LRAD/RPAD(STRING, 최종적으로 반환할 문자의 길이, [덧붙이고자 하는 문자])
    
    문자열에 덧붙이고자 하는 문자를 왼쪽 또는 오른쪽에 덧붙여서 최종 N길이만큼의 문자열 반환
*/

-- 20만큼의 길이 중 EMAIL 컬럼값은 오른쪽으로 정렬하고 나머지 부분은 공백으로 채워짐
SELECT EMP_NAME, LPAD(EMAIL, 20) -- 덧붙이고자 하는 문자 생략시 기본값이 공백
FROM EMPLOYEE;

SELECT EMP_NAME, LPAD(EMAIL, 20, '#')
FROM EMPLOYEE;

SELECT EMP_NAME, RPAD(EMAIL, 20, '#')
FROM EMPLOYEE;

-- 850101-2****** 나오게 조회 => 총 글자수 : 14
SELECT RPAD('850101-2', 14, '*')
FROM DUAL;

SELECT EMP_NAME, RPAD(SUBSTR(EMP_NO, 1, 8), 14, '*')
FROM EMPLOYEE;

-----------------------------------------------------------------------------
/*
    * LTRIM / RTRIM
    문자열에서 특정 문자를 제거한 나머지를 반환
    
    LTRIM/RTRIM(STRING, ['제거할 문자들'])    => 생략하면 공백 제거
    
    문자열의 왼쪽 혹은 오른쪽에서 제거하고자 하는 문자들을 찾아서 제거 후 문자열 반환
*/

SELECT LTRIM('    K H ') -- 공백 찾아서 제거하고 공백아닌 문자 나오면 끝남
FROM DUAL; -- 'K H '

SELECT LTRIM('123123KH123', '123')
FROM DUAL; -- 'KH123'

SELECT LTRIM('ACABACCKH', 'ABC')
FROM DUAL; -- 'KH'

SELECT RTRIM('5782KH123', '0123456789')
FROM DUAL; -- '5782KH'

/*
    * TRIM
    문자열의 앞 / 뒤 / 양쪽에 있는 지정한 문자들을 제거한 나머지 문자열 반환
    TRIM([LEADING][제거하고자 하는 문자들 FROM] STRING)
*/

SELECT TRIM('   K H   ')
FROM DUAL; -- 'K H'

-- SELECT TRIM('ZZZKHZZZ', 'Z')
-- FROM DUAL; // 오류
SELECT TRIM('Z' FROM 'ZZZKHZZZ')
FROM DUAL; -- 'KH'

SELECT TRIM(LEADING 'Z' FROM 'ZZZKHZZZ') -- LEADING : 앞 => LTIM과 유사
FROM DUAL; -- 'KHZZZ'

SELECT TRIM(TRAILING 'Z' FROM 'ZZZKHZZZ') -- TRAILING : 뒤 => RTIM과 유사
FROM DUAL; -- 'ZZZKH'

SELECT TRIM(BOTH 'Z' FROM 'ZZZKHZZZ') -- TRAILING : 양쪽 => 생략시 기본값
FROM DUAL; -- 'KH'

-----------------------------------------------------------------------------
/*
    * LOWER / UPPER / INITCAP
    
    LOWER/UPPER/INITCAP(STRING)     => 결과값은
    
    LOWER : 전부 소문자로 변경한 문자열 반환 (자바에서의 tOLowerCase() 메소드와 유사)
    UPPER : 전부 대문자로 변경한 문자열 반환 (자바에서의 toUpperCase() 메소드와 유사)
    INITCAP : 단어 앞글자마다 대문자로 변경한 문자열 반환
*/

SELECT LOWER('Welcome To My World!')
FROM DUAL;

SELECT UPPER('Welcome To My World!')
FROM DUAL;

SELECT INITCAP('welcome to my world!')
FROM DUAL;

------------------------------------------------------------------------------
/*
    * CONCAT
    문자열 두개 전달받아서 하나로 합친 후 결과 반환
    
    CONCAT(STRING, STRING)      => 결과값 CHARACTER 타입
*/

SELECT CONCAT('ABC', '초콜렛')
FROM DUAL;

SELECT 'ABC' || '초콜렛'
FROM DUAL;

-- SELECT CONCAT('ABC', '초콜렛', '먹고싶다') -- 오류발생 : 문자열 2개만 받을 수 있음
-- FROM DUAL;

SELECT 'ABC' || '초콜렛' || '먹고싶다'
FROM DUAL;

------------------------------------------------------------------------------
/*
    * REPLACE
    문자열 전달받아 변경해서 반환
    
    REPLACE(STRING, STR1, STR2)     => 결과값은 CHARACTER 타입
*/

SELECT EMP_NAME, EMAIL, REPLACE(EMAIL, 'kh.or.kr', 'gmail.com')
FROM EMPLOYEE;

--------------------------------------------------------------------------------
/*
    < 숫자 처리 함수 >
    
    * ABS
    숫자의 절대값을 구해주는 함수
    
    ABS(NUMBER)     => 결과값은 NUMBER 타입
*/

SELECT ABS(-10)
FROM DUAL; -- 10

SELECT ABS(-5.7)
FROM DUAL; -- 5.7

--------------------------------------------------------------
/*
    * MOD
    두 수를 나눈 나머지 값을 반환해주는 함수
    
    MOD(NUMBER, NUMBER)     => 결과값 NUMBER 타입
*/

SELECT MOD(10, 3)
FROM DUAL; -- 1

SELECT MOD(10.9, 3)
FROM DUAL; -- 1.9

--------------------------------------------------------

/*
    * ROUND
    반올림한 결과를 반환해주는 함수
    
    ROUND(NUMBER, [위치])     => 결과값은 NUMBER 타입
    위치 생략 시 0번째 자리에서 반올림
*/

SELECT ROUND(123.456)
FROM DUAL; -- 123

SELECT ROUND(123.456, 1)
FROM DUAL; -- 123.5