"""Rebuild SQLite database from source CSVs. Python 3 standard library only."""
import csv
import sqlite3
from pathlib import Path
ROOT = Path(__file__).resolve().parent
DB = ROOT / 'ecommerce_analytics.db'
if DB.exists():
    DB.unlink()
con = sqlite3.connect(DB)
con.executescript((ROOT / 'sql' / '01_schema.sql').read_text(encoding='utf-8'))
for table in ('customers', 'products', 'orders', 'order_items', 'payments'):
    with (ROOT / 'data' / f'{table}.csv').open(newline='', encoding='utf-8') as f:
        reader = csv.DictReader(f)
        cols = reader.fieldnames
        con.executemany(f"INSERT INTO {table} ({','.join(cols)}) VALUES ({','.join('?' for _ in cols)})", ([row[c] for c in cols] for row in reader))
con.commit()
assert not con.execute('PRAGMA foreign_key_check').fetchall()
print('Database created:', DB)
con.close()
