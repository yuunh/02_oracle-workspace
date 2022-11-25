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

--------------------------------- QUIZ 2 -----------------------------
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

-- ������ 
-- 1. ������ �켱������ ���� AND �����ڰ� ���� �����
-- 2. ���ʽ��� ���� �����͸� ������ ����
-- 3. ���ڰ� �ƴ� �����Ͱ� ������ ����
-- 4. ���ϵ�ī�� _�� �������� ���� �ߺ��Ǿ� ����� �̻��ϰ� ������ ����
-- 5. ������ 200������ �ȵǴ� �����Ͱ� ������ ����

-- ���� ����
SELECT EMP_NAME, EMP_NO, JOB_CODE, DEPT_CODE, SALARY, BONUS
FROM EMPLOYEE
WHERE JOB_CODE IN ('J7', 'J6') AND SALARY >= 2000000
AND BONUS IS NOT NULL AND SUBSTR(EMP_NO, 8, 1) IN ('2', '4')
AND EMAIL LIKE '___$_%' ESCAPE '$';

SELECT EMP_NAME, EMP_NO, JOB_CODE, DEPT_CODE, SALARY, BONUS
FROM EMPLOYEE
WHERE (JOB_CODE = 'J7' OR JOB_CODE = 'J6') AND SALARY >= 2000000
AND EMAIL LIKE '___$_%' ESCAPE '$' AND BONUS IS NOT NULL
AND SUBSTR(EMP_NO, 8, 1) IN ('2', '4');


