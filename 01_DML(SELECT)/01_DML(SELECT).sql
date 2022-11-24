/*
    < SELECT >
    ������ ��ȸ�� �� ���Ǵ� ����
    
    >> RESULT SET : SELECT���� ���� ��ȸ�� �����(��, ��ȸ�� ����� ������ �ǹ�)
    
    [ǥ����]
    SELECT ��ȸ�ϰ��� �ϴ� �÷�1, �÷�2, �÷�3, .... 
    FROM ���̺��;
    
    * �ݵ�� �����ϴ� �÷����� ����Ѵ�!! ���� �÷� ���� ������!!
*/

-- EMPLOYEE ���̺��� ��� �÷� ��ȸ
-- SELECT EMP_ID, EMP_NAME, EMP_NO, ....
SELECT *
FROM EMPLOYEE;

-- EMPLOYEE ���̺��� ���, �̸�, �޿� ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE;

-- JOB ���̺��� ��� �÷� ��ȸ
SELECT *
FROM JOB;

-------------------- �ǽ����� ------------------------------
-- 1. JOB ���̺��� ���޸� ��ȸ
SELECT JOB_NAME
FROM JOB;

-- 2. DEPARTMENT ���̺��� ��� �÷� ��ȸ
SELECT *
FROM DEPARTMENT;

-- 3. DEPARTMENT ���̺��� �μ��ڵ�, �μ��� ��ȸ
SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT;

-- 4. EMPLOYEE ���̺��� �����, �̸���, ��ȭ��ȣ, �Ի���, �޿� ��ȸ
SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE, SALARY
FROM EMPLOYEE;

/*
    <�÷����� ���� �������>
    SELECT�� �÷��� �ۼ��κп� ������� ��� ����(�̶�, �������� ��� ��ȸ)
*/

-- EMPLOYEE ���̺��� �����, ����� ����(�޿�*12) ��ȸ
SELECT EMP_NAME, SALARY * 12
FROM EMPLOYEE;

-- EMPLOYEE ���̺��� �����, �޿�, ���ʽ� ��ȸ
SELECT EMP_NAME, SALARY, BONUS
FROM EMPLOYEE;

-- EMPLOYEE ���̺��� �����, �޿�, ���ʽ�, ����, ���ʽ� ���Ե� ����((�޿� + ���ʽ� * �޿�)*12) ��ȸ
SELECT EMP_NAME, SALARY, BONUS, SALARY * 12, ((SALARY + BONUS * SALARY) * 12)
FROM EMPLOYEE;
--> ������� ���� �� NULL ���� ������ ��� ��������� ����� ������ NULL�� ����

-- EMPLOYEE ���̺��� �����, �Ի��� ��ȸ
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE;

-- EMPLOYEE ���̺��� �����, �Ի���, �ٹ��ϼ�(���ó�¥ - �Ի���) ��ȸ
-- * ���ó�¥ : SYSDATE
SELECT EMP_NAME, HIRE_DATE, SYSDATE - HIRE_DATE
FROM EMPLOYEE;
-- DATE - DATE : �� �� ���� => ������� �±���(�� ������)
-- ��, ���� �������� ������ DATE ������ ��/��/��/��/��/�� ������ �ð� ���������� �����ϱ� ����!
-- �Լ� �����ϸ� ����� ��� Ȯ�� ���� => ���߿� �����

-----------------------------------------------------------------------------------
/*
    < �÷��� ��Ī �����ϱ�>
    ��������� �ϰ� �Ǹ� �÷����� ��������.. �̶� �÷��� ��Ī�� �ο��ؼ� ����ϰ� ������
    
    [ǥ����]
    �÷��� ��Ī / �÷��� AS ��Ī / �÷��� "��Ī" / �÷��� AS "��Ī"
    
    AS ���̵� �Ⱥ��̵� �ο��ϰ��� �ϴ� ��Ī�� ���� Ȥ�� Ư�����ڰ� ���Ե� ���
    �ݵ��!! �ֵ���ǥ("")�� ����ؾߵ�
*/

SELECT EMP_NAME �����, SALARY AS �޿�, SALARY * 12 "����(��)", ((SALARY + BONUS * SALARY) * 12) AS "���ʽ� ���� ����"
FROM EMPLOYEE;

