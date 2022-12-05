-- ���� ����
-- DDL ����� �����ϰ� ����� Ŀ�ؼ�, ���ҽ� ���� �ο��� ��

/*
    * DDL (DATA DEFINITION LANGUAGE) : ������ ���� ���
    ����Ŭ���� �����ϴ� ��ü(OBJECT)�� ������ �����(CREATE), 
    ������ ����(ALTER)�ϰ�, ���� ��ü�� ����(DROP)�ϴ� ���
    ��, ���� ������ ���� �ƴ� ���� ��ü�� �����ϴ� ���
    �ַ� DB������, �����ڰ� �����
    
    ����Ŭ���� �����ϴ� ��ü(����) : ���̺�(TABLE), ��(VIEW), ������(SEQUENCE),
                                �ε���(INDEX), ��Ű��(PACKAGE), Ʈ����(TRIGGER),
                                ���ν���(PROCEDURE), �Լ�(FUNCTION), ���Ǿ�(SYNONYM), �����(USER)
                                
    < CREATE >
    ��ü�� ������ �����ϴ� ����
*/

/*
    1. ���̺� ����
    - ���̺��̶� ? ��(ROW)�� ��(COLUMN)�� �����Ǵ� ���� �⺻���� �����ͺ��̽� ��ü��
                ��� �����͵��� ���̺��� ���ؼ� �����!!
                (DBMS ��� �� �ϳ���, �����͸� ������ ǥ ���·� ǥ���� ��)
            
    [ ǥ���� ]
    CREATE TABLE ���̺��(
        �÷��� �ڷ���(ũ��),
        �÷��� �ڷ���(ũ��),
        �÷��� �ڷ���,
        ....
    );
    
    * �ڷ���
    - ���� (CHAR(����Ʈũ��) | VARCHAR2(����Ʈũ��)) => �ݵ�� ũ�� ���� �ؾ���!!
    > CHAR : �ִ� 2000����Ʈ���� ���� ����. ������ ���� �ȿ����� ����� 
            / ���� ���� (������ ũ�⺸�� �� ���� ���� ������ �������� ä����)
            => ������ ���ڼ��� �����͸��� ��� ��� ��� (gender, y n)
            
    > VARCHAR2 : �ִ� 4000����Ʈ���� ���� ����. ���� ���� (���� ���� ���� ���� ũ�Ⱑ ������)
                => �� ������ �����Ͱ� ������ �𸣴� ��� ���
                
    - ���� (NUMBER)
    
    - ��¥ (DATE)
*/
--> ȸ���� ���� �����͸� ��� ���� MEMBER �����ϱ�
CREATE TABLE MEMBER(
    MEM_NO NUMBER,
    MEM_ID VARCHAR2(20),
    MEM_PWD VARCHAR2(20),
    MEM_NAME VARCHAR2(20),
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    MEM_DATE DATE
);
-- ���� �÷��� ��Ÿ�� �߻��ߴٸ�..?
-- �ٽ� ����� �ɱ�? ���� �����ϰ� �ٽ� �ؾߵ�

SELECT *
FROM MEMBER;

-- USER_TABLES : ���� �� ������ ������ �ִ� ���̺� ���� �� �� ����
SELECT *
FROM USER_TABLES;

-- USER_TAB_COLUMNS : �� ����ڰ� ������ �ִ� ���̺� ���� ��� �÷� �� �� ����
SELECT *
FROM USER_TAB_COLUMNS;

--------------------------------------------------------------------------------
/*
    2. �÷��� �ּ� �ޱ� (�÷��� ���� ���� ������)
    
    [ǥ����]
    COMMENT ON COLUMN ���̺��.�÷��� IS '�ּ�����';
    
    >> �߸� �ۼ��ϰ� �������� ��� ���� �� �ٽ� �����ϸ� ��!!
*/
COMMENT ON COLUMN MEMBER.MEM_NO IS 'ȸ������';
COMMENT ON COLUMN MEMBER.MEM_NO IS 'ȸ����ȣ';
COMMENT ON COLUMN MEMBER.MEM_ID IS 'ȸ�����̵�';
COMMENT ON COLUMN MEMBER.MEM_PWD IS 'ȸ����й�ȣ';
COMMENT ON COLUMN MEMBER.MEM_NAME IS 'ȸ����';
COMMENT ON COLUMN MEMBER.GENDER IS '����(��/��)';
COMMENT ON COLUMN MEMBER.PHONE IS '��ȭ��ȣ';
COMMENT ON COLUMN MEMBER.EMAIL IS '�̸���';
COMMENT ON COLUMN MEMBER.MEM_DATE IS 'ȸ��������';

