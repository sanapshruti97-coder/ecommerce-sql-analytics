PRAGMA foreign_keys=ON;
CREATE TABLE customers (customer_id INTEGER PRIMARY KEY, customer_name TEXT NOT NULL, city TEXT, signup_date TEXT NOT NULL);
CREATE TABLE products (product_id INTEGER PRIMARY KEY, product_name TEXT NOT NULL, category TEXT NOT NULL, list_price REAL NOT NULL);
CREATE TABLE orders (order_id INTEGER PRIMARY KEY, customer_id INTEGER NOT NULL REFERENCES customers(customer_id), order_date TEXT NOT NULL, order_status TEXT NOT NULL, sales_channel TEXT NOT NULL);
CREATE TABLE order_items (order_item_id INTEGER PRIMARY KEY, order_id INTEGER NOT NULL REFERENCES orders(order_id), product_id INTEGER NOT NULL REFERENCES products(product_id), quantity INTEGER NOT NULL, unit_price REAL NOT NULL);
CREATE TABLE payments (payment_id INTEGER PRIMARY KEY, order_id INTEGER NOT NULL UNIQUE REFERENCES orders(order_id), amount REAL NOT NULL, payment_method TEXT, payment_status TEXT);
CREATE INDEX idx_orders_customer ON orders(customer_id);
CREATE INDEX idx_orders_date ON orders(order_date);
CREATE INDEX idx_items_order ON order_items(order_id);