--------------------------------------------------------------------------------------------------------------------
/*
    <���ͷ�>
    ���Ƿ� ������ ���ڿ�('')
    
    SELECT���� ���ͷ��� �����ϸ� ���̺�� �����ϴ� ������ó�� ��ȸ ����
    ��ȸ�� RESULT SET�� ��� �࿡ �ݺ������� ���� ���
*/

-- EMPLOYEE ���̺��� ���, �����, �޿� ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY, '��' AS "����"
FROM EMPLOYEE;

/*
    < ���� ������ : || >
    ���� �÷������� �ϳ��� �÷��� ��ó�� �����ϰų�, �÷����� ���ͷ��� ������ �� ����
    System.out.println("num�� �� : " + num);
*/

-- EMPLOYEE ���̺��� ���, �̸�, �޿��� �ϳ��� Į������ ��ȸ
SELECT EMP_ID || EMP_NAME || SALARY
FROM EMPLOYEE;

-- �÷����� ���ͷ� ����
-- XXX�� ������ XXX�� �Դϴ�. => ��Ī : �޿�����
SELECT EMP_NAME || '�� ������ ' || SALARY || '�� �Դϴ�.' AS "�޿�����"
FROM EMPLOYEE;

--------------------------------------------------------------------
/*
    < DISTINCT >
    �÷��� �ߺ��� ������ �� ������ ǥ���ϰ��� �� �� ���(��, �ߺ�����)
*/

-- ���� �츮 ȸ�翡 � ������ ������� �����ϴ��� �ñ���

-- EMPLOYEE ���̺��� �����ڵ� ��ȸ
SELECT JOB_CODE
FROM EMPLOYEE; -- 23��

-- EMPLOYEE ���̺��� �ߺ� ���ŵ� �����ڵ� ��ȸ
SELECT DISTINCT JOB_CODE
FROM EMPLOYEE; -- 7��

-- ������� � �μ��� �����ִ��� �ñ��ϴ�
SELECT DISTINCT DEPT_CODE
FROM EMPLOYEE; -- NULL : ���� �μ� ��ġ �ȵ� ���

-- DISTINCT ���ǻ��� : DISTINCT�� SELECT���� �� �ѹ��� ��� ����!!
/* ���� ����
SELECT DISTINCT JOB_CODE, DISTINCT EDPT_CODE
FROM EMPLOYEE;
*/
SELECT DISTINCT JOB_CODE, DEPT_CODE
FROM EMPLOYEE; -- 13��
-- JOB_CODE, DEPT_CODE �� ������ ��� �ߺ� �Ǻ�

-- =========================================================

/*
    < WHERE �� >
    ��ȸ�ϰ��� �ϴ� ���̺�κ��� Ư�� ���ǿ� �����ϴ� �����͸��� ��ȸ�ϰ��� �� �� ���
    �̶� WHERE ������ ���ǽ��� �����ϰ� ��!
    ���ǽĿ����� �پ��� �����ڵ� ��밡��!!
    
    [ǥ����] * ���� ���� �Ұ�
    SELECT �÷�1, �÷�2, ....
    FROM ���̺��
    WHERE ���ǽ�;
    
    [�񱳿�����]
    >, <, >=, <=    --> ��Һ�
    =               --> �����
    !=, ^=, <>      --> �������� ������ ��
*/

-- EMPLOYEE ���̺��� �μ��ڵ尡 'D9'�� ����鸸 ��ȸ (�̶�, ��� �÷� ��ȸ)
SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- EMPLOYEE ���̺��� �μ��ڵ尡 'D1'�� ������� �����, �޿�, �μ��ڵ常 ��ȸ
SELECT EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';

-- EMPLOYEE ���̺��� �μ��ڵ尡 'D1'�� �ƴ� ������� ���, �����, �μ��ڵ� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE
-- WHERE DEPT_CODE != 'D1';
-- WHERE DEPT_CODE ^= 'D1';
WHERE DEPT_CODE <> 'D1';

-- EMPLOYEE ���̺��� �޿��� 400���� �̻��� ������� �����, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= 4000000;

