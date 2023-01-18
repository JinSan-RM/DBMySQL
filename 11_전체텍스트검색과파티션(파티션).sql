create database partdb;
use partdb;
-- 2. 파티션
-- 1) 파티션 테이블 생성
create table parttbl(
	userid		varchar(8) not null,
	name 		varchar(10) not null,
	birthyear	int not null,
	addr		varchar(10) not null
)
partition by range(birthyear)(
	partition part1 values less than (1971),
	partition part2 values less than (1979),
	partition part3 values less than maxvalue
);

-- 2) list 파티션 테이블 생성

create table partlisttbl(
	userid		varchar(8) not null,
	name 		varchar(10) not null,
	birthyear	int not null,
	addr		varchar(10) not null
)
partition by list columns(addr)(
	partition part1 values in ('서울','경기'),
	partition part2 values in ('충북','충남'),
	partition part3 values in ('전북','전남'),
	partition part4 values in ('경북','경남'),
	partition part5 values in ('제주','강원')
);

-- 3) data insert 
select * from parttbl;

insert into parttbl(userid, name, birthyear, addr)
select userid, name, birthyear, addr
	from sqldb.usertbl;

select * from parttbl;

-- 파티션 정보 조회
SELECT table_schema, table_name, partition_name,
		 partition_ordinal_position, table_rows
  FROM information_schema.partitions
 WHERE table_name = 'parttbl' ;

-- 4) 데이터 조회
select * from parttbl where birthyear < 1969;
explain select * from parttbl where birthyear < 1969;
explain partitions select * from parttbl where birthyear < 1969;

explain partitions select * from parttbl where birthyear < 1978;

-- 5) 파티션 분리
alter table parttbl
	reorganize partition part3 into(
		partition part31 values less than (1985),
		partition part32 values less than maxvalue
	);

SELECT table_schema, table_name, partition_name,
		 partition_ordinal_position, table_rows
  FROM information_schema.partitions
 WHERE table_name = 'parttbl' ;


optimize table parttbl;
select * from parttbl;

SELECT table_schema, table_name, partition_name,
		 partition_ordinal_position, table_rows
  FROM information_schema.partitions
 WHERE table_name = 'parttbl' ;

-- 6) 파티션 합하기
alter table parttbl
	reorganize partition part1, part2 into(
		partition part12 values less than(1979)
	);

optimize table parttbl;

SELECT table_schema, table_name, partition_name,
		 partition_ordinal_position, table_rows
  FROM information_schema.partitions
 WHERE table_name = 'parttbl' ;

-- 7) 파티션 삭제
alter table parttbl
	drop partition part12;

optimize table parttbl;

SELECT table_schema, table_name, partition_name,
		 partition_ordinal_position, table_rows
  FROM information_schema.partitions
 WHERE table_name = 'parttbl' ;









