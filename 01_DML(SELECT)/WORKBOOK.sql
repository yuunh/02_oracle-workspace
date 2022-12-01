-- ���� ����

-- 1. �� ������б��� �а� �̸��� �迭�� ǥ���Ͻÿ�. ��, ��� ����� "�а� ��", "�迭"���� ǥ���ϵ��� �Ѵ�.
SELECT DEPARTMENT_NAME AS "�а� ��", CATEGORY AS "�迭"
FROM TB_DEPARTMENT;

-- 2. �а��� �а� ������ ������ ���� ���·� ȭ�鿡 ����Ѵ�.
SELECT DEPARTMENT_NAME || '�� ������ ' || CAPACITY || ' �� �Դϴ�.' AS "�а��� ����"
FROM TB_DEPARTMENT;

-- 3. "������а�" �� �ٴϴ� ���л� �� ���� �������� ���л��� ã�ƴ޶�� ��û�� ���Դ�. �����ΰ�? 
--    (�����а��� '�а��ڵ�'�� �а� ���̺�(TB_DEPARTMENT)�� ��ȸ�ؼ� ã�� ������ ����)
SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE DEPARTMENT_NO = '001' AND SUBSTR(STUDENT_SSN, 8, 1) IN ('2', '4')
      AND ABSENCE_YN = 'Y';

-- 4. ���������� ���� ���� ��� ��ü�ڵ��� ã�� �̸��� �Խ��ϰ��� �Ѵ�. 
--    �� ����ڵ��� �й��� ������ ���� �� ����ڵ��� ã�� ������ SQL ������ �ۼ��Ͻÿ�.
--    A513079, A513090, A513091, A513110, A513119
SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE STUDENT_NO IN ('A513079', 'A513090', 'A513091', 'A513110', 'A513119')
ORDER BY STUDENT_NO DESC;

-- 5. ���������� 20 �� �̻� 30 �� ������ �а����� �а� �̸��� �迭�� ����Ͻÿ�.
SELECT DEPARTMENT_NAME, CATEGORY
FROM TB_DEPARTMENT
WHERE CAPACITY BETWEEN  20 AND  30;

-- 6. �� ������б��� ������ �����ϰ� ��� �������� �Ҽ� �а��� ������ �ִ�. 
--    �׷� �� ������б� ������ �̸��� �˾Ƴ� �� �ִ� SQL ������ �ۼ��Ͻÿ�.
SELECT PROFESSOR_NAME
FROM TB_PROFESSOR
WHERE DEPARTMENT_NO IS NULL;

-- 7. Ȥ�� ������� ������ �а��� �����Ǿ� ���� ���� �л��� �ִ��� Ȯ���ϰ��� �Ѵ�. 
--    ��� SQL ������ ����ϸ� �� ������ �ۼ��Ͻÿ�.
SELECT *
FROM TB_STUDENT
WHERE DEPARTMENT_NO IS NULL;

-- 8. ������û�� �Ϸ��� �Ѵ�. �������� ���θ� Ȯ���ؾ� �ϴµ�, 
--    ���������� �����ϴ� ������� � �������� �����ȣ�� ��ȸ�غ��ÿ�.
SELECT CLASS_NO
FROM TB_CLASS
WHERE PREATTENDING_CLASS_NO IS NOT NULL;

-- 9. �� ���п��� � �迭(CATEGORY)���� �ִ��� ��ȸ�غ��ÿ�.
SELECT DISTINCT CATEGORY
FROM TB_DEPARTMENT
ORDER BY CATEGORY;

-- 10. 02 �й� ���� �����ڵ��� ������ ������� �Ѵ�. ������ ������� ������ ��������
--     �л����� �й�, �̸�, �ֹι�ȣ�� ����ϴ� ������ �ۼ��Ͻÿ�.
SELECT STUDENT_NO, STUDENT_NAME, STUDENT_SSN
FROM TB_STUDENT
WHERE SUBSTR(STUDENT_NO, 2, 1) = 2 AND STUDENT_ADDRESS LIKE '%����%'
      AND ABSENCE_YN = 'N'
ORDER BY STUDENT_NAME;

--------------------------------------------------------------------------------
-- 1. ������а�(�а��ڵ� 002) �л����� �й��� �̸�, ���� �⵵�� ���� �⵵�� ���� ������ ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
--    ( ��, ����� "�й�", "�̸�", "���г⵵" �� ǥ�õǵ��� �Ѵ�.)
SELECT STUDENT_NO AS "�й�", STUDENT_NAME AS "�̸�", TO_CHAR(ENTRANCE_DATE,'YYYY-MM-DD') AS "���г⵵"
FROM TB_STUDENT
WHERE DEPARTMENT_NO = 002
ORDER BY ENTRANCE_DATE;

