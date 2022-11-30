-- ���� ����

/*
    < JOIN >
    �� �� �̻��� ���̺��� �����͸� ��ȸ�ϰ��� �� �� ���Ǵ� ����
    ��ȸ ����� �ϳ��� �����(RESULT SET)�� ����
    
    ������ ������ ���̽��� �ּ����� �����ͷ� ������ ���̺� �����͸� ��� ����
    
    -- � ����� � �μ��� �����ִ��� �ñ���! �ڵ帻��.. �̸�����
    
    => ������ ������ ���̽����� SQL���� �̿��� ���̺��� "����"�� �δ� ���
    (������ �� ��ȸ�� �ؿ��°� �ƴ϶� �� ���̺� ���� ���ν��� �����͸� ��Ī�ؼ� ��ȸ�ؾߵ�)
    
    JOIN�� ũ�� "����Ŭ ���뱸��"�� "ANSI ����" (ANSI == �̱�����ǥ����ȸ => �ƽ�Ű�ڵ�ǥ ����� ��)
*/

SELECT EMP_NAME, DEPT_CODE
FROM EMPLOYEE; -- DEPT_CODE

SELECT *
FROM DEPARTMENT; -- DEPT_ID

-- ��ü ������� ���, �����, �μ��ڵ�, �μ��� ��ȸ�ϰ��� �� ��
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE;

SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT;

-- ��ü ������� ���, �����, �����ڵ�, ���޸� ��ȸ�ϰ��� �� ��
SELECT EMP_ID, EMP_NAME, JOB_CODE
FROM EMPLOYEE; -- JOB_CODE

SELECT *
FROM JOB; -- JOB_CODE

/*
    1. �����(EQUAL JOIN) / ��������(INNER JOIN)
    �����Ű�� �÷��� ���� ��ġ�ϴ� ��鸸 ���εż� ��ȸ (== ��ġ�ϴ� ���� ���� ���� ��ȸ���� ����)
*/

-- >> ����Ŭ ���� ����
-- FROM ���� ��ȸ�ϰ��� �ϴ� ���̺�� �ϴ� ���� (, �����ڷ�)
-- WHERE ���� ��Ī��ų �÷�(�����)�� ���� ������ ������

-- 1) ������ �� �÷����� �ٸ� ��� (EMP : DEPT_CODE, DEP : DEPT_ID)
-- ���, �����, �μ��ڵ�, �μ����� ���� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_ID, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID;
--> ��ġ�ϴ� ���� ���� ���� ��ȸ���� ���ܵȰ� Ȯ�� ����
-- DEPT_CODE�� NULL�� ��� ��ȸX, DEPT_ID D3, D4, D7 ��ȸ X

-- 2) ������ �� �÷����� ���� ��� (EMP : JOB_CODE, JOB : JOB_CODE)
-- ���, �����, �����ڵ�, ���޸�
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE, JOB
WHERE JOB_CODE = JOB_CODE; -- ������!!
-- ambiguously : �ָ��ϴ�, ��ȣ�ϴ� => �÷��� � ���̺��� �÷����� �𸣰ڴ�

-- �ذ��� 1. ���̺���� �̿��ϴ� ���
SELECT EMP_ID, EMP_NAME, JOB.JOB_CODE, JOB_NAME
FROM EMPLOYEE, JOB
WHERE EMPLOYEE.JOB_CODE = JOB.JOB_CODE;

-- �ذ��� 2. ���̺� ��Ī�� �ο��ؼ� �̿��ϴ� ���
SELECT EMP_ID, EMP_NAME, J.JOB_CODE, JOB_NAME
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE;

-->> ANSI ����
-- FROM ���� ������ �Ǵ� ���̺��� �ϳ��� ��� �� ��
-- JOIN ���� ���� ��ȸ�ϰ��� �ϴ� ���̺� ��� + ��Ī��ų �÷��� ���� ���ǵ� ���� ���
-- JOIN USING, JOIN ON

-- 1) ������ �� �÷����� �ٸ� ��� (EMP : DEPT_CODE, DEP : DEPT_ID)
-- ������ JOIN ON �������θ� ����!!
-- ���, �����, �μ��ڵ�, �μ���
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

-- 2) ������ �� �÷����� ���� ��� (EMP : JOB_CODE, JOB : JOB_CODE)
-- JOIN ON, JOIN USING ���� ��� ����
-- ���, �����, �����ڵ�, ���޸�
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
JOIN JOB ON (JOB_CODE = JOB_NAME); -- ������!!
-- ambiguously : �ָ��ϴ�, ��ȣ�ϴ� => �÷��� � ���̺��� �÷����� �𸣰ڴ�

