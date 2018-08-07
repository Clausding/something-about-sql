--数据库的创建
CREATE DATABASE shop;

--表的创建
CREATE TABLE Shohin
(shohin_id		CHAR(4)			NOT NULL,
 shohin_mei		VARCHAR(100)	NOT NULL,
 shohin_bunrui	VARCHAR(32)		NOT NULL,
 hanbai_tanka	INTEGER			,
 shiire_tanka	INTEGER			,
 torokubi		DATE 			,
 PRIMARY KEY (shohin_id));

--表的删除
DROP TABLE Shohin;

--表定义的更新(就是在表中删除或增加字段)
ALTER TABLE Shohin DROP COLUMN shohin_mei_kana;

--表的名称的修改
RENAME TABLE Sohin To Shohin;

--表的数据的插入
BEGIN TRANSACTION;
INSERT INTO Shohin VALUES ('0001', 'T恤衫', '衣服'， 1000， 500， '2009-09-20');
INSERT INTO Shohin VALUES ('0002', '打孔器', '办公用品'， 500， 320， '2009-09-20');
COMMIT;

