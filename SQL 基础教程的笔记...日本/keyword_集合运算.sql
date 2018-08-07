--集合运算：就是把表看成集合，然后采取集合的运算方式



--表的加减法：对表的行进行增减
	--UNION:并集运算
		--对product1和product2的元素进行并集运算(去除重复记录)
SELECT 	product_id, product_name
FROM 	products1
UNION 
SELECT 	product_id, product_name
FROM 	products2;
		--使用ALL保留重复记录
SELECT 	product_id, product_name
FROM 	products1
UNION 	ALL 
SELECT 	product_id, product_name
FROM 	products2;

	--INTERSECT:交集运算

	--EXCEPT:两个集合相交，一个集合去掉交集后剩下的部分，差集运算



--表的联结：对表的列进行增加
	--INNER JOIN：内联结
		--显示某个商店的商品id之外的商品名字啊商品价格啊
SELECT S.shop_id, S.shop_name, S.product_id, P.product_name, P.product_price
FROM shops AS S 
INNER JOIN products AS P 
ON S.product_id=P.product_id;

	--OUT JOIN:外联结
		--除了内联结的功能之外.还显示了主表的记录.
		--主表的确定：RIGHT就是右边的表，LEFT就是左边的表
		--这个'外'，代表这种联结会出现某一方之外的元素.
		--左外和右外没啥区别
SELECT S.shop_id, S.shop_name, S.product_id, P.product_name, P.product_price
FROM shops AS S 
RIGHT OUTER JOIN products AS P 
ON S.product_id=P.product_id;

	--CROSS JOIN:交叉联结，又叫笛卡尔积
		--总的行数是两个表行数的乘积
		--这种联结方式一般不怎么使用



--除法的使用，不能理解
SELECT DISTINCT emp
FROM EmpSkills ES1
WHERE NOT EXISTS(SELECT 	skill 
				FROM 	Skills
				EXCEPT 
				SELECT sill 
				FROM EmpSkills ES2
				WHERE ES1.emp = ES2.emp 
				);








