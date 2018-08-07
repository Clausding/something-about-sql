--聚合函数：COUNT数量 AVG平均值 SUM总数 MAX最大值 MIN最小值
	--COUNT关键字.查询所有记录的数量(除了COUNT(*)，聚合函数均将NULL排除)
SELECT COUNT(*)
FROM Shohin;

	--COUNT的输入值使用DISTINCT.输出值为：去除重复后，字段值的数量
SELECT COUNT( DISTINC shohin_bunrui)
FROM Shohin;



--对表进行分组：GROUP BY
	--运行顺序：将所有行分组，再输出结果
SELECT shohin_bunrui, COUNT(*)
FROM Shohin
GROUP BY shohin_bunrui;

	--当GROUP遇到WHERE:先执行WHERE再执行GROUP
	--下面输出：在所有衣服中，每种品牌的数量
	--执行顺序：FROM - WHERE - GROUP BY - SELECT,这符合英语的思维方式
SELECT brand, COUNT(*)
FROM Shohin
WHERE category = '衣服'
GROUP BY brand;



--为聚合结果指定条件
	--HAVING
	--以下返回：产品数量为2的品牌
SELECT brand, COUNT(*)
FROM product
GROUP BY brand
HAVING COUNT(*) = 2;



--为查询结果进行排序
	--ORDER BY
	--按照价格从高到低排列(降序).ASC代表升序,默认是升序的
SELECT product_id, product_name, product_price
FROM products
ORDER BY product_price DESC;

	--在ORDER BY中使用别名
SELECT product_id AS id, 	product_name AS name, 	product_price AS price
FROM products
ORDER BY id, price ASC;


