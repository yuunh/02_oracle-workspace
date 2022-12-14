-- ���� ����

---------- QUIZ1 ----------
-- CREATE USER TEST INDENTIFIED BY 1234; ����
-- User TEST��(��) �����ƽ��ϴ�.
-- ���� ������ �ϰ� ���� => ����!!

-- �� ������ ������?
-- ������ : ���� ������ �ϰ� ���� ������ �ο����� �ʾұ� ������
-- ��ġ : GRANT CONNECT, RESOURCE TO TEST;

---------- QUIZ2 ----------
-- JOIN
CREATE TABLE TB_JOB(
    JOBCODE NUMBER PRIMARY KEY,
    JOBNAME VARCHAR2(10) NOT NULL
);

CREATE TABLE TB_EMP(
    EMPNO NUMBER PRIMARY KEY,
    EMPNAME VARCHAR2(10) NOT NULL,
    JOBNO NUMBER REFERENCES TB_JOB(JOBCODE)
);

-- ���� �� ���̺��� �ִٴ� �����Ͽ�
-- �� ���̺��� �����ؼ� EMPNO, EMPNAME, JOBNO, JOBNAME �÷��� ��ȸ�Ұ���
-- �̶� ������ SQL��
SELECT EMPNO, EMPNAME, JOBNO, JOBNAME
FROM TB_EMP
JOIN TB_JOB USING (JOBNO);
-- ���� �߻�
-- ORA-00904: "TB_JOB"."JOBNO": invalid identifier

-- ������ : JOBNO �÷��� TB_EMP���� ���������� TB_JOB���� �������� �ʱ� ������ USING ���� ��� �Ұ�
-- ��ġ : USING(JOBNO)�� �ƴ϶� ON�� ����ؼ� ON (JOBNO = JOBCODE)�� �Ѵ�
SELECT EMPNO, EMPNAME, JOBNO, JOBNAME
FROM TB_EMP
JOIN TB_JOB ON (JOBNO = JOBCODE);

--------------------------------------------------------------------------------
-- ���̺� ���� �����ؼ� ������ Ÿ�� (CHAR, VARCHAR2) ������

-- ����Ŭ ��ü (SEQUENCE, VIEW, ....) ����

-- ���� ���� ���� => �ڴʰ� ���� ������ �߰��� �� �ִ� ALTER�� �ۼ�

-- DCL ?

-- COMMIT / ROLLBACK

---------- QUIZ3 ----------
-- JOIN

-- �Ʒ��� SQL������ �μ��� ���� �հ谡 15,000,000�� �ʰ��ϴ� �μ��� ��ȸ�� ���̴�
-- �� ����� �ùٸ��� �ʴ�
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
WHERE SALARY > 15000000
GROUP BY DEPT_CODE;

SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) > 15000000;

---------- QUIZ4 ----------
-- ���� ����
CREATE TABLE QUIZ4(
    QNO NUMBER PRIMARY KEY,
    QNAME VARCHAR2(10),
    SCORE NUMBER
);

INSERT INTO QUIZ4 VALUES (1, '����1��', 30);
INSERT INTO QUIZ4 VALUES (1, '����2��', 50);
INSERT INTO QUIZ4 VALUES (NULL, '����1��', 30);

-- JOIN => DECODE
-- J7�� ����� �޿��� 10% �λ�
-- J6�� ����� �޿��� 15% �λ�

-- '21/09/28' ���ڿ� => '2021-09-28'
-- '210908' => 2021�� 9�� 8��

-- CASE WHEN
-- �ʱް����� �߱ް����� ��ް�����

