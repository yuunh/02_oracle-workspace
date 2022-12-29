-- ���� ����

/*
    < �Լ� FUNCTION >
    ���޵� �÷����� �о�鿩�� �Լ��� ������ ����� ��ȯ��
    
    - ������ �Լ� : N���� ���� �о�鿩�� N���� ������� ����(�� �ึ�� �Լ� ���� ��� ��ȯ)
    - �׷� �Լ� : N���� ���� �о�鿩�� 1���� ������� ����(�׷��� ���� �׷캰�� �Լ� ���� ��� ��ȯ)
    
    >> SELECT ���� ������ �Լ��� �׷� �Լ� �Բ� ��� ����!!
        ��? ��� ���� ������ �ٸ��� ����!!!
        
    >> �Լ����� ����� �� �ִ� ��ġ : SELECT��, WHERE��, ORDER BY��, GROUP BY��, HAVING��
*/

/*
    < ���� ó�� �Լ� >
    
    * LENGTH / LENGTHB      => ����� NUMBER Ÿ��
    
    LENGTH(�÷�|'���ڿ��ǰ�') : �ش� ���ڿ� ���� ���ڼ� ��ȯ
    LENGTHB(�÷�|'���ڿ��ǰ�') : �ش� ���ڿ� ���� ����Ʈ�� ��ȯ
    
    '��', '��', '��' �ѱ��ڴ� 3BYTE ��ÿ� -> 9����Ʈ
    ������, ����, Ư�� �ѱ��ڴ� 1BYTE
*/

-- DUAL : ���� ���̺�! ���̺� ���� ���� �� ��
SELECT SYSDATE
FROM DUAL;

SELECT LENGTH('����Ŭ'), LENGTHB('����Ŭ')
FROM DUAL; 

SELECT LENGTH('oracle'), LENGTHB('oracle')
FROM DUAL;

SELECT EMP_NAME, LENGTH(EMP_NAME), LENGTHB(EMP_NAME), EMAIL, LENGTH(EMAIL), LENGTHB(EMAIL)
FROM EMPLOYEE; -- ���ึ�� ����ǰ� ���� => ������ �Լ�

/*
    * INSTR
    ���ڿ��κ��� Ư�� ������ ���� ��ġ�� ã�Ƽ� ��ȯ
    
    INSTR(�÷� | '���ڿ�', 'ã�����ϴ� ����', ['ã����ġ�� ���۰�', [����]]) => ������� NUMBER Ÿ��
    
    ã�� ��ġ�� ���۰�
    1 : �տ������� ã�ڴ�
    -1 : �ڿ������� ã�ڴ�
*/

SELECT INSTR('AABAACAABBAA', 'B') -- ã�� ��ġ�� ���۰��� 1�� �⺻�� => �տ������� ã��. ������ 1�� �⺻��
FROM DUAL; -- 3

SELECT INSTR('AABAACAABBAA', 'B', 1)
FROM DUAL;

SELECT INSTR('AABAACAABBAA', 'B', -1) -- �ڿ������� ã��
FROM DUAL; -- 10

SELECT INSTR('AABAACAABBAA', 'B', 1, 2) -- �տ������� �ι�° B�� ã��
FROM DUAL; -- 9

SELECT INSTR('AABAACAABBAA', 'B', -1, 3) -- �ڿ������� ����° B�� ã��
FROM DUAL; -- 3

SELECT EMAIL, INSTR(EMAIL, '_', 1, 1) AS "_��ġ", INSTR(EMAIL, '@') AS "@��ġ"
FROM EMPLOYEE;

-----------------------------------------------------------------------------------
/*
    * SUBSTR
    ���ڿ����� Ư�� ���ڿ��� �����ؼ� ��ȯ (�ڹٿ��� subString() �޼ҵ�� ����)
    
    SUBSTR(STRING, POSITION, [LENGTH])  => ������� CHARACTER Ÿ��
    - STRING : ����Ÿ���÷� �Ǵ� '���ڿ���'
    - POSITION : ���ڿ��� ������ ������ġ��
    - LENGTH : ������ ���� ���� (������ ������ �ǹ�)
*/