-- EMPLOYEE���� ������(ENT_YN �÷����� 'N')�� ������� ���, �̸�, �Ի��� ��ȸ
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE ENT_YN = 'N';

---------------------- �ǽ����� ----------------------------------------
-- 1. �޿��� 300���� �̻��� ������� �����, �޿�, �Ի���, ����(���ʽ�������) ��ȸ
SELECT EMP_NAME AS "�����", SALARY AS "�޿�", HIRE_DATE "�Ի���", SALARY * 12 AS "����"
FROM EMPLOYEE
WHERE SALARY >= 3000000;

-- 2. ������ 500���� �̻��� ������� �����, �޿�, ����, �μ��ڵ� ��ȸ
SELECT EMP_NAME AS "�����", SALARY AS "�޿�", SALARY * 12 AS "����", DEPT_CODE AS "�μ��ڵ�"
FROM EMPLOYEE
WHERE SALARY * 12 >= 5000000;
-- WHERE ���� >= 5000000; // ����!! (WHERE �������� SELECT ���� �ۼ��� ��Ī ��� �Ұ�!!) => ���� ���� ���� ������
-- ���� ���� ����
-- FROM�� => WHERE�� => SELECT��

-- 3. �����ڵ尡 'J3'�� �ƴ� ������� ���, �����, �����ڵ�, ��翩�� ��ȸ
SELECT EMP_ID AS "�����ȣ", EMP_NAME AS "�����", JOB_CODE AS "�����ڵ�", ENT_YN AS "��翩��"
FROM EMPLOYEE
WHERE JOB_CODE != 'J3';

-- �μ��ڵ尡 'D9'�̸鼭 �޿��� 500���� �̻��� ������� ���, �����, �޿�, �μ��ڵ� ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9' AND SALARY >= 5000000;

-- �μ��ڵ尡 'D6'�̰ų� �޿��� 300���� �̻��� ������� �����, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6' OR SALARY >= 3000000;

-- �޿��� 350���� �̻� 600���� ���ϸ� �޴� ������� �����, ���, �޿� ��ȸ
SELECT EMP_NAME, EMP_ID, SALARY
FROM EMPLOYEE
-- WHERE 3500000 <= SALARY <= 6000000; // ���� �߻�!!
WHERE SALARY >= 3500000 AND SALARY <= 6000000;

--------------------------------------------------------------------
/*
    < BETWEEN A AND B >
    ���ǽĿ��� ��� �Ǵ� ����
    �� �̻� �� ������ ������ ���� ������ ������ �� ���Ǵ� ������
    
    [ǥ����]
    �񱳴���÷� BETWEEN A(��1) AND B(��2)
    -> �ش� �÷����� A�̻��̰� B������ ���
*/

SELECT EMP_NAME, EMP_ID, SALARY
FROM EMPLOYEE
WHERE SALARY BETWEEN 3500000 AND 6000000;

-- ���� ���� ���� ���� ����� ��ȸ�ϰ� �ʹٸ�? (350���� �̸� + 600���� �ʰ��� ���)
SELECT EMP_NAME, EMP_ID, SALARY
FROM EMPLOYEE
-- WHERE SALARY < 3500000 OR SALARY > 6000000;
-- WHERE NOT SALARY BETWEEN 3500000 AND 6000000;
WHERE SALARY NOT BETWEEN 3500000 AND 6000000;
-- NOT : ������������
-- �÷��� �� �Ǵ� BETWEEN �տ� ���� ����

-- �Ի����� '90/01/01' ~ '01/01/01' ��� �÷� ��ȸ
SELECT *
FROM EMPLOYEE
-- WHERE HIRE_DATE >= '90/01/01' AND HIRE_DATE <= '01/01/01';
WHERE HIRE_DATE BETWEEN '90/01/01' AND '01/01/01'; -- DATE ���ĵ� ��Һ� ����!!

