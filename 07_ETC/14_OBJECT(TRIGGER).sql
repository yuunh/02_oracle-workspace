-- ���� ����

/*
    < Ʈ���� TRIGGER >
    ���� ������ ���̺� INSERT, UPDATE, DELETE �� DML���� ���� ��������� ���� ��
    (���̺� �̺�Ʈ�� �߻����� ��)
    �ڵ����� �Ź� ������ ������ �̸� �����ص� �� �ִ� ��ü
    
    EX)
    ȸ��Ż��� ������ ȸ�����̺� �����͸� DELETE �� �� 
    ��ٷ� Ż���� ȸ���鸸 ���� �����ϴ� ���̺� �ڵ����� INSERT ó���ؾߵȴ�
    �Ű�Ƚ���� ���� ���� �Ѿ��� �� ���������� �ش� ȸ���� ������Ʈ�� ó���ǰԲ�
    ����� ���� �����Ͱ� ���(INSERT)�� ������ �ش� ��ǰ�� ���� �������� �Ź� ����(UPDATE)�ؾߵɶ�
    
    * Ʈ���� ����
    - SQL���� ����ñ⿡ ���� �з�
     > BEFROE TRIGGER : ���� ������ ���̺� �̺�Ʈ�� �߻��Ǳ� ���� Ʈ���� ����
     > AFTER TRIGGER : ���� ������ ���̺� �̺�Ʈ�� �߻��� �Ŀ� Ʈ���� ����
     
    - SQL���� ���� ������ �޴� �� �࿡ ���� �з�
     > STATEMENT TRIGGER (����Ʈ����) : �̺�Ʈ�� �߻��� SQL���� ���� �� �ѹ��� Ʈ���� ����
     > ROW TRIGGER (��Ʈ����) : �ش� SQL�� ������ ������ �Ź� Ʈ���� ����
                              (FOR EACH ROW �ɼ� ����ؾߵ�)
                              > :OLD - BEFORE UPDATE(������ �ڷ�), BEFORE DELETE(������ �ڷ�)
                              > :NEW - AFTER INSERT(�߰��� �ڷ�), AFTER UPDATE(������ �ڷ�)
    
    * Ʈ���� ��������
    [ǥ����]
    CREATE [OR REPLACE] TRIGGER Ʈ���Ÿ�
    BEFORE | AFTER      INSERT | UPDATE | DELETE    ON ���̺��
    [FOR EACH ROW]
    �ڵ����� ������ ����;
     �� [DECLARE
            ��������]
        BEGIN
            ���೻��(�ش� ���� ������ �̺�Ʈ �߻��� ���������� ������ ����)
        [EXCEPTION
            ����ó������;]
        END;
        /
*/

-- EMPLOYEE ���̺� ���ο� ���� INSERT �� ������ �ڵ����� �޼��� ��µǴ� Ʈ���� ����
CREATE OR REPLACE TRIGGER TRG_01
AFTER INSERT ON EMPLOYEE
BEGIN
    DBMS_OUTPUT.PUT_LINE('���Ի���� ȯ���մϴ�!');
END;
/

INSERT INTO EMPLOYEE (EMP_ID, EMP_NAME, EMP_NO, DEPT_CODE, JOB_CODE, SAL_LEVEL, HIRE_DATE)
VALUES(500, '�̼���', '111111-2222222', 'D7', 'J7', 'S2', SYSDATE);

INSERT INTO EMPLOYEE (EMP_ID, EMP_NAME, EMP_NO, DEPT_CODE, JOB_CODE, SAL_LEVEL, HIRE_DATE)
VALUES(501, '�ָ�', '121212-2121212', 'D7', 'J7', 'S2', SYSDATE);

--------------------------------------------------------------------------------
-- ��ǰ �԰� �� ��� ���� ����
-- >> �׽�Ʈ�� ���� ���̺� �� ������ ����

-- 1. ��ǰ�� ���� ������ ������ ���̺�
CREATE TABLE TB_PRODUCT(
    PCODE NUMBER PRIMARY KEY,       -- ��ǰ��ȣ
    PNAME VARCHAR2(30) NOT NULL,    -- ��ǰ��
    BRAND VARCHAR2(30) NOT NULL,    -- �귣��
    PRICE NUMBER,                   -- ����
    STOCK NUMBER DEFAULT 0          -- ������
);

-- ��ǰ��ȣ �ߺ� �ȵǰԾ� �Ź� ���ο� ��ȣ�� �߻���Ű�� ������
CREATE SEQUENCE SEQ_PCODE
START WITH 200
INCREMENT BY 5
NOCACHE;

