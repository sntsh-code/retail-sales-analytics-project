*\
  
-- REVENUE TREND MONTH BY MONTH

SELECT 
    DATE_FORMAT(o.order_date, '%Y-%m') AS month,
    ROUND(SUM(oi.total_price), 2) AS total_revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
ORDER BY month
;


-- REVENUE GENERATED IN EACH QUATER

SELECT 
	YEAR(o.order_date) AS year,
    QUARTER(o.order_date) AS quarter,
    ROUND(SUM(oi.total_price),2) AS total_revenue
FROM orders o
JOIN order_items oi 
    ON o.order_id = oi.order_id
GROUP BY YEAR(o.order_date), QUARTER(o.order_date)
ORDER BY year, quarter 
;


-- NUMBER OF ORDERS PALCED IN EACH MONTH
SELECT 
	MONTH(order_date) AS month,
	COUNT(order_id) AS number_orders_palced
FROM orders
GROUP BY month(order_date)
ORDER BY month ASC 
;


-- IS SALES INCREASING QUATER BY QUATER?

SELECT 
	YEAR(o.order_date) AS year,
    QUARTER(o.order_date) AS quarter,
    ROUND(SUM(oi.total_price),2) AS total_revenue
FROM orders o
JOIN order_items oi 
    ON o.order_id = oi.order_id
GROUP BY YEAR(o.order_date), QUARTER(o.order_date)
ORDER BY year, quarter 
; --  (AFTER EXEQUTION OF QUERY) NO

 
-- CATERGORIES / PRODUCTS ARE DRIVING SALES PERIOD

SELECT 
	p.product_id,
    p.product_name,
    p.category,
    DATE_FORMAT(o.order_date, '%Y-%m') AS month,
    ROUND(SUM(oi.total_price), 2) AS total_revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON p.product_id = o.order_id
GROUP BY p.product_id, p.product_name, p.category, DATE_FORMAT(o.order_date, '%Y-%m')
ORDER BY month , total_revenue DESC
;


-- HIGHEST REVENUE CATEGORY OF EACH MONTH

WITH category_sales AS (
    SELECT 
        DATE_FORMAT(o.order_date, '%Y-%m') AS month,
        p.category,
        SUM(oi.total_price) AS total_revenue,
        ROW_NUMBER() OVER (PARTITION BY DATE_FORMAT(o.order_date, '%Y-%m') 
                           ORDER BY SUM(oi.total_price) DESC) AS rn
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    JOIN products p ON oi.product_id = p.product_id
    GROUP BY month, p.category
)
SELECT month, category, ROUND(total_revenue, 2) AS total_revenue
FROM category_sales
WHERE rn = 1
ORDER BY month
;


-- HIGHEST REVENUE PRODUCT EACH MONTH

WITH product_sales AS (
    SELECT 
        DATE_FORMAT(o.order_date, '%Y-%m') AS month,
        p.product_name,
        SUM(oi.total_price) AS total_revenue,
        ROW_NUMBER() OVER (PARTITION BY DATE_FORMAT(o.order_date, '%Y-%m') 
                           ORDER BY SUM(oi.total_price) DESC) AS rn
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    JOIN products p ON oi.product_id = p.product_id
    GROUP BY month, p.product_name
)
SELECT month, product_name, ROUND(total_revenue, 2) AS total_revenue
FROM product_sales
WHERE rn = 1
ORDER BY month;
