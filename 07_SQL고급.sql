-- 1. Data Type
use sqldb;

-- 변수 선언 및 출력
set @a = 10;
set @b = 20;
set @stra = "mariadb";

select @a, @b, @stra;

-- 테이블과 변수 출력
select @stra, a.* ,'test'
  from usertbl a;
 
 select 'test', concat('아이디 :', a.userid)
   from usertbl a;
  
 insert into usertbl(userid, username, mdate)
 select id, name, '2022' from usertbl2;
 
-- 2. Data 형변환
select cast(avg(amount)as integer) '평균',
	   convert(avg(amount), integer) 'convert 적용',
	   avg(amount),
	   sum(amount),
	   count(*)
from buytbl;

-- 단가 * 수량 = 금액
price * amount = price*amount
-- 숫자를 문자형으로 바꾸기
-- 문자를 연결해야 함
select concat(cast(price as varchar(10)), 
		' * ' ,
		cast(amount as varchar(10)),
		' = ',
		cast(price*amount as varchar(10)))
from buytbl;


-- 2. 내장/윈도우 함수
-- 1) 제어 흐름 함수
-- if(수식, 값1, 값2)
-- usertbl의 birthyear가 50세 이상인 경우는 '50세 이상', 그 외에는 '50세 미만'으로 조회

select name, birthYear,
	if(birthYear <= '1972', '50세 이상', '50세 미만')
  from usertbl;

 -- ifnull(수식1, 수식2)
 -- usertbl에서 mobile1에 값이 있는 경우는 해당 값을, 없는 경우는 '연락처 없음'을 조회
 
 select name, mobile1, ifnull(mobile1, '연락처 없음')
   from usertbl;
  
-- nullif(수식1, 수식2)
select name, mobile1 , nullif(mobile1, '010')
  from usertbl;
 
-- case
-- addr이 '서울'이거나 '경기'이면 '수도권'으로 조회 나머지는 그대로 조회
select name, addr,
	case addr
		when '서울' then '수도권'
		when '경기' then '수도권'
		else addr
	end
  from usertbl;

 
-- 2) 문자열 함수
-- bit_length, char_length, length
-- 'abc','가나다'
select bit_length('abc'),
	   char_length('abc'),
	   length('abc');
	   
select bit_length('가나다'),
	   char_length('가나다'),
	   length('가나다');
	   
-- instr(문자열, 검색어)
select instr('apple banana orange', 'pp');

-- format(숫자, 소수점자리수)
select format(1234.578,2);

-- left, right

select left('apple banana orange', 5),  right('apple banana orange', 5);



-- replace
select replace('이것이 MariaDB이다.','이것이', 'This is');

-- substring
select substring(name,2,char_length(name)),
	   name,
	   char_length(name)
from usertbl;

-- 3) 수학함수
-- ceil, floor, round
select ceil(4.7), floor(4.7), round(4.7);

-- rand
select rand();

-- 4) 날짜 / 시간 함수
-- adddate +  / subdate - 
select name, mdate, 
	subdate(mdate, 5),
	adddate(mDate, interval 1 month),
	adddate(mdate, interval 1 year) 
  from usertbl;
 
-- now(), sysdate(), year(), month(), day()
 select now(), sysdate();
 select year(now()), month(now()), day(now()), date(now()), time(now());

-- period_add, period_diff
select period_add(2023-01,50);
select period_diff(5,6);
 
-- 5) 시스템 정보 함수
-- user, database 확인
select user(), database();

-- found_rows()
select * from buytbl;
select found_rows();

-- row_count

update buytbl set amount=3 where userid = 'KBS';
select row_count();

-- 6) BLOB 형태 데이터 입력
create table blobtbl (col1 varchar(50), col2 longblob);
desc blobtbl;

insert into blobtbl(col1, col2)
values('3', load_file('c:\\kdtwork\\dbwork\\69c0252b-5e71-476c-b002-acbb9a71a619.png'));

select *
  from blobtbl;
  
delete from where 
 
select col2 into dumpfile 'c:\\kdtwork\\dbwork\\69c0252b-5e71-476c-b002-acbb9a71a6192.png'
  from blobtbl
 where col1='3';

-- 7) 윈도우 함수
-- row_number()
select row_number() over(partition by addr order by height desc),
		height, name, addr
  from usertbl
order by height desc;

-- 8) 피벗 구현
create table pivotTest(
	pname	char(3),
	season	char(3),
	amount	int
);

INSERT INTO pivotTest VALUES
('TV', '1', 10), ('TV', '2', 20), ('TV', '2', 15), ('TV' ,'4' ,25),
('세탁기', '1', 5), ('세탁기', '3', 10),('세탁기', '3', 15), ('세탁기', '4', 20),
('에어컨', 2, 20), ('에어컨', 3, 10);

select *
  from pivottest;
  
select  pname, 
		if(season ='1',amount,0) '1분기', 
		if(season ='2',amount,0) '2분기', 
		if(season ='3',amount,0) '3분기', 
		if(season ='4',amount,0) '4분기', 
		amount '합계'
  from pivottest;
 

 select  pname, 
		sum(if(season ='1',amount,0)) '1분기', 
		sum(if(season ='2',amount,0)) '2분기', 
		sum(if(season ='3',amount,0)) '3분기', 
		sum(if(season ='4',amount,0)) '4분기', 
		sum(amount) '합계'
  from pivottest
  group by pname;
  
-- 9) json
 select json_object('이름',name,'신장',height)
   from usertbl;
  
-- 3.
