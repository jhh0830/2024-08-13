/*
    < SUBQUERY 서브쿼리 >
    
    하나의 주된 SQL 문 (SELECT, INSERTM UPDATE, DELETE, CREATE....)
    안에 "포함된 또 하나의 SELECT 문"
    즉, 메인 SQL 문을 위해 보조 역할을 하는 쿼리문
    
    하나의 주된 SQL 문 : 메인쿼리
    포함된 또 하나의 SELECT 문 : 서브쿼리 - 1 (먼저 실행)
    
*/

-- 서브쿼리 맛보기 수업
-- 간단 서브쿼리 예시 1
-- 권가영 사원과 같은 부서인 사원들
-- 1) 먼저 권가영 사원이 부서코드 조회
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '권가영';
--> 권가영 사원의 부서코드는 D9임!!
-- 2) 부서코드가 D9 인 사원들 조회
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- 위의 두 단계를 하나의 쿼리문으로 합치기
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME = '권가영');

-- 간단 서브쿼리 예시 2
-- 전체 사원의 평균 급여보다 더 많은 급여를 받고 있는
-- 사원들의 사번, 이름, 직급코드를 조회
-- 1) 먼저 전체 사원들의 평균 급여 구하기
SELECT AVG(SALARY)
FROM EMPLOYEE;
--> 평균 급여가 대략 3047662 원 임!!

-- 2) 급여가 2047662 원 이상인 사원들을 조회
SELECT EMP_ID, EMP_NAME, JOB_CODE
FROM EMPLOYEE
WHERE SALARY >= 3047662;

-- 위의 두 단계를 하나의 쿼리문으로 합치기
SELECT EMP_ID, EMP_NAME, JOB_CODE
FROM EMPLOYEE
WHERE SALARY>=(SELECT AVG(SALARY)
FROM EMPLOYEE);
