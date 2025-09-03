*\

-- FOREIGN KEY INDEX

CREATE INDEX idx_orders_customer_id ON orders(customer_id);
CREATE INDEX idx_customers_region_id ON customers(region_id);
CREATE INDEX idx_order_items_order_id ON order_items(order_id);
CREATE INDEX idx_order_items_product_id ON order_items(product_id);

-- DATA COLUMN INDEX

CREATE INDEX idx_orders_order_date ON orders(order_date);
CREATE INDEX idx_orders_ship_date ON orders(ship_date);
CREATE INDEX idx_region_region_name ON region(region_name(30));

-- COMPOSITE INDEXE

CREATE INDEX idx_orders_customer_date ON orders(customer_id, order_date);
CREATE INDEX idx_products_info ON products(product_name(30), category(30), price);
