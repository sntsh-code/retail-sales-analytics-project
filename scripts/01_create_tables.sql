*/


--TABLE NAME **customers**
  
CREATE TABLE customers (
	customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE NOT NULL,
    phone INT,
    region_id INT
    );

--TABLE NAME **region**

CREATE TABLE region (
	refion_id INT PRIMARY KEY,
    region_name VARCHAR(100)
	);

--TABLE NAME **products**

CREATE TABLE products(
	product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
	category VARCHAR(100),
    price DECIMAL
	);

--TABLE NAME **orders**

CREATE TABLE orders (
	order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    ship_date DATE,
    satuts VARCHAR(100)
	);

--TABLE NAME **order_items**

CREATE TABLE order_items (
	order_item_id INT PRIMARY KEY,
	order_id INT,
	product_id INT,
    quantity INT,
    total_price DECIMAL
	);