INSERT INTO TB_PRODUCT VALUES(SEQ_PCODE.NEXTVAL, '������20', '�Ｚ', 1400000, DEFAULT);
INSERT INTO TB_PRODUCT VALUES(SEQ_PCODE.NEXTVAL, '������14', '����', 1300000, 10);
INSERT INTO TB_PRODUCT VALUES(SEQ_PCODE.NEXTVAL, '�����', '������', 600000, 20);

SELECT *
FROM TB_PRODUCT;

COMMIT;

-- 2. ��ǰ ����� �� �̷� ���̺�
-- � ��ǰ�� � ��¥�� ��� ����� �Ǿ������� ���� �����͸� ����ϴ� ���̺�
CREATE TABLE TB_PRODETAIL(
    DCODE NUMBER PRIMARY KEY,                      -- �̷¹�ȣ
    PCODE NUMBER REFERENCES TB_PRODUCT,            -- ��ǰ��ȣ   
    PDATE DATE NOT NULL,                           -- ��ǰ�������
    AMOUNT NUMBER NOT NULL,                        -- ��������
    STATUS CHAR(6) CHECK(STATUS IN ('�԰�', '���')) -- ����(�԰�/���)
);

-- �̷� ��ȣ�� �Ź� ���ο� ��ȣ ������Ѽ� �� �� �ְ� �����ִ� ������
CREATE SEQUENCE SEQ_DCODE
NOCACHE;

-- 200�� ��ǰ�� ���� ��¥�� 10�� �԰�
INSERT INTO TB_PRODETAIL VALUES(SEQ_DCODE.NEXTVAL, 200, SYSDATE, 10, '�԰�');

-- 200�� ��ǰ�� ��� ������ 10 ����
UPDATE TB_PRODUCT
SET STOCK = STOCK + 10
WHERE PCODE = 200;

COMMIT; -- �ش� Ʈ������ Ŀ��

-- 210�� ��ǰ�� ���� ��¥�� 5�� ���
INSERT INTO TB_PRODETAIL VALUES(SEQ_DCODE.NEXTVAL, 210, SYSDATE, 5, '���');

-- 201�� ��ǰ�� ��� ������ 5 ����
UPDATE TB_PRODUCT
SET STOCK = STOCK - 5
WHERE PCODE = 210;

COMMIT;

-- 205�� ��ǰ�� ���� ��¥�� 20�� �԰�
INSERT INTO TB_PRODETAIL VALUES(SEQ_DCODE.NEXTVAL, 205, SYSDATE, 20, '�԰�');

-- 205�� ��ǰ�� ��� ������ 20 ����
UPDATE TB_PRODUCT
SET STOCK = STOCK + 20
WHERE PCODE = 200; -- �߸��Է���

ROLLBACK; -- �߸��Է��ؼ� �ѹ���

-- 205�� ��ǰ�� ���� ��¥�� 20�� �԰� 
INSERT INTO TB_PRODETAIL VALUES(SEQ_DCODE.NEXTVAL, 205, SYSDATE, 20, '�԰�');
-- DCODE 3�� �ƴϰ� 4��

-- 205�� ��ǰ�� ��� ������ 20 ����
UPDATE TB_PRODUCT
SET STOCK = STOCK + 20
WHERE PCODE = 205;

COMMIT;

-- TB_PRODETAIL ���̺� INSERT �̺�Ʈ �߻���
-- TB_PRODUCT ���̺� �ڵ����� ������ UPDATE �ǰԲ� Ʈ���� ����

/*
    - ��ǰ�� �԰�� ��� => �ش� ��ǰ ã�Ƽ� ������ ���� UPDATE
    UPDATE TB_PRODUCT
    SET STOCK = STOCK + �����԰�ȼ���(INSERT�� �ڷ��� AMOUNT ��)
    WHERE PCODE = �����԰�Ȼ�ǰ��ȣ(INSERT�� �ڷ��� PCODE ��);
    
    - ��ǰ�� ���� ��� => �ش� ��ǰ ã�Ƽ� ������ ���� UPDATE
    UPDATE TB_PRODUCT
    SET STOCK = STOCK - �������ȼ���(INSERT�� �ڷ��� AMOUNT ��)
    WHERE PCODE = �������Ȼ�ǰ��ȣ(INSERT�� �ڷ��� PCODE ��);
*/

