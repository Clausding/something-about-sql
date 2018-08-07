--视图
--表中储存的是实际数据，而视图中保存的是从表中取出数据所使用的SELECT语句
--应该将经常使用的SELECT语句做成视图

CREATE VIEW productsView(product_brand, brandAmount)
AS
SELECT product_brand, COUNT(*)
FROM products
GROUP BY product_brand;

SELECT product_brand， brandAmount
FROM productsView;



--子查询就是一次性视图
--(tips:Oracle数据库中FROM关键字后不能加AS)
SELECT product_brand， brandAmount
FROM (	SELECT product_brand, COUNT(*) AS brandAmount
		FROM products
		GROUP BY product_brand ) AS productsView;

	--标量子查询,标量就是不变的量
	--查询价格大于平均价格的商品.sql执行时会优先执行子语句
SELECT product_id, product_name, product_price
FROM products
WHERE product_price > (SELECT AVG(product_price)
						FROM products);

	--标量子查询的语句放在SELECT中.
SELECT 	product_price，
		(SELECT AVG(product_price)
		FROM products) AS product_price_average
FROM products;

	--查询均价大于总体均价的品牌，并列出这些品牌的均价
SELECT  product_brand，AVG(product_price)
FROM 	products
GROUP BY product_brand
HAVING	AVG(product_price) > (SELECT AVG(product_price)
								FROM products);

	--在细分的组内进行查询时，需要进行关联子查询
    --按品牌分组，查询大于组内均价的商品的分类、名称和价格
SELECT 	product_category, product_name, product_price
FROM 	products AS p1
WHERE 	product_price > (   SELECT AVG(product_price)
							FROM products AS p2
							WHERE p2.product_category = p1.product_category
							ORDER BY product_category
						);
	--个人感想：1.外层逐行运行WHERE 2.传入内层product_category，计算得该品牌均价 
	--3.继续WHERE语句，满足条件了就SELECT
