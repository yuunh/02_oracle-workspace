-- ���� ���� �ϱ�
--------------------------------- QUIZ 1 -----------------------------
-- ���ʽ��� �� ������ �μ���ġ�� �� ��� ����
SELECT *
FROM EMPLOYEE
WHERE BONUS = NULL AND DEPT_CODE != NULL;
-- NULL ���� ���� ���������� �� ó�� ���� ����

-- ������ : NULL ���� ���� ���� �ܼ��� �Ϲ� �񱳿����ڸ� ���� ���� �� ����
-- �ذ��� : IS NULL / IS NOT NULL �����ڸ� �̿��ؼ� ���ؾ� �Ѵ�

-- ��ġ�� SQL��
SELECT *
FROM EMPLOYEE
WHERE BONUS IS NULL AND DEPT_CODE IS NOT NULL;