-- 2. �� ������б��� ���� �� �̸��� �� ���ڰ� �ƴ� ������ �� �� �ִٰ� �Ѵ�. �� ������ �̸��� �ֹι�ȣ�� ȭ�鿡 ����ϴ� SQL ������ �ۼ��� ����. 
-- (* �̶� �ùٸ��� �ۼ��� SQL ������ ��� ���� ����� �ٸ��� ���� �� �ִ�. ������ �������� �����غ� ��)
SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR
WHERE PROFESSOR_NAME NOT LIKE '___';

-- 3. �� ������б��� ���� �������� �̸��� ���̸� ����ϴ� SQL ������ �ۼ��Ͻÿ�. 
--    �� �̶� ���̰� ���� ������� ���� ��� ������ ȭ�鿡 ��µǵ��� ����ÿ�. 
--    (��, ���� �� 2000 �� ���� ����ڴ� ������ ��� ����� "�����̸�", "����"�� �Ѵ�. ���̴� ���������� ����Ѵ�.)
SELECT PROFESSOR_NAME AS "�����̸�", EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM TO_DATE( 19 || SUBSTR(PROFESSOR_SSN, 1, 6), 'RRMMDD')) AS "����"
FROM TB_PROFESSOR
WHERE SUBSTR(PROFESSOR_SSN, 8, 1) = '1'
ORDER BY "����";

-- 4. �������� �̸� �� ���� ������ �̸��� ����ϴ� SQL ������ �ۼ��Ͻÿ�. 
--    ��� ����� "�̸�" �� �������� �Ѵ�. (���� 2 ���� ���� ������ ���ٰ� �����Ͻÿ�)
SELECT SUBSTR(PROFESSOR_NAME, 2) AS "�̸�"
FROM TB_PROFESSOR;

-- 5. �� ������б��� ����� �����ڸ� ���Ϸ��� �Ѵ�. ��� ã�Ƴ� ���ΰ�? 
--    �̶�, 19 �쿡 �����ϸ� ����� ���� ���� ������ �����Ѵ�.
SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
WHERE (TO_CHAR(ENTRANCE_DATE, 'YYYY') - TO_CHAR('19' || SUBSTR(STUDENT_SSN, 1, 2))) > '19';

-- 6. 2020 �� ũ���������� ���� �����ΰ�?
SELECT  TO_CHAR(TO_DATE(20201225), 'DAY')
FROM DUAL;

-- 7. TO_DATE('99/10/11','YY/MM/DD'), TO_DATE('49/10/11','YY/MM/DD') �� ���� �� �� �� �� �� ���� �ǹ��ұ�? 
--    �� TO_DATE('99/10/11','RR/MM/DD'), TO_DATE('49/10/11','RR/MM/DD') �� ���� �� �� �� �� �� ���� �ǹ��ұ�?
SELECT TO_CHAR(TO_DATE('99/10/11','YY/MM/DD'), 'YYYY"��" MM"��" DD"��"'),
       TO_CHAR(TO_DATE('49/10/11','YY/MM/DD'), 'YYYY"��" MM"��" DD"��"'),
       TO_CHAR(TO_DATE('99/10/11','RR/MM/DD'), 'YYYY"��" MM"��" DD"��"'),
       TO_CHAR(TO_DATE('49/10/11','RR/MM/DD'), 'YYYY"��" MM"��" DD"��"')
FROM DUAL;

-- 8. �� ������б��� 2000 �⵵ ���� �����ڵ��� �й��� A �� �����ϰ� �Ǿ��ִ�. 
--    2000 �⵵ ���� �й��� ���� �л����� �й��� �̸��� �����ִ� SQL ������ �ۼ��Ͻÿ�.
SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
WHERE NOT STUDENT_NO LIKE 'A%';

-- 9. �й��� A517178 �� �ѾƸ� �л��� ���� �� ������ ���ϴ� SQL ���� �ۼ��Ͻÿ�. 
--    ��, �̶� ��� ȭ���� ����� "����" �̶�� ������ �ϰ�, ������ �ݿø��Ͽ� �Ҽ��� ���� ���ڸ������� ǥ���Ѵ�.
SELECT ROUND(AVG(POINT), 1) AS "����"
FROM TB_GRADE
WHERE STUDENT_NO = 'A517178';

