-- Marketing: repeat delivered buyers with high spend and no purchase in last 90 days of dataset
WITH delivered_orders AS (
 SELECT o.customer_id,o.order_id,o.order_date,SUM(oi.quantity*oi.unit_price) AS value
 FROM orders o JOIN order_items oi ON o.order_id=oi.order_id
 WHERE o.order_status='Delivered' GROUP BY o.customer_id,o.order_id,o.order_date
), customer_summary AS (
 SELECT customer_id,COUNT(*) AS order_count,ROUND(SUM(value),2) AS lifetime_value,MAX(order_date) AS last_order
 FROM delivered_orders GROUP BY customer_id
), anchor AS (SELECT MAX(order_date) AS as_of_date FROM orders)
SELECT c.customer_id,c.city,s.order_count,s.lifetime_value,s.last_order,
 CAST(julianday(a.as_of_date)-julianday(s.last_order) AS INTEGER) AS days_since_last_order
FROM customer_summary s JOIN customers c ON c.customer_id=s.customer_id CROSS JOIN anchor a
WHERE s.order_count>=2 AND s.lifetime_value>=20000
AND julianday(a.as_of_date)-julianday(s.last_order)>90
ORDER BY s.lifetime_value DESC;
