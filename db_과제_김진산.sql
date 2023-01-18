-- 데이터 베이스 생성
create database employees;
-- 데이터 베이스 사용
use employees;

-- employees의 table 생성
create table employees(
	emp_no 		int primary key not null comment '사원번호',
	emp_name	varchar(20) not null comment 	 '사원이름',
	emp_phone	varchar(20) not null comment	 '전화번호',
	addr		varchar(100) default null comment'주소'	 ,
	email		varchar(100) default null comment'이메일'
);

-- 데이터 생성
insert into employees (emp_no, emp_name, emp_phone, addr, email)
	values(1001, '홍길동', '010-1111-1111', '서울시 강남구', 'hong@naver.com');
insert into employees (emp_no, emp_name, emp_phone, addr, email)
	values(1002, '강감찬', '010-2222-2222', '인천시 서구', 'kang@hotmail.com');
insert into employees (emp_no, emp_name, emp_phone, addr, email)
	values(1003, '홍길동', '010-3333-3333', '수원시 성남구', 'lee@gmail.com');
	
-- 데이터 생성 후 조회
select * from employees;

-- 데이터 삭제
delete from employees;
-- 데이터 삭제 후 확인
select * from employees;