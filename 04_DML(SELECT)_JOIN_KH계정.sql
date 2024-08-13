
/*
   
       < JOIN >
    
    �� �� �̻��� ���̺���
    �����͸� �Բ� "��ȸ" �ϰ��� �� �� ���Ǵ� ����
    ��ȸ ����� �ϳ��� ����� (RESULT SET) ���� ����
    
    * ������ �����ͺ��̽������� 
      "�ּ���" �� �����ͷ� ������ ���̺� �����͸� "�ɰ���" �����ϰ� ����
      > �������� "�ߺ�" �� �ּ�ȭ �ϱ� ���ؼ� �ִ��� �ɰ��°�!!
        (����ȭ �۾�)
      
    * ��, JOIN ������ ���ؼ� �������� ���̺� �� "����" �� �ξ
      ���� ��ȸ�ؾ� ��!!
      ��, ������ JOIN �� �ؼ� ��ȸ�� �ϴ°� �ƴϰ�
      ���̺� ���� "�����" �� �ش��ϴ� �÷��� ��Ī���Ѽ� ��ȸ�ؾ���!!
      (�ܷ�Ű) 
      
    * JOIN �� ũ�� "����Ŭ ���� ����" �� "ANSI (�̱�����ǥ����ȸ) ����"
      ���� ������ ������.
      
            ����Ŭ ���� ����        |     ANSI ����
======================================================================
               �����            |       ��������
            (EQUAL JOIN)          |    (INNER JOIN)
-------------------------------------------------------------------------------
               ��������             |     �ܺ�����  
             (LEFT JOIN)           |      (LEFT OUTER JOIN)
             (RIGHT JOIN)          |     (RIGHT OUTER JOIN)
                                   |       (FULL OUTER JOIN)
                                   |  => ����Ŭ ���뱸�������� �Ұ�
--------------------------------------------------------------------
            ī���̻� ��              |           ��������
        (CARTESIAN PRODUCT)        |          (CROSS JOIN)
--------------------------------------------------------------------------
                            ��ü���� (SELF JOIN)
                            ������ (NON EQUAL JOIN)


*/

-- EMPLOYEE ���̺�κ��� ��ü �������
-- ���, ����� ,�μ��ڵ�, �μ������ �˾Ƴ��� �ʹٸ�?
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE;
--> EMPLOYEE ���̺��� DEPT_CODE
SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT;
--> DEPARTMENT ���̺��� DEPT_ID

-- EMPLOYEE ���̺�κ��� ��ü �������
-- ���, �����, �����ڵ�, ���޸���� �˾Ƴ����� �Ѵٸ�?

SELECT EMP_ID, EMP_NAME, JOB_CODE
FROM EMPLOYEE;
--> EMPLOYEE ���̺��� JOB_CODE

SELECT JOB_CODE, JOB_NAME
FROM JOB;
--> JOB ���̺��� JOB_CODE

--> JOIN �� ���ؼ� "�����" �� �ش�Ǵ� �÷���
-- ����� ��Ī��Ű�� ��ġ �ϳ��� ������� ���� ��������!!


--------------------------------------------------------------------------------

/*
    1. ����� (EQUAL JOIN) / �������� (INNER JOIN)
    
    ����� �÷����� "��ġ" �ϴ� ��鸸 ���εǼ� ��ȸ�ϰڴ�.
    ��, ��ġ���� �ʴ� ������ ��ȸ���� �����ϰڴ�.
    
*/

-->> ����Ŭ ���� ����
--  FROM ���� ��ȸ�ϰ��� �ϴ� ���̺����� ���� (,��)
--  WHERE ���� ��Ī��ų �÷��� (�����) �� ���� ���� ���

