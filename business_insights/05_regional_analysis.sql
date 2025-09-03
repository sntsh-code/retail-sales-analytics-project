*\

=================
REGIONAL ANALYSIS
=================

----------------------------------------------------------

A.
	INSIGHTS : Which region contribute the most the sales ?
	QUERY : 
        SELECT 
      	    region_name,
            ROUND(SUM(total_price), 2) AS revenue
        FROM region
        LEFT JOIN order_items 
      	ON region_id = order_id
        GROUP BY region_name
        HAVING region_name != 'N/A'
        ORDER BY revenue DESC
        LIMIT 1 
        ;
	RESULT : WEST 
	BUSINESS INSIGHTS : Region WEST contribute the rs. 12463.08

-------------------------------------------------------------
    
B.
	INSIGHTS : What is the average order value per region ?
	QUERY : 
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

	RESULT :
          | Region  | Avg. Order Value (₹) |
          | ------- | -------------------- |
          | South   | 269.60               |
          | East    | 264.26               |
          | Central | 258.60               |
          | North   | 247.62               |
          | West    | 230.80               |

	BUSINESS INSIGHTS : The South region leads with the highest average order value (₹269.60), while the West lags at ₹230.80. 
                      With a modest gap of ₹38.80 across regions, improving basket size in weaker regions (North & West) can significantly raise overall performance.


============================================================================================================================================================================================================================
