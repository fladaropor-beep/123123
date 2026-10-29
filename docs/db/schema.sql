-- ShoeShop: схема 
-- Таблицы и столбцы сохраняют имена CSV: categories, manufacturers, suppliers,
-- products, roles, users, pvz, orderstatus, orders, prodorders.
CREATE DATABASE IF NOT EXISTS shoe_shop CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE shoe_shop;
SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS prodorders;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS pvz;
DROP TABLE IF EXISTS orderstatus;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS manufacturers;
DROP TABLE IF EXISTS suppliers;
DROP TABLE IF EXISTS roles;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE categories (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(50) NOT NULL
) ENGINE=InnoDB;
CREATE TABLE manufacturers (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(50) NOT NULL
) ENGINE=InnoDB;
CREATE TABLE suppliers (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(50) NOT NULL
) ENGINE=InnoDB;
CREATE TABLE roles (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(30) NOT NULL
) ENGINE=InnoDB;
CREATE TABLE orderstatus (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(20) NOT NULL
) ENGINE=InnoDB;
CREATE TABLE users (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  full_name VARCHAR(60) NOT NULL,
  login VARCHAR(50) NOT NULL,
  password VARCHAR(30) NOT NULL,
  role_id INT NOT NULL,
  CONSTRAINT fk_users_role FOREIGN KEY (role_id) REFERENCES roles(id)
) ENGINE=InnoDB;
CREATE TABLE pvz (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  postcode CHAR(6) NOT NULL,
  city VARCHAR(30) NOT NULL,
  street VARCHAR(30) NOT NULL,
  house VARCHAR(5) NULL
) ENGINE=InnoDB;
CREATE TABLE products (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  article VARCHAR(10) NOT NULL,
  name VARCHAR(50) NOT NULL,
  unit VARCHAR(10) NOT NULL,
  price DECIMAL(10,2) NOT NULL,
  discount INT NOT NULL,
  stock_qty INT NOT NULL,
  description TEXT NULL,
  photo VARCHAR(100) NULL,
  category_id INT NOT NULL,
  manufacturer_id INT NOT NULL,
  supplier_id INT NOT NULL,
  CONSTRAINT fk_products_category FOREIGN KEY (category_id) REFERENCES categories(id),
  CONSTRAINT fk_products_manufacturer FOREIGN KEY (manufacturer_id) REFERENCES manufacturers(id),
  CONSTRAINT fk_products_supplier FOREIGN KEY (supplier_id) REFERENCES suppliers(id)
) ENGINE=InnoDB;
CREATE TABLE orders (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  order_date DATETIME NOT NULL,
  delivery_date DATETIME NULL,
  pvz_id INT NOT NULL,
  user_id INT NOT NULL,
  receive_code VARCHAR(10) NOT NULL,
  status_id INT NOT NULL,
  CONSTRAINT fk_orders_pvz FOREIGN KEY (pvz_id) REFERENCES pvz(id),
  CONSTRAINT fk_orders_user FOREIGN KEY (user_id) REFERENCES users(id),
  CONSTRAINT fk_orders_status FOREIGN KEY (status_id) REFERENCES orderstatus(id)
) ENGINE=InnoDB;
CREATE TABLE prodorders (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  order_id INT NOT NULL,
  product_id INT NOT NULL,
  qty INT NOT NULL,
  CONSTRAINT fk_prodorders_order FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
  CONSTRAINT fk_prodorders_product FOREIGN KEY (product_id) REFERENCES products(id)
) ENGINE=InnoDB;
