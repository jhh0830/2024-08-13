
/*
   
       < JOIN >
    
    두 개 이상의 테이블에서
    데이터를 함께 "조회" 하고자 할 때 사용되는 구문
    조회 결과는 하나의 결과물 (RESULT SET) 으로 나옴
    
    * 관계형 데이터베이스에서는 
      "최소한" 의 데이터로 각가의 테이블에 데이터를 "쪼개서" 보관하고 있음
      > 데이터의 "중복" 을 최소화 하기 위해서 최대한 쪼개는것!!
        (정규화 작업)
      
    * 즉, JOIN 구문을 통해서 여러개의 테이블 간 "관계" 를 맺어서
      같이 조회해야 함!!
      단, 무작정 JOIN 을 해서 조회를 하는건 아니고
      테이블 간의 "연결고리" 에 해당하는 컬럼을 매칭시켜서 조회해야함!!
      (외래키) 
      
    * JOIN 은 크게 "오라클 전용 구문" 과 "ANSI (미국국립표준협회) 구문"
      으로 문법이 나뉜다.
      
            오라클 전용 구문        |     ANSI 구문
======================================================================
               등가조인            |       내부조인
            (EQUAL JOIN)          |    (INNER JOIN)
-------------------------------------------------------------------------------
               포괄조인             |     외부조인  
             (LEFT JOIN)           |      (LEFT OUTER JOIN)
             (RIGHT JOIN)          |     (RIGHT OUTER JOIN)
                                   |       (FULL OUTER JOIN)
                                   |  => 오라클 전용구문에서는 불가
--------------------------------------------------------------------
            카테이산 곱              |           교차조인
        (CARTESIAN PRODUCT)        |          (CROSS JOIN)
--------------------------------------------------------------------------
                            자체조인 (SELF JOIN)
                            비등가조인 (NON EQUAL JOIN)


*/

-- EMPLOYEE 테이블로부터 전체 사원들의
-- 사번, 사원명 ,부서코드, 부서명까지 알아내고 싶다면?
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE;
--> EMPLOYEE 테이브의 DEPT_CODE
SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT;
--> DEPARTMENT 테이블의 DEPT_ID

-- EMPLOYEE 테이블로부터 전체 사원들의
-- 사번, 사원명, 직급코드, 직급명까지 알아내고자 한다면?

SELECT EMP_ID, EMP_NAME, JOB_CODE
FROM EMPLOYEE;
--> EMPLOYEE 테이블의 JOB_CODE

SELECT JOB_CODE, JOB_NAME
FROM JOB;
--> JOB 테이블의 JOB_CODE

--> JOIN 을 통해서 "연결고리" 에 해당되는 컬럼을
-- 제대로 매칭시키면 마치 하나의 결과물로 조히 가능해짐!!


--------------------------------------------------------------------------------

/*
    1. 등가조인 (EQUAL JOIN) / 내부조인 (INNER JOIN)
    
    연결고리 컬럼값이 "일치" 하는 행들만 조인되서 조회하겠다.
    즉, 일치하지 않는 값들은 조회에서 제외하겠다.
    
*/

-->> 오라클 전용 구문
--  FROM 절에 조회하고자 하는 테이블명들을 나열 (,로)
--  WHERE 절에 매칭시킬 컬럼명 (연결고리) 에 대한 조건 기술

-- 전체 사원들의 사번, 사원명, 부서코드, 부서명을 같이 조회
-- 1) 연결고리 컬러명이 서로 다른 경우 
-- EMPLOYEE 테이블의 DEPT_CODE / DEPARTMENT 테이블의 DEPT_ID
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID;
--> 일치하지 않는 값은 조회에서 제외된 것 확인 가능 
-- (DEPT_CODE 가 NULL 이였던 2명의 사원데이터는
-- 조회가 안됨)
-- (DEPT_ID 가 D3, D4, D7 인 부서명 정보 또한 조회가 안됨)

-- 사번, 사원명, 직급코드, 직급명
-- 2) 연결 할 두 컬럼명이 같을 경우
-- EMPLOYEE 테이블의 JOB_CODE / JOB 테이블의 JOB_CODE
/*
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE,JOB
WHERE JOB_CODE = JOB_CODE;
*/
--> 오류 발생
-- AMBIGUOUSLY : 애매모호한
-- 확실히 어떤 테이블의 컬럼명인지 다 명시해야 해결 가능!!

