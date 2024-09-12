CREATE TABLE locations (
	location_id INTEGER,
	location_name VARCHAR(50) NOT NULL,
	address VARCHAR(100) NOT NULL,
	city VARCHAR(50) NOT NULL,
	state CHAR(2) NOT NULL,
	zip_code CHAR(5),
	PRIMARY KEY (location_id));

CREATE TABLE suppliers (
	supplier_id INTEGER,
	supplier_name VARCHAR(50) NOT NULL,
	contact_name VARCHAR(50) NOT NULL,
	contact_phone VARCHAR(20) NOT NULL,
	contact_email VARCHAR(100) NOT NULL,
	PRIMARY KEY (supplier_id));

CREATE TABLE customers (
	customer_id INTEGER,
	customer_first_name VARCHAR(20) NOT NULL,
	customer_last_name VARCHAR(20) NOT NULL,
	customer_email VARCHAR(100) NOT NULL,
	customer_phone VARCHAR(20) NOT NULL,
	customer_address VARCHAR(100) NOT NULL,
	PRIMARY KEY (customer_id));

CREATE TABLE categories (
    category_id INTEGER,
    category_name VARCHAR NOT NULL,
    PRIMARY KEY (category_id));

CREATE TABLE employees (
	employee_id INTEGER,
	employee_first_name VARCHAR(20) NOT NULL,
	employee_last_name VARCHAR(20) NOT NULL,
	employee_email VARCHAR(100) NOT NULL,
	employee_phone VARCHAR(20) NOT NULL,
	employee_position VARCHAR(50) NOT NULL,
	location_id INTEGER NOT NULL,
	PRIMARY KEY (employee_id),
	FOREIGN KEY (location_id) REFERENCES locations(location_id));

CREATE TABLE inventory_items (
	item_id INTEGER,
	item_name VARCHAR(50) NOT NULL,
	description TEXT NOT NULL,
	category_id INTEGER NOT NULL,
	supplier_id INTEGER NOT NULL,
	cost_price DECIMAL(4,2) NOT NULL,
	retail_price DECIMAL(4,2) NOT NULL,
	quantity_in_stock INTEGER NOT NULL,
	PRIMARY KEY (item_id),
	FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id),
	FOREIGN KEY (category_id) REFERENCES categories(category_id));


CREATE TABLE deliveries (
	delivery_id INTEGER,
	item_id INTEGER NOT NULL,
	supplier_id INTEGER NOT NULL,
	delivery_date DATE NOT NULL,
	quantity_delivered INTEGER NOT NULL,
	delivery_unit_price DECIMAL(6,2) NOT NULL,
	PRIMARY KEY (delivery_id),
	FOREIGN KEY (item_id) REFERENCES inventory_items(item_id),
	FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id));

CREATE TABLE sales (
	sale_id INTEGER,
	employee_id INTEGER NOT NULL,
	sale_date DATE NOT NULL,
	total_amount DECIMAL(6,2) NOT NULL,
	location_id INTEGER NOT NULL,
	PRIMARY KEY (sale_id),
	FOREIGN KEY (employee_id) REFERENCES employees(employee_id),
	FOREIGN KEY (location_id) REFERENCES locations(location_id));


CREATE TABLE transactions (
    transaction_id INTEGER,
    sale_id INTEGER NOT NULL,
	customer_id INTEGER NOT NULL,
    PRIMARY KEY (transaction_id),
    FOREIGN KEY (sale_id) REFERENCES sales(sale_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id));

CREATE TABLE transaction_items (
    transaction_item_id INTEGER,
    transaction_id INTEGER NOT NULL,
	item_id INTEGER NOT NULL,
	quantity_sold SMALLINT NOT NULL,
	unit_price DECIMAL(6, 2) NOT NULL,
    PRIMARY KEY (transaction_item_id),
    FOREIGN KEY (transaction_id) REFERENCES transactions(transaction_id),
    FOREIGN KEY (item_id) REFERENCES inventory_items(item_id));

CREATE TABLE accounting (
    accounting_id INTEGER,
    transaction_id INTEGER NOT NULL,
	transaction_type CHAR(6) NOT NULL,
	transaction_amount DECIMAL(8, 2) NOT NULL,
	transaction_date DATE NOT NULL,
    PRIMARY KEY (accounting_id),
    FOREIGN KEY (transaction_id) REFERENCES transactions(transaction_id),
	CHECK (transaction_type IN ('debit', 'credit')));

CREATE TABLE expenses (
    expense_id INTEGER,
    location_id INTEGER NOT NULL,
	expense_date DATE NOT NULL,
	expense_description VARCHAR NOT NULL,
	expense_amount DECIMAL(8, 2) NOT NULL,
    PRIMARY KEY (expense_id),
    FOREIGN KEY (location_id) REFERENCES locations(location_id));

CREATE TABLE shelves (
    shelf_id INTEGER,
    location_id INTEGER NOT NULL,
	shelf_name VARCHAR NOT NULL,
    PRIMARY KEY (shelf_id),
    FOREIGN KEY (location_id) REFERENCES locations(location_id));

CREATE TABLE shelf_contents (
    shelf_content_id INTEGER,
    shelf_id INTEGER NOT NULL,
	item_id INTEGER NOT NULL,
	quantity_on_shelf SMALLINT NOT NULL,
    PRIMARY KEY (shelf_content_id),
    FOREIGN KEY (shelf_id) REFERENCES shelves(shelf_id),
	FOREIGN KEY (item_id) REFERENCES inventory_items(item_id));
	
CREATE TABLE employee_shifts (
	employee_id INTEGER,
	location_id INTEGER NOT NULL,
	accounting_id INTEGER NOT NULL,
	shift_date DATE NOT NULL,
	shift_end_time TIME NOT NULL,
	shift_start_time TIME NOT NULL,
	hourly_wage DECIMAL(6,2) NOT NULL,
	PRIMARY KEY (employee_id),
	FOREIGN KEY (location_id) REFERENCES locations(location_id),
	FOREIGN KEY (accounting_id) REFERENCES accounting(accounting_id));
	
	
	