-- ��ü ������� ���, �����, �μ��ڵ�, �μ����� ���� ��ȸ
-- 1) ����� �÷����� ���� �ٸ� ��� 
-- EMPLOYEE ���̺��� DEPT_CODE / DEPARTMENT ���̺��� DEPT_ID
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID;
--> ��ġ���� �ʴ� ���� ��ȸ���� ���ܵ� �� Ȯ�� ���� 
-- (DEPT_CODE �� NULL �̿��� 2���� ��������ʹ�
-- ��ȸ�� �ȵ�)
-- (DEPT_ID �� D3, D4, D7 �� �μ��� ���� ���� ��ȸ�� �ȵ�)

-- ���, �����, �����ڵ�, ���޸�
-- 2) ���� �� �� �÷����� ���� ���
-- EMPLOYEE ���̺��� JOB_CODE / JOB ���̺��� JOB_CODE
/*
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE,JOB
WHERE JOB_CODE = JOB_CODE;
*/
--> ���� �߻�
-- AMBIGUOUSLY : �ָŸ�ȣ��
-- Ȯ���� � ���̺��� �÷������� �� ����ؾ� �ذ� ����!!

-- ���1. ���̺���� �̿��ϴ� ���
-- ���̺��.�÷���
SELECT EMP_ID, EMP_NAME,EMPLOYEE.JOB_CODE, JOB_NAME
FROM EMPLOYEE, JOB
WHERE EMPLOYEE.JOB_CODE = JOB.JOB_CODE;

-- ���2. ���̺� ��Ī �ο� �� ��Ī�� �̿��ϴ� ���
-- (��� ���̺��� ��Ī�� ���� �� ����!!)
-- ��Ī.�÷���
SELECT EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE;

-->> ANSI ����
--  FROM ���� ���� ���̺���� �ϳ��� ����� ��
--  �� �ڿ� JOIN ������ ���� ��ȸ�ϰ��� �ϴ� ���̺���� ���
--  ���� ��Ī��ų �÷��� ���� ���ǵ� JOIN ���� ���� ���
--  (USING ���� / ON ����)


-- ���, �����, �μ��ڵ�, �μ���
-- 1) ����� �÷����� �ٸ� ���
-- EMPLOYEE = DEPT_CODE / DEPARTMENT = DEPT_ID
-- => ������ ON ������ ��� ����!!
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE
/* INNER */ JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
--> INNER ���� ����

-- ���, �����, �����ڵ�, ���޸�
-- 2) ���� �� �� �÷����� ���� ���
-- EMPLOYEE - JOB_CODE/ JOB - JOB_CODE
-- => ON ����, USING ���� ��� ��� ����
-- 2_1) ON ���� �̿�
-- AMBIGUOUSLY �� �߻��� �� �ֱ� ������
-- ���̺���̵� ��ġ�̵� ���� Ȯ���ϰ� ����ؾ� �Ѵ�!!
SELECT EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
FROM EMPLOYEE E
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE);

-- 2_2) USING ���� �̿�
-- ON ������ ������� ���� ���ǽ��� ���� ���� ���,
-- USING ������ ���������� "�����" �� �������ִ� ������
-- => ������ �÷��� �ϳ��� ���ָ� �˾Ƽ� ��Ī������
--   AMBIGUOUSL �߻�X
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE);

-- ����)
-- ����� �÷����� ������ ���� NATIRAL JOIN �� ����
-- NATURAL JOIN : �ڿ� ����
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
NATURAL JOIN JOB;

--> �ΰ��� ���̺�� �����ϰ�, ������� ���� ������ ��� X
--  �� ���Ե� �ΰ��� ���̺� ��ġ�ϴ� �÷��� �����ϰ� �Ѱ��� �����ϱ� ����


-- ������� ���� ���� �Ӹ� ���̶�
-- �߰����� ���ǵ� ���� ����!!

-- ������ "�븮" �� ������� ���,�̸�, �޿�, ���޸� ��ȸ
-->> ����Ŭ ���� ����
SELECT EMP_ID, EMP_NAME, SALARY, JOB_NAME
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE -- ������� ���� ����
    AND JOB_NAME = '�븮'; -- �߰����� ���ǽ�
    
