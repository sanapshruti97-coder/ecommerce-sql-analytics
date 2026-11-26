-- Products with delivered revenue above the average category-product revenue
WITH product_sales AS (
 SELECT p.product_id,p.product_name,p.category,COALESCE(SUM(CASE WHEN o.order_status='Delivered' THEN oi.quantity*oi.unit_price ELSE 0 END),0) AS revenue
 FROM products p LEFT JOIN order_items oi ON p.product_id=oi.product_id
 LEFT JOIN orders o ON o.order_id=oi.order_id GROUP BY p.product_id
)
SELECT product_id,product_name,category,ROUND(revenue,2) AS revenue
FROM product_sales s
WHERE revenue > (SELECT AVG(s2.revenue) FROM product_sales s2 WHERE s2.category=s.category)
ORDER BY revenue DESC;