-- ���̺� �����ϰ��� �� �� : DROP TABLE ���̺��;
DROP TABLE MEMBER;

-- ���̺� �����͸� �߰���Ű�� ���� (DML : INSERT)
-- INSERT INTO ���̺�� VALUSE(��1, ��2, ....);

SELECT *
FROM MEMBER;

-- INSERT INTO MEMBER VALUES(1, 'user01', 'pass01', '�����'); ==> �� �Է� ���ϸ� ������!
INSERT INTO MEMBER VALUES(1, 'user01', 'pass01', '�����', '��', '010-1111-2222', 'aaa@naver.com', '20/12/30');
INSERT INTO MEMBER VALUES(2, 'user02', 'pass02', 'Ȳ����', '��', null, NULL, SYSDATE);
INSERT INTO MEMBER VALUES(NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL); 
-- ��ȿ���� ���� �����Ͱ� ���� ����... ���� ������ �ɾ������

--------------------------------------------------------------------------------
/*
    < �������� CONSTRAINTS >
    - ���ϴ� �����Ͱ� (��ȿ�� ������ ��)�� �����ϱ� ���ؼ� Ư�� �÷��� �����ϴ� ��������
    - ������ ���Ἲ ������ �������� �Ѵ�
    
    * ���� : NOT NULL, UNIQUE, CHECK, PRIMARY KEY, FOREING KEY
*/

/*
    * NOT NULL ��������
    �ش� �÷��� �ݵ�� ���� �����ؾ� �� ��� (��, �ش� �÷��� ���� NULL�� ���ͼ��� �ȵǴ� ���)
    ���� / ������ NULL ���� ������� �ʵ��� ����
    
    ���� ������ �ο��ϴ� ����� ũ�� 2������ ���� (�÷�������� / ���̺������)
    * NOT NULL ���������� ������ �÷�������� �ۿ� �ȵ�!!
*/

-- �÷�������� : �÷��� �ڷ��� ��������
CREATE TABLE MEM_NOTNULL(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
);

SELECT *
FROM MEM_NOTNULL;

INSERT INTO MEM_NOTNULL VALUES(1, 'user01', 'pass01', '�����', '��', null, null);
INSERT INTO MEM_NOTNULL VALUES(2, 'user02', null, 'Ȳ����', '��', null, 'aaa@naver.com');
-- ORA-01400: cannot insert NULL into ("DDL"."MEM_NOTNULL"."MEM_PWD")
-- �ǵ��ߴ���� ������! (NOT NULL �������ǿ� ����Ǿ� ���� �߻�)
INSERT INTO MEM_NOTNULL VALUES(2, 'user01', 'pass01', 'Ȳ����', null, null, null);
-- ���̵� �ߺ��Ǿ��������� �ұ��ϰ� �� �߰���... �ФѤ�

--------------------------------------------------------------------------------
/*
    *UNIQUE ��������
    �ش� �÷��� �ߺ��� ���� ������ �� �� ���
    �÷����� �ߺ����� �����ϴ� ��������
    ���� / ������ ������ �ִ� �����Ͱ� �� �ߺ����� ���� ��� ���� �߻�
*/

CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE, --> �÷����� ���
    MPM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
);

SELECT *
FROM MEM_UNIQUE;

DROP TABLE MEM_UNIQUE;

-- ���̺� ���� ��� : ��� �÷� �� ������ �� �������� ���
--                  ��������(�÷���)
CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL, 
    MPM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    UNIQUE(MEM_ID) -- ���̺� ���� ���
);

SELECT *
FROM MEM_UNIQUE;

