show databases;

use shopdb;

show tables;

-- 1. Database 구축
-- 1) Data 활용

-- 데이터 조회
select * from membertbl; 
select  memberName, memberAddress from membertbl;
select * from membertbl where membername='Park';
select membername from membertbl where membername='Kim';

-- 데이터 입력
insert into membertbl values('10005','Hong','경기 군포시');
select * from membertbl;

-- 데이터 수정
update membertbl set memberaddress = '서울 마포' where membername='Hong'

-- 데이터 삭제
delete from membertbl where membername = 'hong';

-- 2) Index 생성
-- table 생성
create table Indextbl
(
	first_name VARCHAR(14),
	last_name VARCHAR(16),
	hire_date DATE
);

show tables;

-- 데이터 insert
insert into indextbl 
select first_name, last_name, hire_date from employees.employees;





-- 데이터 확인
select * from indextbl;

-- 실행 경로 확인(인덱스 생선 전)
explain select * from indextbl where first_name = 'Mary';

-- 실행경로 확인(인덱스 생성 후)
create index idx_indextbl_first_name on indextbl(first_name);

explain select * from indextbl where first_name = 'Mary';

-- 3) View 생성
-- View 생성
create view uv_member
as
select memberid, memberaddress
from membertbl;

-- view 조회
select * from uv_member;

-- 3) Stored Procedure
-- 프로그램
DELIMITER //
create procedure myproc()
begin
	select * from membertbl where membername ='Lee';
	select * from producttbl where productname = '냉장고';
end //
DELIMITER ;

-- procedure 실행
call myproc();

-- 4) trigger
-- 백업 테이블 생성
create table deletedmembertbl
(memberID CHAR(8),
	memberName CHAR(5),
	memberAddresschar(20),
	deleteDate date
	);

-- trigger 생성

DELIMITER //
create trigger trg_deletedMemberTBL -- 트리거 이름
after delete 						-- 삭제 후에 작동하게 지정
on memberTBL						-- 트리거를 부착할 테이블
for each row  						-- 각 행마다 적용
begin
insert into deletedmembertbl
		-- old 테이블의 내용을 백업테이블 에삽입
		values(old.memberID,old.membername,old.memberaddress, curdate());
	
end //
delimiter // 

-- membertbl 데이터 확인
select * from membertbl;
use shopdb
-- delete membertbl
delete  from membertbl where membername = 'Lee';

select * from membertbl;