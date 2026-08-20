-- Schema design note:
-- Data types, NULL constraints, primary keys, and foreign keys were chosen based on the
-- Olist dataset's actual structure and findings from EDA, rather than arbitrary assumptions.



CREATE TABLE IF NOT EXISTS customers (
	customer_id VARCHAR(32) PRIMARY KEY,
	customer_unique_id VARCHAR(32) NOT NULL,
	customer_zip_code_prefix CHAR(5) NOT NULL,
	customer_city VARCHAR(100) NOT NULL,
	customer_state CHAR(2) NOT NULL

);

CREATE TABLE IF NOT EXISTS orders (
	order_id VARCHAR(32) PRIMARY KEY,
	customer_id VARCHAR(32) NOT NULL,
	order_status VARCHAR(15) NOT NULL,
	order_purchase_ts TIMESTAMP NOT NULL,
	order_approved_at TIMESTAMP ,
	order_delivered_carrier_date TIMESTAMP ,
	order_delivered_customer_date TIMESTAMP,
	order_estimated_delivery_date TIMESTAMP,

	FOREIGN KEY (customer_id)
		REFERENCES customers(customer_id)
);

CREATE TABLE IF NOT EXISTS products(
	product_id VARCHAR(32) PRIMARY KEY,
	product_category_name VARCHAR(100),
	product_name_length SMALLINT,
	product_description_length SMALLINT,
	product_photos_qty SMALLINT,
	product_weight_g SMALLINT,
	product_length_cm NUMERIC(6,2),
	product_height_cm NUMERIC(6,2),
	product_width_cm NUMERIC(6,2)
);


CREATE TABLE IF NOT EXISTS sellers(
	seller_id VARCHAR(32) PRIMARY KEY,
	seller_zip_code_prefix CHAR(5) NOT NULL,
	seller_city VARCHAR(100) NOT NULL,
	seller_state CHAR(2) NOT NULL
);


CREATE TABLE IF NOT EXISTS order_items (
	order_id VARCHAR(32) NOT NULL,
	order_item_id SMALLINT NOT NULL,
	product_id VARCHAR(32) NOT NULL,
	seller_id VARCHAR(32) NOT NULL,
	shipping_limit_date TIMESTAMP ,
	price NUMERIC(10,2) NOT NULL,
	freight_value NUMERIC(10,2) NOT NULL,

	PRIMARY KEY(order_id, order_item_id),
	
	FOREIGN KEY (order_id)
		REFERENCES orders(order_id),

	FOREIGN KEY (product_id)
    	REFERENCES products(product_id),

	FOREIGN KEY (seller_id)
    	REFERENCES sellers(seller_id)


);

CREATE TABLE IF NOT EXISTS geolocation (
	geolocation_zip_code_prefix CHAR(5) NOT NULL,
	geolocation_lat NUMERIC(9,6) NOT NULL,
	geolocation_lng NUMERIC(9,6) NOT NULL,
	geolocation_city VARCHAR(100) NOT NULL,
	geolocation_state CHAR(2) NOT NULL
);

CREATE TABLE IF NOT EXISTS order_payments (
	order_id VARCHAR(32) NOT NULL,
	payment_sequential SMALLINT NOT NULL,
	payment_type VARCHAR(20) NOT NULL,
	payment_installments SMALLINT NOT NULL,
	payment_value NUMERIC(10,2) NOT NULL,

	PRIMARY KEY (order_id, payment_sequential),

	FOREIGN KEY (order_id)
		REFERENCES orders(order_id)
);


CREATE TABLE IF NOT EXISTS order_reviews (
	review_id VARCHAR(32) PRIMARY KEY,
	order_id VARCHAR(32) NOT NULL,
	review_score SMALLINT NOT NULL,
	review_comment_title VARCHAR(100),
	review_comment_message TEXT,
	review_creation_date TIMESTAMP,
	review_answer_timestamp TIMESTAMP,

	FOREIGN KEY (order_id)
		REFERENCES orders(order_id)
);

CREATE TABLE IF NOT EXISTS product_category_translation (
	product_category_name VARCHAR(100) PRIMARY KEY,
	product_category_name_english VARCHAR(100) NOT NULL
);