-- 방법1. 테이블명을 이용하는 방법
-- 테이블명.컬럼명
SELECT EMP_ID, EMP_NAME,EMPLOYEE.JOB_CODE, JOB_NAME
FROM EMPLOYEE, JOB
WHERE EMPLOYEE.JOB_CODE = JOB.JOB_CODE;

-- 방법2. 테이블에 별칭 부여 후 별칭을 이용하는 방법
-- (사실 테이블에도 별칭을 붙일 수 있음!!)
-- 별칭.컬럼명
SELECT EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE;

-->> ANSI 구문
--  FROM 절에 기준 테이블명을 하나만 기술한 뒤
--  그 뒤에 JOIN 절에서 같이 조회하고자 하는 테이블명을 기술
--  또한 매칭시킬 컬럼에 대한 조건도 JOIN 절에 같이 기술
--  (USING 구문 / ON 구문)


-- 사번, 사원명, 부서코드, 부서명
-- 1) 연결고리 컬러명이 다를 경우
-- EMPLOYEE = DEPT_CODE / DEPARTMENT = DEPT_ID
-- => 무조건 ON 구문만 사용 가능!!
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE
/* INNER */ JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
--> INNER 생략 가능

-- 사번, 사원명, 직급코드, 직급명
-- 2) 연결 할 두 컬럼명이 같은 경우
-- EMPLOYEE - JOB_CODE/ JOB - JOB_CODE
-- => ON 구문, USING 구문 모두 사용 가능
-- 2_1) ON 구문 이용
-- AMBIGUOUSLY 가 발생할 수 있기 때문에
-- 테이블명이든 별치이든 간에 확실하게 명시해야 한다!!
SELECT EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
FROM EMPLOYEE E
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE);

-- 2_2) USING 구문 이용
-- ON 구문은 연결고리에 대한 조건식을 내가 직접 기술,
-- USING 구문은 내부족으로 "동등비교" 를 수행해주는 구문임
-- => 동일한 컬럼명 하나만 써주면 알아서 매칭시켜줌
--   AMBIGUOUSL 발생X
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE);

-- 참고)
-- 연결고리 컬러명이 돌일한 경우는 NATIRAL JOIN 도 가능
-- NATURAL JOIN : 자연 조인
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
NATURAL JOIN JOB;

--> 두개의 테이블명만 제시하고, 연결고리에 대한 조건은 기술 X
--  운 좋게도 두개의 테이블에 일치하는 컬럼이 유일하게 한개씩 존재하기 때문


-- 연결고리에 대한 조건 뿐만 나이라
-- 추가적인 조건도 제시 가능!!

-- 직급이 "대리" 인 사원들의 사번,이름, 급여, 직급명 조회
-->> 오라클 전용 구문
SELECT EMP_ID, EMP_NAME, SALARY, JOB_NAME
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE -- 연결고리에 대한 조건
    AND JOB_NAME = '대리'; -- 추가적인 조건식
    
-->> ANSI 구문
SELECT EMP_ID, EMP_NAME, SALARY, JOB_NAME
 FROM EMPLOYEE E
  -- JOIN JOB USING (JOB_CODE)
 JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
 WHERE JOB_NAME = '대리';
 
----- < 실습문제 > ------
-- 1. 부서가 "인사관리부" 인 사원들의 사번,사원명, 보너스 조회
-->> 오라클 전용구문
SELECT EMP_ID, EMP_NAME, BONUS , DEPT_TITLE
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID 
 AND DEPT_TITLE = '인사관리부';
-->> ANSI 구문

SELECT EMP_ID, EMP_NAME, BONUS ,DEPT_TITLE
FROM EMPLOYEE E JOIN DEPARTMENT D ON(
 E.DEPT_CODE = D.DEPT_ID )
WHERE DEPT_TITLE = '인사관리부';

-- 2. 부서가 "총무부"가 아닌 사원들의 사원명, 급여, 입사일 조회
-->> 오라클 전용구문
SELECT EMP_NAME, SALARY ,  HIRE_DATE
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID 
 --AND NOT (DEPT_TITLE = '총무부');
AND DEPT_TITLE !='총무부'
UNION
SELECT EMP_NAME, SALARY ,  HIRE_DATE
FROM EMPLOYEE 
WHERE DEPT_CODE IS NULL;
-->> ANSI 구문
SELECT  EMP_NAME, SALARY , HIRE_DATE
FROM EMPLOYEE E JOIN  DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
--WHERE NOT (DEPT_TITLE = '총무부');
WHERE DEPT_TITLE != '총무부'
UNION
SELECT EMP_NAME, SALARY ,  HIRE_DATE
FROM EMPLOYEE 
WHERE DEPT_CODE IS NULL;