SELECT SUBSTR('SHOWMETHEMONEY', 7) -- 7��°���� ������ ����
FROM DUAL; -- THEMONEY

SELECT SUBSTR('SHOWMETHEMONEY', 5, 2) -- 5��°���� 2���� ����
FROM DUAL; -- ME

SELECT SUBSTR('SHOWMETHEMONEY', 1, 6)
FROM DUAL; -- SHOWME

SELECT SUBSTR('SHOWMETHEMONEY', -8, 3) -- �ڿ��� 8��°���� 3���� ����
FROM DUAL; --THE

SELECT EMP_NAME, EMP_NO, SUBSTR(EMP_NO, 8, 1) AS "����"
FROM EMPLOYEE;

-- ���� ����鸸 ��ȸ
SELECT EMP_NAME, EMP_NO
FROM EMPLOYEE
-- WHERE SUBSTR(EMP_NO, 8, 1) = '2' OR SUBSTR(EMP_NO, 8, 1) = '4';
WHERE SUBSTR(EMP_NO, 8, 1) IN ('2', '4');

-- ���� ����鸸 ��ȸ
SELECT EMP_NAME, EMP_NO
FROM EMPLOYEE
WHERE SUBSTR (EMP_NO, 8, 1) IN ('1', '3')
-- WHERE SUBSTR (EMP_NO, 8, 1) IN (1, 3); -- ���������� �ڵ� ����ȯ���༭ �����ϱ���
ORDER BY EMP_NAME; -- �⺻������ ��������

-- �Լ� ��ø ���
SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL, 1, INSTR(EMAIL, '@') - 1) AS "���̵�"
FROM EMPLOYEE;

-----------------------------------------------------------------------------------
/*
    * LPAD / RPAD
    ���ڿ��� ��ȸ�� �� ���ϰ� �ְ� ��ȸ�ϰ��� �� �� ���
    
    LRAD/RPAD(STRING, ���������� ��ȯ�� ������ ����, [�����̰��� �ϴ� ����])
    
    ���ڿ��� �����̰��� �ϴ� ���ڸ� ���� �Ǵ� �����ʿ� ���ٿ��� ���� N���̸�ŭ�� ���ڿ� ��ȯ
*/

-- 20��ŭ�� ���� �� EMAIL �÷����� ���������� �����ϰ� ������ �κ��� �������� ä����
SELECT EMP_NAME, LPAD(EMAIL, 20) -- �����̰��� �ϴ� ���� ������ �⺻���� ����
FROM EMPLOYEE;

SELECT EMP_NAME, LPAD(EMAIL, 20, '#')
FROM EMPLOYEE;

SELECT EMP_NAME, RPAD(EMAIL, 20, '#')
FROM EMPLOYEE;

-- 850101-2****** ������ ��ȸ => �� ���ڼ� : 14
SELECT RPAD('850101-2', 14, '*')
FROM DUAL;

SELECT EMP_NAME, RPAD(SUBSTR(EMP_NO, 1, 8), 14, '*')
FROM EMPLOYEE;

-----------------------------------------------------------------------------
/*
    * LTRIM / RTRIM
    ���ڿ����� Ư�� ���ڸ� ������ �������� ��ȯ
    
    LTRIM/RTRIM(STRING, ['������ ���ڵ�'])    => �����ϸ� ���� ����
    
    ���ڿ��� ���� Ȥ�� �����ʿ��� �����ϰ��� �ϴ� ���ڵ��� ã�Ƽ� ���� �� ���ڿ� ��ȯ
*/

SELECT LTRIM('    K H ') -- ���� ã�Ƽ� �����ϰ� ����ƴ� ���� ������ ����
FROM DUAL; -- 'K H '

SELECT LTRIM('123123KH123', '123')
FROM DUAL; -- 'KH123'

SELECT LTRIM('ACABACCKH', 'ABC')
FROM DUAL; -- 'KH'

SELECT RTRIM('5782KH123', '0123456789')
FROM DUAL; -- '5782KH'