INSERT INTO MEM_UNIQUE VALUES (1, 'user01', 'pass01', '�����', null, null, null);
INSERT INTO MEM_UNIQUE VALUES (2, 'user01', 'pass02', 'Ȳ����', null, null, null);
-- ORA-00001: unique constraint (DDL.SYS_C007069) violated
-- UNIQUE �������ǿ� ����Ǿ���! INSERT ����
--> ���� ������ �������Ǹ����� �˷��� (Ư�� Ŀ���� � ������ �ִ��� ���� �˷����� ����)
--> ���� �ľ��ϱⰡ �Ʒ���
--> �������� �ο��� �������Ǹ� ���������� ������ �ý��ۿ��� ������ �������Ǹ��� �ο�����

/*
    * �������� �ο��� �������Ǹ���� �����ִ� ���
    
    > �÷��������
    CREATE TABLE ���̺��(
        �÷��� �ڷ��� [CONSTRAINT �������Ǹ�] ��������,
        �÷��� �ڷ���
    );
    > ���̺������
    CREATE TABLE ���̺��(
        �÷��� �ڷ���,
        �÷��� �ڷ���,
        [CONSTRAINT �������Ǹ�] ��������(�÷���)
    );
*/

DROP TABLE MEM_UNIQUE;

CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER CONSTRAINT MEMNO_NN NOT NULL,
    MEM_ID VARCHAR2(20) CONSTRAINT MEMID_NN NOT NULL, 
    MPM_PWD VARCHAR2(20) CONSTRAINT MEMPWD_NN NOT NULL,
    MEM_NAME VARCHAR2(20) CONSTRAINT MEMNAME_NN NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    CONSTRAINT MEMID_UQ UNIQUE(MEM_ID) -- ���̺� ���� ���
);

SELECT *
FROM MEM_UNIQUE;

INSERT INTO MEM_UNIQUE VALUES (1, 'user01', 'pass01', '�����', null, null, null);
INSERT INTO MEM_UNIQUE VALUES (2, 'user01', 'pass02', 'Ȳ����', null, null, null);
-- ORA-00001: unique constraint (DDL.MEMID_UQ) violated

INSERT INTO MEM_UNIQUE VALUES (2, 'user02', 'pass02', 'Ȳ����', null, null, null);
INSERT INTO MEM_UNIQUE VALUES (3, 'user03', 'pass03', '�̰���', '��', null, null);
--> ������ ��ȿ�� ���� �ƴѰ� ���͵� INSERT  �� ��... => �̷��� �ȵ�!!

--------------------------------------------------------------------------------
/*
    * CHECK(���ǽ�) ��������
    �ش� �÷��� ���� �� �ִ� ���� ���� ������ �����ص� �� ����
    �ش� ���ǿ� �����ϴ� ������ ���� ��� �� ����
*/

CREATE TABLE MEM_CHECK(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��', '��')), -- �÷��������
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
    -- CHECK(GENDER IN ('��', '��')) -- ���̺������
);

SELECT *
FROM MEM_CHECK;

INSERT INTO MEM_CHECK VALUES (1, 'user01', 'pass01', '�����', '��', null, null);
INSERT INTO MEM_CHECK VALUES (2, 'user02', 'pass02', 'Ȳ����', '��', null, null); 
-- ORA-02290: check constraint (DDL.SYS_C007079) violated
-- CHECK �������ǿ� ����Ǿ��� ������ ���� �߻�
-- ���� GENDER �÷��� ������ ���� �ְ��� �Ѵٸ� CHECK �������ǿ� �����ϴ� ���� �־�ߵ�

INSERT INTO MEM_CHECK VALUES (2, 'user02', 'pass02', 'Ȳ����', null, null, null); 
-- NOT NULL�� �ƴϸ� NULL�� ������

INSERT INTO MEM_CHECK VALUES (2, 'user03', 'pass03', 'Ȳ����', null, null, null); 

