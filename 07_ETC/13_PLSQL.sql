-- ���� ����

/*
    < PL / SQL >
    PROCEDURE LANGUAGE EXTENSION TO SQL (���ν���)
    
    ����Ŭ ��ü�� ����Ǿ��ִ� ������ ���
    SQL ���� ������ ������ ����, ����ó��(IF), �ݺ�ó��(LOOP, FOR, WHILE) ���� �����Ͽ� SQL�� ���� ����
    �ټ��� SQL���� �ѹ��� ���� ����(BLOCK ����) + ����ó���� ����
    
    * PL / SQL ����
    - [�����] : DECALRE�� ����, ������ ����� ���� �� �ʱ�ȭ�ϴ� �κ�
    - ����� : BEGIN���� ����, ������ �־����! SQL�� �Ǵ� ���(���ǹ�, �ݺ���) ���� ������ ����ϴ� �κ�
    - [����ó����] : EXCEPTION���� ����, ���� �߻��� �ذ��ϱ� ���� ������ �̸� ����ص� �� �ִ� ����
*/

-- �����ϰ� ȭ�鿡 HELLO ORACLE ��� (�ڹٿ��� HELLO WORLD ����ߴ� ��ó��...)
SET SERVEROUTPUT ON;

BEGIN 
    -- System.out.println("HELLO ORACLE");
    DBMS_OUTPUT.PUT_LINE('HELLO ORACLE');
END;
/

--------------------------------------------------------------------------------
/*
    1. DECLARE �����
    ���� �� ��� �����ϴ� ���� (����� ���ÿ� �ʱ�ȭ�� ����)
    �Ϲ�Ÿ�Ժ���, ���۷���Ÿ�Ժ���, ROWŸ�Ժ���
    
    1_1) �Ϲ�Ÿ�� ���� ���� �� �ʱ�ȭ
        [ǥ����] ������ [CONSTANT -> �������] �ڷ��� [:= ��];
*/

DECLARE -- �����
    EID NUMBER;
    ENAME VARCHAR2(20);
    PI CONSTANT NUMBER := 3.14;
BEGIN -- �����
    -- EID := 800;
    -- ENAME := '���峲';
    
    EID := &��ȣ;
    ENAME := '&�̸�';
    -- �Է� �ޱ� => &
    
    DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('PI : ' || PI);
END;
/
--------------------------------------------------------------------------------
-- 1_2) ���۷��� Ÿ�� ���� ���� �� �ʱ�ȭ (� ���̺��� � �÷��� ������ Ÿ���� �����ؼ� �� Ÿ������ ����)
-- [ǥ����] ������ �ڷ��� ���̺��.�÷���%TYPE;

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
BEGIN
    -- EID := '300';
    -- ENAME := '������';
    -- SAL := 3000000;
    
    -- ����� 200���� ����� ���, �����, ���� ��ȸ�ؼ� �� ������ ����
    SELECT EMP_ID, EMP_NAME, SALARY
    INTO EID, ENAME,SAL
    FROM EMPLOYEE
    -- WHERE EMP_ID = 201;
    WHERE EMP_ID = &���;
    
    DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('SAL : ' || SAL);
END;
/    
------------------------------- �ǽ����� ----------------------------------------
/*
    ���۷���Ÿ�� ������ EID, ENAME, JCODE, SAL, DTITLE �� �����ϰ�
    �� �ڷ����� EMLOYEE, DEPARTMENT ���̺��� �����ϵ���
    
    ����ڰ� �Է��� ����� ����� ���, �����, �����ڵ�, �޿�, �μ��� ��ȸ�� �� �� ������ ��� ���
*/

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    JCODE EMPLOYEE.JOB_CODE%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY, DEPT_TITLE
    INTO EID, ENAME, JCODE, SAL, DTITLE
    FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_ID = DEPT_CODE)
    WHERE EMP_ID = &���;
    
    DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('JCODE : ' || JCODE);
    DBMS_OUTPUT.PUT_LINE('SAL : ' || SAL);
    DBMS_OUTPUT.PUT_LINE('DTITLE : ' || DTITLE);
