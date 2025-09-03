*\
  
-- THE AVERAGE ORDER VALUE FOR EACH CUSTOMER COMAPERED TO OVERALL AVERAGE

SELECT 
    c.customer_id,
    c.proper_name,
    AVG(SUM(oi.total_price)) OVER (PARTITION BY c.customer_id) AS avg_order_value_per_customer,
    AVG(SUM(oi.total_price)) OVER () AS overall_avg_order_value
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.proper_name, o.order_id
;


-- PRODUCT WITH THE MOST SALES IN EACH MONTH

WITH product_sales AS (
    SELECT 
        DATE_FORMAT(o.order_date, '%Y-%m') AS month,
        p.product_name,
        SUM(oi.total_price) AS revenue,
        ROW_NUMBER() OVER (PARTITION BY DATE_FORMAT(o.order_date, '%Y-%m') 
                           ORDER BY SUM(oi.total_price) DESC) AS rn
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    JOIN products p ON oi.product_id = p.product_id
    GROUP BY month, p.product_name
)
SELECT month, product_name, revenue
FROM product_sales
WHERE rn = 1
ORDER BY month;



-- CUSTOMERS WHICH IN TOP 10% MOST FREQUENT BUYERS

WITH customer_orders AS (
    SELECT 
        c.customer_id,
        c.proper_name,
        COUNT(o.order_id) AS order_count
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    GROUP BY c.customer_id, c.proper_name
)
SELECT 
    customer_id,
    proper_name,
    order_count,
    NTILE(10) OVER (ORDER BY order_count DESC) AS decile
FROM customer_orders;
