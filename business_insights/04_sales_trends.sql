*\

================
**SALES TRENDS**
================

  ------------------------------------------------------------

A.
	INSIGHTS : What is the total revenue generated per month ?
	QUERY : 
          SELECT 
            DATE_FORMAT(o.order_date, '%Y-%m') AS month,
            ROUND(SUM(oi.total_price),2) AS total_revenue
          FROM orders o
          JOIN order_items oi 
          ON o.order_id = oi.order_id
          GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
          ORDER BY month
          ;
	
  RESULT : 
          | Month | Revenue (₹) |
          | ----- | ----------- |
          | Jan   | 7015.73     |
          | Feb   | 3473.37     |
          | Mar   | 7205.39     |
          | Apr   | 4157.07     |
          | May   | 4502.20     |
          | Jun   | 4916.36     |
          | Jul   | 2905.77     |
          | Aug   | 3536.16     |
          | Sep   | 4088.38     |
          | Oct   | 4023.19     |
          | Nov   | 1891.52     |
          | Dec   | 4402.11     |

	BUSINESS INSIGHTS : Revenue in 2023 showed seasonal peaks in Q1 (Jan–Mar) and a sharp decline in November, with mid-year performance staying moderately stable. 
                      Focusing on replicating Q1 strategies year-round and addressing the November slump could improve annual revenue consistency.


B.  
	INSIGHTS : How much revenue is generated in each quarter ?
	QUERY :
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
	RESULT :
          | Year | Quarter | Revenue (₹) |
          | ---- | ------- | ----------- |
          | 2023 | Q1      | 17,694.49   |
          | 2023 | Q2      | 13,575.63   |
          | 2023 | Q3      | 10,530.31   |
          | 2023 | Q4      | 10,316.82   |

	BUSINESS INSIGHTS : Revenue peaked in Q1 (₹17,694.49) but showed a steady decline across the year, with Q3 and Q4 significantly underperforming. 
                      Stabilization in Q4 indicates a possible recovery point, but focusing on sustaining Q1’s momentum is critical for growth.

--------------------------------------------------------------------------------------------------------------------------------------------------
    
C.
	INSIGHTS : How many orders were placed in each month ?
	QUERY : 
        SELECT 
          	MONTH(order_date) AS month,
          	COUNT(order_id) AS number_orders_palced
        FROM orders
        GROUP BY month(order_date)
        ORDER BY month ASC 
        ;

	RESULT :
          | Month | Orders Placed |
          | ----- | ------------- |
          | Jan   | 19            |
          | Feb   | 13            |
          | Mar   | 20            |
          | Apr   | 20            |
          | May   | 20            |
          | Jun   | 21            |
          | Jul   | 15            |
          | Aug   | 14            |
          | Sep   | 19            |
          | Oct   | 18            |
          | Nov   | 11            |
          | Dec   | 20            |

	BUSINESS INSIGHTS : Order volume in 2023 was stable with 210 total orders, averaging 17.5 per month. 
                      Peaks were seen in June and Q2 overall, while November and February underperformed significantly, highlighting areas for targeted improvement.

============================================================================================================================================================================================================================
