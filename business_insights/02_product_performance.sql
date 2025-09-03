*\
========================
**PRODUCT PERFORMANCE **
========================

  
A.
----------------------------------------------------------
	INSIGHTS : Top 5 Products contribute the most revenue ?
	QUERY : 
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
	RESULT : Mouse,Charger,Tablet,Monitor,Keyboard
	BUSINESS INSIGHTS : Top 1 MOUSE has the contributed the rs. 5355.14 of the total revenue


B.

	INSIGHTS : Which product are sold the most units ?
	QUERY : 
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
	RESULT : Tablet
	BUSINESS INSIGHTS : Tablet sold the quantity of 9

