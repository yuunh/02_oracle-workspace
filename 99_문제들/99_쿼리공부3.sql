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
