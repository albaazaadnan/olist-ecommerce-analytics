-- ============================================================
-- OLIST E-COMMERCE BUSINESS ANALYSIS
-- ============================================================




-- 01. Revenue & Order Performance

-- This query return the total numbers of orders, total revenue along side with 
-- average order value

SELECT
    total_orders,
    total_revenue,
    round((total_revenue / total_orders),2) AS aov
FROM 
	(SELECT
		COUNT(DISTINCT o.order_id) as total_orders, 
		sum(price) AS total_revenue
		FROM orders as o
		JOIN order_items as oi
			USING(order_id)
		WHERE o.order_status = 'delivered'
	) AS metrics;



-- 02. Revenue by Product Category

-- This query groups revenue by the original Portuguese category names
-- stored in the products table.
-- The result contains 73 distinct non null categories + 1 NULL group,
-- for 74 rows in total. The NULL group represents products with no
-- category name in the products table.

SELECT 
	p.product_category_name AS category,
	SUM(oi.price) AS revenue

FROM orders as o
JOIN order_items AS oi
	USING(order_id)
JOIN products AS p
	USING(product_id)

WHERE o.order_status = 'delivered'
GROUP BY category;


-- This query translates the portuguese category names into english
-- using the product_category_translation table.
-- The translation table contains 71 categories, while the LEFT JOIN
-- preserves all products from the products table, including categories
-- that have no corresponding translation.
-- The result contains 71 translated categories + 1 NULL group (72 rows in total).

-- The NULL group here is different because it contain both:
-- 1. Products that actually have a NULL category in the products table.
-- 2. Non-null portuguese categories with no corresponding translation.

SELECT 
	pct.product_category_name_english AS category,
	SUM(oi.price) AS revenue

FROM orders as o
JOIN order_items AS oi
	USING(order_id)
JOIN products AS p
	USING(product_id)
LEFT JOIN product_category_translation as pct
	USING(product_category_name)
	
WHERE o.order_status = 'delivered'
GROUP BY category;

-- 74 vs 72, This difference between the two results suggests that some product
-- categories do not have a corresponding translation.
-- The following query identifies those unmatched categories.


SELECT DISTINCT
    p.product_category_name
FROM products AS p
LEFT JOIN product_category_translation AS pct
    USING (product_category_name)
WHERE pct.product_category_name IS NULL
  AND p.product_category_name IS NOT NULL;

-- These two categories exist in the products table but have no
-- corresponding entry in the translation table:
-- "portateis_cozinha_e_preparadores_de_alimentos"
-- "pc_gamer"


  
-- 03. Customer Retention & Repeat Purchases

SELECT 
	customer_type,
	n_customers,
	ROUND((n_customers / SUM(n_customers) OVER() * 100.00),2) AS customer_rate
FROM
	(SELECT 
		CASE WHEN n_orders = 1 THEN 'One Time'
			 ELSE 'Repeat' END AS customer_type,
		COUNT(customer_unique_id) AS n_customers
	
	FROM
		(SELECT
			customer_unique_id,
			COUNT(order_id) as n_orders
		
		FROM customers as c
		JOIN orders as o 
			USING(customer_id)
	
		WHERE o.order_status = 'delivered'
		GROUP BY customer_unique_id
		) AS customer_orders
		
	GROUP BY customer_type
	) AS customers_counts;


-- This query returns the number and percentage of customers who made either
-- one delivered purchase (One Time) or multiple delivered purchases (Repeat).
-- Only 3% of customers made more than one purchase, indicating a very low
-- repeat-purchase rate and a strong reliance on one-time customers.
-- We recommend focusing on customer retention by using targeted email marketing
-- and personalized offers to encourage existing customers to make another purchase.



-- 04. Seller Revenue Performance

SELECT 
    seller_id,
    SUM(price) AS total_revenue
FROM order_items
JOIN orders
    USING(order_id)
WHERE order_status = 'delivered'
GROUP BY seller_id
ORDER BY total_revenue DESC;


-- 05. Delivery Performance by Region

SELECT
	customer_state,
	avg(o.order_delivered_customer_date - o.order_purchase_ts) AS avg_delivery_time

FROM orders as o
JOIN customers as c
	USING(customer_id)
WHERE o.order_status = 'delivered'
GROUP BY customer_state
ORDER BY avg_delivery_time DESC;



-- 06. Impact of Late Delivery on Customer Satisfaction
-- 07. Product Category Satisfaction
-- 08. Impact of Freight Cost on Customer Satisfaction
-- 09. High-Revenue / Low-Performance Sellers
-- 10. Most Valuable Geographic Markets