SELECT EMP_NAME, LTRIM(PHONE, '010'), RTRIM(EMAIL, '@kh.or.kr')
FROM EMPLOYEE;
/*
    * TRIM
    ���ڿ��� �� / �� / ���ʿ� �ִ� ������ ���ڵ��� ������ ������ ���ڿ� ��ȯ
    TRIM([LEADING][�����ϰ��� �ϴ� ���ڵ� FROM] STRING)
*/

SELECT TRIM('   K H   ')
FROM DUAL; -- 'K H'

-- SELECT TRIM('ZZZKHZZZ', 'Z')
-- FROM DUAL; // ����
SELECT TRIM('Z' FROM 'ZZZKHZZZ')
FROM DUAL; -- 'KH'

SELECT TRIM(LEADING 'Z' FROM 'ZZZYHZZZ') -- LEADING : �� => LTIM�� ����
FROM DUAL; -- 'KHZZZ'

SELECT TRIM(TRAILING 'Z' FROM 'ZZZYHZZZ') -- TRAILING : �� => RTIM�� ����
FROM DUAL; -- 'ZZZKH'

SELECT TRIM(BOTH 'Z' FROM 'ZZZKHZZZ') -- TRAILING : ���� => ������ �⺻��
FROM DUAL; -- 'KH'

-----------------------------------------------------------------------------
/*
    * LOWER / UPPER / INITCAP
    
    LOWER/UPPER/INITCAP(STRING)     => �������
    
    LOWER : ���� �ҹ��ڷ� ������ ���ڿ� ��ȯ (�ڹٿ����� tOLowerCase() �޼ҵ�� ����)
    UPPER : ���� �빮�ڷ� ������ ���ڿ� ��ȯ (�ڹٿ����� toUpperCase() �޼ҵ�� ����)
    INITCAP : �ܾ� �ձ��ڸ��� �빮�ڷ� ������ ���ڿ� ��ȯ
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
    ���ڿ� �ΰ� ���޹޾Ƽ� �ϳ��� ��ģ �� ��� ��ȯ
    
    CONCAT(STRING, STRING)      => ����� CHARACTER Ÿ��
*/

SELECT CONCAT('ABC', '���ݷ�')
FROM DUAL;

SELECT 'ABC' || '���ݷ�'
FROM DUAL;

-- SELECT CONCAT('ABC', '���ݷ�', '�԰�ʹ�') -- �����߻� : ���ڿ� 2���� ���� �� ����
-- FROM DUAL;

SELECT 'ABC' || '���ݷ�' || '�԰�ʹ�'
FROM DUAL;

------------------------------------------------------------------------------
/*
    * REPLACE
    ���ڿ� ���޹޾� �����ؼ� ��ȯ
    
    REPLACE(STRING, STR1, STR2)     => ������� CHARACTER Ÿ��
*/

SELECT EMP_NAME, EMAIL, REPLACE(EMAIL, 'kh.or.kr', 'gmail.com')
FROM EMPLOYEE;

SELECT REPLACE('����� ������ ���ﵿ', '���ﵿ', '�Ｚ��')
FROM DUAL;
--------------------------------------------------------------------------------
/*
    < ���� ó�� �Լ� >
    
    * ABS
    ������ ���밪�� �����ִ� �Լ�
    
    ABS(NUMBER)     => ������� NUMBER Ÿ��
*/

SELECT ABS(-10)
FROM DUAL; -- 10

SELECT ABS(-5.7)
FROM DUAL; -- 5.7

--------------------------------------------------------------
/*
    * MOD
    �� ���� ���� ������ ���� ��ȯ���ִ� �Լ�
    
    MOD(NUMBER, NUMBER)     => ����� NUMBER Ÿ��
*/

SELECT MOD(10, 3)
FROM DUAL; -- 1

SELECT MOD(10.9, 3)
FROM DUAL; -- 1.9

