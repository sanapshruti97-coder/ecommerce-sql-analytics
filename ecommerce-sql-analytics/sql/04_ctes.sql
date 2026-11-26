-- Customer lifetime spend and order count
WITH delivered_order_values AS (
 SELECT o.customer_id,o.order_id,SUM(oi.quantity*oi.unit_price) AS order_value
 FROM orders o JOIN order_items oi ON o.order_id=oi.order_id
 WHERE o.order_status='Delivered' GROUP BY o.customer_id,o.order_id
), customer_metrics AS (
 SELECT customer_id,COUNT(*) AS delivered_orders,ROUND(SUM(order_value),2) AS lifetime_spend
 FROM delivered_order_values GROUP BY customer_id
)
SELECT c.customer_id,c.city,COALESCE(m.delivered_orders,0) AS delivered_orders,
 COALESCE(m.lifetime_spend,0) AS lifetime_spend
FROM customers c LEFT JOIN customer_metrics m ON c.customer_id=m.customer_id
ORDER BY lifetime_spend DESC LIMIT 20;
