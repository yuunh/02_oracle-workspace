-- ���� ����
---------------------------------- QUIZ 1-------------------------------------
-- ROWNUM�� Ȱ���ؼ� �޿��� ���� ���� 5���� ��ȸ�ϰ� �;����� ����� ��ȸ�� �ȵǾ���
-- �̶� �ۼ��� SQL���� �Ʒ��� ����
SELECT ROWNUM, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE ROWNUM <= 5
ORDER BY SALARY DESC;

-- � �������� �ִ���, �ذ�� SQL�� �ۼ�
-- SELECT ���� ���� ����Ǳ� ������ ROWNUM�� �ο��ǰ� ������ ��
SELECT ROWNUM, E.*
FROM (SELECT EMP_NAME, SALARY
      FROM EMPLOYEE
      ORDER BY SALARY DESC) E
WHERE ROWNUM <= 5;
---------------------------------- QUIZ 2-------------------------------------
-- �μ��� ��� �޿��� 270������ �ʰ��ϴ� �μ��鿡 ���� �μ��ڵ�, �μ��� �ѱ޿���, �μ��� ��� �޿�, �λ纰 �����
-- �̶� �ۼ��� SQL���� �Ʒ��� ����
SELECT DEPT_CODE, SUM(SALARY) ����, FLOOR(AVG(SALARY)) ���, COUNT(*) �ο���
FROM EMPLOYEE
WHERE SALARY > 2700000
GROUP BY DEPT_CODE
ORDER BY 1;

-- � �������� �ִ���, �ذ�� SQL�� �ۼ�
-- GROUP BY ���� ������ WHERE�� �ƴ϶� HAVING ���� ���� �Ѵ�
SELECT DEPT_CODE, SUM(SALARY) ����, FLOOR(AVG(SALARY)) ���, COUNT(*) �ο���
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING AVG(SALARY) > 2700000
ORDER BY 1;