--------------------------------------------------------
/*
    * ROUND
    �ݿø��� ����� ��ȯ���ִ� �Լ�
    
    ROUND(NUMBER, [��ġ])     => ������� NUMBER Ÿ��
    ��ġ ���� �� 0��° �ڸ����� �ݿø�
*/

SELECT ROUND(123.456) -- ��ġ ������ 0
FROM DUAL; -- 123

SELECT ROUND(123.456, 1)
FROM DUAL; -- 123.5

SELECT ROUND(123.456, 5) -- ��ġ���� ū �� �Է½� �״�� ����
FROM DUAL; -- 123.456

SELECT ROUND(123.456, -1)
FROM DUAL; -- 120

SELECT ROUND(123.456, -2)
FROM DUAL; -- 100

---------------------------------------------------------------
/*
    * CEIL
    �ø� ó�����ִ� �Լ�
    
    CEIL(NUMBER)
*/

SELECT CEIL(123.152) -- 5 �̻� �ƴϾ ������ �ø�! ��ġ ���� �Ұ�
FROM DUAL; -- 124

----------------------------------------------------------------
/*
    * FLOOR
    �Ҽ��� �Ʒ� ���� ó���ϴ� �Լ�
    
    FLOOR(NUMBER)
*/

SELECT FLOOR(123.152) -- ������ ����! ��ġ ���� �Ұ�
FROM DUAL; -- 123

SELECT FLOOR(123.952)
FROM DUAL; -- 123

-------------------------------------------------------------------
/*
    * TRUNC(�����ϴ�)
    ��ġ ���� ������ ���� ó�����ִ� �Լ�
    
    TRUNC(NUMBER, [��ġ])
*/

SELECT TRUNC(123.456) -- ��ġ ���� ���ϸ� FLOOR�̶� ������
FROM DUAL; -- 123

SELECT TRUNC(123.456, 1) -- �Ҽ��� �Ʒ� ù°�ڸ����� ǥ����
FROM DUAL; -- 123.4

SELECT TRUNC(123.456, -1) -- �ش� ��ġ �ڷ� ����
FROM DUAL; -- 120

----------------------------------------------------------------
/*
    < ��¥ ó�� �Լ� >
*/

-- * SYSDATE : �ý��� ��¥ �� �ð� ��ȯ (���� ��¥ �� �ð�)
SELECT SYSDATE -- Ŭ���ؼ� Ȯ���غ��� �ð��� Ȯ�� ����
FROM DUAL;

-- * MONTHS_BETWEEN(DATE1, DATE2) : �� ��¥ ������ ���� �� ��ȯ 
--          => ���������� DATE1 - DATE2 �� ������ 30, 31�� �����
-- => ����� : NUMBER Ÿ��

-- EMPLOYEE���� �����, �ٹ��ϼ�, �ٹ�������
SELECT EMP_NAME, FLOOR(SYSDATE - HIRE_DATE) || '��' AS "�ٹ��ϼ�",
CEIL(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) || '����' AS "�ٹ�������"
FROM EMPLOYEE;

-- * ADD_MONTHS(DATE, NUMBER) : Ư�� ��¥�� �ش� ���ڸ�ŭ�� �������� ���ؼ� ��¥�� ����
-- => ����� : DATE Ÿ��
SELECT ADD_MONTHS(SYSDATE, 6)
FROM DUAL;

-- EMPLOYEE���� �����, �Ի���, �Ի� �� 6������ �� ��¥
SELECT EMP_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE, 6) AS "������ ���� ��¥"
FROM EMPLOYEE;

-- * NEXT_DAY(DATR, ����(����|����)) : Ư�� ��¥ ���Ŀ� ����� �ش� ������ ��¥�� ��ȯ���ִ� �Լ�
-- => ����� : DATE Ÿ��
SELECT SYSDATE, NEXT_DAY(SYSDATE, '�ݿ���')
FROM DUAL;

SELECT SYSDATE, NEXT_DAY(SYSDATE, '��')
FROM DUAL;

-- 1. �Ͽ���, 2. ������, 3. ȭ����, 4. ������, 5. �����, 6. �ݿ���, 7. �����
SELECT SYSDATE, NEXT_DAY(SYSDATE, 6)
FROM DUAL;

