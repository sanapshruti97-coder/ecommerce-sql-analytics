-- Orders by weekday (SQLite: 0=Sunday, 6=Saturday)
SELECT CASE strftime('%w',order_date)
 WHEN '0' THEN 'Sunday' WHEN '1' THEN 'Monday' WHEN '2' THEN 'Tuesday'
 WHEN '3' THEN 'Wednesday' WHEN '4' THEN 'Thursday' WHEN '5' THEN 'Friday'
 ELSE 'Saturday' END AS weekday,
 COUNT(*) AS total_orders,
 SUM(CASE WHEN order_status='Delivered' THEN 1 ELSE 0 END) AS delivered_orders
FROM orders GROUP BY strftime('%w',order_date) ORDER BY strftime('%w',order_date);

-- Days between signup and first order
SELECT c.customer_id,c.signup_date,MIN(o.order_date) AS first_order_date,
 CAST(julianday(MIN(o.order_date))-julianday(c.signup_date) AS INTEGER) AS days_to_first_order
FROM customers c JOIN orders o ON c.customer_id=o.customer_id
GROUP BY c.customer_id,c.signup_date ORDER BY days_to_first_order DESC LIMIT 20;
