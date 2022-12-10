-- ���� ����

/*
    < TCL : TRANSACTION CONTROL LANGUAGE >
    Ʈ������ ���� ���
    
    * Ʈ������ (TRANSACTION)
    - �����ͺ��̽��� ������ ���� ����
    - �������� ������� (DML �߰�, ����, ����)���� �ϳ��� Ʈ�����ǿ� ��� ó��
      DML�� �� ���� ������ �� Ʈ�������� �����ϸ� �ش� Ʈ�����ǿ� ���� ��� ó��
                           Ʈ�������� �������� ������ Ʈ�������� ���� ����
      COMMIT �ϱ� ������ ������׵��� �ϳ��� Ʈ�����ǿ� ��Ե�
      Ŀ���� �ؾ߸��� ���� ��� �ݿ��ȴٰ� �����ϸ��!
      
    - Ʈ�����ǿ� ����� �Ǵ� SQL : INSERT, UPDATE, DELETE (DML)
    
    COMMIT (Ʈ������ ���� ó�� �� Ȯ��)
    ROLLBACK (Ʈ������ ���)
    SAVEPOINT (�ӽ�����)
    
    COMMIT; ���� : �� Ʈ�����ǿ� ����ִ� ������׵��� ���� DB�� �ݰ��Ű�ڴٴ� �ǹ� ( �Ŀ� Ʈ�������� �����)
    ROLLBACK; ���� : �� Ʈ�����ǿ� ����ִ� ������׵��� ����(���) �� �� ������ COMMIT �������� ���ư�
    SAVEPOINT ����Ʈ��; ���� : ���� �� ������ �ش� ����Ʈ������ �ӽ��������� �����صδ� ��
                             ROLLBACK ����� ��ü ������׵��� �� ����ϴ� ���� �ƴ϶� �Ϻθ� �ѹ� ����!
*/

SELECT *
FROM EMP_01;

-- ����� 900���� ��� �����
DELETE FROM EMP_01
WHERE EMP_ID = 900;
-- ������ ��ó�� ����

-- ����� 901���� ��� �����
DELETE FROM EMP_01
WHERE EMP_ID = 901;

ROLLBACK;
-- ������� ��ҵǰ�, Ʈ�����ǵ� ������. ������ �ٽ� �ǻ�Ƴ���
-- > ������ ������ ���� �ƴϱ� ������ �ѹ� ����

--------------------------------------------------------------------------------
-- 200�� ��� �����
DELETE FROM EMP_01
WHERE EMP_ID = 200;

SELECT *
FROM EMP_01;

-- 800�� Ȳ���� �ѹ��� ��� �߰�
INSERT INTO EMP_01 VALUES(800, 'Ȳ����', '�ѹ���');

COMMIT;
-- ���� DB�� �ݿ���!!

ROLLBACK;
-- �̹� Ŀ���ؼ� ���� DB�� �ݿ��Ǿ��� ������ �ѹ� �Ұ���

--------------------------------------------------------------------------------
-- 217, 216, 214 ��� ����
DELETE FROM EMP_01
WHERE EMP_ID IN (217, 216, 214);

SELECT *
FROM EMP_01;

-- �ӽ������� ���
SAVEPOINT SP;

-- 801 ��ȿ�� �λ������ ��� �߰�
INSERT INTO EMP_01 VALUES(801, '��ȿ��', '�λ������');

-- 218 ��� ����
DELETE FROM EMP_01
WHERE EMP_ID = 210;

-- ROLLBACK;
-- ���⼭ �׳� �ѹ��ϸ� ���� �� ��ҵ�

ROLLBACK TO SP;

--------------------------------------------------------------------------------
-- 900, 901 ��� ����
DELETE FROM EMP_01
WHERE EMP_ID IN (900, 901);

-- 218 ��� ����
DELETE FROM EMP_01
WHERE EMP_ID = 218;

SELECT *
FROM EMP_01;

-- DDL��
CREATE TABLE TEST1(
    TID NUMBER
);
-- DDL���� �����ϴ� ���� Ʈ�������� ���� DB�� �ݿ��ǰ�, �ڵ� Ŀ�� �� DDL���� �����

ROLLBACK;

-- DDL�� (CREATE, ALTER, DROP)�� �����ϴ� ���� ������ Ʈ�����ǿ� �ִ� ������׵���
-- ������ COMMIT(���� DB�� �ݿ�)
-- ��, DDL�� ���� �� ������׵��� �־��ٸ� ��Ȯ�� �Ƚ�(COMMIT, ROLLBACK) �ϰ� ����