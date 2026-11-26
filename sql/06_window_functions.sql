-- Rank products by revenue within category
WITH product_revenue AS (
 SELECT p.product_id,p.product_name,p.category,
 ROUND(SUM(oi.quantity*oi.unit_price),2) AS revenue
 FROM products p JOIN order_items oi ON p.product_id=oi.product_id
 JOIN orders o ON o.order_id=oi.order_id WHERE o.order_status='Delivered'
 GROUP BY p.product_id
)
SELECT *,DENSE_RANK() OVER(PARTITION BY category ORDER BY revenue DESC) AS category_rank
FROM product_revenue ORDER BY category,category_rank;

-- Running monthly revenue and previous-month comparison
WITH monthly AS (
 SELECT strftime('%Y-%m',o.order_date) AS month,
 ROUND(SUM(oi.quantity*oi.unit_price),2) AS revenue
 FROM orders o JOIN order_items oi ON o.order_id=oi.order_id
 WHERE o.order_status='Delivered' GROUP BY month
)
SELECT month,revenue,
 ROUND(SUM(revenue) OVER(ORDER BY month ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW),2) AS cumulative_revenue,
 LAG(revenue) OVER(ORDER BY month) AS previous_month_revenue
FROM monthly ORDER BY month;
