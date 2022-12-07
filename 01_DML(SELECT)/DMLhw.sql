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

--------------------------------------------------------------------------------
-- ���ʽ��� �� ������ �μ���ġ�� �� ��� ����
SELECT *
FROM EMPLOYEE
WHERE BONUS = NULL AND DEPT_CODE != NULL;

-- NULL ���� ���� ���� =�� ���� �ȵ�
SELECT *
FROM EMPLOYEE
WHERE BONUS IS NULL AND DEPT_CODE IS NOT NULL;
--------------------------------------------------------------------------------
-- �˻��ϰ��� �ϴ� ����
-- JOB_CODE�� J7�̰ų� J6�̸鼭 SALARY ���� 200���� �̻��̰�
-- BONUS�� �ְ� �����̸� �̸��� �ּҴ� _ �տ� 3���ڸ� �ִ� �����
-- EMP_NAME, EMP_NO, JOB_CODE, DEPT_CODE, SALARY, BONUS ��ȸ
-- ���������� ��ȸ�� �� �ȴٸ� ���� ����� 2����

-- ���� ������ �����Ű���� �ۼ��� SQL���� �Ʒ��� ����.
SELECT EMP_NAME, EMP_NO, JOB_CODE, DEPT_CODE, SALARY, BONUS
FROM EMPLOYEE
WHERE JOB_CODE = 'J7' OR JOB_CODE = 'J6' AND SALARY > 2000000
AND EMAIL LIKE '___%' AND BONUS IS NULL;

-- ���� SQL�� ����� ���ϴ� ����� ����� ��ȸ�� ���� �ʴ´�.
-- �̶� � ���������� �ִ��� ��� ã�Ƽ� �����Ͻÿ�.
-- �׸��� ��ġ�� �Ϻ��� SQL���� �ۼ��� �� ��

-- AND�� OR�� ���� ����Ǿ� ������ ������ �켱 ������ ���� AND�� ���� �����
-- > �����ڴ� 200���� �ʰ��� ���� ��������
-- ���ʽ��� �ִ� ����� NULL ���� ������� �ʴ�
-- ���ڸ� ���ϴ� ������ ����
-- �̸��� �񱳽� �׹�° �ڸ��� �ִ� _�� ������ ������ ����� �������� ���� �ߺ���

SELECT EMP_NAME, EMP_NO, JOB_CODE, DEPT_CODE, SALARY, BONUS
FROM EMPLOYEE
WHERE (JOB_CODE = 'J7' OR JOB_CODE = 'J6') AND SALARY >= 2000000
AND EMAIL LIKE '___$_%' ESCAPE '$' AND BONUS IS NOT NULL
AND SUBSTR(EMP_NO, 8, 1) IN ('2', '4');
--------------------------------------------------------------------------------
-- ROWNUM�� Ȱ���ؼ� �޿��� ���� ���� 5���� ��ȸ�ϰ� �;����� ����� ��ȸ�� �ȵǾ���
-- �̶� �ۼ��� SQL���� �Ʒ��� ����
SELECT ROWNUM, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE ROWNUM <= 5
ORDER BY SALARY DESC;

-- � �������� �ִ���, �ذ�� SQL�� �ۼ�

-- ���� ������ SELECT ���� ���� ����Ǳ� ������ ROWNUM�� �ο��ǰ� ���ĵ�
SELECT ROWNUM, EMP_NAME, SALARY
FROM (SELECT *
        FROM EMPLOYEE
        ORDER BY SALARY DESC)
WHERE ROWNUM <= 5;
--------------------------------------------------------------------------------
-- �μ��� ��� �޿��� 270������ �ʰ��ϴ� �μ��鿡 ���� �μ��ڵ�, �μ��� �ѱ޿���, �μ��� ��� �޿�, �λ纰 �����
-- �̶� �ۼ��� SQL���� �Ʒ��� ����
SELECT DEPT_CODE, SUM(SALARY) ����, FLOOR(AVG(SALARY)) ���, COUNT(*) �ο���
FROM EMPLOYEE
WHERE SALARY > 2700000
GROUP BY DEPT_CODE
ORDER BY 1;

-- � �������� �ִ���, �ذ�� SQL�� �ۼ�

-- GROUP BY ���� ����� ���� WHERE�� �ƴ϶� HAVING ���� ����Ѵ�
SELECT DEPT_CODE, SUM(SALARY) ����, FLOOR(AVG(SALARY)) ���, COUNT(*) �ο���
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING AVG(SALARY) > 2700000
ORDER BY 1;
--------------------------------------------------------------------------------
-- ������ �޿� ��ȸ�� �� ���޺��� �λ��ؼ� ��ȸ
-- J7�� ����� �޿��� 10% �λ� (SALARY * 1.1)
-- J6�� ����� �޿��� 15% �λ� (SALARY * 1.15)
-- J4�� ����� �޿��� 20% �λ� (SALARY * 1.2)
-- �� ���� ����� �޿��� 5% �λ� (LALART * 1.05)

SELECT EMP_NAME, JOB_CODE, SALARY,
        DECODE(JOB_CODE, 'J7', SALARY * 1.1,
                         'J6', SALARY * 1.15,
                         'J4', SALARY * 1.2,
                               SALARY * 1.05)
FROM EMPLOYEE;
--------------------------------------------------------------------------------
-- '21/09/28'�� ���� ���ڿ��� ������ '2021-09-28'�� ǥ���غ���
SELECT TO_CHAR(TO_DATE('21/09/28'), 'YYYY-MM-DD')
FROM DUAL;

-- '210908'�� ���� ���ڿ��� ������ 2021�� 9�� 8�� ǥ���غ���
SELECT TO_CHAR(TO_DATE('210908'), 'YYYY"��" FMMM"��" DD"��"')
FROM DUAL;