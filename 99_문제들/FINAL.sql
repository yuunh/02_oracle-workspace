-- ���� ����

-- 3. �������� 25�� �̻��� å ��ȣ�� �������� ȭ�鿡 ����ϴ� SQL ���� �ۼ��Ͻÿ�.
SELECT BOOK_NO, BOOK_NM
FROM TB_BOOK
WHERE LENGTH(BOOK_NM) >= 25;

-- 4. �޴��� ��ȣ�� ��019���� �����ϴ� �达 ���� ���� �۰��� �̸������� �������� �� 
-- ���� ���� ǥ�õǴ� �۰� �̸��� �繫�� ��ȭ��ȣ, �� ��ȭ��ȣ, �޴��� ��ȭ��ȣ�� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
SELECT WRITER_NM, OFFICE_TELNO, HOME_TELNO, MOBILE_NO
FROM (SELECT WRITER_NM, OFFICE_TELNO, HOME_TELNO, MOBILE_NO
        FROM TB_WRITER
        WHERE MOBILE_NO LIKE '019%' AND WRITER_NM LIKE '��%'
        ORDER BY 1)
WHERE ROWNUM = 1;

-- 5. ���� ���°� ���ű衱�� �ش��ϴ� �۰����� �� �� ������ ����ϴ� SQL ������ �ۼ��Ͻÿ�. 
-- (��� ����� ���۰�(��)������ ǥ�õǵ��� �� ��)
SELECT COUNT(DISTINCT WRITER_NO) AS "�۰�(��)"
FROM TB_BOOK_AUTHOR
WHERE COMPOSE_TYPE LIKE '%�ű�%';

-- 6. 300�� �̻� ��ϵ� ������ ���� ���� �� ��ϵ� ���� ������ ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
-- (���� ���°� ��ϵ��� ���� ���� ������ ��)
SELECT COMPOSE_TYPE, COUNT(*)
FROM TB_BOOK_AUTHOR
GROUP BY COMPOSE_TYPE
HAVING COUNT(*) >= 300 AND COMPOSE_TYPE IS NOT NULL;

-- 7. ���� �ֱٿ� �߰��� �ֽ��� �̸��� ��������, ���ǻ� �̸��� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
SELECT BOOK_NM, ISSUE_DATE, PUBLISHER_NM
FROM (SELECT BOOK_NM, ISSUE_DATE, PUBLISHER_NM
        FROM TB_BOOK
        ORDER BY ISSUE_DATE DESC)
WHERE ROWNUM = 1;

-- 8. ���� ���� å�� �� �۰� 3���� �̸��� ������ ǥ���ϵ�, ���� �� ������� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
-- ��, ��������(��٣���) �۰��� ���ٰ� �����Ѵ�. (��� ����� ���۰� �̸���, ���� ������ ǥ�õǵ��� �Ұ�)
SELECT *
FROM (SELECT WRITER_NM AS "�۰� �̸�", COUNT(*) AS "�� ��"
        FROM TB_WRITER TW, TB_BOOK_AUTHOR TBA
        WHERE TW.WRITER_NO = TBA.WRITER_NO
        GROUP BY WRITER_NM
        ORDER BY 2 DESC) W
WHERE ROWNUM <= 3; 

