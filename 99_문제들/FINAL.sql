-- 먼저 저장

-- 3. 도서명이 25자 이상인 책 번호와 도서명을 화면에 출력하는 SQL 문을 작성하시오.
SELECT BOOK_NO, BOOK_NM
FROM TB_BOOK
WHERE LENGTH(BOOK_NM) >= 25;

-- 4. 휴대폰 번호가 ‘019’로 시작하는 김씨 성을 가진 작가를 이름순으로 정렬했을 때 
-- 가장 먼저 표시되는 작가 이름과 사무실 전화번호, 집 전화번호, 휴대폰 전화번호를 표시하는 SQL 구문을 작성하시오.
SELECT WRITER_NM, OFFICE_TELNO, HOME_TELNO, MOBILE_NO
FROM (SELECT WRITER_NM, OFFICE_TELNO, HOME_TELNO, MOBILE_NO
        FROM TB_WRITER
        WHERE MOBILE_NO LIKE '019%' AND WRITER_NM LIKE '김%'
        ORDER BY 1)
WHERE ROWNUM = 1;

-- 5. 저작 형태가 “옮김”에 해당하는 작가들이 총 몇 명인지 계산하는 SQL 구문을 작성하시오. 
-- (결과 헤더는 “작가(명)”으로 표시되도록 할 것)
SELECT COUNT(DISTINCT WRITER_NO) AS "작가(명)"
FROM TB_BOOK_AUTHOR
WHERE COMPOSE_TYPE LIKE '%옮김%';

-- 6. 300권 이상 등록된 도서의 저작 형태 및 등록된 도서 수량을 표시하는 SQL 구문을 작성하시오.
-- (저작 형태가 등록되지 않은 경우는 제외할 것)
SELECT COMPOSE_TYPE, COUNT(*)
FROM TB_BOOK_AUTHOR
GROUP BY COMPOSE_TYPE
HAVING COUNT(*) >= 300 AND COMPOSE_TYPE IS NOT NULL;

-- 7. 가장 최근에 발간된 최신작 이름과 발행일자, 출판사 이름을 표시하는 SQL 구문을 작성하시오.
SELECT BOOK_NM, ISSUE_DATE, PUBLISHER_NM
FROM (SELECT BOOK_NM, ISSUE_DATE, PUBLISHER_NM
        FROM TB_BOOK
        ORDER BY ISSUE_DATE DESC)
WHERE ROWNUM = 1;

-- 8. 가장 많은 책을 쓴 작가 3명의 이름과 수량을 표시하되, 많이 쓴 순서대로 표시하는 SQL 구문을 작성하시오.
-- 단, 동명이인(同名異人) 작가는 없다고 가정한다. (결과 헤더는 “작가 이름”, “권 수”로 표시되도록 할것)
SELECT *
FROM (SELECT WRITER_NM AS "작가 이름", COUNT(*) AS "권 수"
        FROM TB_WRITER TW, TB_BOOK_AUTHOR TBA
        WHERE TW.WRITER_NO = TBA.WRITER_NO
        GROUP BY WRITER_NM
        ORDER BY 2 DESC) W
WHERE ROWNUM <= 3; 

