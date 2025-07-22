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

-- 사번이 s0005인 사원의 사원명, 성별, 입사일, 부서아이디, 이메일, 급여를 조회

select emp_name, gender, hire_date, dept_id, email, salary from employee where emp_id = "s0005";

-- SYS 부서에 속한 모든 사원들을 조회, 단 출력되는 EMP_ID 칼럼은 '사원번호' 별칭으로 조회
select emp_id as '사원번호', emp_name, eng_name, gender, hire_date, salary from employee where dept_id = "sys";

-- emp_name '사원명' 별칭 수정
select emp_id as '사원번호', emp_name as '사원명', eng_name, gender, hire_date, salary from employee where dept_id = "sys";

-- !! where 조건절 컬럼으로 별칭을 사용할 수 있을까요???
-- 사원명이 홍길동인 상원을 별칭으로 조회??? ::: where 조건절에서 별칭을 컬럼명으로 사용 x
select emp_id as '사원번호', emp_name as '사원명', eng_name, gender, hire_date, salary from employee where '사원명' = '홍길동';
select emp_id as '사원번호', emp_name as '사원명', eng_name, gender, hire_date, salary from employee where 사원명 = '홍길동';

-- 전략기획(stg) 부서의 모든 사원들의 사번, 사원명, 입사일, 급여를 조회
select * from department;
select emp_id, emp_name, hire_date, salary, dept_id from employee where dept_id = "stg";

-- 입사일이 2014년 8월 1일인 사원들을 조회
select * from employee where hire_date = "2014-08-01";	-- DATE 타입은 표현은 문자열처럼, 처리는 숫자처럼
-- 급여가 5000인 사원을 조회
select * from employee where salary = 5000;
-- 성별이 남자인 사원들을 조회
select * from employee where gender = 'm';
-- 성별이 여자인 사원들을 조회
select * from employee where gender = "F";
select * from employee;

-- null : 아직 정의되지 않은 미지수
-- 숫자에서는 가장 큰수로 인식, 논리적인 의미를 포함하고 있으므로 등호(=)로는 검색 X, IS 키워드와 함께 사용O
-- 급여가 null인 값을 가진 사원들을 조회
select * from employee where salary = null;		-- 에러는 안생기지만 값은 안나옴
select * from employee where salary is null;	-- 옳은 방법

-- 영어이름이 정해지지 않은 사원들을 조회
select * from employee where eng_name is null;

-- 퇴사하지 않은 사원들의 보너스 칼럼(급여*20%)을 추가하여 조회
select *, salary*0.2 as bonus from employee where retire_date is null;

-- 퇴사한 사원들의 사번, 사원명, 이메일, 폰번호, 급여를 조회
select emp_id, emp_name, email, phone, salary from employee where retire_date is not null;

-- ifnull 함수 : null 값을 다른 값으로 대체하는 방법
-- 형식 ifnull(null포함컬럼명, 대체값)
-- sys 부서에 속한 사원들의 정보 조회, 단, 급여가 null인 사원은 0으로 치환
select emp_id, emp_name, email, phone, ifnull(salary, 0) as salary from employee where dept_id = 'stg';

-- 사원 전체 테이블의 내용을 조회, 단 영어이름이 정해지지 않은 사원들은 'smith' 이름으로 치환
select emp_id, emp_name, ifnull(eng_name, "smith") as eng_name, gender, phone, email, salary from employee;

-- mkt 부서의 사원들을 조회. 제작인인 사원들의 retire_date 컬럼은 현재 날짜로 치환
select emp_id, emp_name, eng_name, gender, hire_date, ifnull(retire_date, curdate()) as retire_date, phone, email, salary 
from employee 
where dept_id = "mkt";

/************************************
	DISTINCT : 중복된 데이터를 배제하고 조회
    형식> select distinct [컬럼리스트] ~
*************************************/
-- 사원테이블의 부서리스트를 조회
select distinct dept_id from employee;
-- 주의!! unique한 컬럼과 함께 조회하는 경우 distinct가 적용되지 않음
select distinct emp_id, dept_id from employee;

/************************************
	ORDER by 컬럼 : 데이터 정렬
    형식> select [컬럼리스트]
		from [테이블]
		where [조건절]
		order by [컬럼명, ... ] asc/desc
*************************************/
-- 급여를 기준으로 오름차순 : 오름차순은 생략 가능
select * from employee order by salary desc;
select emp_id, emp_name, hire_date as tt from employee order by tt;
-- 모든 사원을 급여, 성별을 기준으로 오름차순 정렬
select * from employee order by salary, gender;
-- eng_name이 null인 사원들을 입사일 기준으로 내림차순 정렬
select * from employee where eng_name is null order by hire_date desc;
-- 퇴직한 사원들을 급여기준으로 내림차순 정렬
select * from employee where retire_date is not null order by salary desc;
-- 퇴직한 사원들을 급여기준으로 내림차순 정렬, salary 컬럼을 '급여' 별칭으로 치환
-- '급여' 별칭으로 order by가 가능할까요??? :: 별칭으로 order by 가능함
-- where 조건절 데이터 탐색 > 컬럼리스트 > 정렬
select emp_id, emp_name, gender, hire_date, retire_date, phone, email, salary as 급여
from employee 
where retire_date is not null 
order by 급여 desc;