-- 9. �۰� ���� ���̺��� ��� ������� �׸��� �����Ǿ� �ִ� �� �߰��Ͽ���. 
-- ������ ������� ���� �� �۰��� ������ ���ǵ����� �����ϰ� ������ ��¥���� �����Ű�� SQL ������ �ۼ��Ͻÿ�. (COMMIT ó���� ��)
UPDATE TB_WRITER
SET REGIST_DATE = (SELECT MIN(ISSUE_DATE)
                    FROM TB_BOOK 
                    JOIN TB_BOOK_AUTHOR USING (BOOK_NO)
                    WHERE ;
                    
UPDATE TB_WRITER A --1
SET    REGIST_DATE = (SELECT MIN(ISSUE_DATE) --4 SET �ϴ°� 5��
                       FROM   TB_BOOK_AUTHOR  --2
                       JOIN   TB_BOOK USING (BOOK_NO)
                       WHERE  A.WRITER_NO = WRITER_NO;  --3
-- 10. ���� �������� ���� ���̺��� ������ �������� ���� ���� �����ϰ� �ִ�. �����δ� �������� ���� �����Ϸ��� �Ѵ�. 
-- ���õ� ���뿡 �°� ��TB_BOOK_ TRANSLATOR�� ���̺��� �����ϴ� SQL ������ �ۼ��Ͻÿ�. 
-- (Primary Key ���� ���� �̸��� ��PK_BOOK_TRANSLATOR���� �ϰ�, 
-- Reference ���� ���� �̸��� ��FK_BOOK_TRANSLATOR_01��, ��FK_BOOK_TRANSLATOR_02���� �� ��)
CREATE TABLE TB_BOOK_TRANSLATOR(
    BOOK_NO VARCHAR2(10) CONSTRAINT FK_BOOK_TRANSLATOR_01 REFERENCES TB_BOOK NOT NULL,
    WRITER_NO VARCHAR2(10) CONSTRAINT FK_BOOK_TRANSLATOR_02 REFERENCES TB_WRITER NOT NULL,
    TRANS_LANG VARCHAR2(60), 
    CONSTRAINT PK_BOOK_TRANSLATOR PRIMARY KEY(BOOK_NO, WRITER_NO)
);

-- 11. ���� ���� ����(compose_type)�� '�ű�', '����', '��', '����'�� �ش��ϴ� �����ʹ�
-- ���� ���� ���� ���̺��� ���� ���� ���� ���̺�(TB_BOOK_ TRANSLATOR)�� �ű�� SQL ������ �ۼ��Ͻÿ�. 
-- ��, ��TRANS_LANG�� �÷��� NULL ���·� �ε��� �Ѵ�. 
-- (�̵��� �����ʹ� �� �̻� TB_BOOK_AUTHOR ���̺� ���� ���� �ʵ��� ������ ��)
INSERT INTO TB_BOOK_TRANSLATOR (BOOK_NO, WRITER_NO)
(SELECT BOOK_NO, WRITER_NO
    FROM TB_BOOK_AUTHOR
    WHERE COMPOSE_TYPE IN ('�ű�', '����', '��', '����')
);

DELETE FROM TB_BOOK_AUTHOR
WHERE COMPOSE_TYPE IN ('�ű�', '����', '��', '����');

-- 12. 2007�⵵�� ���ǵ� ������ �̸��� ������(����)�� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
SELECT TB.BOOK_NM, TW.WRITER_NM
FROM TB_BOOK TB
JOIN TB_BOOK_TRANSLATOR TBT ON (TB.BOOK_NO = TBT.BOOK_NO)
JOIN TB_WRITER TW ON (TBT.WRITER_NO = TW.WRITER_NO)
WHERE TO_CHAR(TO_DATE(SUBSTR(TB.ISSUE_DATE, 1, 2), 'RRRR'), 'YYYY') = '2007';

-- 13. 12�� ����� Ȱ���Ͽ� ��� ���������� �������� ������ �� ������ �ϴ� �並 �����ϴ� SQL ������ �ۼ��Ͻÿ�. 
-- (�� �̸��� ��VW_BOOK_TRANSLATOR���� �ϰ� ������, ������, �������� ǥ�õǵ��� �� ��)
CREATE OR REPLACE FORCE VIEW VW_BOOK_TRANSLATOR
AS SELECT TB.BOOK_NM, TW.WRITER_NM, TB.ISSUE_DATE
    FROM TB_BOOK TB
    JOIN TB_BOOK_TRANSLATOR TBT ON (TB.BOOK_NO = TBT.BOOK_NO)
    JOIN TB_WRITER TW ON (TBT.WRITER_NO = TW.WRITER_NO)
    WHERE TO_CHAR(TO_DATE(SUBSTR(TB.ISSUE_DATE, 1, 2), 'RRRR'), 'YYYY') = '2007'
    ORDER BY 1
WITH READ ONLY;

GRANT CREATE VIEW TO FINAL;

-- 14. ���ο� ���ǻ�(�� ���ǻ�)�� �ŷ� ����� �ΰ� �Ǿ���. 
-- ���õ� ���� ������ �Է��ϴ� SQL ������ �ۼ��Ͻÿ�.(COMMIT ó���� ��)
INSERT INTO TB_PUBLISHER VALUES('�� ���ǻ�', '02-6710-3737', DEFAULT);

COMMIT;

-- 15. ��������(��٣���) �۰��� �̸��� ã������ �Ѵ�. �̸��� �������� ���ڸ� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
SELECT WRITER_NM, COUNT(*)
FROM TB_WRITER
GROUP BY WRITER_NM
HAVING COUNT(*) != 1;

-- 16. ������ ���� ���� �� ���� ����(compose_type)�� ������ �����͵��� ���� �ʰ� �����Ѵ�. 
-- �ش� �÷��� NULL�� ��� '����'���� �����ϴ� SQL ������ �ۼ��Ͻÿ�.(COMMIT ó���� ��)
UPDATE TB_BOOK_AUTHOR
SET COMPOSE_TYPE = '����'
WHERE COMPOSE_TYPE IS NULL;

COMMIT;

-- 17. �������� �۰� ������ �����Ϸ��� �Ѵ�. �繫���� �����̰�, �繫�� ��ȭ ��ȣ ������ 3�ڸ��� 
-- �۰��� �̸��� �繫�� ��ȭ ��ȣ�� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
SELECT WRITER_NM, OFFICE_TELNO
FROM TB_WRITER
WHERE OFFICE_TELNO LIKE '02-___-%'
ORDER BY 1;

-- 18. 2006�� 1�� �������� ��ϵ� �� 31�� �̻� �� �۰� �̸��� �̸������� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
SELECT WRITER_NM
FROM TB_WRITER
WHERE MONTHS_BETWEEN(TO_DATE('060101', 'RRMMDD'), REGIST_DATE) >= 372
ORDER BY 1;

-- 19. ���� ��� �ٽñ� �α⸦ ��� �ִ� 'Ȳ�ݰ���' ���ǻ縦 ���� ��ȹ���� ������ �Ѵ�. 
-- 'Ȳ�ݰ���'  ���ǻ翡�� ������ ���� �� ��� ������ 10�� �̸��� ������� ����, �����¸� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�. 
-- ��� ������ 5�� �̸��� ������ ���߰��ֹ��ʿ䡯��, �������� ���ҷ��������� ǥ���ϰ�, 
-- �������� ���� ��, ������ ������ ǥ�õǵ��� �Ѵ�. 
SELECT BOOK_NM, PRICE, 
CASE WHEN STOCK_QTY < 5 THEN '�߰��ֹ��ʿ�' ELSE '�ҷ�����' END AS "������"
FROM TB_BOOK
WHERE PUBLISHER_NM = 'Ȳ�ݰ���' AND STOCK_QTY < 10
ORDER BY STOCK_QTY DESC, BOOK_NM;

-- 20. '��ŸƮ��' ���� �۰��� ���ڸ� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�. (��� ����� ��������,�����ڡ�,�����ڡ��� ǥ���� ��)
SELECT BOOK_NM AS "������", TW.WRITER_NM AS "����", TR.WRITER_NM AS "����"
FROM TB_BOOK TB
JOIN TB_BOOK_AUTHOR TBA ON (TB.BOOK_NO = TBA.BOOK_NO)
JOIN TB_BOOK_TRANSLATOR TBT ON (TBA.BOOK_NO = TBT.BOOK_NO)
JOIN TB_WRITER TW ON (TBA.WRITER_NO = TW.WRITER_NO)
JOIN TB_WRITER TR ON (TBT.WRITER_NO = TR.WRITER_NO)
WHERE BOOK_NM = '��ŸƮ��';

SELECT 
    BOOK_NM AS "������" -- TB_BOOK
    , (SELECT TW.WRITER_NM FROM TB_WRITER TW WHERE TW.WRITER_NO = A.WRITER_NO) AS "����"
    , (SELECT TW.WRITER_NM FROM TB_WRITER TW WHERE TW.WRITER_NO = B.WRITER_NO) AS "����"   
FROM TB_BOOK_AUTHOR A
JOIN TB_BOOK_TRANSLATOR B ON A.BOOK_NO = B.BOOK_NO 
JOIN TB_BOOK C ON A.BOOK_NO = C.BOOK_NO
WHERE C.BOOK_NM = '��ŸƮ��';

-- 21. ���� �������� ���� �����Ϸκ��� �� 30���� ����ǰ�, ��� ������ 90�� �̻��� ������ ���� 
-- ������, ��� ����, ���� ����, 20% ���� ������ ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�. 
-- (��� ����� ��������, ����� ������, ������(Org)��, ������(New)���� ǥ���� ��. 
-- ��� ������ ���� ��, ���� ������ ���� ��, ������ ������ ǥ�õǵ��� �� ��
SELECT BOOK_NM AS "������", STOCK_QTY AS "��� ����", PRICE AS "����(Org)", PRICE * 80 / 100 AS "����(New)"
FROM TB_BOOK
WHERE EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM ISSUE_DATE) > 30
AND STOCK_QTY >= 90
ORDER BY 2 DESC, 4 DESC, 1;

SELECT BOOK_NM AS "������", STOCK_QTY AS "��� ����", PRICE AS "����(Org)", PRICE * 80 / 100 AS "����(New)"
FROM TB_BOOK
WHERE MONTHS_BETWEEN(SYSDATE, ISSUE_DATE) >= 360
AND STOCK_QTY >= 90
ORDER BY 2 DESC, 4 DESC, 1;