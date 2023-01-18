create database fulltextdb;
use fulltextdb;
-- 1. 전체 텍스트 인덱스 생성

create table fulltexttbl(
	id 		int auto_increment primary key,
	title	varchar(15) not null,
	description	varchar(1000)
);

INSERT INTO FulltextTbl VALUES
(NULL, N'광해, 왕이 된 남자', N'왕위를 둘러싼 권력 다툼과 당쟁으로 혼란이 극에 달한 광해군 8년'),
(NULL, N'간첩', N'남한 내에 고장간첩 5만 명이 암약하고 있으며 특히 권력 핵심부에도 침투해있다.'),
(NULL, N'남자가 사랑할 때', N'대책 없는 한 남자이야기. 형 집에 얹혀 살며 조카한테 무시당하는 남자'),
(NULL, N'레지던트 이블 5', N'인류 구원의 마지막 퍼즐, 이 여자가 모든 것을 끝낸다.'),
(NULL, N'파괴자들', N'사랑은 모든 것을 파괴한다! 한 여자를 구하기 위한, 두 남자의 잔인한 액션 본능!'),
(NULL, N'킹콩을 들다', N' 역도에 목숨을 건 시골소녀들이 만드는 기적 같은 신화.'),
(NULL, N'테드', N'지상최대 황금찾기 프로젝트! 500년 전 사라진 황금도시를 찾아라!'),
(NULL, N'타이타닉', N'비극 속에 침몰한 세기의 사랑, 스크린에 되살아날 영원한 감동'),
(NULL, N'8월의 크리스마스', N'시한부 인생 사진사와 여자 주차 단속원과의 미묘한 사랑'),
(NULL, N'늑대와 춤을', N'늑대와 친해져 모닥불 아래서 함께 춤을 추는 전쟁 영웅 이야기'),
(NULL, N'국가대표', N'동계올림픽 유치를 위해 정식 종목인 스키점프 국가대표팀이 급조된다.'),
(NULL, N'쇼생크 탈출', N'그는 누명을 쓰고 쇼생크 감옥에 감금된다. 그리고 역사적인 탈출.'),
(NULL, N'인생은 아름다워', N'귀도는 삼촌의 호텔에서 웨이터로 일하면서 또 다시 도라를 만난다.'),
(NULL, N'사운드 오브 뮤직', N'수녀 지망생 마리아는 명문 트랩가의 가정교사로 들어간다'),
(NULL, N'매트릭스', N' 2199년.인공 두뇌를 가진 컴퓨터가 지배하는 세계.');

select * from fulltexttbl;

select * from fulltexttbl where description like '%남자%';

-- 2) 전체 텍스트 인덱스 생성
drop index idx_fulltexttbl on fulltexttbl;

create fulltext index idx_fulltexttbl
	on fulltexttbl(description);


show index from fulltexttbl;

-- 전체 텍스트 인덱스 테이블 데이터 확인
set global innodb_ft_aux_table = 'fulltextdb/fulltexttbl';

select * from information_schema.INNODB_FT_INDEX_TABLE;



-- 3) 전체 텍스트 검색
-- in natural mode 검색
select * from fulltexttbl
	where match(description) against('남자');

select * from fulltexttbl
	where match(description) against('남자 여자');

-- in boolean mode

select * from fulltexttbl
	where match(description) against('남자*' in boolean mode);

select * from fulltexttbl
	where match(description) against('남자* 여자*' in boolean mode);

select * from fulltexttbl
	where match(description) against('-남자* 여자*' in boolean mode);


-- 4) 중지(제외) 단어 설정