SELECT SYSDATE, NEXT_DAY(SYSDATE, 'FRIDAY')
FROM DUAL;

-- ����Ŭ ȯ�� ���� ��� ����
SELECT *
FROM NLS_SESSION_PARAMETERS;

ALTER SESSION SET NLS_LANGUAGE = AMERICAN;
ALTER SESSION SET NLS_LANGUAGE = KOREAN;

-- * LAST_DAY(DATE) : �ش� ���� ������ ��¥�� ���ؼ� ��ȯ
-- => ����� : DATE Ÿ��
SELECT LAST_DAY(SYSDATE)
FROM DUAL;

-- EMPLOYEE���� �����, �Ի���, �Ի��� ���� ������ ��¥
SELECT EMP_NAME, HIRE_DATE, LAST_DAY(HIRE_DATE)
FROM EMPLOYEE;

-- EMPLOYEE���� �����, �Ի���, �Ի��� ���� ������ ��¥, �Ի��� �޿� �ٹ��� �ϼ�
SELECT EMP_NAME, HIRE_DATE, LAST_DAY(HIRE_DATE), LAST_DAY(HIRE_DATE) - HIRE_DATE
FROM EMPLOYEE;

/*
    * EXTRACT : Ư�� ��¥�κ��� �⵵1��1�� ���� �����ؼ� ��ȯ�ϴ� �Լ�
    
    EXTRACT(YEAR FROM DATE) : �⵵�� ����
    EXTRACT(MONTH FROM DATE) : ���� ����
    EXTRACT(DAY FROM DATE) : �ϸ� ����
*/
-- �����, �Ի�⵵, �Ի��, �Ի���
SELECT EMP_NAME, 
EXTRACT(YEAR FROM HIRE_DATE) || '��' AS "�Ի�⵵", 
EXTRACT(MONTH FROM HIRE_DATE) || '��' AS "�Ի��", 
EXTRACT(DAY FROM HIRE_DATE) || '��' AS "�Ի���"
FROM EMPLOYEE
ORDER BY "�Ի�⵵", "�Ի��", "�Ի���";

SELECT  
EXTRACT(YEAR FROM HIRE_DATE) || '��' AS "�Ի�⵵", 
EXTRACT(MONTH FROM HIRE_DATE) || '��' AS "�Ի��", 
EXTRACT(DAY FROM HIRE_DATE) || '��' AS "�Ի���"
FROM EMPLOYEE;
----------------------------------------------------------------------------------
/*
    < ����ȯ �Լ� >
    
    * TO_CHAR() : ���� Ÿ�� �Ǵ� ��¥ Ÿ���� ���� ���� Ÿ������ ��ȯ�����ִ� �Լ�
    
    TO_CHAR(����|��¥, [����])        => ������� CHARATER Ÿ��!
*/

-- ����Ÿ�� => ����Ÿ��
SELECT TO_CHAR(1234)
FROM DUAL; -- '1234'

SELECT TO_CHAR(1234, '99999') -- 5ĭ¥�� ���� Ȯ��, ������ ����, ��ĭ ����
FROM DUAL; -- ' 1234'

SELECT TO_CHAR(1234, '999999') -- 6ĭ¥�� ���� Ȯ��, ������ ����, ��ĭ ����
FROM DUAL; -- '  1234'

SELECT TO_CHAR(1234, '00000') -- 5ĭ¥�� ���� Ȯ��, ������ ����, ��ĭ 0���� ä��
FROM DUAL; -- '01234'

SELECT TO_CHAR(1234, 'L99999') -- ���� ������ ����(LOCAL)�� ȭ�����
FROM DUAL; -- '��1234'

SELECT TO_CHAR(1234, '$99999')
FROM DUAL; -- '$1234'

SELECT TO_CHAR(1234, 'L99,999')
FROM DUAL; -- '��1,234'

SELECT EMP_NAME, TO_CHAR(SALARY, 'L999,999,999')
FROM EMPLOYEE;

