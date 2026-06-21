CREATE TABLE IF NOT EXISTS product (
    product_id SERIAL PRIMARY KEY,
    sku VARCHAR(50) UNIQUE NOT NULL,
    product_name VARCHAR(200) NOT NULL,
    category VARCHAR(100),
    brand VARCHAR(100),
    unit_price NUMERIC(10,2) NOT NULL,
    status VARCHAR(30) DEFAULT 'ACTIVE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS customer (
    customer_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(200) NOT NULL,
    email VARCHAR(200) UNIQUE NOT NULL,
    phone VARCHAR(30),
    loyalty_tier VARCHAR(50),
    total_refund_amount NUMERIC(10,2) DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS stock (
    stock_id SERIAL PRIMARY KEY,
    product_id INT NOT NULL REFERENCES product(product_id),
    warehouse_id VARCHAR(50) NOT NULL,
    available_qty INT DEFAULT 0,
    reserved_qty INT DEFAULT 0,
    reorder_level INT DEFAULT 10,
    last_stock_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS order_header (
    order_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL REFERENCES customer(customer_id),
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    order_status VARCHAR(50) DEFAULT 'CREATED',
    payment_status VARCHAR(50) DEFAULT 'PENDING',
    refund_flag CHAR(1) DEFAULT 'N',
    refund_status VARCHAR(50) DEFAULT 'NOT_APPLICABLE',
    total_amount NUMERIC(10,2) DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS order_line (
    order_line_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL REFERENCES order_header(order_id),
    product_id INT NOT NULL REFERENCES product(product_id),
    quantity INT NOT NULL,
    unit_price NUMERIC(10,2) NOT NULL,
    line_amount NUMERIC(10,2) NOT NULL
);