-->> ANSI ����
SELECT EMP_ID, EMP_NAME, SALARY, JOB_NAME
 FROM EMPLOYEE E
  -- JOIN JOB USING (JOB_CODE)
 JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
 WHERE JOB_NAME = '�븮';
 
----- < �ǽ����� > ------
-- 1. �μ��� "�λ������" �� ������� ���,�����, ���ʽ� ��ȸ
-->> ����Ŭ ���뱸��
SELECT EMP_ID, EMP_NAME, BONUS , DEPT_TITLE
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID 
 AND DEPT_TITLE = '�λ������';
-->> ANSI ����

SELECT EMP_ID, EMP_NAME, BONUS ,DEPT_TITLE
FROM EMPLOYEE E JOIN DEPARTMENT D ON(
 E.DEPT_CODE = D.DEPT_ID )
WHERE DEPT_TITLE = '�λ������';

-- 2. �μ��� "�ѹ���"�� �ƴ� ������� �����, �޿�, �Ի��� ��ȸ
-->> ����Ŭ ���뱸��
SELECT EMP_NAME, SALARY ,  HIRE_DATE
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID 
 --AND NOT (DEPT_TITLE = '�ѹ���');
AND DEPT_TITLE !='�ѹ���'
UNION
SELECT EMP_NAME, SALARY ,  HIRE_DATE
FROM EMPLOYEE 
WHERE DEPT_CODE IS NULL;
-->> ANSI ����
SELECT  EMP_NAME, SALARY , HIRE_DATE
FROM EMPLOYEE E JOIN  DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
--WHERE NOT (DEPT_TITLE = '�ѹ���');
WHERE DEPT_TITLE != '�ѹ���'
UNION
SELECT EMP_NAME, SALARY ,  HIRE_DATE
FROM EMPLOYEE 
WHERE DEPT_CODE IS NULL;

-- 3. ���ʽ��� �޴� ������� ���, �����, ���ʽ� , �μ��� ��ȸ
-->> ����Ŭ ���뱸��
SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE
FROM EMPLOYEE E , DEPARTMENT D
WHERE E.DEPT_CODE=D.DEPT_ID AND  BONUS IS NOT  NULL
ORDER BY EMP_ID ASC;
-->> ANSI ����
SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE
FROM EMPLOYEE E JOIN DEPARTMENT D ON (E.DEPT_CODE=D.DEPT_ID)
WHERE  BONUS IS NOT NULL
ORDER BY EMP_ID ASC;


-- 4. �Ʒ��� �� ���̺��� �����ؼ� �μ��ڵ�, �μ��� ,�����ڵ�, ������ ��ȸ

SELECT * FROM DEPARTMENT;-- DEPT_ID, DEPT_TITLE , LOCATION_ID
SELECT * FROM LOCATION;  -- LOCAL_CODE, NATIONAL_CODE, LOCAL_NAME
-->> ����Ŭ ���뱸��
SELECT DEPT_ID, DEPT_TITLE, LOCAL_CODE, LOCAL_NAME
FROM DEPARTMENT D , LOCATION L
WHERE D.LOCATION_ID = L.LOCAL_CODE;
-->> ANSI ����
SELECT  DEPT_ID, DEPT_TITLE, LOCAL_CODE, LOCAL_NAME
FROM DEPARTMENT D JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE);

-- ���� 4����������..
-- �ƽþ� ������ ��ġ�� �μ��� ����ʹٸ�?
SELECT DEPT_ID, DEPT_TITLE, LOCAL_CODE, LOCAL_NAME
FROM DEPARTMENT D , LOCATION L
WHERE D.LOCATION_ID = L.LOCAL_CODE AND LOCAL_NAME LIKE 'ASIA%';

SELECT  DEPT_ID, DEPT_TITLE, LOCAL_CODE, LOCAL_NAME
FROM DEPARTMENT D JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
WHERE  LOCAL_NAME LIKE 'ASIA%';

-- > � ���� / ���� ����
-- : "��ġ" �ϴ� ��鸸 ��ȸ�ϴ� ����
-- ��ġ���� �ʴ� ����� ���ʿ� ��ȸ���� ����!!