-- 3. 보너스를 받는 사원들의 사번, 사원명, 보너스 , 부서명 조회
-->> 오라클 전용구문
SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE
FROM EMPLOYEE E , DEPARTMENT D
WHERE E.DEPT_CODE=D.DEPT_ID AND  BONUS IS NOT  NULL
ORDER BY EMP_ID ASC;
-->> ANSI 구문
SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE
FROM EMPLOYEE E JOIN DEPARTMENT D ON (E.DEPT_CODE=D.DEPT_ID)
WHERE  BONUS IS NOT NULL
ORDER BY EMP_ID ASC;


-- 4. 아래의 두 테이블을 참고해서 부서코드, 부서명 ,지역코드, 지역명 조회

SELECT * FROM DEPARTMENT;-- DEPT_ID, DEPT_TITLE , LOCATION_ID
SELECT * FROM LOCATION;  -- LOCAL_CODE, NATIONAL_CODE, LOCAL_NAME
-->> 오라클 전용구문
SELECT DEPT_ID, DEPT_TITLE, LOCAL_CODE, LOCAL_NAME
FROM DEPARTMENT D , LOCATION L
WHERE D.LOCATION_ID = L.LOCAL_CODE;
-->> ANSI 구문
SELECT  DEPT_ID, DEPT_TITLE, LOCAL_CODE, LOCAL_NAME
FROM DEPARTMENT D JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE);

-- 위의 4번문제에서..
-- 아시아 지역에 위치한 부서만 보고싶다면?
SELECT DEPT_ID, DEPT_TITLE, LOCAL_CODE, LOCAL_NAME
FROM DEPARTMENT D , LOCATION L
WHERE D.LOCATION_ID = L.LOCAL_CODE AND LOCAL_NAME LIKE 'ASIA%';

SELECT  DEPT_ID, DEPT_TITLE, LOCAL_CODE, LOCAL_NAME
FROM DEPARTMENT D JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
WHERE  LOCAL_NAME LIKE 'ASIA%';

-- > 등가 조인 / 내부 조인
-- : "일치" 하는 행들만 조회하는 개념
-- 일치하지 않는 행들은 애초에 조회되지 않음!!

/*
    2. 포괄 조인 / 외부 조인 (OUTER JOIN)
    
    테이블 간의 JOIN 시 일치하지 않은 행도 포함시켜서 조회 가능
    단, 반드시 LEFT / RIGHT 를 지정해야함
    (기존이 되는 테이블을 지정해야 함)

*/

-- EMPLOYEE 테이블로부터
-- "전체" 사원들의 사원명, 급여, 부서명 조회
-->> ANSI 구문
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
--> EMPLOYEE 테이블로 부터 DEPT_CODE 가 NULL 인 두 명의 사원 조회 X
--> DEPARTMENT 테이블로부터 DEPT_ID 가 D3,D4,D7 인 부서명 조회 X

-- 1) LEFT OUTER JOIN
-- 두 테이블 중 "왼편" 에 기술된 테이블을 기준으로 하여 JOIN
-- 즉, 뭐가 되었든 간에 왼편에 기술된 테이블의 데이터는 무조건 조회
-- (일치하는걸 찾지 못하더라도)
-->> ANSI 구문 
SELECT EMP_NAME, SALARY ,DEPT_TITLE
FROM EMPLOYEE
LEFT OUTER JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID);
--> EMPLOYEE 테이블을 기준으로 조회했기 때문에
-- EMPLOYEE 에 존재하는 테이터는 뭐가 되었든 간에 무조건 조회
-- (일치하는걸 찾지 못하더라도)

-->> 오라클 전용 구문
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID(+);
--> 내가 기준으로 삼을 테이블의 컬러명이 아닌
-- 반대 테이블의 컬럼명 뒤에 (+) 를 붙여준다. 참조한다? 그런뜻으로 쓰이는듯?

-- 2) RIGHT OUTER JOIN
-- 두 테이블 중 "오른편" 에 기술된 테이블을 기준으로 조인
-- 즉, 뭐가 되었든 간에 오른편에 기술된 테이블의 데이터는 무조건 조회
-- (일치하는것을 찾지 못하더라도)

