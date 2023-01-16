-- 1. 클러스터형 인덱스
create database indexdb;
use indexdb;


create table usertbl
(
	userid		varchar(8)	primary key,
	name		varchar(10) not null,
	birthyear	int			not null,
	addr		varchar(10) not null
);

INSERT INTO usertbl VALUES('LSG', '이승기', 1987, '서울');
INSERT INTO usertbl VALUES('KBS', '김범수', 1979, '경남');
INSERT INTO usertbl VALUES('KKH', '김경호', 1971, '전남');
INSERT INTO usertbl VALUES('JYP', '조용필', 1950, '경기');
INSERT INTO usertbl VALUES('SSK', '성시경', 1979, '서울');

select * from usertbl;

alter table usertbl
drop primary key;

delete from usertbl;

select * from usertbl;

-- 2. 보조 인덱스

create index idx_usertbl_addr
	on usertbl (addr);
show table status;

show index from usertbl;

create unique index idx_usertbl_birthyear
	on usertbl(birthyear);

create unique index idx_usertbl_name
	on usertbl(name);

insert into usertbl values('aaa', '홍홍홍',1990,'인천');

-- 3. 조합 인덱스

create index idx_usertbl_02
	on usertbl(name, birthyear);

explain select * from usertbl where name='홍길동';

drop index idx_usertbl_name
	on usertbl;
	
show table status;

-- 4. 인덱스 성능 비교
-- 1) 테이블 복사
select count(*)
  from employees.employees;
  
 
create table emp 
select * from employees.employees; -- 인덱스 없음

create table emp_c
select * from employees.employees; -- primary key 적용 (emp_no)

create table emp_se 
select * from employees.employees; -- 보조인덱스 적용 (emp_no)

select count(*) from emp;

select count(*) from emp_c;

select count(*) from emp_se;

show table status;

analyze table emp;
analyze table emp_c;
analyze table emp_se;

show table status;
 
-- 2) 인덱스 생성
alter table emp_c
	add primary key(emp_no);
 
create index idx_emp_se
on emp_se(emp_no);

-- 3) id=10020 데이터 조회
explain select * from emp where emp_no = 10020;
explain select * from emp_c where emp_no = 10020;
explain select * from emp_se where emp_no = 10020;
 

explain select count(*) from emp; 
explain select count(*) from emp_c;
explain select count(*) from emp_se;

-- 4) 강제로 인덱스 제외
explain 
	select * 
		from emp_c 
			ignore index (primary)where emp_no = 10020;
			
-- 5) 강제로 인덱스 적용
-- index 2개 : idx_emp_se => emp_no,  idx_emp_se_01 => first_name
create index idx_emp_se_02
on emp_se(first_name);

show index idx_emp_se;
analyze table idx_emp_se_01;
explain select * from emp_se where first_name = '성시경' and emp_no =10020;