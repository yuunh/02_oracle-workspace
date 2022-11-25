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

SELECT TRIM(LEADING 'Z' FROM 'ZZZKHZZZ') -- LEADING : �� => LTIM�� ����
FROM DUAL; -- 'KHZZZ'

SELECT TRIM(TRAILING 'Z' FROM 'ZZZKHZZZ') -- TRAILING : �� => RTIM�� ����
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

SELECT ROUND(123.456)
FROM DUAL; -- 123

SELECT ROUND(123.456, 1)
FROM DUAL; -- 123.5