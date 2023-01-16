-- 1. SQL분류

-- 2. 데이터 조회
-- 1) TABLE 조회

show databases;

use shopdb;

show tables;

show table status;

desc membertbl;


-- 2) 기본 SQL문

use employees;

select * from titles;
select * from employees.titles;

select emp_no, title from titles;


select * from titles where title = 'Staff';
select count(*) from titles where title = 'Staff';
select count(*) from titles;

select emp_no as '사원번호', title as '직무' from titles;

select distinct title from titles;

-- 3) SQL DB 생성
-- sql database 생성
create database SQLDB;

-- sqlDB 연결
USE sqlDB;

-- userTBL 생성

DROP TABLE IF EXISTS buyTBL, userTBL ;
CREATE TABLE userTBL
( userID		CHAR(8) not null primary key, 	-- 사용자 아이디(PK)
  name		VARCHAR(10) NOT NULL, 		-- 이름
  birthYear	INT NOT NULL,			-- 출생연도
  addr		CHAR(2) NOT NULL,		-- 지역(서울, 경기, 경남)
  mobile1	CHAR(3),				-- 국번
  mobile2	CHAR(8),				-- 번호2
  height		SMALLINT,			-- 키
  mDate		DATE				-- 회원 가입일
);

-- buyTBL 생성
CREATE TABLE buyTbl
( num		INT AUTO_INCREMENT NOT NULL PRIMARY KEY,-- 순번(PK)
  userID		CHAR(8) NOT NULL, 			 		-- 아이디(FK)
  prodName	CHAR(6) NOT NULL,						-- 물품명
  groupName	CHAR(4),								-- 분류
  price		INT NOT NULL,							-- 단가
  amount		SMALLINT NOT NULL,					-- 수량
  FOREIGN KEY (userID) REFERENCES userTbl(userID)	-- 외래 키 지정
);

-- userTBL 데이타 생성
INSERT INTO usertbl VALUES('LSG', '이승기', 1987, '서울', '011', '11111111', 182, '2008-8-8');
INSERT INTO usertbl VALUES('KBS', '김범수', 1979, '경남', '011', '22222222', 173, '2012-4-4');
INSERT INTO usertbl VALUES('KKH', '김경호', 1971, '전남', '019', '33333333', 177, '2007-7-7');
INSERT INTO usertbl VALUES('JYP', '조용필', 1950, '경기', '011', '44444444', 166, '2009-4-4');
INSERT INTO usertbl VALUES('SSK', '성시경', 1979, '서울',  NULL,       NULL, 186, '2013-12-12');
INSERT INTO usertbl VALUES('LJB', '임재범', 1963, '서울', '016', '66666666', 182, '2009-9-9');
INSERT INTO usertbl VALUES('YJS', '윤종신', 1969, '경남',  NULL,       NULL, 170, '2005-5-5');
INSERT INTO usertbl VALUES('EJW', '은지원', 1972, '경북', '011', '88888888', 174, '2014-3-3');
INSERT INTO usertbl VALUES('JKW', '조관우', 1965, '경기', '018', '99999999', 172, '2010-10-10');
INSERT INTO usertbl VALUES('BBK', '바비킴', 1973, '서울', '010', '00000000', 176, '2013-5-5');

select * from usertbl;

-- buyTBL 데이타 생성
INSERT INTO buytbl VALUES(NULL, 'KBS', '운동화',  NULL,  30,   2);
INSERT INTO buytbl VALUES(NULL, 'KBS', '노트북',  '전자',  1000,   1);
INSERT INTO buytbl VALUES(NULL, 'JYP', '모니터',  '전자',  200,   1);
INSERT INTO buytbl VALUES(NULL, 'JYP', '모니터', '전자',  200,  1);
INSERT INTO buytbl VALUES(NULL, 'BBK', '모니터', '전자',  200,  5);
INSERT INTO buytbl VALUES(NULL, 'KBS', '청바지', '의류',  50,   3);
INSERT INTO buytbl VALUES(NULL, 'BBK', '메모리', '전자',  80,  10);
INSERT INTO buytbl VALUES(NULL, 'SSK', '책',	   '서적',  15,   5);
INSERT INTO buytbl VALUES(NULL, 'EJW', '책',    '서적',  15,   2);
INSERT INTO buytbl VALUES(NULL, 'EJW', '청바지', '의류',  50,   1);
INSERT INTO buytbl VALUES(NULL, 'BBK', '운동화',  NULL,  30,   2);
INSERT INTO buytbl VALUES(NULL, 'EJW', '책',    '서적',  15,   1);
INSERT INTO buytbl VALUES(NULL, 'BBK', '운동화',  NULL,  30,   2);

select * from buytbl;




-- 3) 조건 연산자
select * from usertbl

select * 
from usertbl 
where name = '바비킴';

-- ">=" 연산자 : 출생연도가 '1970'년 이상이니 사람
select *
from usertbl
where birthYear >= '1970';

-- "!=" 연산자 : 주소가 "서울"이 아닌 사람
select *
from usertbl
where addr != '서울';

-- 4) 관계 연산자
-- "AND" 출생 연도가 1970년 이상이면서 키가 182 이상인 사람

