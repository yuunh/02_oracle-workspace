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
