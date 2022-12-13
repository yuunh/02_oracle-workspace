-- 먼저 저장

/*
    < 트리거 TRIGGER >
    내가 지정한 테이블 INSERT, UPDATE, DELETE 등 DML문에 의해 변경사항이 생길 때
    (테이블에 이벤트가 발생했을 때)
    자동으로 매번 실행할 내용을 미리 정의해둘 수 있는 객체
    
    EX)
    회원탈퇴시 기존의 회원테이블에 데이터를 DELETE 한 후 
    곧바로 탈퇴한 회원들만 따로 보관하는 테이블에 자동으로 INSERT 처리해야된다
    신고횟수가 일정 수를 넘었을 때 묵시적으로 해당 회원을 블랙리스트로 처리되게끔
    입출고에 대한 데이터가 기록(INSERT)될 때마다 해당 상품에 대한 재고수량을 매번 수정(UPDATE)해야될때
    
    * 트리거 종류
    - SQL문의 실행시기에 따른 분류
     > BEFROE TRIGGER : 내가 지정한 테이블에 이벤트가 발생되기 전에 트리거 실행
     > AFTER TRIGGER : 내가 지정한 테이블에 이벤트가 발생한 후에 트리거 실행
     
    - SQL문의 의해 영향을 받는 각 행에 따른 분류
     > STATEMENT TRIGGER (문장트리거) : 이벤트가 발생한 SQL문에 대해 딱 한번만 트리거 실행
     > ROW TRIGGER (행트리거) : 해당 SQL문 실행할 때마다 매번 트리거 실행
                              (FOR EACH ROW 옵션 기술해야됨)
                              > :OLD - BEFORE UPDATE(수정전 자료), BEFORE DELETE(삭제전 자료)
                              > :NEW - AFTER INSERT(추가된 자료), AFTER UPDATE(수정후 자료)
    
    * 트리거 생성구문
    [표현식]
    CREATE [OR REPLACE] TRIGGER 트리거명
    BEFORE | AFTER      INSERT | UPDATE | DELETE    ON 테이블명
    [FOR EACH ROW]
    자동으로 실행할 내용;
     ㄴ [DECLARE
            변수선언]
        BEGIN
            실행내용(해당 위에 지정된 이벤트 발생시 묵시적으로 실행할 구문)
        [EXCEPTION
            예외처리구문;]
        END;
        /
*/

-- EMPLOYEE 테이블에 새로운 행이 INSERT 될 때마다 자동으로 메세지 출력되는 트리거 정의
CREATE OR REPLACE TRIGGER TRG_01
AFTER INSERT ON EMPLOYEE
BEGIN
    DBMS_OUTPUT.PUT_LINE('신입사원님 환영합니다!');
END;
/

INSERT INTO EMPLOYEE (EMP_ID, EMP_NAME, EMP_NO, DEPT_CODE, JOB_CODE, SAL_LEVEL, HIRE_DATE)
VALUES(500, '이순신', '111111-2222222', 'D7', 'J7', 'S2', SYSDATE);

INSERT INTO EMPLOYEE (EMP_ID, EMP_NAME, EMP_NO, DEPT_CODE, JOB_CODE, SAL_LEVEL, HIRE_DATE)
VALUES(501, '주몽', '121212-2121212', 'D7', 'J7', 'S2', SYSDATE);

--------------------------------------------------------------------------------
-- 상품 입고 및 출고 관련 예시
-- >> 테스트를 위한 테이블 및 시퀀스 생성

-- 1. 상품에 대한 데이터 보관할 테이블
CREATE TABLE TB_PRODUCT(
    PCODE NUMBER PRIMARY KEY,       -- 상품번호
    PNAME VARCHAR2(30) NOT NULL,    -- 상품명
    BRAND VARCHAR2(30) NOT NULL,    -- 브랜드
    PRICE NUMBER,                   -- 가격
    STOCK NUMBER DEFAULT 0          -- 재고수량
);

-- 상품번호 중복 안되게씀 매번 새로운 번호를 발생시키는 시퀀스
CREATE SEQUENCE SEQ_PCODE
START WITH 200
INCREMENT BY 5
NOCACHE;

INSERT INTO TB_PRODUCT VALUES(SEQ_PCODE.NEXTVAL, '갤럭시20', '삼성', 1400000, DEFAULT);
INSERT INTO TB_PRODUCT VALUES(SEQ_PCODE.NEXTVAL, '아이폰14', '애플', 1300000, 10);
INSERT INTO TB_PRODUCT VALUES(SEQ_PCODE.NEXTVAL, '대륙폰', '샤오미', 600000, 20);

SELECT *
FROM TB_PRODUCT;

COMMIT;