--------------------------------------------------------------------------------
/*
    * PRIMARY KEY(�⺻Ű) ��������
    ���̺��� �� ����� �ĺ��ϱ� ���� ���� �÷��� �ο��ϴ� ���� ���� (�ĺ����� ����)
    
    EX) �й�, ȸ����ȣ, �����ȣ, �μ��ڵ�, �����ڵ�, �ֹ���ȣ, �����ȣ, ������ȣ, ....
    
    PRIMARY KEY ���������� �ο��ϸ� �� �÷��� �ڵ����� NOT NULL + UNIQUE ���������� ������
    
    * ���ǻ��� : �� ���̺�� ������!! �� ���� ���� ����
*/

CREATE TABLE MEM_PRI(
    MEM_NO NUMBER CONSTRAINT MEMON_PK PRIMARY KEY, -- �÷��������
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
    -- CONSTRAINT MEMNO_PK PRIMARY KEY(MEM_NO) -- ���̺������
);

SELECT *
FROM MEM_PRI;

INSERT INTO MEM_PRI VALUES(1, 'user01', 'pass01', '�����', '��', '010-1111-2222', null);
INSERT INTO MEM_PRI VALUES(1, 'user02', 'pass02', 'Ȳ����', '��', null, null);
-- unique constraint (DDL.MEMON_PK) violated
-- �⺻Ű�� �ߺ����� �������� �� �� UNIQUE �������ǿ� �����

INSERT INTO MEM_PRI VALUES(null, 'user02', 'pass02', 'Ȳ����', '��', null, null);
-- ORA-01400: cannot insert NULL into ("DDL"."MEM_PRI"."MEM_NO")
-- �⺻Ű�� NULL�� �������� �� �� NOT NULL �������ǿ� �����

INSERT INTO MEM_PRI VALUES(2, 'user02', 'pass02', 'Ȳ����', '��', null, null);

CREATE TABLE MEM_PR2(
    MEM_NO NUMBER CONSTRAINT MEMON_PK PRIMARY KEY, -- �÷��������
    MEM_ID VARCHAR2(20) PRIMARY KEY,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
    -- CONSTRAINT MEMNO_PK PRIMARY KEY(MEM_NO) -- ���̺������
);
-- ORA-02260: table can have only one primary key
-- �⺻Ű �ϳ��� �ȴ�!

CREATE TABLE MEM_PR2(
    MEM_NO NUMBER, 
    MEM_ID VARCHAR2(20),
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    PRIMARY KEY(MEM_NO, MEM_ID) -- ��� PRIMARY KEY �������� �ο�(����Ű)
);

SELECT *
FROM MEM_PR2;

INSERT INTO MEM_PR2 VALUES(1, 'user01', 'pass01', '�����', null, null, null);
INSERT INTO MEM_PR2 VALUES(1, 'user02', 'pass02', 'Ȳ����', null, null, null);
INSERT INTO MEM_PR2 VALUES(1, 'user01', 'pass01', '�̰���', null, null, null);
-- ORA-00001: unique constraint (DDL.SYS_C007100) violated

INSERT INTO MEM_PR2 VALUES(null, 'user01', 'pass01', '�̰���', null, null, null);
-- ORA-01400: cannot insert NULL into ("DDL"."MEM_PR2"."MEM_NO")
-- PRIMARY KEY�� �����ִ� �� �÷����� ����!! NULL�� ������� ����

-- ����Ű ��� ���� (���ϱ�, ���ƿ�, ����)
-- ���ϱ� : �� ��ǰ�� ������ �� ���� ���� �� ����
-- � ȸ���� � ��ǰ�� ���ϴ����� ���� �����͸� �����ϴ� ���̺�

CREATE TABLE TB_LIKE(
    MEM_ID VARCHAR2(20),
    PRODUCT_NAME VARCHAR2(10),
    LIKE_DATE DATE,
    PRIMARY KEY(MEM_ID, PRODUCT_NAME)
);

SELECT *
FROM TB_LIKE;

INSERT INTO TB_LIKE VALUES('user01', '��', SYSDATE);
INSERT INTO TB_LIKE VALUES('user02', '��', SYSDATE);
INSERT INTO TB_LIKE VALUES('user01', '��', SYSDATE);
-- ORA-00001: unique constraint (DDL.SYS_C007101) violated

INSERT INTO TB_LIKE VALUES('user01', '��', SYSDATE);
