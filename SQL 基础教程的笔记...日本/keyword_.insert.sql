--插入操作
INSERT INTO products (product_id, product_name, product_price)
VALUES ('001', '高压锅', '1000美元');

INSERT INTO products
VALUES ('001', '高压锅', '1000美元');

	--插入默认值,使用DEFAULT指定.
	--插入操作时，有两种方式指定默认值，显式和隐式
CREATE TABLE products
(product_id		CHAR(4)		NOT NULL,
 product_name	CHAR(20),
 product_price	INTEGER		DEFAULT 0
 PRIMARY KEY (product_id));
	--显式,推荐使用
INSERT INTO products (product_id, product_name, product_price)
VALUES ('001', '高压锅', DEFAULT);
	--隐式，通过省略INSERT语句中的列名称
INSERT INTO products (product_id, product_name)
VALUES ('001', '高压锅');

	--复制其他表的数据，使用INSERT...SELECT
INSERT INTO products (product_id, product_name, product_price)
SELECT product_id, product_name, product_price
FROM products2;