-- 2. 상품 입출고 상세 이력 테이블
-- 어떤 상품이 어떤 날짜에 몇개아 입출고가 되었는지에 대한 데이터를 기록하는 테이블
CREATE TABLE TB_PRODETAIL(
    DCODE NUMBER PRIMARY KEY,                      -- 이력번호
    PCODE NUMBER REFERENCES TB_PRODUCT,            -- 상품번호   
    PDATE DATE NOT NULL,                           -- 상품입출고일
    AMOUNT NUMBER NOT NULL,                        -- 입출고수량
    STATUS CHAR(6) CHECK(STATUS IN ('입고', '출고')) -- 상태(입고/출고)
);

-- 이력 번호로 매번 새로운 번호 살생시켜서 들어갈 수 있게 도와주는 시퀀스
CREATE SEQUENCE SEQ_DCODE
NOCACHE;

-- 200번 상품이 오늘 날짜로 10개 입고
INSERT INTO TB_PRODETAIL VALUES(SEQ_DCODE.NEXTVAL, 200, SYSDATE, 10, '입고');

-- 200번 상품의 재고 수량을 10 증가
UPDATE TB_PRODUCT
SET STOCK = STOCK + 10
WHERE PCODE = 200;

COMMIT; -- 해당 트렌젝션 커밋

-- 210번 상품이 오늘 날짜로 5개 출고
INSERT INTO TB_PRODETAIL VALUES(SEQ_DCODE.NEXTVAL, 210, SYSDATE, 5, '출고');

-- 201번 상품의 재고 수량을 5 감소
UPDATE TB_PRODUCT
SET STOCK = STOCK - 5
WHERE PCODE = 210;

COMMIT;

-- 205번 상품이 오늘 날짜로 20개 입고
INSERT INTO TB_PRODETAIL VALUES(SEQ_DCODE.NEXTVAL, 205, SYSDATE, 20, '입고');

-- 205번 상품의 재고 수량을 20 증가
UPDATE TB_PRODUCT
SET STOCK = STOCK + 20
WHERE PCODE = 200; -- 잘못입력함

ROLLBACK; -- 잘못입력해서 롤백함

-- 205번 상품이 오늘 날짜로 20개 입고 
INSERT INTO TB_PRODETAIL VALUES(SEQ_DCODE.NEXTVAL, 205, SYSDATE, 20, '입고');
-- DCODE 3이 아니고 4임

-- 205번 상품의 재고 수량을 20 증가
UPDATE TB_PRODUCT
SET STOCK = STOCK + 20
WHERE PCODE = 205;

COMMIT;

-- TB_PRODETAIL 테이블에 INSERT 이벤트 발생시
-- TB_PRODUCT 테이블에 자동으로 재고수량 UPDATE 되게끔 트리거 정의

/*
    - 상품이 입고된 경우 => 해당 상품 찾아서 재고수량 증가 UPDATE
    UPDATE TB_PRODUCT
    SET STOCK = STOCK + 현재입고된수량(INSERT된 자료의 AMOUNT 값)
    WHERE PCODE = 현재입고된상품번호(INSERT된 자료의 PCODE 값);
    
    - 상품이 출고된 경우 => 해당 상품 찾아서 재고수량 감소 UPDATE
    UPDATE TB_PRODUCT
    SET STOCK = STOCK - 현재출고된수량(INSERT된 자료의 AMOUNT 값)
    WHERE PCODE = 현재출고된상품번호(INSERT된 자료의 PCODE 값);
*/

-- :NEW 써야함
CREATE OR REPLACE TRIGGER TRG_02
AFTER INSERT ON TB_PRODETAIL
FOR EACH ROW
BEGIN
    -- 상품이 입고된 경우 => 재고수량 증가
    IF (:NEW.STATUS = '입고')
        THEN
            UPDATE TB_PRODUCT
            SET STOCK = STOCK + :NEW.AMOUNT
            WHERE PCODE = :NEW.PCODE;
    END IF;
    -- 상품이 출고된 경우 => 재고수량 감소
    IF (:NEW.STATUS = '출고')
        THEN
            UPDATE TB_PRODUCT
            SET STOCK = STOCK - :NEW.AMOUNT
            WHERE PCODE = :NEW.PCODE;
    END IF;
END;
/

-- 210번 상품이 오늘 날짜로 7개 출고
INSERT INTO TB_PRODETAIL
VALUES(SEQ_DCODE.NEXTVAL, 210, SYSDATE, 7, '출고');

-- 200번 상품이 오늘 날짜로 100개 입고
INSERT INTO TB_PRODETAIL
VALUES(SEQ_DCODE.NEXTVAL, 200, SYSDATE, 100, '입고');