/*
    2. ���� ���� / �ܺ� ���� (OUTER JOIN)
    
    ���̺� ���� JOIN �� ��ġ���� ���� �൵ ���Խ��Ѽ� ��ȸ ����
    ��, �ݵ�� LEFT / RIGHT �� �����ؾ���
    (������ �Ǵ� ���̺��� �����ؾ� ��)

*/

-- EMPLOYEE ���̺�κ���
-- "��ü" ������� �����, �޿�, �μ��� ��ȸ
-->> ANSI ����
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
--> EMPLOYEE ���̺�� ���� DEPT_CODE �� NULL �� �� ���� ��� ��ȸ X
--> DEPARTMENT ���̺�κ��� DEPT_ID �� D3,D4,D7 �� �μ��� ��ȸ X

-- 1) LEFT OUTER JOIN
-- �� ���̺� �� "����" �� ����� ���̺��� �������� �Ͽ� JOIN
-- ��, ���� �Ǿ��� ���� ���� ����� ���̺��� �����ʹ� ������ ��ȸ
-- (��ġ�ϴ°� ã�� ���ϴ���)
-->> ANSI ���� 
SELECT EMP_NAME, SALARY ,DEPT_TITLE
FROM EMPLOYEE
LEFT OUTER JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID);
--> EMPLOYEE ���̺��� �������� ��ȸ�߱� ������
-- EMPLOYEE �� �����ϴ� �����ʹ� ���� �Ǿ��� ���� ������ ��ȸ
-- (��ġ�ϴ°� ã�� ���ϴ���)

-->> ����Ŭ ���� ����
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID(+);
--> ���� �������� ���� ���̺��� �÷����� �ƴ�
-- �ݴ� ���̺��� �÷��� �ڿ� (+) �� �ٿ��ش�. �����Ѵ�? �׷������� ���̴µ�?

-- 2) RIGHT OUTER JOIN
-- �� ���̺� �� "������" �� ����� ���̺��� �������� ����
-- ��, ���� �Ǿ��� ���� ������ ����� ���̺��� �����ʹ� ������ ��ȸ
-- (��ġ�ϴ°��� ã�� ���ϴ���)

-->>ANSI ����
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE
RIGHT OUTER JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);
--> �켱 ��ġ�ϴ� ����� ��ȸ ��,
-- ���� ���̺��� DEPARTMENT ���̺��� ������ ������ �������� ��ȸ��!!!

-->> ����Ŭ ���� ����
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT 
WHERE DEPT_CODE(+) = DEPT_ID;
-- ����Ŭ ������ ���� ��� X ������ �����ϴ°��̱⶧���� �������� Ȯ���ϰ� ���ָ� ��

-- RIGHT OUTER JOIN �� �̿��ؼ�
-- "��ü" ������� �̸�, �޿�, �μ����� ����ʹٸ�?
-->> ANSI ����
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM DEPARTMENT
RIGHT OUTER JOIN EMPLOYEE ON(DEPT_CODE = DEPT_ID);
-->> ����Ŭ ���� ����
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID(+); -- DEPT_ID(+) = DEPT_CODE �ص� ����� ����
--> ����Ŭ ���� ������ ��� ������ ��� ���� ���h�� �� �����ָ� ��!!

-- 3) FULL OUTER JOIN
-- �� ���̺��� ���� ��� ���� ��ȸ�� �� �ֵ��� ����
-- ��, ��ġ�ϴ� �͵��� ã��, ���� ���̺��� ������ �����͸� ���� ����!!
-- ��, ����Ŭ ���� ���������� ���� �Ұ�!!

-->> ANSI ����
SELECT EMP_NAME, SALARY , DEPT_TITLE
FROM EMPLOYEE
FULL /*OUTER ���� ����*/ JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