-- 정보시스템(sys) 부서 사원들 중 입사일이 빠른 순서로, 급여를 많이 받는 순서로 정렬
select emp_id, emp_name, dept_id, hire_date as '입사일', salary as '급여'
from employee 
where dept_id = "sys" 
order by 입사일 asc, 급여 desc;

/************************************
	조건절 + 비교연산자 : 특정 범위 혹은 데이터 검색
    형식> select [컬럼리스트]
		from [테이블]
		where [조건절]
		order by [컬럼명, ... ] asc/desc
*************************************/
-- 급여가 5000 이상인 사원들을 조회, 급여를 오름차순 정렬
select * from employee where salary >=5000 order by salary;
-- 입사일이 2017-01-01 이후 입사한 사원들을 조회
select * from employee where hire_date>='2017-01-01';
-- 입사일이 2015-01-01 이후이거나, 급여가 6000 이상인 사원들을 조회
-- ~이거나, ~또는 : or - 두 개의 조건중 하나만 만족해도 조회가능
select * from employee where hire_date>='2015-01-01' or salary >= 6000;

-- 입사일이 2015-01-01 이후이고, 급여가 6000 이상인 사원들을 조회
-- ~이고 : and - 두 개의 조건중 모두 만족해야만 조회가능
select * from employee where hire_date>='2015-01-01' and salary >= 6000;

-- 특정 기간 : 2015-01-01 ~ 2017-12-31 사이에 입사한 모든 사원 조회
-- 부서기준으로 오름차순 정렬
select * from employee where hire_date<='2017-12-31' and hire_date>='2015-01-01' order by dept_id asc;

-- 급여가 6000 이상 8000 이하인 사원들을 모두 조회
select * from employee where salary>=6000 and salary<=8000;

-- mkt 부서의 사원들의 사번, 사원명, 입사일, 이메일, 급여, 보너스(급여의 20%) 조회
-- 급여가 null인 사원의 보너스는 기본 50
-- 보너스가 1000 이상인 사원 조회
-- 보너스가 높은 사원 기준으로 정렬
select emp_id, emp_name, hire_date, email, salary, ifnull(salary*0.2, 50) as bonus 
from employee 
where dept_id = "mkt" and salary*0.2>=1000
order by bonus desc;

-- 사원명이 '일지매', '오삼식', '김삼순' 인 사원들을 조회
select *
from employee
where emp_name = '일지매' or emp_name = '오삼식' or emp_name = '김삼순';

/************************************
	논리곱(and) : between ~ and
    형식> select [컬럼리스트]
		from [테이블]
		where [컬럼명] between 값1 and 값2
	논리합(or) : in
    형식> select [컬럼리스트]
		from [테이블]
		where [컬럼명] in (값1, 값2, 값3 ...)
*************************************/
-- between ~ and
-- 특정 기간 : 2015-01-01 ~ 2017-12-31 사이에 입사한 모든 사원 조회
-- 부서기준으로 오름차순 정렬
select * from employee 
where hire_date between '2015-01-01' and '2017-12-31' 
order by dept_id asc;

-- 급여가 6000 이상 8000 이하인 사원들을 모두 조회
select * from employee 
where salary between 6000 and 8000;

-- 사원명이 '일지매', '오삼식', '김삼순' 인 사원들을 조회
select *
from employee
where emp_name in ('일지매', '오삼식', '김삼순');

-- 부서아이디가 mkt, sys, stg 에 속한 모든 사원 조회
select *
from employee
where dept_id in ("mkt","sys","stg")
order by dept_id;

/*********************************************
	특정 문자열 검색 : 와일드 문자(%, _) + like 연산자
					% : 전체, _ : 한글자
    형식> select [컬럼리스트] from [테이블]
		where [컬럼명] like '와일드 문자 포함 검색어'
**********************************************/
-- '한'씨 성을 가진 모든 사원을 조회
select *
from employee
where emp_name like '한%';

-- 영어이름이 'f'로 시작하는 모든 사원을 조회
select * 
from employee
where eng_name like 'f%';

-- 이메일 이름 중 두번째 자리에 'a'가 들어가는 모든 사원을 조회
select * 
from employee
where email like '_a%';

-- 이메일 아이디가 4자인 모든 사원을 조회
select * 
from employee
where email like '____@%';







desc employee;
select * from employee;




