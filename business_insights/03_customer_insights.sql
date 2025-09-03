*\

=================
CUSTOMER INSIGHTS
=================

-------------------------------------------------------------------------------------------------
A.
  
	INSIGHTS : What is the average value per customer ?
	QUERY : 
      SELECT 
          ROUND(SUM(oi.total_price) / COUNT(DISTINCT o.customer_id), 2) AS avg_value_per_customer
      FROM orders o
      JOIN order_items oi 
      ON o.order_id = oi.order_id
      ;

	RESULT : 1085.78
	BUSINESS INSIGHTS : On average, each customer contributes ₹1085.78 in revenue.

-------------------------------------------------------------------------------------------------
B.
    
	INSIGHTS : Which customer generates the highest revenue ?
	QUERY : 
      SELECT 
      	  c.customer_id, 
          c.proper_name,
          ROUND(SUM(oi.total_price),2) AS total_revenue
      FROM customers c
      LEFT JOIN order_items oi
      ON oi.order_id = c.customer_id
      GROUP BY c.customer_id, c.proper_name
      ORDER BY total_revenue DESC
      LIMIT 1 
      ;
	RESULT : Customer Chris Davis (ID: 190) generates the highest revenue of ₹2225.78
	BUSINESS INSIGHTS : Customer Chris Davis (ID: 190) generates the highest revenue of ₹2225.78, making him a high-value customer above the average spend (₹1085.78).

  -------------------------------------------------------------------------------------------------------------------------------------------------------------------
C.
	INSIGHTS : List of most valuable customers.
	QUERY : 
        SELECT 
    	      c.customer_id,
    	      c.proper_name AS vip_customer,
            c.email,
            c.phone,
            ROUND(SUM(oi.total_price), 2) AS total_spent
        FROM customers c
        LEFT JOIN order_items oi
        ON c.customer_id = oi.order_id
        GROUP BY c.customer_id, c.proper_name, c.email, c.phone
        HAVING total_spent > '1000'
        ORDER BY total_spent DESC 
        ;
	RESULT : 
          | Customer\_ID | Customer Name  | Email                                            | Phone      | Revenue (₹) |
          | ------------ | -------------- | ----------------------------------------------------------------- | ---------- | ----------- |
          | 190          | Chris Davis    | [chrisdavis52@outlook.com](mailto:chrisdavis52@outlook.com)       | 7662234271 | 2225.78     |
          | 15           | Sara Taylor    | [sarataylor14@gmail.com](mailto:sarataylor14@gmail.com)           | 6205847600 | 1307.82     |
          | 88           | John Smith     | [johnsmith54@gmail.com](mailto:johnsmith54@gmail.com)             | 6304656046 | 1111.63     |
          | 172          | Chris Williams | [chriswilliams91@outlook.com](mailto:chriswilliams91@outlook.com) | 6159637301 | 1083.08     |
          | 103          | Bob Miller     | [bobmiller81@gmail.com](mailto:bobmiller81@gmail.com)             | 6269518104 | 1058.72     |

	BUSINESS INSIGHTS : Chris Davis (ID: 190) is the most valuable customer, generating ₹2225.78, which is more than double the overall average value per customer (₹1085.78). 
                      Sara Taylor (ID: 15) is the second-highest spender with ₹1307.82, above the average. 
                      Customers John Smith, Chris Williams, and Bob Miller are just slightly above the average revenue per customer, indicating they are consistent contributors.
                      The top 5 customers together generate ₹6786.03, which represents a significant share of total revenue (depending on overall sales).
                      Retention & loyalty strategies (personalized offers, exclusive benefits, or premium services) should be focused on these customers to maintain and grow long-term profitability.

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

D.
	INSIGHTS : Which customers are in top 10% most frequent buyers ?
	QUERY : 
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
                                FROM customer_orders
                                ;

	RESULT :
            | Customer\_ID | Customer Name  |
            | ------------ | -------------- |
            | 34           | Emma Davis     |
            | 19           | Linda Smith    |
            | 17           | Linda Miller   |
            | 39           | Alice Miller   |
            | 14           | Linda Smith    |
            | 47           | Bob Jones      |
            | 1            | Alice Miller   |
            | 31           | Emma Williams  |
            | 22           | Sara Clark     |
            | 41           | Mike Jones     |
            | 40           | Chris Brown    |
            | 26           | Mike Brown     |
            | 49           | Emma Smith     |
            | 50           | David Jones    |
            | 33           | Sara Davis     |
            | 32           | Mike Smith     |
            | 20           | Emma Brown     |
            | 44           | Linda Brown    |
            | 13           | Linda Williams |
            | 15           | Sara Taylor    |
            | 18           | Alice Clark    |
            | 11           | Emma Smith     |
            | 43           | Sara Lee       |
            | 3            | David Jones    |
            | 7            | Mike Clark     |
            | 8            | Alice Williams |
            | 12           | Emma Clark     |
            | 10           | Chris Miller   |
            | 9            | John Johnson   |
            | 5            | Sara Smith     |
            | 27           | Linda Smith    |
            | 36           | Linda Davis    |
            | 16           | Chris Davis    |
            | 6            | John Brown     |
            | 2            | Mike Jones     |
            | 42           | Mike Williams  |
            | 23           | Chris Taylor   |
            | 24           | Sara Jones     |
            | 45           | Alice Miller   |
            | 21           | Jane Taylor    |
            | 30           | Jane Miller    |
            | 4            | Sara Clark     |

	BUSINESS INSIGHTS : This customer dataset shows high duplication in first names and family surnames. 
                      By cleaning duplicates and grouping customers into family clusters, the business can improve targeted marketing, customer relationship management, and household-level revenue analysis.

===========================================================================================================================================================================================================================