-- :NEW �����
CREATE OR REPLACE TRIGGER TRG_02
AFTER INSERT ON TB_PRODETAIL
FOR EACH ROW
BEGIN
    -- ��ǰ�� �԰�� ��� => ������ ����
    IF (:NEW.STATUS = '�԰�')
        THEN
            UPDATE TB_PRODUCT
            SET STOCK = STOCK + :NEW.AMOUNT
            WHERE PCODE = :NEW.PCODE;
    END IF;
    -- ��ǰ�� ���� ��� => ������ ����
    IF (:NEW.STATUS = '���')
        THEN
            UPDATE TB_PRODUCT
            SET STOCK = STOCK - :NEW.AMOUNT
            WHERE PCODE = :NEW.PCODE;
    END IF;
END;
/

-- 210�� ��ǰ�� ���� ��¥�� 7�� ���
INSERT INTO TB_PRODETAIL
VALUES(SEQ_DCODE.NEXTVAL, 210, SYSDATE, 7, '���');

-- 200�� ��ǰ�� ���� ��¥�� 100�� �԰�
INSERT INTO TB_PRODETAIL
VALUES(SEQ_DCODE.NEXTVAL, 200, SYSDATE, 100, '�԰�');

--------------------------------------------------------------------------------
-- �л� ���̺� ����
-- TB_STU
-- �÷� : �й�, �̸�, ����(M,F), ��ȭ��ȣ, ��������(����Ʈ ����, ����, ����, ����, ���� ������)
-- STU_NO, STU_NAME, GENDER, PHONE, STU_STATUS
CREATE TABLE TB_STU(
    STU_NO NUMBER PRIMARY KEY,
    STU_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('F', 'M')),
    PHONE VARCHAR2(20),
    STU_STATUS CHAR(6) DEFAULT '����',
    CHECK(STU_STATUS IN ('����', '����', '����', '����'))
);

-- �й������� ����(SEQ_STU_NO)
-- 900������ �����ϰ� (900,901)
CREATE SEQUENCE SEQ_STU_NO
START WITH 900
INCREMENT BY 1
NOCACHE;

-- ������ 5�� �����
INSERT INTO TB_STU VALUES(SEQ_STU_NO.NEXTVAL, '������', 'F', '010-0309-0147', DEFAULT);
INSERT INTO TB_STU VALUES(SEQ_STU_NO.NEXTVAL, '�����', 'F', '010-8031-4012', DEFAULT);
INSERT INTO TB_STU VALUES(SEQ_STU_NO.NEXTVAL, '������', 'M', '010-1833-7427', DEFAULT);
INSERT INTO TB_STU VALUES(SEQ_STU_NO.NEXTVAL, '������', 'F', '010-6323-0930', DEFAULT);
INSERT INTO TB_STU VALUES(SEQ_STU_NO.NEXTVAL, '�ں���', 'M', '010-9939-6166', DEFAULT);

-- ���� ���̺� ����
-- TB_ABSENCE
-- �÷� : ���й�ȣ, �й�(�ܷ�Ű), ��������, ���п���(CHECK Y N) => DEFAULT Y
-- ABS_NO, STU_NO, ABS_DATE, ABS_STATUS
CREATE TABLE TB_ABSENCE(
    ABS_NO NUMBER PRIMARY KEY,
    STU_NO NUMBER REFERENCES TB_STU,
    ABS_DATE DATE,
    ABS_STATUS CHAR(6) DEFAULT 'Y'
);

-- ���� ������ ����(SEQ_ABS_NO)
-- 1������ �����ϰ�
CREATE SEQUENCE SEQ_ABS_NO
NOCACHE;

-- �л��� ������ ��쿡 => �л����̺��� �������ΰ� ������ ���  
-- ���� ���̺� INSERT ��Ű��
-- �л����̺��� �������ΰ� ������ �Ǵ� ���
-- �ش絥���͸� DELETE ó��(���п��� ������ ���е� ����Ʈ) �Ѵ�.
CREATE OR REPLACE TRIGGER TRG_STU_01
AFTER UPDATE ON TB_STU
FOR EACH ROW
BEGIN
    IF (:NEW.STU_STATUS = '����')
        THEN
            INSERT INTO TB_ABSENCE
            VALUES(SEQ_ABS_NO.NEXTVAL, :NEW.STU_NO, SYSDATE, DEFAULT);
    END IF; 

    IF (:NEW.STU_STATUS = '����')
        THEN
            DELETE FROM TB_STU
            WHERE STU_NO = :OLD.STU_NO;
    END IF;
 END;
/   