-- ��¥Ÿ�� => ����Ÿ��
SELECT SYSDATE -- ��¥Ÿ��
FROM DUAL;

SELECT TO_CHAR(SYSDATE) -- ����Ÿ��
FROM DUAL; -- Ŭ���غ��� �ٸ� �� �� �� ����, ��¥ Ÿ���� �ð��� ���´�

SELECT TO_CHAR(SYSDATE, 'HH:MI:SS') -- HH : 12�ð� ����
FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') -- HH : 24�ð� ����
FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'AM HH:MI:SS')
FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY DY') -- DAY : ������, DY : �� ����
FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'MON, YYYY')
FROM DUAL;

SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD DAY AM HH:MI:SS')
FROM DUAL;

SELECT EMP_NAME, HIRE_DATE, TO_CHAR(HIRE_DATE, 'YYYY-MM-DD'), TO_CHAR(HIRE_DATE, 'DAY')
FROM EMPLOYEE;

-- EX) 1990�� 02�� 06�� ��������
SELECT EMP_NAME, HIRE_DATE, TO_CHAR(HIRE_DATE, 'YYYY"��" MM"��" DD"��"')
FROM EMPLOYEE; -- ���� ���� ������ ���� ""�� �����ش�

-- �⵵�� ���õ� ����
SELECT TO_CHAR(SYSDATE, 'YYYY'), -- 2022
       TO_CHAR(SYSDATE, 'YY'), -- 22
       TO_CHAR(SYSDATE, 'RRRR'), -- 2022
       TO_CHAR(SYSDATE, 'RR'), -- 22
       TO_CHAR(SYSDATE, 'YEAR') -- TWENTY TWENTY-TWO
FROM DUAL;

-- ���� ���õ� ����
SELECT TO_CHAR(SYSDATE, 'MM'), -- 11 
       TO_CHAR(SYSDATE, 'MON'), -- 11��
       TO_CHAR(SYSDATE, 'MONTH'), -- 11��
       TO_CHAR(SYSDATE, 'RM') -- XI / ���� �θ� ���ڷ� ǥ��
FROM DUAL;

-- �Ͽ� ���õ� ����
SELECT TO_CHAR(SYSDATE, 'DDD'), -- 332 / ���� �������� ������ ��ĥ°����
       TO_CHAR(SYSDATE,  'DD'), -- 28 / �� �������� ������ ��ĥ°����
       TO_CHAR(SYSDATE, 'D') -- 2 / �� �������� ��ĥ°����
FROM DUAL;

-- ���Ͽ� ���õ� ����
SELECT  TO_CHAR(SYSDATE, 'DAY'), -- ������
        TO_CHAR(SYSDATE, 'DY') -- ��
FROM DUAL;

--------------------------------------------------------------------------------
/*
    * TO DATE : ���� Ÿ�� �Ǵ� ���� Ÿ�� �����͸� ��¥ Ÿ������ ��ȯ�����ִ� �Լ�
    
    TO_DATE(����|����), [����])   => ������� DATE Ÿ��
*/

SELECT TO_DATE(20100101)
FROM DUAL; -- 10/01/01

SELECT TO_DATE(100101)
FROM DUAL; -- 10/01/01

SELECT TO_DATE(070101) 
FROM DUAL; -- �����߻�

SELECT TO_DATE('070101') -- ù ���ڰ� 0�� ��� ����Ÿ������ �����������
FROM DUAL;

SELECT TO_DATE('041030 143000') 
FROM DUAL; -- �����߻�

SELECT TO_DATE('041030 143000', 'YYMMDD HH24MISS') -- �ð��� ǥ���ϰ� ���� ���� ������ �� �־�� ��
FROM DUAL;

SELECT TO_DATE('140630', 'YYMMDD') 
FROM DUAL; -- 2014��

SELECT TO_DATE('980630', 'YYMMDD') 
FROM DUAL; -- 2098�� => ������ ���� ����(21����)�� �ݿ�

SELECT TO_DATE('140630', 'RRMMDD') 
FROM DUAL; -- 2014��

