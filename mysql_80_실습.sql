/**
* MYSQL :: 정형 데이터를 저장하는 데이터베이스
- SQL 문법을 사용하여 데이터를 CRUD한다.
- C(Create:생성, insert)
- R(Read:조회, select)
- U(Update:수정, update)
- D(Delete:삭제, delete)
- 개발자는 DML에 대한 CRUD 명령어를 잘 사용할 수 있어야한다!!!
- SQL은 대소문자 구분하지 않음, 보통 소문자로 작석
- snake 방식의 네이밍 규칙을 가짐

- SQL은 크게 DDL, DML, DCL, DTL로 구분할 수 있다.
1. DDL(Data Definition Language) : 데이터 정의어
	: 데이터를 저장하기 위한 공간을 생성하고 논리적으로 정의하는 언어
    : create, alter, truncate, drop ..
2. DML(Data Manipulation Language) : 데이터 조작어
	: 데이터를 CRUD하는 명령어
    : insert, select, update, delete
3. DCL(Data Control Language) : 데이터 제어어
	: 데이터에 대한 권한과 보안을 정의하는 언어
    : grant, revoke
4. DTL(Data Transaction Language,TCL) : 트랜잭션 제어어
	: 데이터베이스의 처리 작업 단위인 트랜잭션을 관리하는 언어
    : commit, save, rollback
*/

/* 반드시 기억해주세요!!! - 워크벤치 실행시 마다 명령어 실행!!! */
show databases;		-- 모든 데이터베이스 조회
use hrdb2019;		-- 사용할 데이터베이스 오픈
select database();	-- 데이터베이스 선택
show tables;		-- 데이터베이스의 모든 테이블 조회

use market_db;
select database();
show tables;

/************************************
	DESC(DESCRIBE) : 테이블 구조 확인
    형식> desc(describe) [테이블명];
*************************************/
show tables;
desc employee;
desc department;
desc unit;
desc vacation;

/************************************
	SELECT : 테이블 내용 확인
    형식> select [컬럼리스트] from [테이블명];
*************************************/
select emp_id, emp_name from employee;
select * from employee;
select emp_name, gender, hire_date from employee;

-- 사원테이블의 사번, 사원명, 성별, 입사일, 급여를 조회
select emp_id, emp_name, gender, hire_date, salary from employee;

-- 부서테이블의 모든 정보 조회
select * from department;

--	AS : 컬럼명 별칭 부여
--  형식> select [컬럼명 as 별칭, ...] from [테이블명];
-- 사원테이블의 사번, 사원명, 성별, 입사일, 급여 컬럼을 조회한 한글 컬럼명으로 출력
select emp_id as "사 번", emp_name as 사원명, gender as 성별, hire_date 입사일, salary 급여 from employee;

-- 사원테이블의 ID, NAME, GENDER, HDATE, SALARY 컬럼명으로 조회
select emp_id as ID, emp_name as NAME, GENDER, hire_date HDATE, SALARY from employee;

-- 사원테이블의 사번, 사원명, 부서명, 폰번호, 이메일, 급여, 보너스(급여*10%)
-- 기존의 칼럼에 연산을 수행하여 새로운 칼럼을 생성할 수 있다!!

desc employee;
select emp_id, emp_name, dept_id, phone, email, salary, salary*0.1 as bonus from employee;

-- 현재 날짜를 조회 : curdate()
select curdate() as DATE from dual;

/************************************
	SELECT : 테이블 내용 상세 조회
    형식> select [컬럼리스트] 
			from [테이블명]
			where [조건절];
*************************************/
-- 정주고 상원의 정보를 조회
select * from employee;
select * from employee where emp_name = '정주고';		-- "" 사용 가능

-- sys 부서에 속한 모든 사원을 조회
select * from employee where dept_id = "sys";




