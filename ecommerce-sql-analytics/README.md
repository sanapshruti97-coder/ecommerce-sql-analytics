# E-Commerce Sales & Customer Analytics | SQL Portfolio Project

An end-to-end **SQLite** portfolio project using **synthetic e-commerce data** to explore sales performance, product categories, customer value, retention opportunities and channel behavior. No real customer information is included.

## Dataset
- **500 customers**, **80 products**, **2,000 orders**, **4924 order items**, and **2,000 payments**.
- Dates cover 2024–2025; INR-denominated synthetic product prices.
- Five related tables: `customers`, `products`, `orders`, `order_items`, `payments`.
- **Revenue definition:** sum of `quantity * unit_price` for **Delivered** orders only; cancelled, returned and shipped orders are excluded from recognized sales. This is a portfolio convention, not accounting advice.

## Skills demonstrated
| Skill | SQL file | Business question |
|---|---|---|
| JOINs | `sql/02_joins.sql` | Which categories generate the most revenue? |
| Aggregations | `sql/03_aggregations.sql` | How do monthly revenue and AOV change? |
| CTEs | `sql/04_ctes.sql` | Who are the top customers by lifetime spend? |
| Subqueries | `sql/05_subqueries.sql` | Which products beat their category average? |
| Window Functions | `sql/06_window_functions.sql` | How do products rank and revenue accumulate? |
| CASE | `sql/07_case_statements.sql` | How can customers be segmented? |
| Date Functions | `sql/08_date_functions.sql` | What are weekday patterns and first-purchase delays? |
| Combined business case | `sql/09_business_case.sql` | Which valuable repeat buyers may need reactivation? |

## Quick start
1. Download/extract this repository.
2. Open `ecommerce_analytics.db` with [DB Browser for SQLite](https://sqlitebrowser.org/) or another SQLite client.
3. Open any file in `sql/` and run its queries in the SQL editor.
4. Or recreate the database with Python 3: `python setup_database.py` (requires only the standard library).
5. Compare output with CSV files in `results/`.

## Business insights workflow
1. Measure delivered revenue and order volume by month.
2. Compare category performance and rank products within categories.
3. Segment customers by delivered lifetime value.
4. Find valuable repeat customers inactive for over 90 days, relative to the last order date in the synthetic dataset.
5. Propose targeted reactivation campaigns; **do not claim campaigns improved results**, because no experiment was performed.

## Limitations
All records are **synthetically generated**, so patterns are illustrative, not real market findings. Customer names are fictional. `payments` records are illustrative; financial reporting here uses delivered order item values. The analysis uses SQLite functions (`strftime`, `julianday`); other SQL dialects need changes.

## Repository structure
```
README.md
DATA_DICTIONARY.md
setup_database.py
ecommerce_analytics.db
data/              # Five source CSVs
sql/               # Schema and eight analytics scripts
results/           # Reproducible query outputs
```

## Resume bullet
Built an end-to-end SQL e-commerce analytics project across 2,000 synthetic orders, using joins, CTEs, subqueries, window functions, CASE, aggregations and date functions to analyze sales, customer segments and reactivation opportunities.