-----------------------------------------------------------------------------------
/*
    < LIKE >
    ���ϰ��� �ϴ� �÷����� ���� ������ Ư�� ���Ͽ� ������ ��� ��ȸ
    
    [ǥ����]
    �񱳴���÷� LIKE 'Ư������';
    
    - Ư�� ���� ���� �� '%', '_'�� ���ϵ� ī��� ����� �� ����
    >> '%' : 0���� �̻�
    EX) �񱳴���÷� LIKE '����%'   => �񱳴���� �÷����� ���ڷ� "����"�Ǵ°� ��ȸ
        �񱳴���÷� LIKE '%����'   => �񱳴���� �÷����� ���ڷ� "��"���°� ��ȸ
        �񱳴���÷� LIKE '%����%'  => �񱳴���� �÷����� ���ڰ� "����"�Ǵ� �� ��ȸ (Ű���� �˻�)
   
    >> '_' : 1����
    EX) �񱳴���÷� LIKE '_����'   => �񱳴���� �÷����� ���� �տ� ������ �ѱ��ڰ� �� ��� ��ȸ
        �񱳴���÷� LIKE '����_'   => �񱳴���� �÷����� ���� �ڿ� ������ �ѱ��ڰ� �� ��� ��ȸ
        �񱳴���÷� LIKE '_����_'  => �񱳴���� �÷����� ���� �յڿ� ������ �ѱ��ڰ� �� ��� ��ȸ
*/

-- ����� �� ���� ������ ������� �����, �޿�, �Ի��� ��ȸ
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '��%';

-- �̸� �߿� '��'�� ���Ե� ������� �����, �ֹι�ȣ, ��ȭ��ȣ ��ȸ
SELECT EMP_NAME, EMP_NO, PHONE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��%';

-- �̸��� ��� ���ڰ� '��'�� ������� �����, ��ȭ��ȣ ��ȸ
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '_��_';

-- ��ȭ��ȣ�� 3���� �ڸ��� 1�� ������� ���, �����, ��ȭ��ȣ, �̸��� ��ȸ
SELECT EMP_ID, EMP_NAME, PHONE, EMAIL
FROM EMPLOYEE
WHERE PHONE LIKE '__1%';

-- ** Ư�����̽�
-- �̸��� �� _ �������� �ձ��ڰ� 3������ ������� ���, �̸�, �̸��� ��ȸ
-- EX) sim_bs@kh.or.kr, sun_di@kh.or.kr
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
-- WHERE EMAIL LIKE '___%'; // ���ߴ� ��� ���� ����
-- ���ϵ� ī��� ���ǰ� �ִ� ���ڿ� �÷����� ��� ���ڰ� �����ϱ� ������ ����� ��ȸ �ȵ�!!
--> ��� ���ϵ� ī��� ��� ������ ������ �����������!!
--> ������ ������ ����ϰ��� �ϴ� �� �տ� ������ ���ϵ� ī�带 �����ϰ�
--> ������ ���ϵ� ī�带 ESCAPE OPTION���� ����ؾߵ�!!
WHERE EMAIL LIKE '___$_%' ESCAPE '$';


-- ���� ������� �ƴ� �� ���� ������� ��ȸ�غ���
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE NOT EMAIL LIKE '___$_%' ESCAPE '$';
-- NOT�� Į���� �� �Ǵ� LIKE �տ� ���� ����

---------------------- �ǽ����� ----------------------------------
-- 1. EMPLOYEE ���̺��� �̸��� '��'���� ������ ������� �����, �Ի��� ��ȸ
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��';

-- 2. EMPLOYEE ���̺��� �̸��� '��'�� ���ԵǾ��ְ�, �޿��� 240���� �̻��� ������� �����, �޿� ��ȸ
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��%' AND SALARY >= 2400000;

-- 3. EMPLOYEE ���̺��� ��ȭ��ȣ ó�� 3�ڸ��� 010�� �ƴ� ������� �����, ��ȭ��ȣ ��ȸ
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE PHONE NOT LIKE '010%';

-- 4. DEPARTMENT ���̺��� �ؿܿ������� �μ����� �μ��ڵ�, �μ��� ��ȸ
SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT
WHERE DEPT_TITLE LIKE '�ؿܿ���%';

--------------------------------------------------------------------------------------
/*
    < IS NULL / IS NOT NULL >
    �÷����� NULL�� ���� ��� NULL �� �񱳿� ���Ǵ� ������
*/

