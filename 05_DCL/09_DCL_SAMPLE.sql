-- ���� ����

CREATE TABLE TEST(
    TEST_ID NUMBER,
    TEST_NAME VARCHAR2(10)
);

-- CREATE TABLE �� �� �ִ� ������ ��� ���� �߻�!

-- 3_1 CREATE TABLE ���� �ޱ�
-- 3_2 TABLE SPACE �Ҵ� �ޱ�

SELECT *
FROM TEST;

INSERT INTO TEST VALUES(10, '�ȳ�');

--------------------------------------------------------------------------------
-- KH ������ �ִ� EMPLOYEE ���̺� ����
SELECT *
FROM KH.EMPLOYEE;
-- ��ȸ ������ ����

INSERT INTO KH.DEPARTMENT VALUES('D0', 'ȸ���', 'L1');

ROLLBACK;
