use tabledb;
-- 8. 테이블과 뷰(뷰)
-- create view

create view v_usertbl
as
select userid, name, email from usertbl where email is not null;

select * from v_usertbl;

select * from buytbl;

use sqldb;

drop view sum_buytbl;

create view sum_buytbl(prodname, groupname, sum_amount, sum_total)
as
select prodname, groupname, sum(amount), sum(amount*price)
from buytbl
group by prodname, groupname;

select * from sum_buytbl;

desc sum_buytbl;

select userid, prodname, groupname, sum(amount), sum(amount*price)
from buytbl
group by userid,prodname, groupname;