-->>ANSI 구문
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE
RIGHT OUTER JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);
--> 우선 일치하는 행들을 조회 후,
-- 기준 테이블인 DEPARTMENT 테이블의 누락된 정보가 더해져서 조회됨!!!

-->> 오라클 전용 구문
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT 
WHERE DEPT_CODE(+) = DEPT_ID;
-- 오라클 구문은 순서 상관 X 어차피 나열하는것이기때문에 기준점만 확실하게 해주면 됨

-- RIGHT OUTER JOIN 을 이용해서
-- "전체" 사원들의 이름, 급여, 부서명을 보고싶다면?
-->> ANSI 구문
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM DEPARTMENT
RIGHT OUTER JOIN EMPLOYEE ON(DEPT_CODE = DEPT_ID);
-->> 오라클 전용 구문
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID(+); -- DEPT_ID(+) = DEPT_CODE 해도 출력이 같음
--> 오라클 전용 구문은 기술 순서에 상관 없이 방햔만 잘 맞춰주면 됨!!

-- 3) FULL OUTER JOIN
-- 두 테이블이 가진 모든 행을 조회할 수 있도록 조인
-- 즉, 일치하는 것들을 찾고, 양쪽 테이블에서 누락된 데이터를 각각 붙임!!
-- 단, 오라클 전용 구문에서는 절대 불가!!

-->> ANSI 구문
SELECT EMP_NAME, SALARY , DEPT_TITLE
FROM EMPLOYEE
FULL /*OUTER 생략 가능*/ JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

-->> 오라클 구문
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE ,DEPARTMENT
WHERE DEPT_CODE(+)= DEPT_ID(+);
--> 오류남: ONLY ONE OUTER-JOINED TABLE // 오라클은 "절대" 못씀
-- 포괄 조인 / 외부 조인
-- : 왼쪽 기준일 경우 일치하는것 + 왼쪽에서 누락된 데이터
-- : 오른쪽 기준일 경우 일치하는것 + 오른쪽에서 누락된 데이터
-- : FULL 일 경우 (ANSI 만 가능) 일치하는것 + 왼쪽에서 누락 + 오른쪽에서 누락된 데이터

---------------------------------------------------------------------------------
/*
    3. 카테시안 곱 / 교차 조인
    
    모든 테이블의 각 행들이 서로서로 맵핑된 데이터가 조회됨(곱집합)
    두 테이블의 모든 행들이 모두 곱해진 행들의 조합이 다 출력됨
    => 방대한 데이터 출력 => 과부하 위험
    
    주로, 내가 JOIN 구문 작성 시 실수할 경우 발생하지,
    대놓고 실무에서 사용될 일은 극히 드물다.
        
*/

-- 사원명, 부서명 조회
--> 오라클 전용 구문
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT;
--> 23 * 9 = 207 개 행 조회

-->> ANSI 구문
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
CROSS JOIN DEPARTMENT;

-----------------------------------------------------------------------------

/*
    4. 비등가 조인 (NON EQUAL JOIN)
    
    연결고리에 대한 조건식에 '=' (등호) 를 사용하지 않는 조인문
    주로, 지정한 컬럼값이 일치하는 경우가 아닌,
    "범위" 에 포함되는 경우 매칭
    
*/

-- EMPLOYEE 테이블로부터 사원명, 급여
SELECT EMP_NAME, SALARY /*SAL_LEVEL*/
FROM EMPLOYEE;

SELECT * FROM SAL_GRADE;
--> EMPLOYEE 테이블의 SAL_LEVEL 컬럼 (파생컬럼) 은 없어도 무방!!
--  (사실 없는게 더 권장사항임)
-- 왜? SALARY 급여는 유동적인 값인데, SALARY 값이 변할 때마다
-- 그에 맞는 SAL_LEVEL 컬럼값도 함께 변경해줘야함!!
-- 변경도 귀찮을 뿐만 아니라, 변경하는 과정에서 실수할 경우
-- 데이터의 불일치 현상이 발생할 수 있기 때문!!

-- 파생컬럼 예시) EMPLOYEE 테이블의 연봉 컬럼 
--> 마찬가지로 SALARY 가 변경 될때마다 연봉 컬럼값도 같이 계산해서 바꿔야함!!

