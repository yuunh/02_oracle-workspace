-- ���� ����

/*
    DDL (DATA DEFINITION LANGUAGE) : ������ ���� ���
    
    ��ü���� ����(CREATE), ����(ALTER), ����(DROP) �ϴ� ����
    
    < ALTER >
    ��ü�� �����ϴ� ����
    
    [ ǥ���� ]
    ALTER TABLE ���̺�� �����ҳ���;
    
    * ������ ����
    1) �÷� �߰� /  ���� / ����
    2) �������� �߰� / ���� --> ������ �Ұ�! (�����ϰ��� �Ѵٸ� ���� �� ���� �߰��ؾߵ�)
    3) �÷��� / �������Ǹ� / ���̺�� ����
*/

-- 1) �÷� �߰� /  ���� / ����
-- 1-1 �÷� �߰� (ADD) : ADD �÷��� �ڷ��� [DEFAULT �⺻��] [CONSTRATNT �������Ǹ�] ��������

-- DEPT_COPY ���̺� CNAME �÷� �߰�
ALTER TABLE DEPT_COPY ADD CNAME VARCHAR2(20);

-- > ���ο� �÷��� ��������� ������ �� �⺻������ NULL�� ä����

-- LNAME �÷� �߰�  : VARCHAR2(20) �⺻�� : �ѱ�
ALTER TABLE DEPT_COPY ADD LNAME VARCHAR2(20) DEFAULT '�ѱ�';

-- 1-2 �÷� ���� (MODIFY)
-- �ڷ��� ����       : MODIFY �÷��� �ٲٰ����ϴ��ڷ���
-- DEFAULT �� ����  : MODIFY �÷��� DEFAULT �ٲٰ����ϴ±⺻��

ALTER TABLE DEPT_COPY MODIFY DEPT_ID CHAR(3);

ALTER TABLE DEPT_COPY MODIFY DEPT_ID NUMBER;
-- ORA-01439: column to be modified must be empty to change datatype
-- ������ -> ���ڰ� �ƴ� �����Ͱ� �̹� ����ֱ� ������ ���� �Ұ�
-- �����ϴ� �����Ͱ� ����� ���� ����!

ALTER TABLE DEPT_COPY MODIFY DEPT_TITLE VARCHAR2(10);
-- ORA-01441: cannot decrease column length because some value is too big
-- ������ -> �̹� ����ִ� �����Ͱ� 10 ����Ʈ���� ũ�� ������ ���� �Ұ�

-- DEPT_TITLE �÷��� VARCHAR2(50)���� ����
ALTER TABLE DEPT_COPY MODIFY DEPT_TITLE VARCHAR2(50);

-- LOCATION_ID �÷��� VARCHAR2(4)�� ����
ALTER TABLE DEPT_COPY MODIFY LOCATION_ID VARCHAR2(4);

-- LNAME �÷��� �⺻���� '����'���� ����
ALTER TABLE DEPT_COPY MODIFY LNAME DEFAULT '����';
-- DEFAULT ���� �ٲ۴ٰ� �ؼ� ������ �߰��� �����Ͱ� �ٲ�� ���� �ƴϴ�!!

-- ���� ���� ����
ALTER TABLE DEPT_COPY
    MODIFY DEPT_TITLE VARCHAR2(40)
    MODIFY LOCATION_ID VARCHAR2(2)
    MODIFY LNAME DEFAULT '�̱�';
-- ���⼭�� DEFAULT ���� �ٲ۴ٰ� �ؼ� ������ �߰��� �����Ͱ� �ٲ��� �ʴ´�

-- 1-3 �÷� ���� (DROP COLUMN) : DROP COLUMN �����ϰ����ϴ��÷���

-- ������ ���� ���纻 ���̺� ����
CREATE TABLE DEPT_COPY2
AS SELECT *
FROM DEPT_COPY;

SELECT *
FROM DEPT_COPY2;

-- DEPT_COPY2�κ��� DEPT_ID �÷� �����
ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_ID;
ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_TITLE;

