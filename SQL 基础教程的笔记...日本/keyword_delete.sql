--表数据删除，表结构保留
DELETE FROM Shohin;

--选择性删除表的数据行
DELETE FROM Shohin
WHERE hanbai_tanka >= 4000;