*\

=======================
REVENUE & PROFITABILITY
=======================

----------------------------------------------------------------------------- 

A.
	INSIGHTS : What percentage of total revenue comes from top 10% of orders ?
	QUERY : 
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
                                    WHERE rn <= 0.1 * total_orders   
                              )
                            	SELECT 
                            		ROUND((SUM(t.revenue) / (SELECT SUM(revenue) FROM order_revenue)) * 100, 2) AS pct_top_10_orders
                            	FROM top_10_percent t
                              ;

	RESULT : 27.41%
	BUSINESS INSIGHTS : The top 10% of orders contribute 27.14% of revenue, showing strong revenue dependence on a small group of high-value transactions.

============================================================================================================================================================================================================================

