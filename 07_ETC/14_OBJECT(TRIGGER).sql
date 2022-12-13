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
