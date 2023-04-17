create table if not exists song(
	song_id serial not null  primary key,
	title      varchar  not null,
	album      varchar     not null,
	artist      varchar     not null,
    year             varchar     not null,
	genre varchar     not null,
    image_url varchar,
    lyric_id int references lyric(lyric_id) -- on delete cascade,
);

select * from song order by song_id desc;
select * from lyric order by lyric_id desc;

-- drop table song cascade;
create table if not exists lyric(
   	lyric_id 	serial not null  primary key,    
	submitter_name      varchar  not null,
	submitter_email      varchar  not null,
	reg_date timestamp without time zone default (now() at time zone 'utc'),
	texts varchar     not null
);

--������ �ʿ��Ұ� ������
create table if not exists  lyric_revision(
	rev_id 	serial not null  primary key,
	lyric_id int  not null,
	submitter_name      varchar  not null,
	submitter_email      varchar  not null,
	reg_date timestamp not null,
	texts varchar     not null
);

select * from lyric_revision order by lyric_id desc;


-- �ð� ������Ʈ�� Ʈ����
/*
CREATE OR REPLACE FUNCTION update_time_column()   
RETURNS TRIGGER AS $$
BEGIN
    NEW.reg_date = now() at time zone 'utc';
    RETURN NEW;   
END;
$$ language 'plpgsql';

CREATE TRIGGER update_lyric_time BEFORE UPDATE ON lyric FOR EACH ROW EXECUTE PROCEDURE  update_time_column();


-- drop trigger update_lyric_time on lyric;
-- drop trigger lyric_insert_trigger on lyric;

-- drop function update_time_column;
*/

CREATE OR REPLACE FUNCTION lyric_insert() RETURNS trigger AS
  $$
    BEGIN
      INSERT INTO lyric_revision
        (lyric_id, submitter_name, submitter_email, reg_date, texts)
      VALUES
        (NEW.lyric_id, NEW.submitter_name, NEW.submitter_email, NEW.reg_date,NEW.texts);
      RETURN NEW;
    END;
  $$
  LANGUAGE plpgsql;

  
CREATE TRIGGER lyric_insert_trigger
AFTER INSERT ON lyric
  FOR EACH ROW EXECUTE PROCEDURE lyric_insert();


CREATE OR REPLACE FUNCTION lyric_update() RETURNS trigger AS
$$
  BEGIN
      INSERT INTO lyric_revision
        (lyric_id, submitter_name, submitter_email, reg_date, texts)
      VALUES
        (NEW.lyric_id, NEW.submitter_name, NEW.submitter_email, NEW.reg_date,NEW.texts);
    RETURN NEW;

  END;
$$
LANGUAGE plpgsql;


CREATE TRIGGER lyric_update_trigger
AFTER UPDATE ON lyric
  FOR EACH ROW EXECUTE PROCEDURE lyric_update();
  


create table if not exists md5_to_song(
    md5_idx serial not null unique,
	md5 varchar not null  primary key,
	song_id int references song(song_id) on delete cascade
);

create table if not exists hash_to_song(
    hash_idx serial not null unique,
	hash varchar not null  primary key,
	song_id int references song(song_id) on delete cascade
);


create table if not exists hash_to_song_segment(
    idx serial primary key,
    seg_idx int,
	seg varchar not null,
	song_id int references song(song_id) on delete cascade, --���� ����?
    org_hash_idx int references hash_to_song(hash_idx) on delete cascade,
    UNIQUE (seg_idx, org_hash_idx)
);

drop table hash_to_song_segment;


insert into song(title,album,artist,year,genre,image_id) values('title','album','artist','year','genre',NULL);
select * from song;

update song set title ='title', album ='album', artist = 'artist' ,year ='2015',genre = 'jpop',image_id = NULL where song_id = 1;
select * from song;

insert into song(title,album,artist,year,genre,image_id) values('title','album','artist','year','genre',NULL);
select * from song;


-- md5_to_song

insert into md5_to_song(md5,song_id) values('23415',2)
select * from md5_to_song;


insert into hash_to_song(hash,song_id) values('238665789',3);
select * from hash_to_song;

