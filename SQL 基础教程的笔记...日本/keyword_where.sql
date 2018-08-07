--WHERE关键字	
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
AND (shohin_bunrui = '厨房用具'
OR	torokubi ='2009-09-20');