-- 10. �а��� �л����� ���Ͽ� "�а���ȣ", "�л���(��)" �� ���·� ����� ����� ������� ��µǵ��� �Ͻÿ�.
SELECT DEPARTMENT_NO AS "�а���ȣ", COUNT(*) AS "�л���(��)"
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY DEPARTMENT_NO;

-- 11. ���� ������ �������� ���� �л��� ���� �� �� ���� �Ǵ� �˾Ƴ��� SQL ���� �ۼ��Ͻÿ�.
SELECT COUNT(*)
FROM TB_STUDENT
WHERE COACH_PROFESSOR_NO IS NULL;

-- 12. �й��� A112113 �� ���� �л��� �⵵ �� ������ ���ϴ� SQL ���� �ۼ��Ͻÿ�. 
--     ��, �̶� ��� ȭ���� ����� "�⵵", "�⵵ �� ����" �̶�� ������ �ϰ�, 
--     ������ �ݿø��Ͽ� �Ҽ��� ���� �� �ڸ������� ǥ���Ѵ�.
SELECT SUBSTR(TERM_NO, 1, 4) AS "�⵵", ROUND(AVG(POINT), 1) AS "�⵵ �� ����"
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY SUBSTR(TERM_NO, 1, 4)
ORDER BY 1;

-- 13. �а� �� ���л� ���� �ľ��ϰ��� �Ѵ�. �а� ��ȣ�� ���л� ���� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
SELECT DEPARTMENT_NO AS "�а��ڵ��", COUNT(*) AS "���л� ��"
FROM TB_STUDENT
WHERE ABSENCE_YN = 'Y'
GROUP BY DEPARTMENT_NO
HAVING COUNT(*)
ORDER BY DEPARTMENT_NO;

SELECT DEPARTMENT_NO AS "�а��ڵ��", COUNT(*) AS "���л� ��"
--DECODE(ABSENCE_YN, 'Y', 'aa', 'N', 'bb')
FROM TB_STUDENT
--WHERE ABSENCE_YN = 'Y'
WHERE CASE WHEN ABSENCE_YN = 'Y' THEN COUNT(*) = 1
           ELSE COUNT(*) != 1
           END
GROUP BY DEPARTMENT_NO
ORDER BY DEPARTMENT_NO;


SELECT DEPARTMENT_NO, COUNT(*) AS "���л� ��"
FROM TB_STUDENT
WHERE ABSENCE_YN = 'Y'
ORDER BY DEPARTMENT_NO;

-- 14. �� ���б��� �ٴϴ� ��������(��٣���) �л����� �̸��� ã���� �Ѵ�. 
--     � SQL ������ ����ϸ� �����ϰڴ°�?
SELECT STUDENT_NAME AS "�����̸�", COUNT(*) AS "������ ��"
FROM TB_STUDENT
GROUP BY STUDENT_NAME
HAVING COUNT(*) != 1
ORDER BY 1;

-- 15. �й��� A112113 �� ���� �л��� �⵵, �б� �� ������ �⵵ �� ���� ���� , 
--     �� ������ ���ϴ� SQL ���� �ۼ��Ͻÿ�. 
--     (��, ������ �Ҽ��� 1 �ڸ������� �ݿø��Ͽ� ǥ���Ѵ�.)
SELECT TO_CHAR(ENTRANCE_DATE, 'YYYY') AS "�⵵", TO_CHAR(ENTRANCE_DATE, 'DD') AS "�б�"
FROM TB_STUDENT
WHERE STUDENT_NO = 'A112113';

SELECT ROUND(AVG(POINT), 1)
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113';

SELECT *
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113';

--------------------------------------------------------------------------------
-- 1. �л��̸��� �ּ����� ǥ���Ͻÿ�. ��, ��� ����� "�л� �̸�", "�ּ���"�� �ϰ�,
--    ������ �̸����� �������� ǥ���ϵ��� �Ѵ�.
SELECT STUDENT_NAME AS "�л� �̸�", STUDENT_ADDRESS AS "�ּ���"
FROM TB_STUDENT
ORDER BY 1;

-- 2. �������� �л����� �̸��� �ֹι�ȣ�� ���̰� ���� ������ ȭ�鿡 ����Ͻÿ�.
SELECT STUDENT_NAME, STUDENT_SSN
FROM TB_STUDENT
WHERE ABSENCE_YN = 'Y'
ORDER BY 2 DESC;