-->> ����Ŭ ����
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE ,DEPARTMENT
WHERE DEPT_CODE(+)= DEPT_ID(+);
--> ������: ONLY ONE OUTER-JOINED TABLE // ����Ŭ�� "����" ����
-- ���� ���� / �ܺ� ����
-- : ���� ������ ��� ��ġ�ϴ°� + ���ʿ��� ������ ������
-- : ������ ������ ��� ��ġ�ϴ°� + �����ʿ��� ������ ������
-- : FULL �� ��� (ANSI �� ����) ��ġ�ϴ°� + ���ʿ��� ���� + �����ʿ��� ������ ������

---------------------------------------------------------------------------------
/*
    3. ī�׽þ� �� / ���� ����
    
    ��� ���̺��� �� ����� ���μ��� ���ε� �����Ͱ� ��ȸ��(������)
    �� ���̺��� ��� ����� ��� ������ ����� ������ �� ��µ�
    => ����� ������ ��� => ������ ����
    
    �ַ�, ���� JOIN ���� �ۼ� �� �Ǽ��� ��� �߻�����,
    ����� �ǹ����� ���� ���� ���� �幰��.
        
*/

-- �����, �μ��� ��ȸ
--> ����Ŭ ���� ����
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT;
--> 23 * 9 = 207 �� �� ��ȸ

-->> ANSI ����
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
CROSS JOIN DEPARTMENT;

-----------------------------------------------------------------------------

/*
    4. �� ���� (NON EQUAL JOIN)
    
    ������� ���� ���ǽĿ� '=' (��ȣ) �� ������� �ʴ� ���ι�
    �ַ�, ������ �÷����� ��ġ�ϴ� ��찡 �ƴ�,
    "����" �� ���ԵǴ� ��� ��Ī
    
*/

-- EMPLOYEE ���̺�κ��� �����, �޿�
SELECT EMP_NAME, SALARY /*SAL_LEVEL*/
FROM EMPLOYEE;

SELECT * FROM SAL_GRADE;
--> EMPLOYEE ���̺��� SAL_LEVEL �÷� (�Ļ��÷�) �� ��� ����!!
--  (��� ���°� �� ���������)
-- ��? SALARY �޿��� �������� ���ε�, SALARY ���� ���� ������
-- �׿� �´� SAL_LEVEL �÷����� �Բ� �����������!!
-- ���浵 ������ �Ӹ� �ƴ϶�, �����ϴ� �������� �Ǽ��� ���
-- �������� ����ġ ������ �߻��� �� �ֱ� ����!!

-- �Ļ��÷� ����) EMPLOYEE ���̺��� ���� �÷� 
--> ���������� SALARY �� ���� �ɶ����� ���� �÷����� ���� ����ؼ� �ٲ����!!

-- �����, �޿�, �޿���� (SAL_GRADE ���̺��� �÷�����)
-->> ����Ŭ ���� ����
SELECT EMP_NAME, SALARY, S.SAL_LEVEL
FROM EMPLOYEE , SAL_GRADE S
--WHERE (MIN_SAL <= SALARY) AND (SALARY<= MAX_SAL);
WHERE SALARY BETWEEN MIN_SAL AND MAX_SAL;
-->> ANSI ����
SELECT EMP_NAME, SALARY, E.SAL_LEVEL, S.SAL_LEVEL
FROM EMPLOYEE E
--JOIN SAL_GRADE S ON (MIN_SAL <= SALARY AND SALARY <= MAX_SAL);
JOIN SAL_GRADE S ON (SALARY BETWEEN MIN_SAL AND MAX_SAL);

--> ANSI ���� �������� �� ������ �ϰ�ʹٸ�
-- ������ ON ������ ��� ������!!
-- ��? ���� ���� ������ ���ǽ��� ����� �� �ۿ� ���� ����

-- �� ���� ����)
-- ���ͳ� ���θ�
-- ȸ�� ���� ���̺� / ���űݾ׿� ���� ������ ȸ����� ���̺�
--------------------------------------------------------------------------------------
/*
     5. ��ü ���� (SELF JOIN)
     
     ���� ���̺��� �ٽ� �ѹ� �����ϴ� ���
     ��, �ڱ� �ڽ��� ���̺�� �ٽ� ������ �δ� ���
     AMBIGUOUSLY ���� ����!!
*/