-- 사원명, 급여, 급여등급 (SAL_GRADE 테이블의 컬럼으로)
-->> 오라클 전용 구문
SELECT EMP_NAME, SALARY, S.SAL_LEVEL
FROM EMPLOYEE , SAL_GRADE S
--WHERE (MIN_SAL <= SALARY) AND (SALARY<= MAX_SAL);
WHERE SALARY BETWEEN MIN_SAL AND MAX_SAL;
-->> ANSI 구문
SELECT EMP_NAME, SALARY, E.SAL_LEVEL, S.SAL_LEVEL
FROM EMPLOYEE E
--JOIN SAL_GRADE S ON (MIN_SAL <= SALARY AND SALARY <= MAX_SAL);
JOIN SAL_GRADE S ON (SALARY BETWEEN MIN_SAL AND MAX_SAL);

--> ANSI 구문 형식으로 비등가 조인을 하고싶다면
-- 무조건 ON 구문만 사용 가느함!!
-- 왜? 내가 직접 복잡한 조건식을 기술할 수 밖에 없기 때문

-- 비등가 조인 예시)
-- 인터넷 쇼핑몰
-- 회원 정보 테이블 / 구매금액에 따른 구간별 회원등급 테이블
--------------------------------------------------------------------------------------
/*
     5. 자체 조인 (SELF JOIN)
     
     같은 테이블을 다시 한번 조인하는 경우
     즉, 자기 자신의 테이블과 다시 조인을 맺는 경우
     AMBIGUOUSLY 오류 주의!!
*/


SELECT EMP_ID "사원 사번", EMP_NAME "사원 이름", SALARY "사원 급여", MANAGER_ID "사수 사번"
FROM EMPLOYEE;
--> 사수의 사번을 통해 해당 사수의 정보를 알아내보자!!

SELECT * FROM EMPLOYEE E; -- 사원에 대한 정보 도출용 (MANAGER_ID)
SELECT * FROM EMPLOYEE M; -- 사수에 대한 정보 도출용 (EMP_ID)
-- 단, 사수가 없다라도 "전체" 사원의 정보는 다 보고싶음!!
-- 사원 사번, 사원명, 사원 부서코드, 사원 급여
-- 사수 사번, 사수명, 사수 부서코드, 사수 급여
-->> 오라클 전용 구문
SELECT E.EMP_ID "사원 사번", E.EMP_NAME "사원명", E.DEPT_CODE "사원 부서코드", E.SALARY "사원 급여"
     , M.EMP_ID "사원 사번", M.EMP_NAME "사수명", M.DEPT_CODE "사수 부서코드", M.SALARY"사수 급여"
     FROM EMPLOYEE E, EMPLOYEE M
     WHERE E.MANAGER_ID = M.EMP_ID(+);
-->> ANSI 구문
SELECT E.EMP_ID "사원 사번", E.EMP_NAME "사원명", E.DEPT_CODE "사원 부서코드", E.SALARY "사원 급여"
     , M.EMP_ID "사원 사번", M.EMP_NAME "사수명", M.DEPT_CODE "사수 부서코드", M.SALARY"사수 급여"
     FROM EMPLOYEE E
     LEFT JOIN EMPLOYEE M ON(E.MANAGER_ID= M.EMP_ID);
--> 사원의 부서코드 뿐만 아니라 부서명도 보고싶다면?
-- 사수 또한 부서코드 뿐만 아니라 부서명도 보고싶다면?


-- 사원 사번, 사원명, 사우너 부서코드, 사원 부서명 , 사원급여
-- 사원 사번, 사원명, 사우너 부서코드, 사원 부서명 , 사원급여

-->> 오라클
SELECT E.EMP_ID "사원 사번", E.EMP_NAME "사원명", E.DEPT_CODE "사원 부서코드", E.SALARY "사원 급여" , D1.DEPT_TITLE "부서명"
, M.EMP_ID "사원 사번", M.EMP_NAME "사수명", M.DEPT_CODE "사수 부서코드", M.SALARY"사수 급여" ,D2.DEPT_TITLE"부서명"
FROM EMPLOYEE E, EMPLOYEE M, DEPARTMENT D1, DEPARTMENT D2
WHERE E.DEPT_CODE = D1.DEPT_ID
AND   M.DEPT_CODE = D2.DEPT_ID
AND   E.MANAGER_ID = M.EMP_ID(+);
-->> ANSI
SELECT E.EMP_ID "사원 사번", E.EMP_NAME "사원명", E.DEPT_CODE "사원 부서코드", E.SALARY "사원 급여" , D1.DEPT_TITLE "부서명"
, M.EMP_ID "사원 사번", M.EMP_NAME "사수명", M.DEPT_CODE "사수 부서코드", M.SALARY"사수 급여" ,D2.DEPT_TITLE"부서명"
FROM EMPLOYEE E
LEFT JOIN EMPLOYEE M ON (E.MANAGER_ID = M.EMP_ID)
LEFT JOIN DEPARTMENT D1 ON(E.DEPT_CODE = D1.DEPT_ID)
LEFT JOIN DEPARTMENT D2 ON(M.DEPT_CODE = D2.DEPT_ID);
--> 여러개의 테이블 또한 조인 가능하다.
-- ANSI 구문의 경우 JOIN 절 작성 순서가 중요!!

