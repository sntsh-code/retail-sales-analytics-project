*\
================
**KEY FINDINGS**
================

-------------------------------------------------------------------------
A. 
	INSIGHT : Which product generate the highest revenue ?
	QUERY : SELECT 
				p.product_id,
		   		p.product_name,
		   		ROUND(SUM(oi.total_price), 2) AS highest_revenue
			FROM products p
			LEFT JOIN order_items oi
			ON p.product_id = oi.order_id
			GROUP BY p.product_id, p.product_name
			ORDER BY highest_revenue DESC
			LIMIT 1 
			;

	RESULT : CAMERA 
	BUSINESS INSIGHTS : CAMERA generate the highest revenue of rs. 2225.78

--------------------------------------------------------------------------
		
B. 
	INSIGHTS : Which category derives the most revenue ?
	QUERY : SELECT 
				p.category,
    			ROUND(SUM(oi.total_price),2 ) AS revenue
			FROM products p
			LEFT JOIN order_items oi
			ON p.product_id = oi.order_id
			GROUP BY p.category
			ORDER BY revenue DESC 
			LIMIT 1
			;

	RESULT : Category GADGETS the most revenue
	BUSINESS INSIGHTS : Category GADGETS has the most amount of revenue that is rs.12643.03

-------------------------------------------------------------------------------------------
		
C. 
	INSIGHTS : Is sales increasing quarter by quarter
	QUERY : SELECT 
				YEAR(o.order_date) AS year,
			    QUARTER(o.order_date) AS quarter,
			    ROUND(SUM(oi.total_price),2) AS total_revenue
				FROM orders o
				JOIN order_items oi 
		    	ON o.order_id = oi.order_id
				GROUP BY YEAR(o.order_date), QUARTER(o.order_date)
				ORDER BY year, quarter 
				; 

	RESULT : NO
	BUSINESS INSIGHTS : Sales are decreasing quarter by quarter.

----------------------------------------------------------------

D.
	INSIGHTS : Which region has the most customers ?
	QUERY : SELECT 
	    		r.region_name,
	    		COUNT(c.customer_id) AS customers_count
			FROM region r
			LEFT JOIN customers c
			ON c.region_id = r.region_id
			GROUP BY r.region_name
			ORDER BY customers_count DESC 
			LIMIT 1 
			;
	RESULT : SOUTH region has the most customers.
	BUSINESS INSIGHTS : SOUTH region has the most customer count of 61.

----------------------------------------------------------------------
		
E.
	INSIGHTS : Regions that are growing and declining over time ? 
	QUERY : WITH region_revenue AS (
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
			ORDER BY total_revenue DESC
			;

	RESULT : SOUTH & NORTH regions are growing over time on other hand WEST, EAST & CENTRAL regions are decaline over time
	BUSINESS INSIGHTS : Focus on WEST, EAST & CENTRAL regions. 

-----------------------------------------------------------

F. 
	INSIGHTS : Which product has the most sales each month?
	QUERY :WITH product_sales AS (
									   SELECT 
									        DATE_FORMAT(o.order_date, '%Y-%m') AS month,
									        p.product_name,
									        ROUND(SUM(oi.total_price),' ') AS revenue,
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
		ORDER BY month
		;

	RESULT :The product which has the most sales from Jan-2023 to Dec-2023 are Charger, Tablet, Mouse, Mouse, Mouse, Keyboard, Charger, Laptop, Monitor, Charger, Tablet, N/a

====================================================================================================================================================================================================================		

	BUSINESS INSIGHTS : MOUSE has the most sales by months.

====================================================================================================================================================================================================================