-- �ذ��� 1. ���̺�� �Ǵ� ��Ī�� �̿��ؼ� �ϴ� ���
SELECT EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
FROM EMPLOYEE E
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE);

-- �ذ��� 2. JOIN USING ���� ����ϴ� ��� (** �� �÷����� ��ġ�� ���� ��� ����!!)
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE);

-------------- [�������] --------------
-- �ڿ�����(NATURAL JOIN) : �� ���̺��� ������ �÷��� �� �Ѱ��� ������ ���!! => ANSI
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
NATURAL JOIN JOB;

-- ������ �븮�� ����� �̸�, ���޸�, �޿� ��ȸ
-- >> ����Ŭ ���� ����
SELECT EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE
AND JOB_NAME = '�븮';

-- >> ANSI ����
SELECT EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '�븮';

---------------------------------- �ǽ����� -------------------------------------
-- 1. �μ��� �λ�������� ������� ���, �̸�, ���ʽ� ��ȸ
-- >> ����Ŭ ���� ����
SELECT EMP_ID, EMP_NAME, BONUS
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
AND DEPT_TITLE = '�λ������' ;

-- >> ANSI ����
SELECT EMP_ID, EMP_NAME, BONUS
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE DEPT_TITLE = '�λ������' ;

-- 2. DEPARTMENT�� LOCATION�� �����ؼ� ��ü �μ��� �μ��ڵ�, �μ���, �����ڵ�, ������ ��ȸ
-- >> ����Ŭ ���� ����
SELECT DEPT_ID, DEPT_TITLE, LOCATION_ID, LOCAL_NAME
FROM DEPARTMENT, LOCATION
WHERE LOCATION_ID = LOCAL_CODE;

-- >> ANSI ����
SELECT DEPT_ID, DEPT_TITLE, LOCATION_ID, LOCAL_NAME
FROM DEPARTMENT
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE);

-- 3. ���ʽ��� �޴� ������� ���, �����, ���ʽ�, �μ��� ��ȸ
-- >> ����Ŭ ���� ����
SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
AND BONUS IS NOT NULL;

-- >> ANSI ����
SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE BONUS IS NOT NULL;

-- 4. �μ��� �ѹ��ΰ� �ƴ� ������� �����, �޿�, �μ��� ��ȸ
-- >> ����Ŭ ���� ����
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
AND DEPT_TITLE != '�ѹ���';

-- >> ANSI ����
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE DEPT_TITLE != '�ѹ���';

------------------------------------------------------------------------------
/*
    2. �������� / �ܺ����� (OUTER JOIN)
    �� ���̺��� JOIN�� ��ġ���� �ʴ� �൵ ���Խ��Ѽ� ��ȸ ����
    ��, �ݵ�� LEFT / RIGHT ���� �ؾߵ�!! ( ������ �Ǵ� ���̺� ����)
*/

-- �ܺ����ΰ� ���Ҹ��� INNER JOIN ��ȸ�صα�
-- �����ֱ�
-- �����, �μ���, �޿�, ����
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY * 12
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID); -- 21�� ����
-- �μ� ��ġ�� �ȵ� ��� 2�� ���� ���� ��ȸ �ȵǰ� ����
-- �μ��� ������ ����� ���� �μ��� ��ȸ �ȵǰ� ����

-- 1) LEFT [OUTER] JOIN : �� ���̺� �� ���� ����� ���̺� �������� JOIN
-- >> ANSI ����
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY * 12
FROM EMPLOYEE -- EMPLOYEE�� �ִ� �� �� ������ ����
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
-- �μ� ��ġ�� ���� �ʾҴ� 2���� ��� ������ ��ȸ��

-- >> ����Ŭ ���� ����
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY * 12
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID(+);

-- 2) RIGHT [OUTER] JOIN : �� ���̺� �� ������ ����� ���̺��� �������� JOIN
-- >> ANSI ����
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY * 12
FROM EMPLOYEE -- DEPARTMENT�� �ִ� �� �� ������ ����
RIGHT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

-- >> ����Ŭ ���� ����
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY * 12
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE(+) = DEPT_ID;