-- ���� ���� �ȵ�!!
ALTER TABLE DEPT_COPY2
    DROP COLUMN DEPT_ID
    DROP COLUMN DEPT_TITLE; -- ������

ALTER TABLE DEPT_COPY2 DROP COLUMN CNAME;
ALTER TABLE DEPT_COPY2 DROP COLUMN LNAME;

ALTER TABLE DEPT_COPY2 DROP COLUMN LOCATION_ID;
-- ORA-12983: cannot drop all columns in a table
-- ������ -> �ּ� �Ѱ��� �÷��� �����ؾ� �Ǳ� ������ ���� �ȵ�!! 

--------------------------------------------------------------------------------
-- 2) �������� �߰� / ����
/*
    2-1) �������� �߰�
    PRIMARY KEY : ADD PRIMARY KEY(�÷���)
    FOREIGN KEY : ADD FOREIGN KEY(�÷���) REFERENCES ���������̺��[(�÷���)]
    UNIQUE      : ADD UNIQUE(�÷���)
    CHECK       : ADD CHECK(�÷��� ���� ����)
    NOT NULL    : MODIFY �÷��� NOT NULL | NULL => �̰� ���� NULL ���
    
    �������Ǹ��� �����ϰ��� �Ѵٸ� [CONSTRAINT �������Ǹ�] 
*/

-- DEPT_ID�� PRIMARY KEY ���� ���� �߰� ADD
-- DEPT_TITLE�� UNIQUE ���� ���� �߰� ADD
-- LNAME�� NOT NULL ���� ���� �߰� MODIFY
ALTER TABLE DEPT_COPY
    ADD CONSTRAINT DCOPY_PK PRIMARY KEY(DEPT_ID)
    ADD CONSTRAINT DCOPY_UQ UNIQUE(DEPT_TITLE)
    MODIFY LNAME CONSTRAINT DCOPY_NN NOT NULL;

-- 2_2 �������� ���� : DROP CONSTRAINT �������Ǹ�
-- NOT NULL�� ������ �ȵǰ� MODIFY NULL �̰ɷ� �����������!

ALTER TABLE DEPT_COPY DROP CONSTRAINT DCOPY_PK;

-- ���� ����
ALTER TABLE DEPT_COPY
    DROP CONSTRAINT DCOPY_UQ
    MODIFY LNAME NULL;

--------------------------------------------------------------------------------
-- 3) �÷��� / �������Ǹ� / ���̺�� ���� (RENAME)

-- 3_1 �÷��� ���� : RENAME COLUMN �����÷��� TO �ٲ��÷���

-- DEPT_TITLE => DEPT_NAME
ALTER TABLE DEPT_COPY RENAME COLUMN DEPT_TITLE TO DEPT_NAME;

-- 3_2 �������Ǹ� ���� : RENAME CONSTRAINT �������Ǹ� TO �ٲ��������Ǹ�

-- SYS_C007276 => DCOPY_DID_NN
ALTER TABLE DEPT_COPY RENAME CONSTRAINT SYS_C007276 TO DCOPY_DID_NN;

-- 3_3 ���̺�� ���� : RENAME [�������̺��] TO �ٲ����̺��

-- DEPT_COPY => DEPT_TEST
ALTER TABLE DEPT_COPY RENAME TO DEPT_TEST;

--------------------------------------------------------------------------------
-- ���̺� ����
DROP TABLE DEPT_TEST;

-- ��, ��򰡿��� �����ǰ� �ִ� �θ����̺��� �Ժη� �����ϸ� �ȵ�!
-- ���࿡ �����ϰ��� �Ѵٸ�
-- ��� 1. �ڽ����̺� ���� ���� �� �θ����̺� �����ϴ� ���
-- ��� 2. �׳� �θ����̺� ���� �ϴµ� ���� ���Ǳ��� ���� �����ϴ� ���
--        DROP TABLE ���̺�� CASCADE CONSTRAINT;
