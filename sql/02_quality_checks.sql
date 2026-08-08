-- Data quality checks for Olist source and core tables.

-- Example: duplicate order IDs
-- SELECT order_id, COUNT(*)
-- FROM olist.orders
-- GROUP BY order_id
-- HAVING COUNT(*) > 1;

-- Example: orphan order items
-- SELECT COUNT(*)
-- FROM olist.order_items oi
-- LEFT JOIN olist.orders o
--   ON oi.order_id = o.order_id
-- WHERE o.order_id IS NULL;

