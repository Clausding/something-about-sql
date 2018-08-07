--SELECT关键字
--表的数据的查询
SELECT shohin_id, shohin_mei, shiire_tanka
FROM Shohin;

	--查询所有字段
SELECT *
FROM Shohin;

	--为字段设定别名
SELECT	shohin_id AS id,	shohin_mei AS name,	shiire_tanka AS tanka
FROM	Shohin;

	--别名是汉字的情况
SELECT	shohin_id		AS "商品编号",
		shohin_mei  	AS "商品名称",
		shiire_tanka	AS "进货单价"
FROM	Shohin;

	--查询结果需要包含新的列，来显示常数
SELECT	'商品' AS mojiretsu,	38 AS kazu,		'2009-02-24' AS hizuke,
		shohin_id,	shohin_mei
FROM 	Shohin;

	--查询结果需要包含新的列，来显示旧列运算后的值
SELECT	shohin_id,	shohin_mei,
		hanbai_tanka * 2 AS "hanbai_tanka_x2"
FROM 	Shohin;

	--查询结果需要删除重复行
SELECT DISTINCT shohin_bunrui
FROM Shohin;

	--查询结果需要只显示部分行(WHERE子句要紧紧跟在FROM子句之后)
SELECT shohin_mei, shohin_bunrui
FROM Shohin
WHERE shohin_bunrui = '衣服';

			--选取出登记日期在2009年9月27日之前的记录('<'可以用来比较日期)
SELECT shohin_mei, shohin_bunrui, torokubi
FROM shohin
WHERE torokubi < '2009-09-27';

			--WHERE子句的条件表达式可使用算术表达式
SELECT shohin_mei, shohin_bunrui, torokubi
FROM shohin
WHERE hanbai_tanka - shiire_tanka >= 500;

			--字段值为NULL的情况
SELECT shohin_mei, shohin_bunrui, torokubi
FROM shohin
WHERE hanbai_tanka IS (NOT) NULL;

			--'NOT'的使用
SELECT shohin_mei, shohin_bunrui, torokubi
FROM shohin
WHERE NOT hanbai_tanka = 500;

			--'AND' 'OR'的使用(实现多重查询条件)
SELECT shohin_mei, shohin_bunrui, torokubi
FROM shohin
WHERE NOT hanbai_tanka = 500 
AND shohin_bunrui = '厨房用具';

			--使用'()'改变运算顺序
SELECT shohin_mei, shohin_bunrui, torokubi
FROM shohin
WHERE NOT hanbai_tanka = 500 
AND (shohin_bunrui = '厨房用具'  OR	torokubi ='2009-09-20');