-- INSERT ... ON CONFLICT DO NOTHING/UPDATE
-- ����) auto-increment holes ���� ����

/*
insert into md5_to_song(md5,song_id) values('2345',2) ON CONFLICT DO NOTHING;
insert into md5_to_song(md5,song_id) values('2345',2) ON CONFLICT(md5) DO UPDATE SET song_id=excluded.song_id;
insert into hash_to_song(hash,song_id) values('238665789',3) ON CONFLICT DO NOTHING;
insert into hash_to_song(hash,song_id) values('238665789',3) ON CONFLICT(hash) DO UPDATE SET song_id=excluded.song_id;
*/


---!!!�۾���!!!---

-- SELECT * FROM hash_to_song;
-- SELECT FROM hash_to_song WHERE hash = '238665789';
-- UPDATE hash_to_song SET song_id=3 where hash = '238665789';


--�� Ʈ������� oracle sql developer���� �۵��� ������???
/*
DO $$
BEGIN
IF EXISTS (SELECT FROM hash_to_song WHERE hash = '238665788') THEN
    UPDATE hash_to_song SET song_id=3 where hash = '238665788';
ELSE
    insert into hash_to_song(hash,song_id) values('238665788',2);
END IF;
END $$;
select * from hash_to_song;

insert into hash_to_song(hash,song_id) values('2365789',1);
commit;
*/


SELECT FROM hash_to_song WHERE hash = '238665789';

IF (SELECT FROM hash_to_song WHERE hash = '238665789' > 0);

IF EXISTS (SELECT FROM hash_to_song WHERE hash = '238665789') THEN
    SELECT FROM hash_to_song WHERE hash = '0';
ELSE
    SELECT FROM hash_to_song WHERE hash = '238665789';
commit;


-- insert into lyric(submitter_name,submitter_email,texts) values('�ۼ���','aaa@aaa.com','�����Դϴ�');
-- update lyric set submitter_name ='������', submitter_email ='bbb@bbb.com', texts='�����ϰſ���',reg_date = now() at time zone 'utc' where lyric_id = 2;

-- select * from lyric;
-- select * from lyric_revision where lyric_id =2;
-- commit;


select * from hash_to_song_segment;

--�׽�Ʈ�� �߰� �۾�
/*
select n/2+1 as seg_idx, substring('23456789' from n for 2) as seg, 1 as song_id,1 as org_hash_idx from generate_series(1, length( '23456789' ), 2) n;
select ROW_NUMBER () OVER(ORDER BY (SELECT 1)) as seg_idx, substring('23456789' from n for 2) as seg, 1 as song_id,1 as org_hash_idx from generate_series(1, length( '23456789' ), 2) n;


SELECT *
FROM  hash_to_song_segment
INNER JOIN 
(select n/2+1 as seg_idx, substring('238567' from n for 2) as seg, 1 as song_id,1 as org_hash_idx from generate_series(1, length( '23456789' ), 2) n) AS a
ON hash_to_song_segment.seg_idx = a.seg_idx
;

-- truncate table hash_to_song_segment;
-- truncate table hash_to_song cascade;

SELECT a.seg_idx, a.seg, a.song_id as song_id, a.org_hash_idx as hash_idx
FROM  hash_to_song_segment
INNER JOIN 
(select n/2+1 as seg_idx, substring('238567' from n for 2) as seg, 1 as song_id,1 as org_hash_idx from generate_series(1, length( '23456789' ), 2) n) AS a
ON hash_to_song_segment.seg_idx = a.seg_idx and hash_to_song_segment.seg = a.seg
;
*/

-- �������� song_id�� ������ ī��Ʈ�ϴ°� �ƴ϶� hashidx�� count���� inner join���� song_id�� �����;� ��(������� ��������)
-- �׸��� �װ� �� inner join�ؼ� song ������ �����;� ��(�̰͵� ���� ����)
-- ������ �׸��� lyric�� ���� ��� �Ǵ°� �ƴѰ�(�̰� ���� �����ϴ°� ������)
-- cnt�� cnt/max_cnt * 100�ؼ� �ۼ�Ʈ�� ǥ���ؾ�?

