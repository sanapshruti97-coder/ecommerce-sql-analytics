# Data Dictionary

All data is synthetic. Dates are ISO-8601 strings (`YYYY-MM-DD`) and currency is illustrative INR.

| Table | Columns | Grain |
|---|---|---|
| customers | customer_id (PK), customer_name, city, signup_date | One customer |
| products | product_id (PK), product_name, category, list_price | One product |
| orders | order_id (PK), customer_id (FK), order_date, order_status, sales_channel | One order |
| order_items | order_item_id (PK), order_id (FK), product_id (FK), quantity, unit_price | One order line |
| payments | payment_id (PK), order_id (FK, unique), amount, payment_method, payment_status | One payment per order |

Order statuses: Delivered, Cancelled, Returned, Shipped. Payment statuses: Paid, Failed, Refunded. `unit_price` is the actual synthetic sold price and may differ from `list_price`. `amount` includes all items in the order. No taxes, delivery charges or discounts beyond unit-price adjustments are modeled.
