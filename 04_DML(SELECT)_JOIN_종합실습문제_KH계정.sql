----- JOIN ���� �ǽ����� -----
-- 1. ������ �븮�̸鼭 ASIA ������ �ٹ��ϴ� �������� ���, �����, ���޸�, �μ���, �ٹ�������, �޿��� ��ȸ�Ͻÿ�
-->> ����Ŭ ���� ����
SELECT E.EMP_ID "���", E.EMP_NAME "�����", J.JOB_NAME "���޸�" , D.DEPT_TITLE "�μ���", L.LOCAL_NAME "�ٹ�������", E.SALARY "�޿�"
FROM EMPLOYEE E, JOB J, DEPARTMENT D, LOCATION L
WHERE E.DEPT_CODE = D.DEPT_ID AND E.JOB_CODE =J.JOB_CODE AND  D.LOCATION_ID = L.LOCAL_CODE AND
JOB_NAME = '�븮' AND LOCAL_NAME LIKE 'ASIA%';

-->> ANSI ����
SELECT E.EMP_ID "���", E.EMP_NAME "�����", J.JOB_NAME "���޸�" , D.DEPT_TITLE "�μ���", L.LOCAL_NAME "�ٹ�������", E.SALARY "�޿�"
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
JOIN JOB J USING (JOB_CODE)
JOIN LOCATION L ON( D.LOCATION_ID = L.LOCAL_CODE )
WHERE JOB_NAME = '�븮' AND LOCAL_NAME LIKE 'ASIA%';
-- 2. 70�����̸鼭 �����̰�, ���� ������ �������� �����, �ֹι�ȣ, �μ���, ���޸��� ��ȸ�Ͻÿ�
-->> ����Ŭ ���� ����
SELECT E.EMP_NAME "�����", E.EMP_NO "�ֹι�ȣ", D.DEPT_TITLE "�μ���" ,J.JOB_NAME "���޸�"
FROM EMPLOYEE E ,JOB J, DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID AND E.JOB_CODE =J.JOB_CODE AND SUBSTR(E.EMP_NO,1,1) = '7' AND SUBSTR(E.EMP_NAME,1,1) = '��' AND SUBSTR(E.EMP_NO ,8,1) = '2';

-->> ANSI ����
SELECT E.EMP_NAME "�����", E.EMP_NO "�ֹι�ȣ", D.DEPT_TITLE "�μ���" ,J.JOB_NAME "���޸�"
FROM EMPLOYEE E
JOIN JOB J USING (JOB_CODE)
JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
WHERE SUBSTR(E.EMP_NO,1,1) = '7' AND SUBSTR(E.EMP_NAME,1,1) = '��' AND SUBSTR(E.EMP_NO ,8,1) = '2';

-- 3. �̸��� '��'�ڰ� ����ִ� �������� ���, �����, ���޸��� ��ȸ�Ͻÿ�
-->> ����Ŭ ���� ����
SELECT E.EMP_ID "���", E.EMP_NAME "�����" ,J.JOB_NAME "���޸�"
FROM EMPLOYEE E , JOB J
WHERE E.JOB_CODE = J.JOB_CODE AND EMP_NAME LIKE '%��%' ;
-->> ANSI ����
SELECT E.EMP_ID "���", E.EMP_NAME "�����" ,J.JOB_NAME "���޸�"
FROM EMPLOYEE E
JOIN JOB J USING(JOB_CODE)
WHERE EMP_NAME LIKE '%��%' ;


-- 4. �ؿܿ������� �ٹ��ϴ� �������� �����, ���޸�, �μ��ڵ�, �μ����� ��ȸ�Ͻÿ�
-->> ����Ŭ ���� ����
SELECT EMP_NAME "�����" , J.JOB_NAME "���޸�" , D.DEPT_ID "�μ��ڵ�" ,D.DEPT_TITLE "�μ���"
FROM EMPLOYEE E ,JOB J, DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID AND E.JOB_CODE = J.JOB_CODE AND D.DEPT_TITLE LIKE '%�ؿܿ���%';
-->> ANSI ����
SELECT EMP_NAME "�����" , J.JOB_NAME "���޸�" , D.DEPT_ID "�μ��ڵ�" ,D.DEPT_TITLE "�μ���"
FROM EMPLOYEE E
JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
JOIN JOB J USING(JOB_CODE)
WHERE D.DEPT_TITLE LIKE '%�ؿܿ���%';