END;
/
--------------------------------------------------------------------------------
-- 1_3) ROWŸ�� ���� ����
-- ���̺��� �� �࿡ ���� ��� �÷����� �Ѳ����� ���� �� �ִ� ����
-- [ǥ����] ������ ���̺��%ROWTYPE;

DECLARE
    E EMPLOYEE%ROWTYPE;
BEGIN
    SELECT * -- ��� �÷��� �ش��ϴ� ���� �־����
    INTO E
    FROM EMPLOYEE
    WHERE EMP_ID = &���;
    
    -- DBMS_OUTPUT.PUT_LINE(E);  / �̰� �ȵ�
    DBMS_OUTPUT.PUT_LINE('����� : ' || E.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('�޿� : ' || E.SALARY);
    DBMS_OUTPUT.PUT_LINE('���ʽ� : ' || NVL(E.BONUS, 0));
END;
/
--------------------------------------------------------------------------------
/*
    2. BEGIN �����
*/

-- < ���ǹ� >
-- 1) IF ���ǽ� THEN ���೻�� END IF; (�ܵ� IF��)

-- ��� �Է¹��� �� �ش� ����� ���, �̸�, �޿�, ���ʽ��� ���
-- �� ���ʽ��� ���� �ʴ� ����� ���ʽ��� ��� �� '���ʽ��� ���޹��� �ʴ� ����Դϴ�.' ���
DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS, 0)
    INTO EID, ENAME, SALARY, BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = &���;
    
    DBMS_OUTPUT.PUT_LINE('��� : ' || EID);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('�޿� : ' || SALARY);
    
    IF BONUS = 0 
        THEN DBMS_OUTPUT.PUT_LINE('���ʽ��� ���޹��� �ʴ� ����Դϴ�.');
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('���ʽ��� : ' || BONUS * 100 || '%');
END;
/

-- 2) IF ���ǽ� THEN ���೻�� ELSE ���೻�� END IF; (IF~ELSE��)
DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS, 0)
    INTO EID, ENAME, SALARY, BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = &���;
    
    DBMS_OUTPUT.PUT_LINE('��� : ' || EID);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('�޿� : ' || SALARY);
    
    IF BONUS = 0 
        THEN DBMS_OUTPUT.PUT_LINE('���ʽ��� ���޹��� �ʴ� ����Դϴ�.');
    ELSE 
         DBMS_OUTPUT.PUT_LINE('���ʽ��� : ' || BONUS * 100 || '%');
    END IF;
END;
/
------------------------------------ �ǽ����� -----------------------------------
-- ���۷��� Ÿ�� ���� (EID, ENAME, DTITLE, NCODE)
-- ������ ���̺� EMPLOYEE, DEPARTMENT, LOCATION

-- �Ϲ�Ÿ�� ���� (TEAM ������(10) <= '������' �Ǵ� '�ؿ���" ���� ����
-- ����ڰ� �Է��� ����� ����� ���, �̸�, �μ���, �ٹ������ڵ� ��ȸ �� �� ������ ����
-- NCODE�� ���� KO�� ��� => TEAM�� '������'
--             �ƴ� ��� => TEAM�� '�ؿ���'
-- ���, �̸�, �μ�, �Ҽӿ� ���� ���

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
    NCODE LOCATION.NATIONAL_CODE%TYPE;
    TEAM VARCHAR2(10);
BEGIN
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE
    INTO EID, ENAME, DTITLE, NCODE
    FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_ID = DEPT_CODE)
    JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
    WHERE EMP_ID = &���;
    
    IF NCODE = 'KO'
        THEN  TEAM := '������';
    ELSE 
        TEAM := '�ؿ���';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('��� : ' || EID);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('�μ��� : ' || DTITLE);
    DBMS_OUTPUT.PUT_LINE('�Ҽ� : ' || TEAM);
