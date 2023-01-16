use sqldb;

-- 0) table 생성
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
-- 1) data 입력
INSERT INTO usertbl VALUES('LSG', '이승기', 1987, '서울', '011', '11111111', 182, '2008-8-8');
INSERT INTO usertbl VALUES('KBS', '김범수', 1979, '경남', '011', '22222222', 173, '2012-4-4');
INSERT INTO usertbl VALUES('KKH', '김경호', 1971, '전남', '019', '33333333', 177, '2007-7-7');
INSERT INTO usertbl VALUES('SSK', '성시경', 1979, '서울',  NULL,       NULL, 186, '2013-12-12');
INSERT INTO usertbl VALUES('LJB', '임재범', 1963, '서울', '016', '66666666', 182, '2009-9-9');
INSERT INTO usertbl VALUES('YJS', '윤종신', 1969, '경남',  NULL,       NULL, 170, '2005-5-5');
INSERT INTO usertbl VALUES('EJW', '은지원', 1972, '경북', '011', '88888888', 174, '2014-3-3');
INSERT INTO usertbl VALUES('JKW', '조관우', 1965, '경기', '018', '99999999', 172, '2010-10-10');
INSERT INTO usertbl VALUES('BBK', '바비킴', 1973, '서울', '010', '00000000', 176, '2013-5-5');

select * from usertbl;

-- 1. IN 포함된 프로시저 생성

drop procedure if exists userproc1;

delimiter $$

create procedure userproc1(in username varchar(10))
begin

	select * from usertbl where name=username;	
	
end $$

delimiter ;

call userproc1('이승기');

-- 2. OUT 포함된 프로시저 생성
drop procedure if exists userproc2;

delimiter $$
create procedure userproc2(in username varchar(10),
							out v_userid char(8))
begin

	select userid into v_userid from usertbl where name=username;	

end $$
delimiter ;

call userproc2('김범수', @v_userid);
select @v_userid;

-- 2. 스토어드 함수

drop function if exists userfunc;

delimiter $$
create function userfunc(value1 int, value2 int)
	returns int
begin
	return value1 + value2;
end $$
delimiter ;

select userfunc(100, 200);

select userfunc(height, 200) from usertbl;

select left(name,2) from usertbl;

-- 3. 커서
drop procedure if exists cursorproc;

delimiter $$
create procedure cursorproc()
begin
	
	declare userheight int;
	declare cnt int default 0;
	declare totalheight int default 0;
	
	declare end0Row boolean default false;

	declare usercursor cursor for
		select height from usertbl;
	
	declare continue handler
		for not found set end0Row = true;
	
	open usercursor;
	
	cursor_loop : loop
		fetch usercursor into height;
		
		if end0Row then 
			leave cursor_loop;
		end if;
		
		set cnt = cnt + 1;
		set totalheight = totalheight + userheight;
		-- select cnt;
		select totalheight / cnt
	end loop cursor_loop;
	
	close usercursor;
	
end $$

delimiter ;


-- 4. 트리거
-- 백업 테이블 생성
CREATE TABLE backup_userTBL
( userID		CHAR(8) not null primary key, 	-- 사용자 아이디(PK)
  name		VARCHAR(10) NOT NULL, 		-- 이름
  birthYear	INT NOT NULL,			-- 출생연도
  addr		CHAR(2) NOT NULL,		-- 지역(서울, 경기, 경남)
  mobile1	CHAR(3),				-- 국번
  mobile2	CHAR(8),				-- 번호2
  height		SMALLINT,			-- 키
  mDate		DATE				-- 회원 가입일
);

select * from backup_usertbl;

-- 트리거 생성 : delete
drop trigger if exists backupusertbl_deletetrg;

delimiter $$
create trigger backusertbl_deletetrg
	after delete
	on usertbl
	for each row
begin
	insert into backup_usertbl
	values(old.userid, old.name, old.birthyear, old.addr, 
			old.mobile1, old.mobile2, old.height, old.mdate);
	
end $$
delimiter ;

delete from usertbl where userid='EJW';

select *from backup_usertbl;