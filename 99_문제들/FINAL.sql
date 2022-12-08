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
SELECT COUNT(*) AS "�۰�(��)"
FROM TB_BOOK_AUTHOR
WHERE COMPOSE_TYPE LIKE '%�ű�%';

-- 6. 300�� �̻� ��ϵ� ������ ���� ���� �� ��ϵ� ���� ������ ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
-- (���� ���°� ��ϵ��� ���� ���� ������ ��)


-- 7. ���� �ֱٿ� �߰��� �ֽ��� �̸��� ��������, ���ǻ� �̸��� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
SELECT BOOK_NM, ISSUE_DATE, PUBLISHER_NM
FROM (SELECT BOOK_NM, ISSUE_DATE, PUBLISHER_NM
        FROM TB_BOOK
        ORDER BY ISSUE_DATE DESC)
WHERE ROWNUM = 1;

-- 8. ���� ���� å�� �� �۰� 3���� �̸��� ������ ǥ���ϵ�, ���� �� ������� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
-- ��, ��������(��٣���) �۰��� ���ٰ� �����Ѵ�. (��� ����� ���۰� �̸���, ���� ������ ǥ�õǵ��� �Ұ�)


-- 9. �۰� ���� ���̺��� ��� ������� �׸��� �����Ǿ� �ִ� �� �߰��Ͽ���. 
-- ������ ������� ���� �� �۰��� ������ ���ǵ����� �����ϰ� ������ ��¥���� �����Ű�� SQL ������ �ۼ��Ͻÿ�. (COMMIT ó���� ��)
UPDATE TB_WRITER
SET REGIST_DATE = 

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


-- 12. 2007�⵵�� ���ǵ� ������ �̸��� ������(����)�� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.


-- 13. 12�� ����� Ȱ���Ͽ� ��� ���������� �������� ������ �� ������ �ϴ� �並 �����ϴ� SQL ������ �ۼ��Ͻÿ�. 
-- (�� �̸��� ��VW_BOOK_TRANSLATOR���� �ϰ� ������, ������, �������� ǥ�õǵ��� �� ��)


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
WHERE OFFICE_TELNO LIKE '02%' 
AND SUBSTR(OFFICE_TELNO, 4) LIKE '___$_%' ESCAPE '$';
SUBSTR(EMAIL, 1, INSTR(EMAIL, '@') - 1)
SELECT SUBSTR(OFFICE_TELNO, 4,INSTR(EMAIL, '-') -1) LIKE '___$_%' ESCAPE '$'
FROM TB_WRITER;

-- 18. 2006�� 1�� �������� ��ϵ� �� 31�� �̻� �� �۰� �̸��� �̸������� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
SELECT WRITER_NM
FROM TB_WRITER
WHERE EXTRACT(YEAR FROM REGIST_DATE) - EXTRACT(YEAR FROM TO_DATE('060101')) >= 31
ORDER BY 1;

SELECT *
FROM TB_WRITER
WHERE REGIST_DATE IS  NOT NULL;

-- 19. ���� ��� �ٽñ� �α⸦ ��� �ִ� 'Ȳ�ݰ���' ���ǻ縦 ���� ��ȹ���� ������ �Ѵ�. 
-- 'Ȳ�ݰ���'  ���ǻ翡�� ������ ���� �� ��� ������ 10�� �̸��� ������� ����, �����¸� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�. 
-- ��� ������ 5�� �̸��� ������ ���߰��ֹ��ʿ䡯��, �������� ���ҷ��������� ǥ���ϰ�, 
-- �������� ���� ��, ������ ������ ǥ�õǵ��� �Ѵ�. 
SELECT BOOK_NM, PRICE, 
CASE WHEN STOCK_QTY < 5 THEN '�߰��ֹ��ʿ�' ELSE '�ҷ�����' END AS "������"
FROM TB_BOOK
WHERE PUBLISHER_NM = 'Ȳ�ݰ���'
ORDER BY STOCK_QTY DESC, BOOK_NM;

-- 20. '��ŸƮ��' ���� �۰��� ���ڸ� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�. (��� ����� ��������,�����ڡ�,�����ڡ��� ǥ���� ��)


-- 21. ���� �������� ���� �����Ϸκ��� �� 30���� ����ǰ�, ��� ������ 90�� �̻��� ������ ���� 
-- ������, ��� ����, ���� ����, 20% ���� ������ ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�. 
-- (��� ����� ��������, ����� ������, ������(Org)��, ������(New)���� ǥ���� ��. 
-- ��� ������ ���� ��, ���� ������ ���� ��, ������ ������ ǥ�õǵ��� �� ��
SELECT BOOK_NM AS "������", STOCK_QTY AS "��� ����", PRICE AS "����(Org)", PRICE * 80 / 100 AS "����(New)"
FROM TB_BOOK
WHERE EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM ISSUE_DATE) > 30
AND STOCK_QTY >= 90
ORDER BY 2 DESC, 4 DESC, 1;
