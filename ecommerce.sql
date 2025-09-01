-- Use/Innit DB
CREATE DATABASE IF NOT EXISTS ecommerce;
USE ecommerce;

-- =========================
-- REFERENCE TABLES
-- =========================

CREATE TABLE categories (
  category_id     BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  category_name   VARCHAR(120) NOT NULL,
  parent_id       BIGINT UNSIGNED NULL,
  UNIQUE KEY uk_category_name (category_name),
  CONSTRAINT fk_categories_parent
    FOREIGN KEY (parent_id) REFERENCES categories(category_id)
      ON UPDATE CASCADE ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE manufacturers (
  manufacturer_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name            VARCHAR(160) NOT NULL,
  email           VARCHAR(160),
  phone           VARCHAR(30),
  address_line1   VARCHAR(200),
  address_line2   VARCHAR(200),
  city            VARCHAR(100),
  state           VARCHAR(100),
  postal_code     VARCHAR(20),
  country         VARCHAR(100),
  UNIQUE KEY uk_manufacturer_name (name)
) ENGINE=InnoDB;

-- =========================
-- PRODUCT CATALOG
-- =========================

CREATE TABLE products (
  product_id      BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name            VARCHAR(160) NOT NULL,
  description     TEXT,
  price           DECIMAL(10,2) NOT NULL CHECK (price >= 0),
  stock           INT NOT NULL DEFAULT 0 CHECK (stock >= 0),
  category_id     BIGINT UNSIGNED NOT NULL,
  manufacturer_id BIGINT UNSIGNED NULL,
  created_at      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at      TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  KEY idx_products_category (category_id),
  KEY idx_products_manufacturer (manufacturer_id),
  FULLTEXT KEY ft_products_name_desc (name, description),
  CONSTRAINT fk_products_category
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_products_manufacturer
    FOREIGN KEY (manufacturer_id) REFERENCES manufacturers(manufacturer_id)
      ON UPDATE CASCADE ON DELETE SET NULL
) ENGINE=InnoDB;

-- =========================
-- CUSTOMERS & AUTH
-- =========================

CREATE TABLE customers (
  customer_id   BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  full_name     VARCHAR(160) NOT NULL,
  email         VARCHAR(160) NOT NULL,
  phone         VARCHAR(30),
  password_hash VARCHAR(255) NOT NULL,
  address_line1 VARCHAR(200),
  address_line2 VARCHAR(200),
  city          VARCHAR(100),
  state         VARCHAR(100),
  postal_code   VARCHAR(20),
  country       VARCHAR(100),
  created_at    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY uk_customer_email (email),
  KEY idx_customer_phone (phone)
) ENGINE=InnoDB;

-- Each customer has at most one open cart
CREATE TABLE carts (
  cart_id      BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  customer_id  BIGINT UNSIGNED NOT NULL,
  created_at   TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY uk_cart_customer (customer_id),
  CONSTRAINT fk_carts_customer
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
      ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE cart_items (
  cart_item_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  cart_id      BIGINT UNSIGNED NOT NULL,
  product_id   BIGINT UNSIGNED NOT NULL,
  quantity     INT NOT NULL CHECK (quantity > 0),
  added_at     TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY uk_cart_product (cart_id, product_id),
  KEY idx_cartitems_product (product_id),
  CONSTRAINT fk_cartitems_cart
    FOREIGN KEY (cart_id) REFERENCES carts(cart_id)
      ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_cartitems_product
    FOREIGN KEY (product_id) REFERENCES products(product_id)
      ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

-- =========================
-- ORDERS, ITEMS, PAYMENTS
-- =========================

CREATE TABLE orders (
  order_id        BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  customer_id     BIGINT UNSIGNED NOT NULL,
  order_date      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  status          ENUM('PLACED','PAID','PACKED','SHIPPED','DELIVERED','CANCELLED','REFUNDED')
                  NOT NULL DEFAULT 'PLACED',
  subtotal_amount DECIMAL(10,2) NOT NULL DEFAULT 0,
  shipping_amount DECIMAL(10,2) NOT NULL DEFAULT 0,
  discount_amount DECIMAL(10,2) NOT NULL DEFAULT 0,
  total_amount    DECIMAL(10,2) AS (subtotal_amount + shipping_amount - discount_amount) STORED,
  ship_name       VARCHAR(160),
  ship_phone      VARCHAR(30),
  ship_address1   VARCHAR(200),
  ship_address2   VARCHAR(200),
  ship_city       VARCHAR(100),
  ship_state      VARCHAR(100),
  ship_postal     VARCHAR(20),
  ship_country    VARCHAR(100),
  KEY idx_orders_customer (customer_id),
  KEY idx_orders_status (status),
  CONSTRAINT fk_orders_customer
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
      ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE order_items (
  order_item_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  order_id      BIGINT UNSIGNED NOT NULL,
  product_id    BIGINT UNSIGNED NOT NULL,
  quantity      INT NOT NULL CHECK (quantity > 0),
  unit_price    DECIMAL(10,2) NOT NULL CHECK (unit_price >= 0),
  line_total    DECIMAL(10,2) AS (quantity * unit_price) STORED,
  UNIQUE KEY uk_order_product (order_id, product_id),
  KEY idx_orderitems_product (product_id),
  CONSTRAINT fk_orderitems_order
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
      ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_orderitems_product
    FOREIGN KEY (product_id) REFERENCES products(product_id)
      ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE payments (
  payment_id     BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  order_id       BIGINT UNSIGNED NOT NULL,
  method         ENUM('UPI','CARD','NET_BANKING','WALLET','COD') NOT NULL,
  amount         DECIMAL(10,2) NOT NULL CHECK (amount >= 0),
  status         ENUM('PENDING','SUCCESS','FAILED','REFUNDED') NOT NULL DEFAULT 'PENDING',
  transaction_ref VARCHAR(120),
  paid_at        TIMESTAMP NULL DEFAULT NULL,
  UNIQUE KEY uk_payments_order (order_id), -- 1:1 with order
  CONSTRAINT fk_payments_order
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
      ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

-- =========================
-- LOGISTICS
-- =========================

CREATE TABLE distributors (
  distributor_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name           VARCHAR(160) NOT NULL,
  contact_email  VARCHAR(160),
  contact_phone  VARCHAR(30),
  service_area   VARCHAR(160),
  UNIQUE KEY uk_distributor_name (name)
) ENGINE=InnoDB;

CREATE TABLE shipments (
  shipment_id     BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  order_id        BIGINT UNSIGNED NOT NULL,
  distributor_id  BIGINT UNSIGNED NOT NULL,
  tracking_number VARCHAR(120) NOT NULL,
  status          ENUM('CREATED','DISPATCHED','IN_TRANSIT','OUT_FOR_DELIVERY','DELIVERED','FAILED','RETURNED')
                  NOT NULL DEFAULT 'CREATED',
  dispatched_at   TIMESTAMP NULL,
  delivered_at    TIMESTAMP NULL,
  UNIQUE KEY uk_shipments_order (order_id),       -- enforce 1:1 Order:Shipment
  UNIQUE KEY uk_shipments_tracking (tracking_number),
  KEY idx_shipments_distributor (distributor_id),
  CONSTRAINT fk_shipments_order
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
      ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_shipments_distributor
    FOREIGN KEY (distributor_id) REFERENCES distributors(distributor_id)
      ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

-- =========================
-- ORG / HR
-- =========================

CREATE TABLE departments (
  department_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  department_name VARCHAR(120) NOT NULL,
  UNIQUE KEY uk_department_name (department_name)
) ENGINE=InnoDB;

CREATE TABLE employees (
  employee_id   BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  full_name     VARCHAR(160) NOT NULL,
  email         VARCHAR(160) NOT NULL,
  phone         VARCHAR(30),
  role          ENUM('ADMIN','MANAGER','SUPPORT','WAREHOUSE','DELIVERY','FINANCE','HR')
                NOT NULL DEFAULT 'SUPPORT',
  department_id BIGINT UNSIGNED,
  hired_at      DATE,
  UNIQUE KEY uk_employee_email (email),
  KEY idx_employees_department (department_id),
  CONSTRAINT fk_employees_department
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
      ON UPDATE CASCADE ON DELETE SET NULL
) ENGINE=InnoDB;

-- =========================
-- REVIEWS / SUPPORT / INVENTORY LOGS
-- =========================

CREATE TABLE reviews (
  review_id   BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  customer_id BIGINT UNSIGNED NOT NULL,
  product_id  BIGINT UNSIGNED NOT NULL,
  rating      TINYINT NOT NULL CHECK (rating BETWEEN 1 AND 5),
  comment     TEXT,
  review_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY uk_review_customer_product (customer_id, product_id),
  KEY idx_reviews_product (product_id),
  CONSTRAINT fk_reviews_customer
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
      ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_reviews_product
    FOREIGN KEY (product_id) REFERENCES products(product_id)
      ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE inventory_logs (
  log_id          BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  product_id      BIGINT UNSIGNED NOT NULL,
  employee_id     BIGINT UNSIGNED,
  change_type     ENUM('ADD','REMOVE','ADJUST','SALE','RETURN') NOT NULL,
  quantity_changed INT NOT NULL,            -- can be negative on REMOVE/SALE
  note            VARCHAR(255),
  created_at      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  KEY idx_invlogs_product (product_id),
  KEY idx_invlogs_employee (employee_id),
  CONSTRAINT fk_invlogs_product
    FOREIGN KEY (product_id) REFERENCES products(product_id)
      ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_invlogs_employee
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
      ON UPDATE CASCADE ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE support_tickets (
  ticket_id       BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  customer_id     BIGINT UNSIGNED NOT NULL,
  assigned_emp_id BIGINT UNSIGNED NULL,
  issue_summary   VARCHAR(200) NOT NULL,
  issue_detail    TEXT,
  status          ENUM('OPEN','IN_PROGRESS','RESOLVED','CLOSED') NOT NULL DEFAULT 'OPEN',
  created_at      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at      TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  KEY idx_tickets_customer (customer_id),
  KEY idx_tickets_assignee (assigned_emp_id),
  CONSTRAINT fk_tickets_customer
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
      ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_tickets_employee
    FOREIGN KEY (assigned_emp_id) REFERENCES employees(employee_id)
      ON UPDATE CASCADE ON DELETE SET NULL
) ENGINE=InnoDB;

-- =========================
-- OPTIONAL: SAMPLE CHECKS/TRIGGERS (lightweight)
-- Keep stock from going negative on order placement.
-- =========================

/* Example trigger to reduce stock when an order item is inserted.
   Adjust to your transactional strategy as needed. */
DELIMITER $$
CREATE TRIGGER trg_order_items_after_insert
AFTER INSERT ON order_items
FOR EACH ROW
BEGIN
  UPDATE products
  SET stock = stock - NEW.quantity
  WHERE product_id = NEW.product_id;

  -- Keep subtotal in sync on the order header
  UPDATE orders o
  JOIN (
    SELECT order_id, SUM(line_total) AS sum_total
    FROM order_items
    WHERE order_id = NEW.order_id
    GROUP BY order_id
  ) s ON s.order_id = o.order_id
  SET o.subtotal_amount = s.sum_total;
END$$
DELIMITER ;

-- Prevent negative stock
ALTER TABLE products
  ADD CONSTRAINT chk_products_stock_nonneg CHECK (stock >= 0);


-- --------------------------------------------------------------------------------------------------------------------------------------------------------