SELECT EMP_ID "��� ���", EMP_NAME "��� �̸�", SALARY "��� �޿�", MANAGER_ID "��� ���"
FROM EMPLOYEE;
--> ����� ����� ���� �ش� ����� ������ �˾Ƴ�����!!

SELECT * FROM EMPLOYEE E; -- ����� ���� ���� ����� (MANAGER_ID)
SELECT * FROM EMPLOYEE M; -- ����� ���� ���� ����� (EMP_ID)
-- ��, ����� ���ٶ� "��ü" ����� ������ �� �������!!
-- ��� ���, �����, ��� �μ��ڵ�, ��� �޿�
-- ��� ���, �����, ��� �μ��ڵ�, ��� �޿�
-->> ����Ŭ ���� ����
SELECT E.EMP_ID "��� ���", E.EMP_NAME "�����", E.DEPT_CODE "��� �μ��ڵ�", E.SALARY "��� �޿�"
     , M.EMP_ID "��� ���", M.EMP_NAME "�����", M.DEPT_CODE "��� �μ��ڵ�", M.SALARY"��� �޿�"
     FROM EMPLOYEE E, EMPLOYEE M
     WHERE E.MANAGER_ID = M.EMP_ID(+);
-->> ANSI ����
SELECT E.EMP_ID "��� ���", E.EMP_NAME "�����", E.DEPT_CODE "��� �μ��ڵ�", E.SALARY "��� �޿�"
     , M.EMP_ID "��� ���", M.EMP_NAME "�����", M.DEPT_CODE "��� �μ��ڵ�", M.SALARY"��� �޿�"
     FROM EMPLOYEE E
     LEFT JOIN EMPLOYEE M ON(E.MANAGER_ID= M.EMP_ID);
--> ����� �μ��ڵ� �Ӹ� �ƴ϶� �μ��� ����ʹٸ�?
-- ��� ���� �μ��ڵ� �Ӹ� �ƴ϶� �μ��� ����ʹٸ�?


-- ��� ���, �����, ���� �μ��ڵ�, ��� �μ��� , ����޿�
-- ��� ���, �����, ���� �μ��ڵ�, ��� �μ��� , ����޿�

-->> ����Ŭ
SELECT E.EMP_ID "��� ���", E.EMP_NAME "�����", E.DEPT_CODE "��� �μ��ڵ�", E.SALARY "��� �޿�" , D1.DEPT_TITLE "�μ���"
, M.EMP_ID "��� ���", M.EMP_NAME "�����", M.DEPT_CODE "��� �μ��ڵ�", M.SALARY"��� �޿�" ,D2.DEPT_TITLE"�μ���"
FROM EMPLOYEE E, EMPLOYEE M, DEPARTMENT D1, DEPARTMENT D2
WHERE E.DEPT_CODE = D1.DEPT_ID
AND   M.DEPT_CODE = D2.DEPT_ID
AND   E.MANAGER_ID = M.EMP_ID(+);
-->> ANSI
SELECT E.EMP_ID "��� ���", E.EMP_NAME "�����", E.DEPT_CODE "��� �μ��ڵ�", E.SALARY "��� �޿�" , D1.DEPT_TITLE "�μ���"
, M.EMP_ID "��� ���", M.EMP_NAME "�����", M.DEPT_CODE "��� �μ��ڵ�", M.SALARY"��� �޿�" ,D2.DEPT_TITLE"�μ���"
FROM EMPLOYEE E
LEFT JOIN EMPLOYEE M ON (E.MANAGER_ID = M.EMP_ID)
LEFT JOIN DEPARTMENT D1 ON(E.DEPT_CODE = D1.DEPT_ID)
LEFT JOIN DEPARTMENT D2 ON(M.DEPT_CODE = D2.DEPT_ID);
--> �������� ���̺� ���� ���� �����ϴ�.
-- ANSI ������ ��� JOIN �� �ۼ� ������ �߿�!!

