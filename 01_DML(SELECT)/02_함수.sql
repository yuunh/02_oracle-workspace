SELECT SYSDATE
FROM DUAL;

SELECT LENGTH('오라클'), LENGTHB('오라클')
FROM DUAL;

SELECT LENGTH('oracle'), LENGTHB('oracle')
FROM DUAL;

SELECT EMP_NAME, LENGTH(EMP_NAME), LENGTHB(EMP_NAME)
FROM EMPLOYEE;

SELECT EMAIL, LENGTH(EMAIL), LENGTHB(EMAIL)
FROM EMPLOYEE;

SELECT INSTR('AABAACAABBAA', 'B')
FROM DUAL;

SELECT INSTR('AABAACAABBAA', 'B', 1)
FROM DUAL;

SELECT INSTR('AABAACAABBAA', 'B', -1)
FROM DUAL;

SELECT INSTR('AABAACAABBAA', 'B', 1, 2)
FROM DUAL;

SELECT INSTR('AABAACAABBAA', 'B', -1, 3)
FROM DUAL;

SELECT EMAIL, INSTR(EMAIL, '_', 1, 1) AS "_위치", INSTR(EMAIL, '@') AS "@위치"
FROM EMPLOYEE;

SELECT SUBSTR('MERRYCHRISTMAS', 6)
FROM DUAL;

SELECT SUBSTR('MERRYCHRISTMAS', 6, 6)
FROM DUAL;

SELECT SUBSTR('MERRYCHRISTMAS', 1, 5)
FROM DUAL;

SELECT SUBSTR('MERRYCHRISTMAS', -9, 5)
FROM DUAL;

SELECT EMP_NAME, EMP_NO, SUBSTR(EMP_NO, 8, 1) AS "성별"
FROM EMPLOYEE;

SELECT EMP_NAME, EMP_NO
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) IN ('2', '4');

SELECT EMP_NAME, EMP_NO
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) IN ('1', '3')
ORDER BY EMP_NO;

SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL, 1, INSTR(EMAIL, '@') - 1) AS "아이디"
FROM EMPLOYEE
ORDER BY "아이디";

SELECT EMP_NAME, LPAD(SUBSTR(EMAIL, 1, INSTR(EMAIL, '@') - 1), 10, '-') AS "아이디"
FROM EMPLOYEE
ORDER BY "아이디";