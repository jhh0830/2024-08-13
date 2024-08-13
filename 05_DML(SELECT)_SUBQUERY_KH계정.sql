/*
    < SUBQUERY �������� >
    
    �ϳ��� �ֵ� SQL �� (SELECT, INSERTM UPDATE, DELETE, CREATE....)
    �ȿ� "���Ե� �� �ϳ��� SELECT ��"
    ��, ���� SQL ���� ���� ���� ������ �ϴ� ������
    
    �ϳ��� �ֵ� SQL �� : ��������
    ���Ե� �� �ϳ��� SELECT �� : �������� - 1 (���� ����)
    
*/

-- �������� ������ ����
-- ���� �������� ���� 1
-- �ǰ��� ����� ���� �μ��� �����
-- 1) ���� �ǰ��� ����� �μ��ڵ� ��ȸ
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '�ǰ���';
--> �ǰ��� ����� �μ��ڵ�� D9��!!
-- 2) �μ��ڵ尡 D9 �� ����� ��ȸ
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- ���� �� �ܰ踦 �ϳ��� ���������� ��ġ��
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME = '�ǰ���');

-- ���� �������� ���� 2
-- ��ü ����� ��� �޿����� �� ���� �޿��� �ް� �ִ�
-- ������� ���, �̸�, �����ڵ带 ��ȸ
-- 1) ���� ��ü ������� ��� �޿� ���ϱ�
SELECT AVG(SALARY)
FROM EMPLOYEE;
--> ��� �޿��� �뷫 3047662 �� ��!!

-- 2) �޿��� 2047662 �� �̻��� ������� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_CODE
FROM EMPLOYEE
WHERE SALARY >= 3047662;

-- ���� �� �ܰ踦 �ϳ��� ���������� ��ġ��
SELECT EMP_ID, EMP_NAME, JOB_CODE
FROM EMPLOYEE
WHERE SALARY>=(SELECT AVG(SALARY)
FROM EMPLOYEE);