----------------------------------------------------------------

/*
    < ���� JOIN >
    
    3 �� �̻��� ���̺��� �����ϴ� ��
    ANSI ������ ��� JOIN �ۼ� ������ �߿��ϴ�!!
    
*/

-- ���, �����, �μ���, ���޸� , �ٹ�������
SELECT * FROM EMPLOYEE;    -- DEPT_CODE   JOB_CODE
SELECT * FROM DEPARTMENT;  -- DEPT_ID
SELECT * FROM JOB;         --             JOB_CODE
SELECT * FROM LOCATION;    --             LOCAL_CODE


-->> ����Ŭ ���� ����
SELECT E.EMP_ID "���" , E.EMP_NAME "�����" , J.JOB_NAME "���޸�", L.LOCAL_NAME "�ٹ�������"

FROM EMPLOYEE E, DEPARTMENT D,JOB J, LOCATION L
WHERE E.DEPT_CODE = D.DEPT_ID (+)
AND E.JOB_CODE =J.JOB_CODE(+)
AND D.LOCATION_ID = L.LOCAL_CODE(+);

-->> ANSI ����
SELECT E.EMP_ID "���" , E.EMP_NAME "�����" , J.JOB_NAME "���޸�", L.LOCAL_NAME "�ٹ�������"
FROM EMPLOYEE E
LEFT JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
LEFT JOIN JOB J USING (JOB_CODE)--JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
LEFT JOIN LOCATION L ON(D.LOCATION_ID = L.LOCAL_CODE);
--> ANSI ������ ��� JOIN �� �ۼ� ������ �߿��ϴ�!!
-- LOCATION ���̺��� DEPARTMENT ���̺��� ���� JOIN �Ұ�!!

-- �����, �μ���, ���޸�, �ٹ�������, �ٹ�������, �޿����
SELECT * FROM EMPLOYEE;    -- DEPT_CODE     JOB_CODE                                   SALARY
SELECT * FROM DEPARTMENT;  -- DEPT_ID                   LOCATION_ID
SELECT * FROM JOB;         --               JOB_CODE
SELECT * FROM LOCATION;    --                           LOCAL_CODE    NATIONAL_CODE
SELECT * FROM NATIONAL;    --                                         NATIONAL_CODE
SELECT * FROM SAL_GRADE;   --                                                           MIN_SAL /MAX_SAL
-->>  ����Ŭ ����
SELECT E.EMP_NAME "�����" , D.DEPT_TITLE "�μ���", J.JOB_NAME "���޸�", L.LOCAL_NAME "�ٹ�������", N.NATIONAL_NAME "�ٹ�������", E.SAL_LEVEL "�޿����" 
FROM EMPLOYEE E, DEPARTMENT D, JOB J, LOCATION L,  NATIONAL N, SAL_GRADE S
WHERE E.DEPT_CODE =D.DEPT_ID AND E.JOB_CODE= J.JOB_CODE AND D.LOCATION_ID = L.LOCAL_CODE AND L.NATIONAL_CODE = N.NATIONAL_CODE
AND E.SALARY BETWEEN S.MIN_SAL AND S.MAX_SAL;
-->> ANSI
SELECT E.EMP_NAME "�����" , D.DEPT_TITLE "�μ���", J.JOB_NAME "���޸�", L.LOCAL_NAME "�ٹ�������", N.NATIONAL_NAME "�ٹ�������", E.SAL_LEVEL "�޿����" 
FROM EMPLOYEE E
JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
JOIN JOB J USING(JOB_CODE)
JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
JOIN NATIONAL N USING (NATIONAL_CODE)
JOIN SAL_GRADE S ON (E.SALARY BETWEEN S.MIN_SAL AND S.MAX_SAL);
-----------------------------------------------------------------------


------------------------------<JOIN ���� �ǽ����� >-----------------------