-- ���ʽ��� ���� �ʴ� ���(BONUS�� ���� NULL)���� ���, �����, �޿�, ���ʽ� ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
-- WHERE BONUS = NULL; // ������!
WHERE BONUS IS NULL;

-- ���ʽ��� �޴� ���(BONUS�� ���� NULL�� �ƴ�)���� ���, �����, �޿�, ���ʽ� ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
-- WHERE BONUS != NULL; // ������!
WHERE BONUS IS NOT NULL;
-- NOT�� �÷��� �� �Ǵ� IS �ڿ��� ��� �����ϴ�

-- �μ���ġ�� ���� ������ ������ ���ʽ��� �޴� ������� �����, ���ʽ�, �μ��ڵ� ��ȸ
SELECT EMP_NAME, BONUS, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;

------------------------------------------------------------------------
/*
    < IN >
    �豳��� �÷����� ���� ������ ��� �߿� ��ġ�ϴ� ���� �ִ���
    
    [ǥ����]
    �񱳴���÷� IN ('��1', '��2', ....)
*/

-- �μ��ڵ尡 'D6'�̰ų� 'D8'�̰ų� 'D5'�� �μ������� �̸�, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
-- WHERE DEPT_CODE = 'D6' OR DEPT_CODE = 'D8' OR DEPT_CODE = 'D5';
WHERE DEPT_CODE IN ('D6', 'D8', 'D5');

-- �� ���� �����
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE NOT IN ('D6', 'D8', 'D5');

-- ==================================================================
/*
    < ������ �켱 ���� >
    0. ()
    1. ���������
    2. ���Ῥ����
    3. �񱳿�����
    4. IS NULL / LIKE / IN
    5. BTWEEN A AND B
    6. NOT(��������)
    7. AND(��������)
    8. OR(��������)
*/

-- ** OR���� AND�� ���� ������ ��!!
-- �����ڴٰ� 'J7'�̰ų� 'J2'�� ����� �� �޿��� 200���� �̻��� ������� ��� �÷� ��ȸ
SELECT *
FROM EMPLOYEE
WHERE (JOB_CODE = 'J7' OR JOB_CODE = 'J2') AND SALARY >= 2000000;

------------------------- �ǽ����� ---------------------------------
-- 1. ����� ���� �μ���ġ�� ���� ���� ������� (�����, ������, �μ��ڵ�) ��ȸ
SELECT EMP_NAME, MANAGER_ID, DEPT_CODE
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL AND DEPT_CODE IS NULL;

-- 2. ����(���ʽ�������)�� 3000���� �̻��̰� ���ʽ��� ���� �ʴ� ������� (���, �����, �޿�, ���ʽ�) ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE SALARY * 12 >= 30000000 AND BONUS IS NULL;

-- 3. �Ի����� '95/01/01' �̻��̰� �μ���ġ�� ���� ������� (���, �����, �Ի���, �μ��ڵ�) ��ȸ
SELECT EMP_ID, EMP_NAME, HIRE_DATE, DEPT_CODE
FROM EMPLOYEE
WHERE HIRE_DATE >= '95/01/01' AND DEPT_CODE IS NOT NULL;

-- 4. �޿��� 200���� �̻� 500���� �����̰� �Ի����� '01/01/01' �̻��̰� ���ʽ��� ���� �ʴ� �������
-- (���, �����, �޿�, �Ի���, ���ʽ�) ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY, HIRE_DATE, BONUS
FROM EMPLOYEE
WHERE SALARY BETWEEN 2000000 AND 5000000 AND HIRE_DATE >= '01/01/01' AND BONUS IS NULL;

-- 5. ���ʽ����Կ����� NULL�� �ƴϰ� �̸��� '��'�� ���ԵǾ��ִ� ������� (���, �����, �޿�, ���ʽ����Կ���) ��ȸ (��Ī�ο�)
SELECT EMP_ID, EMP_NAME, SALARY, ((SALARY + BONUS * SALARY) * 12) AS "���ʽ� ���� ����"
FROM EMPLOYEE
WHERE ((SALARY + BONUS * SALARY) * 12) IS NOT NULL AND EMP_NAME LIKE '%��%' ;
