	--窗口函数：
		--指定排序规则.在商品分类组内排序，按照商品价格升序排序
SELECT product_name, product_category, product_price,
	RANK () OVER ( PARTTION BY product_category
						ORDER BY product_price	) AS ranking
FROM products;