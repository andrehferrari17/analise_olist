CREATE TABLE SELLER (
    seller_id VARCHAR(100) PRIMARY KEY,
	seller_zip_code_prefix VARCHAR(6),
	seller_city VARCHAR (50),
	seller_state VARCHAR(2)
);


COPY SELLER(seller_id, seller_zip_code_prefix, seller_city, seller_state)
FROM 'C:\Users\Administrador\OneDrive\Arquivos_Pessoais\OLIST\CSV_FILES\SELLERS.csv'
DELIMITER ',' 
CSV HEADER;
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
CREATE TABLE PRODUCTS (
    product_id VARCHAR(100) PRIMARY KEY,
	product_category_name VARCHAR(50),
	product_name_lenght INT,
	product_description_lenght INT,
	product_photos_qty INT,
	product_weight_g INT,
	product_length_cm INT,
	product_height_cm INT,
	product_width_cm INT
);


COPY PRODUCTS(
	product_id, product_category_name, product_name_lenght, 
	product_description_lenght, product_photos_qty, product_weight_g,
	product_length_cm, product_height_cm, product_width_cm
	)
FROM 'C:\Users\Administrador\OneDrive\Arquivos_Pessoais\OLIST\CSV_FILES\PRODUCTS.csv'
DELIMITER ',' 
CSV HEADER;
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
CREATE TABLE ORDER_PAYMENTS (
    order_id VARCHAR(100) PRIMARY KEY,
	payment_sequential INT,
	payment_type VARCHAR(30),
	payment_installments INT,
	payment_value FLOAT
);

COPY ORDER_PAYMENTS(
	order_id, payment_sequential, payment_type, 
	payment_installments, payment_value
	)
FROM 'C:\Users\Administrador\OneDrive\Arquivos_Pessoais\OLIST\CSV_FILES\ORDER_PAYMENTS_V2.csv'
DELIMITER ',' 
CSV HEADER;
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
CREATE TABLE CUSTOMERS (
    customer_id VARCHAR(100) PRIMARY KEY,
	customer_unique_id VARCHAR(100),
	customer_zip_code_prefix VARCHAR(6),
	customer_city VARCHAR(50),
	customer_state VARCHAR(2)
);

COPY CUSTOMERS(
	customer_id, customer_unique_id, customer_zip_code_prefix, 
	customer_city, customer_state
	)
FROM 'C:\Users\Administrador\OneDrive\Arquivos_Pessoais\OLIST\CSV_FILES\CUSTOMERS.csv'
DELIMITER ',' 
CSV HEADER;
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
CREATE TABLE ORDER_REVIEWS (
    review_id VARCHAR(100),
    order_id VARCHAR(100) PRIMARY KEY,
    review_score INT,
    review_comment_title TEXT,
    review_comment_message TEXT,
    review_creation_date TIMESTAMP,
    review_answer_timestamp TIMESTAMP
);

COPY ORDER_REVIEWS(
	review_id, order_id, review_score, 
	review_comment_title, review_comment_message, review_creation_date,
	review_answer_timestamp
	)
FROM 'C:\Users\Administrador\OneDrive\Arquivos_Pessoais\OLIST\CSV_FILES\ORDER_REVIEWS.csv'
DELIMITER ',' 
CSV HEADER;









