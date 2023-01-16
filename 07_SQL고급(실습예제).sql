-- 3개 테이블 join
-- 1) 3개 테이블 생성 / 데이타 입력

-- 학생 테이블(stdtbl), 학생_동아리 테이블(stdclubtbl), 동아리 테이블(clubtbl)
-- stdtbl : id(pk), name, addr
-- stdclubtbl : num(pk), id, clubcode
-- clubtbl : clubcode(pk), clubname, roomno

CREATE TABLE stdtbl(
	id 	varchar(10) not null primary key,
	name	varchar(20) not null,
	addr	varchar(10)
	);

CREATE TABLE clubtbl(
	clubcode varchar(10) not null primary key,
	clubname varchar(20) not null,
	roomno varchar(10)
	);

CREATE TABLE stdclubtbl(
	num	int	AUTO_INCREMENT not null primary key,
	id	varchar(10) not null,
	clubcode varchar(10) not null,
	FOREIGN KEY(id) REFERENCES stdtbl(id),
	FOREIGN KEY(clubcode) REFERENCES clubtbl(clubcode)
	);
	
-- 데이타 입력	
INSERT INTO stdtbl VALUES ('K001', '김범수', '경남'), ('S001','성시경', '서울'), ('J001','조용필', '경기'), ('E001','은지원', '경북'), ('B001','바비킴', '서울');
INSERT INTO clubtbl VALUES ('SWIM', '수영', '101호'), ('BADK','바둑', '102호'), ('SOCC','축구', '103호'), ('BONS','봉사', '104호');
INSERT INTO stdclubtbl VALUES (NULL, 'K001', 'BADK'), (NULL, 'K001', 'SOCC'), (NULL, 'J001', 'SOCC'), (NULL, 'E001', 'SOCC'), (NULL, 'E001', 'BONS'), (NULL, 'B001', 'BONS');

-- 학생의 아이디, 이름, 주소, 가입한 동아리코드, 가입한 동아리명 출력
select * from stdtbl;
select * from clubtbl;
select * from stdclubtbl;

select a.id, b.name, b.addr, a.clubcode, c.clubname 
  from stdclubtbl a
 	inner join stdtbl b 
 	on a.id = b.id
 	inner join clubtbl c 
 	on a.clubcode = c.clubcode;

select x.*, y.clubname
from	(select b.name,b.addr, a.clubcode
	       from stdclubtbl a
			inner join stdtbl b
			on a.id = b.id) x
	inner join clubtbl y
	on x.clubcode = y.clubcode
;
	
select b.name,b.addr, a.clubcode
	       from stdclubtbl a
		inner join stdtbl b
		on a.id = b.id;

select  a.id, b.name, b.addr, a.clubcode, c.clubname 
  from stdclubtbl a, stdtbl b, clubtbl c
 where a.id=b.id
   and a.clubcode = c.clubcode;
