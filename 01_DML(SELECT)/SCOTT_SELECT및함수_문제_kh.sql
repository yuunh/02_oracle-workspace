-- ���� ����

--1. EMP���̺��� COMM �� ���� NULL�� �ƴ� ���� ��ȸ
SELECT *
FROM EMP
WHERE COMM IS NOT NULL;

--2. EMP���̺��� Ŀ�̼��� ���� ���ϴ� ���� ��ȸ
SELECT ENAME
FROM EMP
WHERE COMM IS NULL;

--3. EMP���̺��� �����ڰ� ���� ���� ���� ��ȸ
SELECT *
FROM EMP
WHERE MGR IS NULL;

--4. EMP���̺��� �޿��� ���� �޴� ���� ������ ��ȸ
SELECT *
FROM EMP
ORDER BY SAL DESC;

--5. EMP���̺��� �޿��� ���� ��� Ŀ�̼��� �������� ���� ��ȸ
SELECT *
FROM EMP
ORDER BY SAL DESC, COMM DESC;

--6. EMP���̺��� �����ȣ, �����,����, �Ի��� ��ȸ (��, �Ի����� �������� ���� ó��)
SELECT EMPNO, ENAME, JOB, HIREDATE
FROM EMP
ORDER BY 4;

--7. EMP���̺��� �����ȣ, ����� ��ȸ (�����ȣ ���� �������� ����)
SELECT EMPNO, ENAME
FROM EMP
ORDER BY 1 DESC;

--8. EMP���̺��� ���, �Ի���, �����, �޿� ��ȸ
-- (�μ���ȣ�� ���� ������, ���� �μ���ȣ�� ���� �ֱ� �Ի��� ������ ó��)
SELECT EMPNO, HIREDATE, ENAME, SAL
FROM EMP
ORDER BY DEPTNO, HIREDATE;

--9. ���� ��¥�� ���� ���� ��ȸ
SELECT SYSDATE
FROM DUAL;

--10. EMP���̺��� ���, �����, �޿� ��ȸ
-- (��, �޿��� 100���������� ���� ��� ó���ϰ� �޿� ���� �������� ����)
SELECT EMPNO, ENAME, TRUNC(SAL, -2)
FROM EMP
ORDER BY 3 DESC;

--11. EMP���̺��� �����ȣ�� Ȧ���� ������� ��ȸ
SELECT *
FROM EMP
WHERE MOD(EMPNO, 2) = 1;

--12. EMP���̺��� �����, �Ի��� ��ȸ (��, �Ի����� �⵵�� ���� �и� �����ؼ� ���)
SELECT ENAME, 
EXTRACT(YEAR FROM HIREDATE) || '��' AS "�Ի�⵵", 
EXTRACT(MONTH FROM HIREDATE) || '��' AS "�Ի��"
FROM EMP;

--13. EMP���̺��� 9���� �Ի��� ������ ���� ��ȸ
SELECT *
FROM EMP
WHERE EXTRACT(MONTH FROM HIREDATE) = 9;

--14. EMP���̺��� 81�⵵�� �Ի��� ���� ��ȸ
SELECT *
FROM EMP
WHERE EXTRACT(YEAR FROM HIREDATE) = 1981;

--15. EMP���̺��� �̸��� 'E'�� ������ ���� ��ȸ
SELECT *
FROM EMP
WHERE ENAME LIKE '%E';

--16. EMP���̺��� �̸��� �� ��° ���ڰ� 'R'�� ������ ���� ��ȸ 
--16-1. LIKE ���
SELECT *
FROM EMP
WHERE ENAME LIKE '__R%';

--16-2. SUBSTR() �Լ� ���
SELECT *
FROM EMP
WHERE SUBSTR(ENAME, 3, 1) = 'R';

--17. EMP���̺��� ���, �����, �Ի���, �Ի��Ϸκ��� 40�� �Ǵ� ��¥ ��ȸ
SELECT EMPNO, ENAME, HIREDATE, ADD_MONTHS(HIREDATE, 480)
FROM EMP;

--18. EMP���̺��� �Ի��Ϸκ��� 38�� �̻� �ٹ��� ������ ���� ��ȸ
SELECT *
FROM EMP
WHERE EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIREDATE) >= 38;

--19. ���� ��¥���� �⵵�� ����
SELECT EXTRACT(YEAR FROM SYSDATE)
FROM DUAL;