-- 3. �ּ����� �������� ��⵵�� �л��� �� 1900 ��� �й��� ���� 
--    �л����� �̸��� �й�, �ּҸ� �̸��� ������������ ȭ�鿡 ����Ͻÿ�. 
--    ��, ���������� "�л��̸�","�й�", "������ �ּ�" �� ��µǵ��� �Ѵ�.
SELECT STUDENT_NAME AS "�л��̸�", STUDENT_NO AS "�й�", STUDENT_ADDRESS AS "������ �ּ�"
FROM TB_STUDENT
WHERE STUDENT_NO LIKE '9%' 
AND STUDENT_ADDRESS LIKE '%��⵵%' OR STUDENT_ADDRESS LIKE '%������%'
ORDER BY STUDENT_NAME;

-- 4. ���� ���а� ���� �� ���� ���̰� ���� ������� �̸��� Ȯ���� �� �ִ� SQL ������ �ۼ��Ͻÿ�. 
--    (���а��� '�а��ڵ�'�� �а� ���̺�(TB_DEPARTMENT)�� ��ȸ�ؼ� ã�� ������ ����)
SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR
WHERE DEPARTMENT_NO = '005'
ORDER BY PROFESSOR_SSN;

-- 5. 2004 �� 2 �б⿡ 'C3118100' ������ ������ �л����� ������ ��ȸ�Ϸ��� �Ѵ�. 
--    ������ ���� �л����� ǥ���ϰ�, ������ ������ �й��� ���� �л����� ǥ���ϴ� ������ �ۼ��غ��ÿ�.
SELECT STUDENT_NO, POINT
FROM TB_GRADE
WHERE CLASS_NO = 'C3118100';
--GROUP BY STUDENT_NO;
--ORDER BY 2 DESC;

-- 6. �л� ��ȣ, �л� �̸�, �а� �̸��� �л� �̸����� �������� �����Ͽ� ����ϴ� SQL ���� �ۼ��Ͻÿ�.
SELECT STUDENT_NO, STUDENT_NAME, DEPARTMENT_NAME
FROM TB_STUDENT
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
ORDER BY SUBSTR(STUDENT_NAME, 2);

-- 7. �� ������б��� ���� �̸��� ������ �а� �̸��� ����ϴ� SQL ������ �ۼ��Ͻÿ�.
SELECT CLASS_NAME, DEPARTMENT_NAME
FROM TB_CLASS
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
ORDER BY DEPARTMENT_NO;

-- 8. ���� ���� �̸��� ã������ �Ѵ�. ���� �̸��� ���� �̸��� ����ϴ� SQL ���� �ۼ��Ͻÿ�.
SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_CLASS
JOIN TB_PROFESSOR USING (DEPARTMENT_NO)
GROUP BY CLASS_NAME;

-- 9. 8 ���� ��� �� ���ι���ȸ�� �迭�� ���� ������ ���� �̸��� ã������ �Ѵ�. 
-- �̿� �ش��ϴ� ���� �̸��� ���� �̸��� ����ϴ� SQL ���� �ۼ��Ͻÿ�.
SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_CLASS
JOIN TB_PROFESSOR USING (DEPARTMENT_NO)
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
WHERE CATEGORY = '�ι���ȸ';

-- 10. �������а��� �л����� ������ ���Ϸ��� �Ѵ�. 
--     �����а� �л����� "�й�", "�л� �̸�", "��ü ����"�� ����ϴ� SQL ������ �ۼ��Ͻÿ�. 
--     (��, ������ �Ҽ��� 1 , �ڸ������� �ݿø��Ͽ� ǥ���Ѵ�.)
SELECT STUDENT_NO AS "�й�", STUDENT_NAME AS "�л� �̸�", ROUND(POINT, 1) AS "��ü ����"
FROM TB_STUDENT
JOIN TB_GRADE USING (STUDENT_NO)
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
WHERE DEPARTMENT_NAME = '�����а�';

-- 11. �й��� A313047 �� �л��� �б��� ������ ���� �ʴ�. 
--     ���� �������� ������ �����ϱ� ���� �а� �̸�, �л� �̸��� ���� ���� �̸��� �ʿ��ϴ�. 
--     �̶� ����� SQL ���� �ۼ��Ͻÿ�. 
--     ��, �������� ?�а��̸�?, ?�л��̸�?, ?���������̸�?���� ��µǵ��� �Ѵ�.
SELECT DEPARTMENT_NAME AS "�а��̸�", STUDENT_NAME AS "�л��̸�", PROFESSOR_NAME AS "���������̸�"
FROM TB_STUDENT
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
JOIN TB_PROFESSOR ON (COACH_PROFESSOR_NO = PROFESSOR_NO)
WHERE STUDENT_NO = 'A313047';

