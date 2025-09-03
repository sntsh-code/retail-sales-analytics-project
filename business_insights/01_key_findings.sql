	INSIGHT : Which product generate the HIGHEST REVENUE ?
    	QUERY : SELECT 
        		      p.product_id,
           		    p.product_name,
                 	ROUND(SUM(oi.total_price), 2) AS highest_revenue
          		FROM products p
          		LEFT JOIN order_items oi
          		ON p.product_id = oi.order_id
          		GROUP BY p.product_id, p.product_name
          		ORDER BY highest_revenue DESC
          		LIMIT 1 ;
	RESULT : CAMERA 
	BUSINESS INSIGHTS : CAMERE generate the highest revenue of RS.2225.78
