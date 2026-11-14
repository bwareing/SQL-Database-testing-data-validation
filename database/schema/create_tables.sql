CREATE table customer_old (
    customer_id int primary key,
    first_name VARCHAR(50) Not Null,
    last_name VARCHAR(50) Not Null,
    email VARCHAR(100) Not Null,
    phone VARCHAR(20),
    created_date date Not Null
);

CREATE table customer_new (
    customer_id int primary key,
    first_name VARCHAR(50) Not Null,
    last_name VARCHAR(50) Not Null,
    email VARCHAR(100) Not Null,
    phone VARCHAR(20),
    created_date date Not Null,
    updated_date date
);

CREATE table orders (
    order_id int primary key,
    customer_id int,
    order_date date Not Null,
    order_amount decimal(10,2) Not Null,
    order_status VARCHAR(50) Not Null,
    FOREIGN KEY (customer_id) REFERENCES customer_new(customer_id)
);
