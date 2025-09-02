*/

-- CUSTOMER WITH MOST CONTRIBUTED IN TOTAL REVENUE
SELECT
	customer_id,
    proper_name,
    ROUND(SUM(total_price)) AS total_revenue
FROM customers
LEFT JOIN order_items
ON order_id = customer_id
GROUP BY customer_id, proper_name
ORDER BY total_revenue DESC
LIMIT 1;

 
-- CUSTOMER THAT PLACED MOST NUMBER OF ORDERS
SELECT 
	c.customer_id,
    c.proper_name,
    c.email,
    COUNT(order_id) AS orders
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.order_id
GROUP BY c.customer_id, c.proper_name, c.email
HAVING orders > 1
ORDER BY orders DESC 
;

-- CUSTOMER BOUGHT THE MOST ITEMS
SELECT 
	customer_id,
    proper_name,
    quantity
FROM customers
LEFT JOIN order_items
ON order_id = customer_id
WHERE quantity = '9'
ORDER BY quantity  DESC ;


-- CUSTOMERS SPEND THE MOST ON AVERAGE PER ORDER
SELECT 
    c.customer_id,
    c.proper_name,
    ROUND(SUM(oi.total_price) / COUNT(DISTINCT o.order_id), 2) AS avg_spent_per_order
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.proper_name
ORDER BY avg_spent_per_order DESC
LIMIT 1;



-- WHO ARE THE LONG TERM HIGH VALUE CUSTOMERS
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
