-- Customer segments based on delivered spend
WITH spend AS (
 SELECT c.customer_id,c.city,COALESCE(SUM(CASE WHEN o.order_status='Delivered' THEN oi.quantity*oi.unit_price ELSE 0 END),0) AS total_spend
 FROM customers c LEFT JOIN orders o ON c.customer_id=o.customer_id
 LEFT JOIN order_items oi ON o.order_id=oi.order_id GROUP BY c.customer_id
)
SELECT customer_id,city,ROUND(total_spend,2) AS total_spend,
 CASE WHEN total_spend>=50000 THEN 'High Value'
      WHEN total_spend>=15000 THEN 'Medium Value'
      ELSE 'Low Value' END AS customer_segment
FROM spend ORDER BY total_spend DESC;
