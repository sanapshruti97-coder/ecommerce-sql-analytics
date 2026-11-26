-- Monthly delivered revenue and average order value
WITH order_totals AS (
 SELECT o.order_id, o.order_date, SUM(oi.quantity*oi.unit_price) AS order_value
 FROM orders o JOIN order_items oi ON o.order_id=oi.order_id
 WHERE o.order_status='Delivered'
 GROUP BY o.order_id,o.order_date
)
SELECT strftime('%Y-%m',order_date) AS month,COUNT(*) AS orders,
 ROUND(SUM(order_value),2) AS revenue,ROUND(AVG(order_value),2) AS avg_order_value
FROM order_totals GROUP BY month ORDER BY month;