----------------------------------------------------------------

/*
    < 다중 JOIN >
    
    3 개 이상의 테이블을 조인하는 것
    ANSI 구문의 경우 JOIN 작성 순서가 중요하다!!
    
*/

-- 사번, 사원명, 부서명, 직급명 , 근무지역명
SELECT * FROM EMPLOYEE;    -- DEPT_CODE   JOB_CODE
SELECT * FROM DEPARTMENT;  -- DEPT_ID
SELECT * FROM JOB;         --             JOB_CODE
SELECT * FROM LOCATION;    --             LOCAL_CODE


-->> 오라클 전용 구문
SELECT E.EMP_ID "사번" , E.EMP_NAME "사원명" , J.JOB_NAME "직급명", L.LOCAL_NAME "근무지역명"

FROM EMPLOYEE E, DEPARTMENT D,JOB J, LOCATION L
WHERE E.DEPT_CODE = D.DEPT_ID (+)
AND E.JOB_CODE =J.JOB_CODE(+)
AND D.LOCATION_ID = L.LOCAL_CODE(+);

-->> ANSI 구문
SELECT E.EMP_ID "사번" , E.EMP_NAME "사원명" , J.JOB_NAME "직급명", L.LOCAL_NAME "근무지역명"
FROM EMPLOYEE E
LEFT JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
LEFT JOIN JOB J USING (JOB_CODE)--JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
LEFT JOIN LOCATION L ON(D.LOCATION_ID = L.LOCAL_CODE);
--> ANSI 구문의 경우 JOIN 절 작성 순서가 중요하다!!
-- LOCATION 테이블이 DEPARTMENT 테이블보다 먼저 JOIN 불가!!

-- 사원명, 부서명, 직급명, 근무지역명, 근무국가명, 급여등급
SELECT * FROM EMPLOYEE;    -- DEPT_CODE     JOB_CODE                                   SALARY
SELECT * FROM DEPARTMENT;  -- DEPT_ID                   LOCATION_ID
SELECT * FROM JOB;         --               JOB_CODE
SELECT * FROM LOCATION;    --                           LOCAL_CODE    NATIONAL_CODE
SELECT * FROM NATIONAL;    --                                         NATIONAL_CODE
SELECT * FROM SAL_GRADE;   --                                                           MIN_SAL /MAX_SAL
-->>  오라클 구문
SELECT E.EMP_NAME "사원명" , D.DEPT_TITLE "부서명", J.JOB_NAME "직급명", L.LOCAL_NAME "근무지역명", N.NATIONAL_NAME "근무국가명", E.SAL_LEVEL "급여등급" 
FROM EMPLOYEE E, DEPARTMENT D, JOB J, LOCATION L,  NATIONAL N, SAL_GRADE S
WHERE E.DEPT_CODE =D.DEPT_ID AND E.JOB_CODE= J.JOB_CODE AND D.LOCATION_ID = L.LOCAL_CODE AND L.NATIONAL_CODE = N.NATIONAL_CODE
AND E.SALARY BETWEEN S.MIN_SAL AND S.MAX_SAL;
-->> ANSI
SELECT E.EMP_NAME "사원명" , D.DEPT_TITLE "부서명", J.JOB_NAME "직급명", L.LOCAL_NAME "근무지역명", N.NATIONAL_NAME "근무국가명", E.SAL_LEVEL "급여등급" 
FROM EMPLOYEE E
JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
JOIN JOB J USING(JOB_CODE)
JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
JOIN NATIONAL N USING (NATIONAL_CODE)
JOIN SAL_GRADE S ON (E.SALARY BETWEEN S.MIN_SAL AND S.MAX_SAL);
-----------------------------------------------------------------------


------------------------------<JOIN 종합 실습문제 >-----------------------