-- songid�� cnt������ ����--
SELECT a.song_id, count(*) cnt
FROM  hash_to_song_segment
INNER JOIN 
(select n/2+1 as seg_idx, substring('238567' from n for 2) as seg, 1 as song_id,1 as org_hash_idx from generate_series(1, length( '23456789' ), 2) n) AS a
ON hash_to_song_segment.seg_idx = a.seg_idx and hash_to_song_segment.seg = a.seg
group by a.song_id order by cnt desc;

/*
-- try improve --

-- song�� NATURAL JOIN ���� ������--
SELECT *
FROM  song
NATURAL JOIN 
(
SELECT a.song_id, count(*) cnt
FROM  hash_to_song_segment
INNER JOIN 
(select n/2+1 as seg_idx, substring('238567' from n for 2) as seg, 1 as song_id,1 as org_hash_idx from generate_series(1, length( '23456789' ), 2) n) AS a
ON hash_to_song_segment.seg_idx = a.seg_idx and hash_to_song_segment.seg = a.seg
group by a.song_id
) as c
;

select * from song;

-- hash_idx�� �������� ������ --
select * from hash_to_song;
select song_id, cnt
from hash_to_song
INNER JOIN 
(SELECT a.org_hash_idx, count(*) cnt
FROM  hash_to_song_segment
INNER JOIN 
(select n/2+1 as seg_idx, substring('238567' from n for 2) as seg, 1 as song_id,1 as org_hash_idx from generate_series(1, length( '23456789' ), 2) n) AS a
ON hash_to_song_segment.seg_idx = a.seg_idx and hash_to_song_segment.seg = a.seg
group by a.org_hash_idx) as b
on hash_idx = b.org_hash_idx
;



(select n/2+1 as seg_idx, substring('23456789' from n for 2) as seg, 1 as song_id,1 as org_hash_idx from generate_series(1, length( '23456789' ), 2) n) as a;
-- end ---


-- ����---
-- 4����Ʈ�� ���´�ġ�� 8���ھ� ������ �ǳ�?
-- libfooid�� �տ� 6�����ΰ� �����ؾ� ���� �ʳ�?
select n/2+1 as seg_idx, substring('23456789' from n for 2) as seg, 1 as song_id,1 as org_hash_idx from generate_series(1, length( '23456789' ), 2) n;
select n/4+1 as seg_idx, substring('234567891011' from n for 4) as seg, 1 as song_id,1 as org_hash_idx from generate_series(1, length( '234567891011' ), 4) n;
-- 3���� ������ 4���ھ� ����
select substring('234567891011', from 1 for 3);
select n/4+1 as seg_idx, substring(substring('234567891011',3) from n for 4) as seg, 1 as song_id,1 as org_hash_idx from generate_series(1, length( '234567891011' ), 4) n;
*/

 
----  Ʈ���� ---
CREATE OR REPLACE FUNCTION hash_insert() RETURNS trigger AS
  $$
    BEGIN
    insert into hash_to_song_segment(seg_idx, seg,song_id,org_hash_idx)
    select n/2+1 as seg_idx, substring(NEW.hash from n for 2) as seg, NEW.song_id,NEW.hash_idx from generate_series(1, length(NEW.hash ), 2) n;
      RETURN NEW;
    END;
  $$
  LANGUAGE plpgsql;
  
  
CREATE TRIGGER hash_insert_trigger
AFTER INSERT ON hash_to_song
  FOR EACH ROW EXECUTE PROCEDURE hash_insert();


CREATE OR REPLACE FUNCTION hash_update() RETURNS trigger AS
$$
  BEGIN
      delete from hash_to_song_segment where org_hash_idx = NEW.hash_idx; 
    insert into hash_to_song_segment(seg_idx, seg,song_id,org_hash_idx)
    select n/2+1 as seg_idx, substring(NEW.hash from n for 2) as seg, NEW.song_id,NEW.hash_idx from generate_series(1, length(NEW.hash ), 2) n;
    RETURN NEW;

  END;
$$
LANGUAGE plpgsql;


CREATE TRIGGER hash_update_trigger
AFTER UPDATE ON hash_to_song
  FOR EACH ROW EXECUTE PROCEDURE hash_update();
  
