-- �� �� ¥�� �ּ�
/*
    ������
    �ּ�
*/

-- ���� ��� �����鿡 ���ؼ� ��ȸ�ϴ� ��ɹ�
SELECT * FROM DBA_USERS;
-- ��ɹ� �ϳ� ����(������ �����ư Ŭ�� | ctrl + enter)

-- �Ϲ� ����ڰ��� �����ϴ� ����(������ ������ ���������� �� �� ����)
-- [ǥ����] CREATE USER ������ IDENTIFIED BY ��й�ȣ;

CREATE USER kh IDENTIFIED BY kh; -- �������� ��ҹ��� �Ȱ���
-- ���� �߰��غ��� => ������ => ��? ���� �ο��� ���� ����

-- ������ ������ �Ϲ� ����� �������� �ּ����� ����(����, ������ ����) �ο�
-- [ǥ����] GRANT ����1, ����2, .... TO ������

GRANT CONNECT, RESOURCE TO kh;

CREATE USER SCOTT IDENTIFIED BY TIGER;

GRANT CONNECT, RESOURCE TO SCOTT;

CREATE USER DDL IDENTIFIED BY DDL;

GRANT CONNECT, RESOURCE TO DDL;

CREATE USER FINAL IDENTIFIED BY FINAL;

GRANT CONNECT, RESOURCE TO FINAL;

CREATE USER JDBC IDENTIFIED BY JDBC;

GRANT CONNECT, RESOURCE TO JDBC;