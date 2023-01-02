-- ���� ����

/*
    < GROUP BY �� >
    �׷� ������ ������ �� �ִ� ���� (�ش� �׷� ���غ��� ���� �׷��� ���� �� ����)
    ���� ���� ������ �ϳ��� �׷����� ��� ó���� �������� ���
*/

SELECT SUM(SALARY)
FROM EMPLOYEE; --> ��ü ����� �ϳ��� �׷����� ��� ������ ���� ���

-- �� �μ��� �� �޿���
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- �� �μ��� �����
SELECT DEPT_CODE, COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- ���� ����
SELECT DEPT_CODE, SUM(SALARY) --3
FROM EMPLOYEE -- 1
GROUP BY DEPT_CODE -- 2
ORDER BY DEPT_CODE; -- 4

SELECT JOB_CODE, SUM(SALARY), COUNT(*) AS "(��)"
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY JOB_CODE;

-- �� ���޺� �� �����, ���ʽ��� �޴� �����, �޿���, ��ձ޿�, �����޿�, �ִ�޿�
SELECT JOB_CODE, COUNT(*) || '��' AS "�� �����", COUNT(BONUS) || '��' AS "���ʽ��� �޴� �����", 
       SUM(SALARY) || '��' AS "�� �޿�", ROUND(AVG(SALARY)) || '��' AS "��� �޿�", 
       MIN(SALARY) || '��' AS "���� �޿�", MAX(SALARY) || '��' AS "�ִ� �޿�"
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY 1;

-- �μ���
SELECT DEPT_CODE, COUNT(*) || '��' AS "�� �����", COUNT(BONUS) || '��' AS "���ʽ��� �޴� �����", 
       SUM(SALARY) || '��' AS "�� �޿�", ROUND(AVG(SALARY)) || '��' AS "��� �޿�", 
       MIN(SALARY) || '��' AS "���� �޿�", MAX(SALARY) || '��' AS "�ִ� �޿�"
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY 1;

-- GROUP BY ���� �Լ��� ��� ����!!
SELECT DECODE(SUBSTR(EMP_NO, 8, 1), '1', '��', '2', '��') AS "����", COUNT(*)
FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO, 8, 1);

-- GROUP BY ���� ���� �÷� ��� ����!!
SELECT DEPT_CODE, JOB_CODE, COUNT(*), SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE
ORDER BY DEPT_CODE;

-------------------------------------------------------------------------------
/*
    < HAVING �� >
    �׷쿡 ���� ������ ������ �� ���Ǵ� ����(�ַ� �׷� �Լ����� ������ ������ ������)
*/

-- �� �μ��� ��� �޿� ��ȸ
SELECT DEPT_CODE, ROUND(AVG(SALARY)) AS "��ձ޿�"
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;

-- �μ��� ��� �޿��� 300���� �̻��� �μ��鸸 ��ȸ
SELECT DEPT_CODE, ROUND(AVG(SALARY)) AS "��ձ޿�"
FROM EMPLOYEE
WHERE ROUND(AVG(SALARY)) >= 3000000 -- �����߻�!! => GROUP BY �������� WHERE �� ��� �Ұ�
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;

SELECT DEPT_CODE, ROUND(AVG(SALARY)) AS "��ձ޿�" -- 4
FROM EMPLOYEE -- 1
GROUP BY DEPT_CODE -- 2
HAVING AVG(SALARY) >= 3000000 -- 3
ORDER BY DEPT_CODE; -- 5

-- ���޺� �� �޿��� (��, ���޺� �޿� ���� 1000���� �̻��� ���� ��ȸ)
SELECT JOB_CODE, SUM(SALARY) AS "�� �޿���"
FROM EMPLOYEE
GROUP BY JOB_CODE
HAVING SUM(SALARY) >= 10000000;

-- �μ��� ���ʽ��� �޴� ����� ���� �μ����� ��ȸ
SELECT DEPT_CODE
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING COUNT(BONUS) = 0;

