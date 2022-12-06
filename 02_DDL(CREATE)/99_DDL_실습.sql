--�ǽ�����--

--�������� ���α׷��� ����� ���� ���̺��� �����

--�̶�, �������ǿ� �̸��� �ο��� ��

-- �� �÷��� �ּ��ޱ�

--------------------------------------------------------------------------------
--1. ���ǻ�鿡 ���� �����͸� ��� ���� ���ǻ� ���̺�(TB_PUBLISHER)

--�÷�: PUB_NO(���ǻ��ȣ) --�⺻Ű(PUBLISHER_PK)

-- PUB_NAME(���ǻ��) --NOT NULL(PUBLICHSER_NN)

-- PHONE(���ǻ���ȭ��ȣ) --�������� ����

--3�� ������ ���� ������ �߰��ϱ�

CREATE TABLE TB_PUBLISHER(
    PUB_NO NUMBER CONSTRAINT PUBLISHER_PK PRIMARY KEY,
    PUB_NAME VARCHAR2(50) CONSTRAINT PUBLICHSER_NN NOT NULL,
    PHONE VARCHAR2(50)
);

SELECT *
FROM TB_PUBLISHER;

DROP TABLE TB_PUBLISHER;

COMMENT ON COLUMN TB_PUBLISHER.PUB_NO IS '���ǻ��ȣ';
COMMENT ON COLUMN TB_PUBLISHER.PUB_NAME IS '���ǻ��';
COMMENT ON COLUMN TB_PUBLISHER.PHONE IS '���ǻ���ȭ��ȣ';

INSERT INTO TB_PUBLISHER VALUES(01, 'â��', '031-955-3333');
INSERT INTO TB_PUBLISHER VALUES(02, '����������', '02-790-6630');
INSERT INTO TB_PUBLISHER VALUES(03, '����������Ͻ�', '0507-1405-9965');
INSERT INTO TB_PUBLISHER VALUES(04, '���̾𽺺Ͻ�', '02-515-2000');
INSERT INTO TB_PUBLISHER VALUES(05, '�Ͻ���', '02-6463-7000');



--2. �����鿡 ���� �����͸� ��� ���� ���� ���̺�(TB_BOOK)

--�÷�: BK_NO(������ȣ) --�⺻Ű(BOOK_PK)

-- BK_TITLE(������) --NOT NULL(BOOK_NN_TITLE)

-- BK_AUTHOR(���ڸ�) --NOT NULL(BOOK_NN_AUTHOR)

-- BK_PRICE(����)

-- BK_STOCK(���) --�⺻�� 1�� ����

-- BK_PUB_NO(���ǻ��ȣ) --�ܷ�Ű(BOOK_FK)(TB_PUBLISHER ���̺��� �����ϵ���)

-- �̶� �����ϰ� �ִ� �θ����� ���� �� �ڽĵ����͵� �����ǵ��� ����

--5�� ������ ���� ������ �߰��ϱ�

CREATE TABLE TB_BOOK(
    BK_NO NUMBER CONSTRAINT BOOK_PK PRIMARY KEY,
    BK_TITLE VARCHAR2(50) CONSTRAINT BOOK_NN_TITLE NOT NULL,
    BK_AUTHOR VARCHAR2(50) CONSTRAINT BOOK_NN_AUTHOR NOT NULL,
    BK_PRICE NUMBER,
    BK_STOCK NUMBER DEFAULT 1,
    BK_PUB_NO NUMBER CONSTRAINT BOOK_FK REFERENCES TB_PUBLISHER(PUB_NO) ON DELETE CASCADE
);

SELECT *
FROM TB_BOOK;

DROP TABLE TB_BOOK;

COMMENT ON COLUMN TB_BOOK.BK_NO IS '������ȣ';
COMMENT ON COLUMN TB_BOOK.BK_TITLE IS '������';
COMMENT ON COLUMN TB_BOOK.BK_AUTHOR IS '���ڸ�';
COMMENT ON COLUMN TB_BOOK.BK_PRICE IS '����';
COMMENT ON COLUMN TB_BOOK.BK_STOCK IS '���';
COMMENT ON COLUMN TB_BOOK.BK_PUB_NO IS '���ǻ��ȣ';

INSERT INTO TB_BOOK VALUES(101, 'ũ�������� Ÿ��', '�����', 13500, 32, 01);
INSERT INTO TB_BOOK VALUES(102, '�Ƹ��', '�տ���', 10800, 29, 01);
INSERT INTO TB_BOOK VALUES(103, '������ ������', '��ȣ��', 12600, 16, 02);
INSERT INTO TB_BOOK VALUES(104, '������ ������', '��ȣ��', 11700, 26, 02);
INSERT INTO TB_BOOK VALUES(105, '���ű��� ��', '��ó�� ��ũ', 11500, 14, 02);
INSERT INTO TB_BOOK VALUES(106, '���� �Ӽ�', '���ȣ', 16000, 90, 03);
INSERT INTO TB_BOOK VALUES(107, '������ �����ϱ�', '�� ũ������', 14800, 29, 03);
INSERT INTO TB_BOOK VALUES(108, '���� ���', '���� ����', 19800, 50, 04);
INSERT INTO TB_BOOK VALUES(109, '�ڽ���', 'Į ���̰�', 17900, 34, 04);
INSERT INTO TB_BOOK VALUES(110, '������ ����', '����ȭ', 15300, 52, 05);



