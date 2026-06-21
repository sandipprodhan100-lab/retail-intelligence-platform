INSERT INTO product (sku, product_name, category, brand, unit_price)
VALUES
('SKU-1001', 'Cotton Shirt', 'Fashion', 'RetailBrand', 29.99),
('SKU-1002', 'Running Shoes', 'Footwear', 'RetailBrand', 79.99)
ON CONFLICT (sku) DO NOTHING;

INSERT INTO customer (customer_name, email, phone, loyalty_tier)
VALUES
('Asha Roy', 'asha.roy@example.com', '07000000001', 'GOLD'),
('John Smith', 'john.smith@example.com', '07000000002', 'SILVER')
ON CONFLICT (email) DO NOTHING;

INSERT INTO stock (product_id, warehouse_id, available_qty, reserved_qty, reorder_level)
SELECT product_id, 'WH-LON-01', 100, 5, 10 FROM product WHERE sku = 'SKU-1001'
ON CONFLICT DO NOTHING;

INSERT INTO stock (product_id, warehouse_id, available_qty, reserved_qty, reorder_level)
SELECT product_id, 'WH-LON-01', 50, 2, 10 FROM product WHERE sku = 'SKU-1002'
ON CONFLICT DO NOTHING;