SELECT TO_DATE('980630', 'RRMMDD') 
FROM DUAL; -- 1998��
-- RR : �ش� ���ڸ� �⵵ ���� 50 �̸��� ��� ���� ���� �ݿ�, 50 �̻��� ��� ���� ���� �ݿ�

--------------------------------------------------------------------------------
/*
    * TO_NUMBER : ���� Ÿ���� �����͸� ���� Ÿ������ ��ȭ�����ִ� �Լ�
    
    TO_NUMBER(����, [����])     => ������� NUMBER Ÿ��
*/

SELECT TO_NUMBER('05123475') -- 0�� ������ ���� Ÿ������ �����
FROM DUAL; -- 5123475

SELECT '1000000' + '55000' -- ����Ŭ������ �ڵ�����ȯ�� �� �Ǿ�����!
FROM DUAL; -- 1055000

SELECT '1,000,000' + '55,000' -- �ȿ� ���ڸ� �־�� �ڵ�����ȯ ��
FROM DUAL; -- ���� �߻�

SELECT TO_NUMBER('1,000,000', '9,999,999') + TO_NUMBER('55,000', '99,999')
FROM DUAL; -- 1055000 / ��������ȯ

------------------------------------------------------------------------------
/*
    < NULL ó�� �Լ� >
*/

-- NVL(�÷�, �ش� �÷����� NULL�� ��� ��ȯ�� ��)
SELECT EMP_NAME, NVL(BONUS, 0)
FROM EMPLOYEE;

-- ��ü ����� �̸�, ���ʽ� ���� ����(�޿� + �޿� * ���ʽ�) * 12
SELECT EMP_NAME, (SALARY + SALARY * BONUS) * 12, (SALARY + SALARY * NVL(BONUS, 0)) * 12
FROM EMPLOYEE;

SELECT EMP_NAME, NVL(DEPT_CODE, '�μ�����')
FROM EMPLOYEE;

-- NVL2(�÷�, ��ȯ��1, ��ȯ��2)
-- �÷����� ������ ��� ��ȯ��1 ��ȯ
-- �÷����� NULL�� ��� ��ȯ��2 ��ȯ

SELECT EMP_NAME, NVL2(DEPT_CODE, '�μ�����', '�μ�����')
FROM EMPLOYEE;

-- ���ʽ��� �ִ� : 0.7 / ���� : 0.1
SELECT EMP_NAME, NVL2(BONUS, 0.7, 0.1)
FROM EMPLOYEE;

-- NULLIF(�񱳴��1, �񱳴��2)
-- �� ���� ���� ��ġ�ϸ� NULL ��ȯ
-- �� ���� ���� ��ġ���� ������ �񱳴��1 ���� ��ȯ

SELECT NULLIF('123', '123')
FROM DUAL; -- NULL

SELECT NULLIF('123', '456')
FROM DUAL; -- 123

-----------------------------------------------------------------
/*
    < ���� �Լ� >
    * DECODE(���ϰ����ϴ� ���(�÷�|�������|�Լ���), �񱳰�1, �����1, �񱳰�2, �����2, ....)
    
    SWITCH(�񱳴��) {
    CASE �񱳰�1 : BREAK;
    CASE �񱳰�2 : BREAK;
    ....
    DEFAULT :
    }
*/

-- ���, �����, �ֹι�ȭ
SELECT
EMP_ID, EMP_NAME, EMP_NO, SUBSTR(EMP_NO, 8, 1),
DECODE(SUBSTR(EMP_NO, 8, 1), '1', '��', '2', '��') AS "����"
FROM EMPLOYEE;


SELECT EMP_NAME, EMP_NO, SUBSTR(EMP_NO, 8, 1),
DECODE(SUBSTR(EMP_NO, 8, 1), '1', '��', '2', '��') AS "����"
FROM EMPLOYEE;


-- ������ �޿� ��ȸ�� �� ���޺��� �λ��ؼ� ��ȸ
-- J7�� ����� �޿��� 10% �λ� (SALARY * 1.1)
-- J6�� ����� �޿��� 15% �λ� (SALARY * 1.15)
-- J4�� ����� �޿��� 20% �λ� (SALARY * 1.2)
-- �� ���� ����� �޿��� 5% �λ� (LALART * 1.05)