----------------------------------------------------------------------------------
/*
    < SELECT �� ���� ���� >
    5. SELECT * | ��ȸ�ϰ��� �ϴ� �÷� ��Ī | ����� "��Ī" | �Լ��� AS "��Ī"
    1. FROM ��ȸ�ϰ��� �ϴ� ���̺��
    2. WHERE ���ǽ� (�ַ� �����ڸ� ������ ���)
    3. GROUP BY �׷� �������� ���� �÷� | �Լ���
    4. HAVING ���ǽ� (�׷� �Լ��� ������ ���)
    6. ORDER BY �÷��� | ��Ī | ���� | [ASC|DESC] [NULLS FIRST | NULLS LAST]
*/
-----------------------------------------------------------------------------
/*
    < ���� �Լ� >
    �׷캰 ����� ������� �߰� ���踦 ������ִ� �Լ�
    
    * ROLLUP
    
    => GROUP BY ���� ����ϴ� �Լ�
*/

-- �� ���޺� �޿���
-- ������ ������ ��ü �� �޿��ձ��� ���� ��ȸ�ϰ� ���� ��
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(JOB_CODE)
ORDER BY JOB_CODE;
-- ROLLUP : GROUP BY�� ���� ���� �׷��� �߰� ���踦 ������ִ� �Լ�

------------------------------------------------------------------------
/*
    < ���� ������ == SET OPERATION >
    
    ���� ���� �������� ������ �ϳ��� ���������� ����� ������
    
    - UNION     : ������ | OR (�� �������� ������ ������� ���� �� �ߺ��Ǵ� ���� �ѹ��� ����������)
    - INTERSECT : ������ | AND (�� �������� ������ ������� �ߺ��� �����)
    - UNION ALL : ������ + ������ (�ߺ��Ǵ� �κ��� �ι� ǥ���� �� ����)
    - MINUS     : ������ ( ���� ��������� ���� ������� �� ������)
*/

-- 1. UNION (������)
-- �μ��ڵ尡 D5�� ��� �Ǵ� �޿��� 300���� �ʰ��� ����� ��ȸ (���, �̸�, �μ��ڵ�, �޿�)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' -- 6���� (�ڳ���, ������, ���ؼ�, �ɺ���, ������, ���ȥ)
UNION -- �ߺ��Ǵ� 2���� ���ŵǰ� 12���� ���� 
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000; -- 8���� (������, ������, ���ö, �����, ������, *�ɺ���, *���ȥ, ������)

-- ���� ������ ������ ��� �Ʒ�ó�� WHERE ���� OR �ᵵ �ذ� ����!!
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' OR SALARY > 3000000; -- 12���� ����

-- 2. INTERSECT (������)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' -- 6���� (�ڳ���, ������, ���ؼ�, �ɺ���, ������, ���ȥ)
INTERSECT -- �ߺ��Ǵ� 2���� ���� ( �ɺ���, ���ȥ)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000; -- 8���� (������, ������, ���ö, �����, ������, *�ɺ���, *���ȥ, ������)

-- ���� ������ ������ ��� �Ʒ�ó�� WHERE ���� AND �ᵵ �ذ� ����!!
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' AND SALARY > 3000000;

------------------------------------------------------------------------------------------------
-- ���� ������ ���ǻ���
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY -- �÷� 4��
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' 
UNION 
SELECT EMP_ID, EMP_NAME, DEPT_CODE -- �÷� 3��
FROM EMPLOYEE
WHERE SALARY > 3000000; 
-- �� �������� SELECT ���� �ۼ��Ǿ� �ִ� �÷� ���� �����ؾߵ�!

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' 
UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE SALARY > 3000000; 
-- �� �������� SELECT ���� �ۼ��Ǿ� �ִ� �÷� Ÿ�� �����ؾߵ�!

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
-- ORDER BY EMP_NAME 
UNION 
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000 
ORDER BY EMP_NAME;
-- ORDER BY ���� ���̰��� �Ѵٸ� �������� ����ؾߵ�!!

----------------------------------------------------------------------------------------
-- 3. UNION ALL : ���� ���� ���� ����� ������ �� ���ϴ� ������ (�ߺ��� ����)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY -- 6����
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' 
UNION ALL -- �ߺ��� ���ͼ� 14�� ����
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY -- 8����
FROM EMPLOYEE
WHERE SALARY > 3000000;

-------------------------------------------------------------------------------
-- 4. MINUS : ���� SELECT ������� ���� SELECT ����� �� ������ (������)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' 
MINUS -- ���� ����� 6���� �߿� �ߺ��Ǵ� ���� ����� ������ 4�� ���� (�ڳ���, ������, ���ؼ�, ������)
SELECT EMP_ID, EMP_NAME,DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

-----------------------------------------------------------------------------------------
