*\
  
-- REGION WITH HIGHEST TOTAL REVENUE
  
SELECT 
	r.region_name,
    ROUND(SUM(total_price),2) as total_revenue
FROM region r
LEFT JOIN order_items oi
ON r.region_id = oi.order_id
GROUP BY r.region_name
ORDER BY total_revenue DESC
LIMIT 1 ;


-- AVERAGE ORDER VALUE PER region

SELECT 
	r.region_name,
    ROUND(AVG(total_price), 2) as avg_order_value
FROM region r
LEFT JOIN order_items oi
ON r.region_id = oi.order_id
GROUP BY r.region_name
HAVING r.region_name != 'N/A'
ORDER BY avg_order_value DESC
;

-- REGION WITH MOST CUSTOMERS
SELECT 
    r.region_name,
    COUNT(c.customer_id) AS customers_count
FROM region r
LEFT JOIN customers c
ON c.region_id = r.region_id
GROUP BY r.region_name
ORDER BY customers_count DESC 
LIMIT 1 
;


-- WHICH REGION IS GROWING/DECLINING OVER TIME

WITH region_revenue AS (
    SELECT 
        r.region_name,
        ROUND(SUM(oi.total_price), 2) AS total_revenue
    FROM region r
    JOIN customers c ON r.region_id = c.region_id
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY r.region_name
)
SELECT 
    region_name,
    total_revenue,
    CASE 
        WHEN total_revenue >= 5000 THEN 'GROWING'
        ELSE 'DECLINING'
    END AS region_growth
FROM region_revenue
ORDER BY total_revenue DESC;