END;
/
----------------------------------- �ǽ����� -------------------------------------
-- ����� ������ ���ϴ� PLSQL �� �ۼ�, ���ʽ��� �ִ� ����� ���ʽ��� �����Ͽ� ���
-- ���ʽ��� ������ ���ʽ� ������ ����, ������ ���ʽ� ���� ����
-- �޿� �̸� ���޷�(\999,999,999)

DECLARE
    EMP EMPLOYEE%ROWTYPE;
    SALARY NUMBER; -- ���� 
BEGIN
    SELECT * 
    INTO EMP
    FROM EMPLOYEE
    WHERE EMP_ID = &���;
    
    IF (EMP.BONUS IS NULL)
        THEN SALARY := EMP.SALARY * 12;
    ELSE 
        SALARY := (EMP.SALARY + (EMP.SALARY * EMP.BONUS)) * 12;
    END IF;
    
    DBMS_OUTPUT.PUT_LINE(EMP.SALARY || ' ' || EMP.EMP_NAME || ' ' 
    || TO_CHAR(SALARY, 'L999,999,999'));   
END;
/
--------------------------------------------------------------------------------
-- 3) IF ���ǽ�1 THEN ���೻��1 ELSIF ���ǽ�2 THEN ���೻��2 ELSE .... END IF; (IF~ELSEIF~ELSE��)

-- ���� �Է¹޾� SCORE ������ ����
-- 90�� �̻��� 'A', 80�� �̻��� 'B', 70�� �̻��� 'C', 60�� �̻� 'D', 60�̸��� 'F'
-- GRADE ������ ����
-- ����� ������ XX���̰� ������ X�����Դϴ�

DECLARE 
    SCORE NUMBER;
    GRADE CHAR(3);
BEGIN 
    SCORE := &����;
    
    IF SCORE >= 90
        THEN GRADE := 'A';
    ELSIF SCORE >= 80
        THEN GRADE := 'B';
    ELSIF SCORE >= 70
        THEN GRADE := 'C';
    ELSIF SCORE >= 60
        THEN GRADE := 'D';
    ELSE
        GRADE := 'F';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('����� ������ ' || SCORE || '���̰�, ������ ' ||
    GRADE || '�����Դϴ�.');
END;
/

-- �޿�
-- 500���� �̻��̸� '���'
-- 300���� �̻��̸� '�߱�'
-- 300���� �̸��̸� '�ʱ�'
-- �ش� ����� �޿� ����� XX�Դϴ�.

DECLARE
    SAL EMPLOYEE.SALARY%TYPE;
    GRADE VARCHAR2(10); -- �޿� ���
    
BEGIN
    SELECT SALARY
    INTO SAL
    FROM EMPLOYEE
    WHERE EMP_ID = &���;
    
    IF SAL >= 5000000
        THEN GRADE := '���';
    ELSIF SAL >= 3000000
        THEN GRADE := '�߱�';
    ELSE 
        GRADE := '�ʱ�';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('�ش� ����� �޿��� ' || SAL || '���̰�, ����� '  || GRADE || '�Դϴ�.');
END;
/
--------------------------------------------------------------------------------
-- 4) CASE �񱳴���� WHEN ������Ұ�1 THEN �����1 WHEN �񱳰�2 THEN �����2 .... ELSE ����� END;

DECLARE
    EMP EMPLOYEE%ROWTYPE;
    DNAME VARCHAR2(30); -- �μ��� ���� ����
BEGIN
    SELECT *
    INTO EMP
    FROM EMPLOYEE
    WHERE EMP_ID = &���;
    
    DNAME := CASE EMP.DEPT_CODE 
                WHEN 'D1' THEN '�λ���'
                WHEN 'D2' THEN 'ȸ����'
                WHEN 'D3' THEN '��������'
                WHEN 'D4' THEN '����������'
                WHEN 'D9' THEN '�ѹ���'
                ELSE '�ؿܿ�����'
            END;
            
    DBMS_OUTPUT.PUT_LINE(EMP.EMP_NAME || '��(��) ' || DNAME || '�Դϴ�.');
END;
/