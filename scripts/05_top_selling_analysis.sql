*/

-- PRODUCT THAT GENERATE THE HIGHEST REVENUE
  
SELECT 
	p.product_id,
    p.product_name,
    ROUND(SUM(oi.total_price), 2) AS highest_revenue
FROM products p
LEFT JOIN order_items oi
ON p.product_id = oi.order_id
GROUP BY p.product_id, p.product_name
ORDER BY highest_revenue DESC
LIMIT 1 ;

-- PRODUCT THAT SOLD THE MOST UNITS

SELECT
	p.product_id,
    p.product_name,
    oi.quantity
FROM products p
LEFT JOIN order_items oi
ON p.product_id = oi.order_id
GROUP BY p.product_id, p.product_name, oi.quantity
ORDER BY oi.quantity DESC
LIMIT 1;

-- CATEGORIES THAT DERIVES THE MOST REVENUE

SELECT 
	p.category,
    ROUND(SUM(oi.total_price),2 ) AS revenue
FROM products p
LEFT JOIN order_items oi
ON p.product_id = oi.order_id
GROUP BY p.category
ORDER BY revenue DESC 
LIMIT 1;


-- MOST VALUABLE CUSTOMERS

SELECT 
	c.customer_id,
	c.proper_name AS vip_customer,
    c.email,
    c.phone,
    ROUND(SUM(oi.total_price), 2) AS total_spent
FROM customers c
LEFT JOIN order_items oi
ON c.customer_id = oi.order_id
GROUP BY c.customer_id, c.proper_name, c.email, c.phone
HAVING total_spent > '1000'
ORDER BY total_spent DESC ;

-- REGION CONTRIBUTE THE MOST SALES

SELECT 
	region_name,
    ROUND(SUM(total_price), 2) AS revenue
FROM region
LEFT JOIN order_items 
	ON region_id = order_id
GROUP BY region_name
HAVING region_name != 'N/A'
ORDER BY revenue DESC
LIMIT 1 ;
