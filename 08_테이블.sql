-- 8. 테이블과 뷰
create database tabledb;
use tabledb;

create table usertbl
(
	userID char(8) not null primary key,
	name varchar(10) not null,
	birthyear int not null,
	addr char(2) not null,
	mobile1 char(3) null,
	mobile2 char(8) null,
	height int null,
	mdate date null
	
);

show index from usertbl;

create table usertbl
(
	userid		varchar(8)	primary key,
	name		varchar(10) not null,
	birthyear	int			not null
);

DROP TABLE  if exists usertbl;

create table buytbl
(
	num			int			auto_increment primary key,
	userid		varchar(8)	not null,
	prodname	varchar(8) 	not null,
	constraint fk_buytbl_usertbl foreign key(userid)
	references usertbl(userid)
);

show index from buytbl;

INSERT INTO usertbl VALUES('LSG', '이승기', 1987);
INSERT INTO usertbl VALUES('KBS', '김범수', 1979);
INSERT INTO buytbl VALUES(NULL, 'LSG', '운동화');
INSERT INTO buytbl VALUES(NULL, 'LSG', '노트북');


select * from usertbl;
select * from buytbl;

-- 데이터 실습 기준 테이블(usertbl) userid 컬럼에 ' ABC' 데이터가 없으므로 에러 발생 
insert into buytbl(num, userid, prodname) values(null, 'ABC','운동화');
update buytbl set userid = 'ABC' where num = 1;

-- 데이터 실습 : 기준테이블에 'ABC' data insert 

insert into usertbl(userid, name,birthyear) values('ABC','홍길동',1990);

select* from usertbl;

insert into buytbl(num, userid, prodname) values(null, 'ABC','운동화');
update buytbl set userid = 'ABC' where num = 1;
select * from buytbl;

-- 데이터 실습 : 기준테이블 데이터 변경 / 삭제 (error : 외래키 테이블에 데이터가 존재하기 때문)
delete buytbl where userid='ABC';
delete usertbl where userid='ABC';
update usertbl set userid='DEF' where userid= 'ABC';

-- 기준 테이블, 변경, 삭제 시 외래키테이블 자동적용
alter table buytbl
	drop constraint fk_buytbl_usertbl;
alter table buytbl
	add constraint fk_buytbl_usertbl foreign key(userid)
		references usertbl(userid)
		on update cascade
		on delete cascade;
delete from usertbl where userid='ABC';
select * from usertbl;
delete from buytbl where userid='ABC';
select * from buytbl;

update usertbl set userid='DEF' where userid= 'LSG';
select * from usertbl;
select * from buytbl;

-- 3) unique key

alter table usertbl
	add email varchar(50);

select * from usertbl;

alter table usertbl
	add constraint uk_usertbl_email
	unique key(email);
	
show index from  usertbl;

update usertbl set email='test@com';

-- 4) check
alter table usertbl 
	add constraint chk_usertbl_birthyear
	check(birthyear >= 1900);
	
insert into usertbl(userid, name, birthyear,email) values('ABC','홍길동',1800,null);

-- 5) Default
alter table usertbl
	alter column birthyear set default 2023;
	
insert into usertbl(userid, name, birthyear,email) values('ABC','홍길동',default,null);
select * from usertbl;

insert into usertbl(userid, name, birthyear,email)
	values('bbc','홍길동',default,null);

insert into usertbl(userid,name,email)
	values('ccc','홍홍홍',null);
	
select * from usertbl;

-- 6) NULL
alter table usertbl 
	modify column name varchar(8) null;

select * from usertbl;

insert into usertbl(userid, name, birthyear, email)
	values('ABb',null,1990,null);
	
-- null 데이터가 존재하므로 not null 변경불가
alter table usertbl 
	modify column name narchar(8) not null;
	
-- null 데이터 update 후 not null 변경 가능
select * from usertbl;

update usertbl set name = '김진산' where name is null;

select * from usertbl;

alter table usertbl 
	modify column name narchar(8) not null;
	
-- 3. 테이블 수정 / 삭제
-- 1) xpdlqmf dkqcnr
create table 테이블명( 컬럼 설정 )
	row_format=compressed;
	
-- 2) 임시테이블
create temporary table temptbl(id int, name varchar(8));

select * from temptbl;
insert into temptbl values(1,'임시');

-- 3) 테이블 수정 / 삭제

alter table usertbl 
	add mobile varchar(20) null;

alter table usertbl 
	drop mobile;

alter table usertbl 
	modify name varchar(20) null;

alter table usertbl
	change name char(30);
	

select * from usertbl;
--