--3. ȸ���� ���� �����͸� ��� ���� ȸ�� ���̺�(TB_MEMBER)

--�÷���: MEMBER_NO(ȸ����ȣ) --�⺻Ű(MEMBER_PK)

-- MEMBER_ID(���̵�) --�ߺ�����(MEMBER_UQ)

--MEMBER_PWD(��й�ȣ) NOT NULL(MEMBER_NN_PWD)

--MEMBER_NAME(ȸ����) NOT NULL(MEMBER_NN_NAME)

--GENDER(����) 'M' �Ǵ� 'F'�� �Էµǵ��� ����(MEMBER_CK_GEN)

--ADDRESS(�ּ�)

--PHONE(����ó)

--STATUS(Ż�𿩺�) --�⺻������ 'N' �׸��� 'Y' Ȥ�� 'N'���� �Էµǵ��� ��������(MEMBER_CK_STA)

--ENROLL_DATE(������) --�⺻������ SYSDATE, NOT NULL ����(MEMBER_NN_EN)

--5�� ������ ���� ������ �߰��ϱ�

CREATE TABLE TB_MEMBER(
    MEMBER_NO VARCHAR2(20) CONSTRAINT MEMBER_PK PRIMARY KEY,
    MEMBER_ID VARCHAR2(50) UNIQUE,
    MEMBER_PWD VARCHAR2(50) CONSTRAINT MEMBER_NN_PWD NOT NULL,
    MEMBER_NAME VARCHAR2(50) CONSTRAINT MEMBER_NN_NAME NOT NULL,
    GENDER CHAR(3) CONSTRAINT MEMBER_CK_GEN CHECK(GENDER IN ('M', 'F')),
    ADDRESS VARCHAR2(50),
    PHONE VARCHAR2(50),
    STATUS CHAR(3) CONSTRAINT MEMBER_CK_STA CHECK(STATUS IN ('Y', 'N')),
    ENROLL_DATE DATE DEFAULT SYSDATE CONSTRAINT MEMBER_NN_EN NOT NULL
);

SELECT *
FROM TB_MEMBER;

DROP TABLE TB_MEMBER;

COMMENT ON COLUMN TB_MEMBER.MEMBER_NO IS 'ȸ����ȣ';
COMMENT ON COLUMN TB_MEMBER.MEMBER_ID IS '���̵�';
COMMENT ON COLUMN TB_MEMBER.MEMBER_PWD IS '��й�ȣ';
COMMENT ON COLUMN TB_MEMBER.MEMBER_NAME IS 'ȸ����';
COMMENT ON COLUMN TB_MEMBER.GENDER IS '����';
COMMENT ON COLUMN TB_MEMBER.ADDRESS IS '�ּ�';
COMMENT ON COLUMN TB_MEMBER.PHONE IS '����ó';
COMMENT ON COLUMN TB_MEMBER.STATUS IS 'Ż�𿩺�';
COMMENT ON COLUMN TB_MEMBER.ENROLL_DATE IS '������';

INSERT INTO TB_MEMBER VALUES('A01', 'user01', 'pass01', '�����', 'F', '��⵵ ȭ����', '010-1987-0620', 'N', '05/09/10');
INSERT INTO TB_MEMBER VALUES('A02', 'user02', 'pass02', '������', 'M', '���ϵ� ��õ��', '010-3991-6230', 'Y', '10/11/23'); 
INSERT INTO TB_MEMBER VALUES('A03', 'user03', 'pass03', '�ְ���', 'M', '���ֱ����� ����', '010-020228
INSERT INTO TB_MEMBER VALUES('A04', 'user04', 'pass04', '
INSERT INTO TB_MEMBER VALUES('A05', 'user05', 'pass05', 




--4. ������ �뿩�� ȸ���� ���� �����͸� ��� ���� �뿩��� ���̺�(TB_RENT)

--�÷�:

--RENT_NO(�뿩��ȣ) --�⺻Ű(RENT_PK)

--RENT_MEM_NO(�뿩ȸ����ȣ) --�ܷ�Ű(RENT_FK_MEM) TB_MEMBER�� �����ϵ���

--�̶� �θ����� ���� �� NULL���� �ǵ��� �ɼ� ����

--RENT_BOOK_NO(�뿩������ȣ) --�ܷ�Ű(RENT_FK_BOOK) TB_BOOK�� �����ϵ���

--�̶� �θ����� ���� �� NULL���� �ǵ��� �ɼǼ���

--RENT_DATE(�뿩��) --�⺻�� SYSDATE

--���õ����� 3������ �߰��ϱ�





--2�� ������ �뿩�� ȸ���� �̸�, ���̵�, �뿩��, �ݳ�������(�뿩��+7)�� ��ȸ�Ͻÿ�.