-- ���� ���̺� ���п��ΰ� N���� �ٲ�°��
CREATE OR REPLACE TRIGGER TRG_STU_02
AFTER UPDATE ON TB_ABSENCE
FOR EACH ROW
BEGIN
    IF (:NEW.ABS_STATUS = 'N')
        THEN
            UPDATE TB_STU
            SET STU_STATUS = '����'
            WHERE STU_NO = :NEW.STU_NO;
    END IF; 
 END;
/ 

--------------------------------------------------------------------------------

DROP TABLE TB_STU;
DROP TABLE TB_ABSENCE;

-- �л����̺� ����
CREATE TABLE TB_STU(
    STU_NO NUMBER PRIMARY KEY,
    STU_NAME VARCHAR2(20),
    GENDER CHAR(1) CHECK(GENDER IN ('M', 'F')),
    PHONE VARCHAR2(15),
    STU_STATUS CHAR(6) DEFAULT '����'
    CHECK(STU_STATUS IN ('����','����','����', '����'))
);

-- �й� ������ ����
CREATE SEQUENCE SEQ_STU_NO
START WITH 900
NOCACHE;

-- ���� ���̺� ����
CREATE TABLE TB_ABSENCE(
    ABS_NO NUMBER PRIMARY KEY,
    STU_NO NUMBER REFERENCES TB_STU ON DELETE CASCADE,
    ABS_DATE DATE,
    ABS_STATUS CHAR(1) DEFAULT 'Y' 
    CHECK (ABS_STATUS IN ('Y', 'N'))
);

CREATE SEQUENCE SEQ_ABS_NO
NOCACHE;

SELECT * FROM TB_STU;
SELECT * FROM TB_ABSENCE;

INSERT INTO TB_STU
VALUES(SEQ_STU_NO.NEXTVAL, '��ÿ�', 'F', '010-2646-7652', DEFAULT);
INSERT INTO TB_STU
VALUES(SEQ_STU_NO.NEXTVAL, '�Ѽ���', 'F', '010-1234-5678', DEFAULT);
INSERT INTO TB_STU
VALUES(SEQ_STU_NO.NEXTVAL, '�ֿ���', 'M', '010-9999-1116', DEFAULT);
INSERT INTO TB_STU
VALUES(SEQ_STU_NO.NEXTVAL, '�����', 'M', '010-8524-6478', DEFAULT);
INSERT INTO TB_STU
VALUES(SEQ_STU_NO.NEXTVAL, '�ڼҿ�', 'F', '010-2368-9713', DEFAULT);
INSERT INTO TB_STU
VALUES(SEQ_STU_NO.NEXTVAL, '�赿��', 'M', '010-2368-9713', DEFAULT);

COMMIT;

CREATE OR REPLACE TRIGGER TRG_STU_01
AFTER UPDATE ON TB_STU
FOR EACH ROW
BEGIN
    -- �������� ����������
    IF (:NEW.STU_STATUS = '����')
        THEN
            INSERT INTO TB_ABSENCE 
            VALUES(SEQ_ABS_NO.NEXTVAL, :NEW.STU_NO, SYSDATE, 'Y'); 
            --COMMIT;
    END IF;
      IF (:NEW.STU_STATUS = '����')
        THEN
            DBMS_OUTPUT.PUT_LINE('�̰�ź��');
    END IF;
END;
/


-- ���� ���̺� ���п��ΰ� N���� �ٲ�°��
-- �л����̺��� �������� �������� ����
CREATE OR REPLACE TRIGGER TRG_STU_02
AFTER UPDATE ON TB_ABSENCE
FOR EACH ROW
BEGIN
    -- ���п��ΰ� N���� ����Ǵ°��
    IF (:NEW.ABS_STATUS = 'N')
        THEN
            UPDATE TB_STU
            SET STU_STATUS = '����'
            WHERE STU_NO = :NEW.STU_NO;
    END IF;
END;
/




-- �л��� ������ ��쿡 => �л����̺��� �������ΰ� ������ ���  
-- ���� ���̺� INSERT ��Ű��
UPDATE TB_STU
SET STU_STATUS = '����'
WHERE STU_NAME = '�赿��';

UPDATE TB_STU
SET STU_STATUS = '����'
WHERE STU_NAME = '�����';


-- ���� ���̺� ���п��ΰ� N���� �ٲ�°��
-- �л����̺��� �������� �������� ����
UPDATE TB_ABSENCE
SET ABS_STATUS = 'N'
WHERE STU_NO = 905;



SET SERVEROUTPUT ON;