select *
from usertbl
where birthYear >= '1970' and height >= '182';

-- "or" 출생 연도가 1970년 이상이거나 키가 182 이상인 사람
select *
from usertbl
where birthYear >= '1970' or height >= '182';

-- "BETWEEN" 키가 170보다 크거나 같고 183보다 작거나 같은사람
select *
from usertbl
where height between 170 and 183 ;

-- "IN" 
analyze select *
from usertbl
where addr = '경기' or addr = '서울';

select *
from usertbl
where addr in ('서울', '경기');

-- "LIKE" 성이 김씨인 사람
select *
from usertbl
where  name like '김%';

-- 이름중에 '경'글자가 포함된 사람
select *
from usertbl
where name like '%경%'

-- 이름이 '수로 끝나느 사람'
select *
from usertbl
where name like '%수'

select *
from usertbl
where name like '%종신' or '%신%';

select '김윤종신' like '_종신';

select *
from usertbl
where birthYear >= 1970 and addr = '서울'

-- 5) SubQuery : 서브쿼리
-- SubQuery 조건 : 키가 177이상인 사람

select height
from usertbl
where height >= 177;

-- 서브쿼리의 결과인 키보다 큰사람
select *
from usertbl
where height  < all (select height
					from usertbl
					where height > 177);
					
-- 이름이 김경호인 사람의 키보다 큰사람
				
select height from usertbl
where name = '김경호'

select *
from usertbl
where height > all (select height
					from usertbl
					where name = '김경호');
					
-- 주소가 '서울'인 사람의 키를 가져오되 키가 같은 사람들의 모든 정보 가져오기을 서브쿼리로 작성
				
select * 
from  usertbl
where height in (select height 
					from usertbl
					where addr = '서울');


select *
from buytbl
where userID in (select userid
				from usertbl
				where addr = '서울');
				
-- 6) ORDER BY
-- 먼저 가입한 순서대로 조회하기
select *
from usertbl
where addr = '서울'
order by mDate desc;

-- 7) distinct / limit
select distinct addr from usertbl;
select * 
from usertbl
order by name
limit 5, 3;


-- 조회를 통한 테이블 생성 및 데이터 insert
create table buytbl2
select * from buytbl;

insert into buytbl2
select* from buytbl; 

create table buytbl3
select userid, price, amount from buytbl where price > 50;


-- 7) GROUP BY 

select *
from buytbl
order by userID;

-- group by 기본 구문 및 alias 적용
select userID, sum(amount)
from buytbl
group by userID;

select userID, 	
		sum(price) '가격', 
		sum(amount) '구매수량', 
		sum(price * amount)'총 금액',
		avg(price * amount),
		count(*)
from buytbl
group by userID;

-- max, min--
select addr, max(height), min(height), avg(height), count(*)
from usertbl
group by addr;

select birthYear , max(height), min(height), avg(height), count(*)
from usertbl
group by birthYear;

-- 휴대폰 번호가 있는 사용자의 수

select count(*)
from usertbl
where mobile1 is not null;

-- 가장 키가 큰 사람의 이름과 키를 조회 : usertbl
select max(height) from usertbl;

select height, name
from usertbl
where height = all (select max(height) from usertbl);

-- 가장 키가 큰 사람의 키를 가져온 다음에, 키가 같은 사람의 이름과 키를 조회 :usertbl
select max(height), min(height) from usertbl;

select height, name
from usertbl
where height = (select max(height) from usertbl)
   or height = (select min(height) from usertbl);

select height, name
from usertbl
where height in (select max(height) from usertbl, select min(height) from usertbl);

-- group by having 구문
select userID, 	
		sum(price) '가격', 
		sum(amount) '구매수량', 
		sum(price * amount)'총 금액',
		avg(price * amount),
		count(*)
from buytbl
group by userID
having sum(price * amount) > 200
order by userID desc;

select userID, 	
		sum(price) '가격', 
		sum(amount) '구매수량', 
		sum(price * amount)'총 금액',
		avg(price * amount),
		count(*)
from buytbl
where price > 100
group by userID
having sum(price * amount) > 200
order by sum(price * amount)
limit 2;

-- step 1 집계하고자 하는 데이터를 전체 데이터에서 추출 (총액 : 3,580원)
select userID , prodName , groupName, price , amount, price *amount as '구매금액' 
from buytbl 
where price > 20;

-- step 2  사용자 id별 구매금액
select userID , 
	sum(price) as '단가의 합계', 
	sum(amount) as '구매 수량의 합계', 
	sum(price *amount) as '구매금액' 
from buytbl 
where price > 20
group by userID ;

-- step 3 사용자 id 별 총액이 100원 미만은 제외
select userID , 
	sum(price) as '단가의 합계', 
	sum(amount) as '구매 수량의 합계', 
	sum(price *amount) as '구매금액' 
from buytbl 
where price > 20
group by userID 
having sum(price *amount) > 100;

-- step 4 큰 구매금액 순으로
select userID , 
	sum(price) as '단가의 합계', 
	sum(amount) as '구매 수량의 합계', 
	sum(price *amount) as '구매금액' 
from buytbl 
where price > 20
group by userID 
having sum(price *amount) >= 100
order by sum(price *amount) desc;