-- 5. ���ʽ��� �޴� �������� �����, ���ʽ�, ����, �μ���, �ٹ��������� ��ȸ�Ͻÿ�
-->> ����Ŭ ���� ���� 

SELECT EMP_NAME "�����" ,BONUS "���ʽ�", (SALARY + (SALARY*BONUS))*12"����",DEPT_TITLE "�μ���", LOCAL_NAME "�ٹ�������"
FROM EMPLOYEE E , DEPARTMENT D, LOCATION L
WHERE E.DEPT_CODE = D.DEPT_ID AND D.LOCATION_ID = L.LOCAL_CODE AND E.BONUS IS NOT NULL;


-->> ANSI ����
SELECT EMP_NAME "�����" ,BONUS "���ʽ�", (SALARY + (SALARY*BONUS))*12"����",DEPT_TITLE "�μ���", LOCAL_NAME "�ٹ�������"
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
JOIN LOCATION L ON D.LOCATION_ID = L.LOCAL_CODE
WHERE E.BONUS IS NOT NULL;

-- 6. �μ��� �ִ� �������� �����, ���޸�, �μ���, �ٹ��������� ��ȸ�Ͻÿ�
-->> ����Ŭ ���� ����
SELECT EMP_NAME "�����" , J.JOB_NAME "���޸�",DEPT_TITLE "�μ���",LOCAL_NAME "�ٹ�������"
FROM EMPLOYEE E , DEPARTMENT D, LOCATION L , JOB J
WHERE E.DEPT_CODE = D.DEPT_ID AND D.LOCATION_ID = L.LOCAL_CODE AND E.JOB_CODE = J.JOB_CODE AND DEPT_TITLE IS NOT NULL;

-->> ANSI ����
SELECT EMP_NAME "�����" , J.JOB_NAME "���޸�",DEPT_TITLE "�μ���",LOCAL_NAME "�ٹ�������"
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
JOIN  LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
JOIN JOB J USING (JOB_CODE)
WHERE DEPT_TITLE IS NOT NULL;
-- 7. '�ѱ�' �� '�Ϻ�' �� �ٹ��ϴ� �������� �����, �μ���, �ٹ�������, �ٹ��������� ��ȸ�Ͻÿ�
-->> ����Ŭ ���� ����
SELECT E.EMP_NAME "�����",D.DEPT_TITLE "�μ���",L.LOCAL_NAME "�ٹ�������",N.NATIONAL_NAME "�ٹ�������"
FROM EMPLOYEE E , DEPARTMENT D, LOCATION L ,NATIONAL N
WHERE E.DEPT_CODE = D.DEPT_ID AND D.LOCATION_ID = L.LOCAL_CODE AND L.NATIONAL_CODE = N.NATIONAL_CODE AND  N.NATIONAL_NAME IN('�ѱ�','�Ϻ�');

-->> ANSI ����
SELECT E.EMP_NAME "�����",D.DEPT_TITLE "�μ���",L.LOCAL_NAME "�ٹ�������",N.NATIONAL_NAME "�ٹ�������"
FROM EMPLOYEE E
JOIN DEPARTMENT D ON( E.DEPT_CODE = D.DEPT_ID) 
JOIN LOCATION L ON(D.LOCATION_ID = L.LOCAL_CODE)
JOIN NATIONAL N ON(L.NATIONAL_CODE = N.NATIONAL_CODE)
WHERE N.NATIONAL_NAME IN('�ѱ�','�Ϻ�');

