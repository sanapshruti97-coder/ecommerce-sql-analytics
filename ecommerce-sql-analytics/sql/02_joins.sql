-- Revenue by product category (delivered orders only)
SELECT p.category, COUNT(DISTINCT o.order_id) AS delivered_orders,
       SUM(oi.quantity) AS units_sold,
       ROUND(SUM(oi.quantity * oi.unit_price),2) AS revenue
FROM orders o JOIN order_items oi ON o.order_id=oi.order_id
JOIN products p ON p.product_id=oi.product_id
WHERE o.order_status='Delivered'
GROUP BY p.category ORDER BY revenue DESC;