-- 9. 작가 정보 테이블의 모든 등록일자 항목이 누락되어 있는 걸 발견하였다. 
-- 누락된 등록일자 값을 각 작가의 ‘최초 출판도서의 발행일과 동일한 날짜’로 변경시키는 SQL 구문을 작성하시오. (COMMIT 처리할 것)
UPDATE TB_WRITER
SET REGIST_DATE = (SELECT MIN(ISSUE_DATE)
                    FROM TB_BOOK 
                    JOIN TB_BOOK_AUTHOR USING (BOOK_NO)
                    WHERE ;
                    
UPDATE TB_WRITER A --1
SET    REGIST_DATE = (SELECT MIN(ISSUE_DATE) --4 SET 하는거 5번
                       FROM   TB_BOOK_AUTHOR  --2
                       JOIN   TB_BOOK USING (BOOK_NO)
                       WHERE  A.WRITER_NO = WRITER_NO;  --3
-- 10. 현재 도서저자 정보 테이블은 저서와 번역서를 구분 없이 관리하고 있다. 앞으로는 번역서는 따로 관리하려고 한다. 
-- 제시된 내용에 맞게 “TB_BOOK_ TRANSLATOR” 테이블을 생성하는 SQL 구문을 작성하시오. 
-- (Primary Key 제약 조건 이름은 “PK_BOOK_TRANSLATOR”로 하고, 
-- Reference 제약 조건 이름은 “FK_BOOK_TRANSLATOR_01”, “FK_BOOK_TRANSLATOR_02”로 할 것)
CREATE TABLE TB_BOOK_TRANSLATOR(
    BOOK_NO VARCHAR2(10) CONSTRAINT FK_BOOK_TRANSLATOR_01 REFERENCES TB_BOOK NOT NULL,
    WRITER_NO VARCHAR2(10) CONSTRAINT FK_BOOK_TRANSLATOR_02 REFERENCES TB_WRITER NOT NULL,
    TRANS_LANG VARCHAR2(60), 
    CONSTRAINT PK_BOOK_TRANSLATOR PRIMARY KEY(BOOK_NO, WRITER_NO)
);

-- 11. 도서 저작 형태(compose_type)가 '옮김', '역주', '편역', '공역'에 해당하는 데이터는
-- 도서 저자 정보 테이블에서 도서 역자 정보 테이블(TB_BOOK_ TRANSLATOR)로 옮기는 SQL 구문을 작성하시오. 
-- 단, “TRANS_LANG” 컬럼은 NULL 상태로 두도록 한다. 
-- (이동된 데이터는 더 이상 TB_BOOK_AUTHOR 테이블에 남아 있지 않도록 삭제할 것)
INSERT INTO TB_BOOK_TRANSLATOR (BOOK_NO, WRITER_NO)
(SELECT BOOK_NO, WRITER_NO
    FROM TB_BOOK_AUTHOR
    WHERE COMPOSE_TYPE IN ('옮김', '역주', '편역', '공역')
);

DELETE FROM TB_BOOK_AUTHOR
WHERE COMPOSE_TYPE IN ('옮김', '역주', '편역', '공역');

-- 12. 2007년도에 출판된 번역서 이름과 번역자(역자)를 표시하는 SQL 구문을 작성하시오.
SELECT TB.BOOK_NM, TW.WRITER_NM
FROM TB_BOOK TB
JOIN TB_BOOK_TRANSLATOR TBT ON (TB.BOOK_NO = TBT.BOOK_NO)
JOIN TB_WRITER TW ON (TBT.WRITER_NO = TW.WRITER_NO)
WHERE TO_CHAR(TO_DATE(SUBSTR(TB.ISSUE_DATE, 1, 2), 'RRRR'), 'YYYY') = '2007';

-- 13. 12번 결과를 활용하여 대상 번역서들의 출판일을 변경할 수 없도록 하는 뷰를 생성하는 SQL 구문을 작성하시오. 
-- (뷰 이름은 “VW_BOOK_TRANSLATOR”로 하고 도서명, 번역자, 출판일이 표시되도록 할 것)
CREATE OR REPLACE FORCE VIEW VW_BOOK_TRANSLATOR
AS SELECT TB.BOOK_NM, TW.WRITER_NM, TB.ISSUE_DATE
    FROM TB_BOOK TB
    JOIN TB_BOOK_TRANSLATOR TBT ON (TB.BOOK_NO = TBT.BOOK_NO)
    JOIN TB_WRITER TW ON (TBT.WRITER_NO = TW.WRITER_NO)
    WHERE TO_CHAR(TO_DATE(SUBSTR(TB.ISSUE_DATE, 1, 2), 'RRRR'), 'YYYY') = '2007'
    ORDER BY 1
WITH READ ONLY;

GRANT CREATE VIEW TO FINAL;

-- 14. 새로운 출판사(춘 출판사)와 거래 계약을 맺게 되었다. 
-- 제시된 다음 정보를 입력하는 SQL 구문을 작성하시오.(COMMIT 처리할 것)
INSERT INTO TB_PUBLISHER VALUES('춘 출판사', '02-6710-3737', DEFAULT);

COMMIT;

-- 15. 동명이인(同名異人) 작가의 이름을 찾으려고 한다. 이름과 동명이인 숫자를 표시하는 SQL 구문을 작성하시오.
SELECT WRITER_NM, COUNT(*)
FROM TB_WRITER
GROUP BY WRITER_NM
HAVING COUNT(*) != 1;

-- 16. 도서의 저자 정보 중 저작 형태(compose_type)가 누락된 데이터들이 적지 않게 존재한다. 
-- 해당 컬럼이 NULL인 경우 '지음'으로 변경하는 SQL 구문을 작성하시오.(COMMIT 처리할 것)
UPDATE TB_BOOK_AUTHOR
SET COMPOSE_TYPE = '지음'
WHERE COMPOSE_TYPE IS NULL;

COMMIT;

-- 17. 서울지역 작가 모임을 개최하려고 한다. 사무실이 서울이고, 사무실 전화 번호 국번이 3자리인 
-- 작가의 이름과 사무실 전화 번호를 표시하는 SQL 구문을 작성하시오.
SELECT WRITER_NM, OFFICE_TELNO
FROM TB_WRITER
WHERE OFFICE_TELNO LIKE '02-___-%'
ORDER BY 1;

-- 18. 2006년 1월 기준으로 등록된 지 31년 이상 된 작가 이름을 이름순으로 표시하는 SQL 구문을 작성하시오.
SELECT WRITER_NM
FROM TB_WRITER
WHERE MONTHS_BETWEEN(TO_DATE('060101', 'RRMMDD'), REGIST_DATE) >= 372
ORDER BY 1;

-- 19. 요즘 들어 다시금 인기를 얻고 있는 '황금가지' 출판사를 위한 기획전을 열려고 한다. 
-- '황금가지'  출판사에서 발행한 도서 중 재고 수량이 10권 미만인 도서명과 가격, 재고상태를 표시하는 SQL 구문을 작성하시오. 
-- 재고 수량이 5권 미만인 도서는 ‘추가주문필요’로, 나머지는 ‘소량보유’로 표시하고, 
-- 재고수량이 많은 순, 도서명 순으로 표시되도록 한다. 
SELECT BOOK_NM, PRICE, 
CASE WHEN STOCK_QTY < 5 THEN '추가주문필요' ELSE '소량보유' END AS "재고상태"
FROM TB_BOOK
WHERE PUBLISHER_NM = '황금가지' AND STOCK_QTY < 10
ORDER BY STOCK_QTY DESC, BOOK_NM;

-- 20. '아타트롤' 도서 작가와 역자를 표시하는 SQL 구문을 작성하시오. (결과 헤더는 ‘도서명’,’저자’,’역자’로 표시할 것)
SELECT BOOK_NM AS "도서명", TW.WRITER_NM AS "저자", TR.WRITER_NM AS "역자"
FROM TB_BOOK TB
JOIN TB_BOOK_AUTHOR TBA ON (TB.BOOK_NO = TBA.BOOK_NO)
JOIN TB_BOOK_TRANSLATOR TBT ON (TBA.BOOK_NO = TBT.BOOK_NO)
JOIN TB_WRITER TW ON (TBA.WRITER_NO = TW.WRITER_NO)
JOIN TB_WRITER TR ON (TBT.WRITER_NO = TR.WRITER_NO)
WHERE BOOK_NM = '아타트롤';

SELECT 
    BOOK_NM AS "도서명" -- TB_BOOK
    , (SELECT TW.WRITER_NM FROM TB_WRITER TW WHERE TW.WRITER_NO = A.WRITER_NO) AS "저자"
    , (SELECT TW.WRITER_NM FROM TB_WRITER TW WHERE TW.WRITER_NO = B.WRITER_NO) AS "역자"   
FROM TB_BOOK_AUTHOR A
JOIN TB_BOOK_TRANSLATOR B ON A.BOOK_NO = B.BOOK_NO 
JOIN TB_BOOK C ON A.BOOK_NO = C.BOOK_NO
WHERE C.BOOK_NM = '아타트롤';

-- 21. 현재 기준으로 최초 발행일로부터 만 30년이 경과되고, 재고 수량이 90권 이상인 도서에 대해 
-- 도서명, 재고 수량, 원래 가격, 20% 인하 가격을 표시하는 SQL 구문을 작성하시오. 
-- (결과 헤더는 “도서명”, “재고 수량”, “가격(Org)”, “가격(New)”로 표시할 것. 
-- 재고 수량이 많은 순, 할인 가격이 높은 순, 도서명 순으로 표시되도록 할 것
SELECT BOOK_NM AS "도서명", STOCK_QTY AS "재고 수량", PRICE AS "가격(Org)", PRICE * 80 / 100 AS "가격(New)"
FROM TB_BOOK
WHERE EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM ISSUE_DATE) > 30
AND STOCK_QTY >= 90
ORDER BY 2 DESC, 4 DESC, 1;

SELECT BOOK_NM AS "도서명", STOCK_QTY AS "재고 수량", PRICE AS "가격(Org)", PRICE * 80 / 100 AS "가격(New)"
FROM TB_BOOK
WHERE MONTHS_BETWEEN(SYSDATE, ISSUE_DATE) >= 360
AND STOCK_QTY >= 90
ORDER BY 2 DESC, 4 DESC, 1;