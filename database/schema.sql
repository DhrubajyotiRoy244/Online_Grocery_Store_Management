-- Maa Bhagwati General Store - base MySQL schema
-- Run once:  mysql -u root -p < database/schema.sql
-- Safe to re-run (every statement uses IF NOT EXISTS).
-- On start-up the server (server/index.js) adds the `customers` and `categories`
-- tables and the nullable `orders.customer_id` column by itself.

SET NAMES utf8mb4;

CREATE DATABASE IF NOT EXISTS maa_bhagwati_store
  CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE maa_bhagwati_store;

CREATE TABLE IF NOT EXISTS products (
  id          INT AUTO_INCREMENT PRIMARY KEY,
  name        VARCHAR(200)  NOT NULL,
  category    VARCHAR(100)  NOT NULL,
  description TEXT          NOT NULL,
  price       DECIMAL(10,2) NOT NULL,
  old_price   DECIMAL(10,2) NULL,
  emoji       VARCHAR(30)   NOT NULL DEFAULT '🛍️',
  image       VARCHAR(500)  NULL,
  stock       INT           NOT NULL DEFAULT 100,
  INDEX idx_products_category (category)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS orders (
  id          INT AUTO_INCREMENT PRIMARY KEY,
  customer    VARCHAR(120)  NOT NULL,
  phone       VARCHAR(18)   NOT NULL,
  address     VARCHAR(500)  NOT NULL,
  total       DECIMAL(12,2) NOT NULL,
  status      VARCHAR(20)   NOT NULL DEFAULT 'New',
  created_at  TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS order_items (
  id          INT AUTO_INCREMENT PRIMARY KEY,
  order_id    INT           NOT NULL,
  product_id  INT           NOT NULL,
  quantity    INT           NOT NULL,
  unit_price  DECIMAL(10,2) NOT NULL,
  CONSTRAINT fk_items_order   FOREIGN KEY (order_id)   REFERENCES orders(id) ON DELETE CASCADE,
  CONSTRAINT fk_items_product FOREIGN KEY (product_id) REFERENCES products(id)
) ENGINE=InnoDB;
