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
-- 04. Seller Revenue Performance
-- 05. Delivery Performance by Region
-- 06. Impact of Late Delivery on Customer Satisfaction
-- 07. Product Category Satisfaction
-- 08. Impact of Freight Cost on Customer Satisfaction
-- 09. High-Revenue / Low-Performance Sellers
-- 10. Most Valuable Geographic Markets