-- 3) FULL [OUTER] JOIN : �� ���̺��� ���� ��� ���� ��ȸ�� �� ���� (��, ����Ŭ���뱸�����δ� �ȵ�)
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY * 12
FROM EMPLOYEE 
FULL JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

-----------------------------------------------------------------------------------
/*
    3. ��ü���� (SELF JOIN)
    ���� ���̺��� �ٽ� �ѹ� �����ϴ� ���
*/

SELECT *
FROM EMPLOYEE;
-- ��ü ����� ���, �����, ����� �μ��ڵ�     => EMPLOYEE E -- MANAGER_ID
--      ����� ���, �����, ����� �μ��ڵ�     => EMPLOYEE M -- EMP_ID

-- >> ����Ŭ ���� ����
SELECT E.EMP_ID, E.EMP_NAME, E.DEPT_CODE,
       M.EMP_ID, M.EMP_NAME, M.DEPT_CODE
FROM EMPLOYEE E, EMPLOYEE M
WHERE E.MANAGER_ID = M.EMP_ID;

-- >> ANSI ����
SELECT E.EMP_ID, E.EMP_NAME, E.DEPT_CODE,
       M.EMP_ID, M.EMP_NAME, M.DEPT_CODE
FROM EMPLOYEE E
LEFT JOIN EMPLOYEE M ON (E.MANAGER_ID = M.EMP_ID);

------------------------------------------------------------------------------------
/*
    < ���� JOIN >
    2�� �̻��� ���̺��� ������ JOIN�� ��
*/

-- ���, �����, �μ���, ���޸�
SELECT *
FROM EMPLOYEE;      -- DEPT_CODE, JOB_CODE
SELECT *
FROM DEPARTMENT;    -- DEPT_ID
SELECT *
FROM JOB;           --            JOB_CODE

-- >> ����Ŭ ���� ����
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE E, DEPARTMENT D, JOB J
WHERE DEPT_CODE = DEPT_ID
AND E.JOB_CODE = J.JOB_CODE;

-- >> ANSI ����
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (DEPT_CODE = DEPT_ID)
JOIN JOB USING (JOB_CODE);

-- ���, �����, �μ���, ������
SELECT *            
FROM EMPLOYEE;      -- DEPT_CODE
SELECT *
FROM DEPARTMENT;    -- DEPT_ID, LOCATION_ID
SELECT *            
FROM LOCATION;      --          LOCAL_CODE

-- >> ����Ŭ ���� ����
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE, DEPARTMENT, LOCATION
WHERE DEPT_CODE = DEPT_ID
AND LOCATION_ID = LOCAL_CODE;

-- >> ANSI ����
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE);

---------------------------- �ǽ����� ----------------------------------
-- 1. ���, �����, �μ���, ������, ������ (EMP, DEP, LOC, NAT ����)
-- >> ����Ŭ ���� ����
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME, NATIONAL_NAME
FROM EMPLOYEE E, DEPARTMENT D, LOCATION L, NATIONAL N
WHERE DEPT_CODE = DEPT_ID
AND LOCATION_ID = LOCAL_CODE
AND L.NATIONAL_CODE = N.NATIONAL_CODE;

-- >> ANSI ����
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME, NATIONAL_NAME
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION L ON (LOCATION_ID = LOCAL_CODE)
JOIN NATIONAL N USING (NATIONAL_CODE);

-- 2. ���, �����, �μ���, ���޸�, ������, ������, �ش� �޿� ��޿��� ���� �� �ִ� �ִ� �ݾ� (���� ����)
-- >> ����Ŭ ���� ����
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, LOCAL_NAME, NATIONAL_NAME, MAX_SAL
FROM EMPLOYEE E, DEPARTMENT D, JOB J, LOCATION L, NATIONAL N, SAL_GRADE S
WHERE DEPT_CODE = DEPT_ID
AND E.JOB_CODE = J.JOB_CODE
AND LOCATION_ID = LOCAL_CODE
AND L.NATIONAL_CODE = N.NATIONAL_CODE
AND E.SAL_LEVEL = S.SAL_LEVEL;

-- >> ANSI ����
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, LOCAL_NAME, NATIONAL_NAME, MAX_SAL
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (DEPT_CODE = DEPT_ID)
JOIN JOB J USING (JOB_CODE)
JOIN LOCATION L ON (LOCATION_ID = LOCAL_CODE)
JOIN NATIONAL N USING (NATIONAL_CODE)
JOIN SAL_GRADE S USING (SAL_LEVEL);