SELECT EMP_NAME, JOB_CODE, SALARY,
DECODE(JOB_CODE, 'J7', SALARY * 1.1,
                 'J6', SALARY * 1.15,
                 'J5', SALARY * 1.2,
                 SALARY * 1.05) AS "�λ�� �޿�"
FROM EMPLOYEE;

/*
    * CASE WHEN THEN
    
    CASE WHEN ���ǽ�1 THEN �����1
         WHEN ���ǽ�2 THEN �����1
         ....
         ELSE �����
    END
*/

SELECT EMP_NAME, SALARY,
    CASE WHEN SALARY >= 5000000 THEN '���'
         WHEN SALARY >= 3500000 THEN '�߱�'
         ELSE '�ʱ�'
    END AS "����"
FROM EMPLOYEE;

-------------------------------< �׷� �Լ� >------------------------------------
-- 1. SUM(����Ÿ���÷�) : �ش� �÷� ������ �� �հ踦 ���ؼ� ��ȯ���ִ� �Լ�

-- EMPLOYEE ���̺��� �� ����� �� �޿���
SELECT SUM(SALARY) || '��' AS "�� �޿���"
FROM EMPLOYEE; -- �� ������� �� �׷����� ����

-- ���� ������� �� �޿���
SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) IN ('1', '3'); -- ���� ������� �� �׷����� ����

-- �μ��ڵ尡 D5�� ������� �� ������
SELECT SUM(SALARY * 12)
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

-- 2. AVG(����Ÿ���÷�) : �ش� �÷����� ��հ��� ���ؼ� ��ȯ���ִ� �Լ�

-- ��ü ����� ��� �޿� ��ȸ
SELECT ROUND(AVG(SALARY)) || '��' AS "��� �޿�"
FROM EMPLOYEE;

SELECT ROUND(AVG(NVL(BONUS, 0)), 2)
FROM EMPLOYEE;

-- 3. MIN(����Ÿ���÷�) : �ش� �÷����� �߿� ���� ���� �� ���ؼ� ��ȯ���ִ� �Լ�

SELECT MIN(EMP_NAME), MIN(SALARY), MIN(HIRE_DATE)
FROM EMPLOYEE;

-- 4. MAX(����Ÿ���÷�) : �ش� �÷����� �߿� ���� ū �� ���ؼ� ��ȯ���ִ� �Լ�

SELECT MAX(EMP_NAME), MAX(SALARY), MAX(HIRE_DATE)
FROM EMPLOYEE;


SELECT MAX(SALARY), MIN(SALARY)
FROM EMPLOYEE;

SELECT MAX(HIRE_DATE), MIN(HIRE_DATE)
FROM EMPLOYEE;

-- 5. COUNT(*|�÷�|DISTINCT �÷�) : ��ȸ�� �� ������ ���� ��ȯ���ִ� �Լ�
--    COUNT(*) : ��ȸ�� ����� ��� �� ������ ���� ��ȯ
--    COUNT(�÷�) : ������ �ش� �÷����� NULL�� �ƴ� �͸� �� ���� ���� ��ȯ
--    COUNT(DISTINCT �÷�) :  �ش� �÷��� �ߺ��� ������ �� �� ���� ���� ��ȯ

-- ��ü ��� ��
SELECT COUNT(*)
FROM EMPLOYEE;

-- ���� ��� ��
SELECT COUNT(*)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) IN ('2', '4');

-- ���ʽ��� �޴� ��� ��
SELECT COUNT(BONUS) -- �÷����� NULL�� �ƴѰŸ� ī���� �Ѵ�
FROM EMPLOYEE;

-- �μ���ġ�� ���� ��� ��
SELECT COUNT(DEPT_CODE)
FROM EMPLOYEE;

SELECT COUNT(DISTINCT DEPT_CODE)
FROM EMPLOYEE;
