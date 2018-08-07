--函数：
	--算术函数：


	--字符串函数：
		--拼接函数||：拼接两个字符串
		--然而mysql中使用CONCAT关键字，sqlserver使用'+'运算符


	--日期函数：
		--CURRENT_DATE:当前日期,下面返回当前日期
SELECT CURRENT_DATE;

		--CURRENT_TIME:当前时间

		--CURRENT_TIMESTAMP:当前的日期和时间


	--转换函数：
		--CAST:转换
		--COALESCE：是一个参数个数不定的函数，返回第一个非NULL值



--谓词
	--LIKE:字符串部分一致查询
		--查找名字中以'西瓜'开头的记录
SELECT *
FROM products
WHERE product_name LIKE '西瓜%';
		--查找'西瓜'开头，2个字符结束的记录
SELECT *
FROM products
WHERE product_name LIKE '西瓜__';

	--BETWEEN AND:
		--找出产品价格在0到100的记录(包含0和100)
SELECT *
FROM products
WHERE product_price BETWEEN 0 AND 100;

	--IS NULL 	IS NOT NULL:判断字段值是否为NULL

	--IN 是 OR的简化用法
SELECT *
FROM products
WHERE product_price IN (100, 200, 400);

SELECT *
FROM products
WHERE 	product_price = 100
OR 		product_price = 200
OR 		product_price = 400;

	--IN 的参数可以用子查询
SELECT *
FROM products
WHERE product_price IN (SELECT product_price
						FROM products
						WHERE product_cid = '2');



--case表达式
	--查询product_cid为1,2,3的商品名字和新建的列ABC_product_id
SELECT 	product_name
		CASE 	WHEN product_cid = '1'
				THEN 'A:' || product_cid
				WHEN product_cid = '2'
				THEN 'B:' || product_cid
				WHEN product_cid = '3'od
				THEN 'C:' || product_cid
				ELSE NULL
		END AS ABC_product_id
FROM products;

	--结果是分类号1,2,3的商品总价统计;结果是三列;这个语句可以用来进行行转列
SELECT 	SUM(CASE 	WHEN product_cid='1'
					THEN product_price ELSE 0 END) AS sumPrice_cid1,
		SUM(CASE 	WHEN product_cid='2'
					THEN product_price ELSE 0 END) AS sumPrice_cid2,
		SUM(CASE 	WHEN product_cid='3'
					THEN product_price ELSE 0 END) AS sumPrice_cid3
FROM products;


	   




