-- 8. ���ʽ��� ���� �ʴ� ������ �� �����ڵ尡 J4 �Ǵ� J7 �� �������� �����, ���޸�, �޿��� ��ȸ�Ͻÿ�
-->> ����Ŭ ���� ����
SELECT EMP_NAME "�����" , J.JOB_NAME "���޸�", E.SALARY "�޿�"
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE AND E.BONUS IS NULL AND J.JOB_CODE IN ('J4','J7');
-->> ANSI ����
SELECT EMP_NAME "�����" , J.JOB_NAME "���޸�", E.SALARY "�޿�"
FROM EMPLOYEE E
JOIN JOB J ON (E.JOB_CODE=J.JOB_CODE)
WHERE  E.BONUS IS NULL AND J.JOB_CODE IN ('J4','J7');
-- 9. ���, �����, ���޸�, �޿���� (SAL_GRADE), ������ ��ȸ�ϴµ�
-- �� ��, ���п� �ش��ϴ� ����
-- �޿������ S1, S2 �� ��� '���'
-- �޿������ S3, S4 �� ��� '�߱�'
-- �޿������ S5, S6 �� ��� '�ʱ�' ���� ��ȸ�ǰ� �Ͻÿ�
-->> ����Ŭ ���� ����
SELECT E.EMP_ID "���",E.EMP_NAME "�����" , J.JOB_NAME "���޸�", S.SAL_LEVEL "�޿����",
CASE WHEN S.SAL_LEVEL  IN('S1','S2') THEN '���'  WHEN S.SAL_LEVEL IN('S3','S4') THEN '�߱�' WHEN S.SAL_LEVEL IN('S5','S6') THEN '�ʱ�'
                                                  END AS "����"
FROM EMPLOYEE E , JOB J, SAL_GRADE S
WHERE E.JOB_CODE = J.JOB_CODE AND E.SAL_LEVEL=S.SAL_LEVEL;

-->> ANSI ����
SELECT E.EMP_ID "���",E.EMP_NAME "�����" , J.JOB_NAME "���޸�", S.SAL_LEVEL "�޿����",
CASE WHEN S.SAL_LEVEL  IN('S1','S2') THEN '���'  WHEN S.SAL_LEVEL IN('S3','S4') THEN '�߱�' WHEN S.SAL_LEVEL IN('S5','S6') THEN '�ʱ�'
END AS "����"
FROM EMPLOYEE E
JOIN JOB J USING (JOB_CODE)
JOIN SAL_GRADE S ON (E.SAL_LEVEL=S.SAL_LEVEL);



-- 10. �� �μ��� �� �޿����� ��ȸ�ϵ� �� ��, �� �޿����� 1000���� �̻��� �μ���, �޿����� ��ȸ�Ͻÿ�
-->> ����Ŭ ���� ����
SELECT  D.DEPT_TITLE "�μ���" , SUM(E.SALARY) "�޿� ��"
FROM EMPLOYEE E, DEPARTMENT D 
WHERE E.DEPT_CODE = D.DEPT_ID HAVING SUM(E.SALARY)>=10000000
GROUP BY D.DEPT_TITLE ;
-->> ANSI ����
SELECT  D.DEPT_TITLE "�μ���" , SUM(E.SALARY) "�޿� ��"
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (E.DEPT_CODE=D.DEPT_ID) HAVING SUM(E.SALARY)>=10000000
GROUP BY D.DEPT_TITLE;

-- 11. �� �μ��� ��ձ޿��� ��ȸ�Ͽ� �μ���, ��ձ޿� (����ó��) �� ��ȸ�Ͻÿ� ��, �μ���ġ�� �ȵ� ������� ��յ� ���� �����Բ� �Ͻÿ�
-->> ����Ŭ ���� ����
SELECT D.DEPT_TITLE "�μ���", TRUNC(AVG(E.SALARY))"��ձ޿�"
FROM EMPLOYEE E , DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID(+)
GROUP BY D.DEPT_TITLE;
-->> ANSI ����
SELECT D.DEPT_TITLE "�μ���", TRUNC(AVG(E.SALARY))"��ձ޿�"
FROM EMPLOYEE E
LEFT JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
GROUP BY D.DEPT_TITLE;
