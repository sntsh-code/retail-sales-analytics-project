*\
  
-- TOTAL REVENUE GENERATED PER MONTH
SELECT 
    DATE_FORMAT(o.order_date, '%Y-%m') AS month,
    ROUND(SUM(oi.total_price),2) AS total_revenue
FROM orders o
JOIN order_items oi 
    ON o.order_id = oi.order_id
GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
ORDER BY month;

-- PRODUCTS THAT CONTRIBUTE THE MOST REVENUE
SELECT 
	p.category,
	p.product_name,
    ROUND(SUM(oi.total_price), 2) AS total_revenue
FROM products p
LEFT JOIN order_items oi
  ON p.product_id = oi.product_id
GROUP BY p.category, p.product_name
ORDER BY total_revenue DESC
LIMIT 5 ;

-- AVERAGE VALUE PER CUSTOMERS
SELECT 
    ROUND(SUM(oi.total_price) / COUNT(DISTINCT o.customer_id), 2) AS avg_value_per_customer
FROM orders o
JOIN order_items oi 
    ON o.order_id = oi.order_id;

-- CUSTOMERS THAT GENERATED THE HIGHEST REVENUE
SELECT 
	c.customer_id, 
    c.proper_name,
    ROUND(SUM(oi.total_price),2) AS total_revenue
FROM customers c
LEFT JOIN order_items oi
	  ON oi.order_id = c.customer_id
GROUP BY c.customer_id, c.proper_name
ORDER BY total_revenue DESC
LIMIT 5 ;
    
-- PERCENTAGE OF TOTAL REVENUE COMES FROM THE TOP 10% OF ORDERS
WITH order_revenue AS (
    SELECT 
        o.order_id,
        SUM(oi.total_price) AS revenue
    FROM orders o
    JOIN order_items oi 
        ON o.order_id = oi.order_id
    GROUP BY o.order_id
),
ranked_orders AS (
    SELECT 
        order_id,
        revenue,
        ROW_NUMBER() OVER (ORDER BY revenue DESC) AS rn,
        COUNT(*) OVER () AS total_orders
    FROM order_revenue
),
top_10_percent AS (
    SELECT 
        order_id,
        revenue
    FROM ranked_orders
    WHERE rn <= 0.1 * total_orders   -- Top 10% orders
)
	SELECT 
		ROUND((SUM(t.revenue) / (SELECT SUM(revenue) FROM order_revenue)) * 100, 2) AS pct_top_10_orders
	FROM top_10_percent t;