-- 12. 2007 �⵵�� '�ΰ������' ������ ������ �л��� ã�� �л��̸��� �����б⸧ ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
SELECT STUDENT_NAME, TERM_NO
FROM TB_STUDENT
JOIN TB_GRADE USING (STUDENT_NO)
JOIN TB_CLASS USING (DEPARTMENT_NO)
WHERE CLASS_NAME = '�ΰ������' AND TERM_NO LIKE '2007%'
ORDER BY 1;

SELECT *
FROM TB_CLASS
ORDER BY 4;

SELECT *
FROM TB_GRADE
WHERE STUDENT_NO = 'A431348';-- AND CLASS_NO = 'C2604100';

-- 13. ��ü�� �迭 ���� �� ���� ��米���� �� �� �������� ���� ������ ã�� 
--     �� ���� �̸��� �а� �̸��� ����ϴ� SQL ������ �ۼ��Ͻÿ�.
SELECT CLASS_NAME, DEPARTMENT_NAME
FROM TB_CLASS
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
JOIN TB_STUDENT USING (DEPARTMENT_NO)
WHERE CATEGORY = '��ü��' AND COACH_PROFESSOR_NO IS NULL
ORDER BY 1;

SELECT *
FROM TB_DEPARTMENT
WHERE CATEGORY = '��ü��';
GROUP BY CATEGORY;

-- 14. �� ������б� ���ݾƾ��а� �л����� ���������� �Խ��ϰ��� �Ѵ�. 
--     �л��̸��� �������� �̸��� ã�� ���� ���� ������ ���� �л��� ��� 
--     "�������� ������?���� ǥ���ϵ��� �ϴ� SQL ���� �ۼ��Ͻÿ�.  
--     ��, �������� ?�л��̸�?, ?��������?�� ǥ���ϸ� ���й� �л��� ���� ǥ�õǵ��� �Ѵ�.
SELECT STUDENT_NAME AS "�л��̸�", NVL(PROFESSOR_NAME, '�������� ������') AS "��������"
FROM TB_STUDENT
JOIN TB_PROFESSOR USING (DEPARTMENT_NO)
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
WHERE DEPARTMENT_NAME = '���ݾƾ��а�'
ORDER BY DEPARTMENT_NO;

-- 15. ���л��� �ƴ� �л� �� ������ 4.0 �̻��� �л��� ã�� 
--     �� �л��� �й�, �̸�, �а� �̸�, ������ ����ϴ� SQL ���� �ۼ��Ͻÿ�.
SELECT STUDENT_NO AS "�й�", STUDENT_NAME AS "�̸�", DEPARTMENT_NAME AS "�а� �̸�", AVG(POINT) AS "����"
FROM TB_STUDENT
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO);
JOIN TB_GRADE USING (STUDENT_NO);

-- 16. ȯ�������а� ����������� ���� �� ������ �ľ��� �� �ִ� SQL ���� �ۼ��Ͻÿ�.
SELECT CLASS_NO, CLASS_NAME
FROM TB_CLASS
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
WHERE DEPARTMENT_NAME = 'ȯ�������а�' -- AND CLASS_TYPE LINE '%����%';
ORDER BY 1;

SELECT DEPARTMENT_NAME
FROM TB_DEPARTMENT;

-- 17. �� ������б��� �ٴϰ� �ִ� �ְ��� �л��� ���� �� �л����� �̸��� �ּҸ� ����ϴ� SQL ���� �ۼ��Ͻÿ�.
SELECT STUDENT_NAME, STUDENT_ADDRESS
FROM TB_STUDENT;

-- 18. ������а����� �� ������ ���� ���� �л��� �̸��� �й��� ǥ���ϴ� SQL ���� �ۼ��Ͻÿ�.
SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT;

-- 19. �� ������б��� "ȯ�������а�"�� ���� ���� �迭 �а����� 
--     �а� �� �������� ������ �ľ��ϱ� ���� ������ SQL ���� ã�Ƴ��ÿ�. 
--     ��, �������� "�迭 �а���", "��������"���� ǥ�õǵ��� �ϰ�, 
--     ������ �Ҽ��� �� �ڸ������� �ݿø��Ͽ� ǥ�õǵ��� �Ѵ�.
 

