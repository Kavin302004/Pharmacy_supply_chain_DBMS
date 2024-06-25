-- Creating the Doctor table
CREATE TABLE Doctor (
    doctor_id NUMBER PRIMARY KEY,
    doctor_name VARCHAR2(100),
    doctor_phone VARCHAR2(20),
    doctor_email VARCHAR2(100)
);

-- Creating the Customer table
CREATE TABLE Customer (
    customer_id NUMBER PRIMARY KEY,
    customer_name VARCHAR2(100),
    email VARCHAR2(100),
    phone VARCHAR2(20),
    premium_subscription VARCHAR2(10),
    address VARCHAR2(200)
);

-- Creating the Payment table
CREATE TABLE Payment (
    payment_id NUMBER PRIMARY KEY,
    pay_date DATE,
    pay_amount NUMBER(10, 2)
);

-- Creating the Class table
CREATE TABLE Class (
    class_id NUMBER PRIMARY KEY,
    class_name VARCHAR2(100),
    description VARCHAR2(500)
);

-- Creating the Supplier table
CREATE TABLE Supplier (
    supplier_id NUMBER PRIMARY KEY,
    supplier_name VARCHAR2(100),
    email VARCHAR2(100),
    phone VARCHAR2(20),
    address VARCHAR2(200)
);

-- Creating the Manufacturer table
CREATE TABLE Manufacturer (
    manufacturer_id NUMBER PRIMARY KEY,
    manufacturer_name VARCHAR2(100),
    email VARCHAR2(100),
    phone VARCHAR2(20),
    address VARCHAR2(200)
);

-- Creating the Medicine table with foreign key references
CREATE TABLE Medicine (
    medicine_id NUMBER PRIMARY KEY,
    medicine_name VARCHAR2(100),
    supplier_id NUMBER,
    manufacturer_id NUMBER,
    stock NUMBER,
    discount NUMBER(5, 2),
    price NUMBER(10, 2),
    expiry_date DATE,
    class_id NUMBER,
    CONSTRAINT fk_supplier FOREIGN KEY (supplier_id) REFERENCES Supplier(supplier_id),
    CONSTRAINT fk_manufacturer FOREIGN KEY (manufacturer_id) REFERENCES Manufacturer(manufacturer_id),
    CONSTRAINT fk_class FOREIGN KEY (class_id) REFERENCES Class(class_id)
);

-- Creating the Customer_order table with foreign key references
CREATE TABLE Customer_order (
    cust_order_id NUMBER PRIMARY KEY,
    customer_id NUMBER,
    order_date DATE,
    delivery_date DATE,
    doctor_id NUMBER,
    payment_id NUMBER,
    CONSTRAINT fk_customer FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    CONSTRAINT fk_doctor FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id),
    CONSTRAINT fk_payment FOREIGN KEY (payment_id) REFERENCES Payment(payment_id)
);

-- Creating the Customer_order_list table with composite primary key and foreign key references
CREATE TABLE Customer_order_list (
    cust_order_id NUMBER,
    medicine_id NUMBER,
    quantity NUMBER,
    unit_price NUMBER(10, 2),
    PRIMARY KEY (cust_order_id, medicine_id),
    CONSTRAINT fk_cust_order FOREIGN KEY (cust_order_id) REFERENCES Customer_order(cust_order_id),
    CONSTRAINT fk_medicine FOREIGN KEY (medicine_id) REFERENCES Medicine(medicine_id)
);

-- Creating the Supplier_Order table
CREATE TABLE Supplier_Order (
    order_id NUMBER PRIMARY KEY,
    order_date DATE,
    delivery_date DATE,
    total_price NUMBER(10, 2)
);

-- Creating the Supply_order_List table with composite primary key and foreign key references
CREATE TABLE Supply_order_List (
    order_id NUMBER,
    medicine_id NUMBER,
    supplier_id NUMBER,
    unit_price NUMBER(10, 2),
    qty NUMBER,
    PRIMARY KEY (order_id, medicine_id),
    CONSTRAINT fk_supply_order FOREIGN KEY (order_id) REFERENCES Supplier_Order(order_id),
    CONSTRAINT fk_supply_medicine FOREIGN KEY (medicine_id) REFERENCES Medicine(medicine_id),
    CONSTRAINT fk_supply_supplier FOREIGN KEY (supplier_id) REFERENCES Supplier(supplier_id)
);
