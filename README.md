# 404s

### Create a database using ths MySQL syntax

create database shannarts;
use shannarts;

CREATE TABLE `shannarts`.`user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `firstname` VARCHAR(100) NOT NULL,
  `lastname` VARCHAR(100) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `role` INT NOT NULL,
  `phone` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE);

CREATE TABLE `shannarts`.`products` (
  `product_id` INT NOT NULL AUTO_INCREMENT,
  `product_name` VARCHAR(100) NOT NULL,
  `price` DECIMAL(10,2) NOT NULL,
  `decription` VARCHAR(1024) NULL,
  `image_path` VARCHAR(255) NULL,
  `date_added` DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`product_id`),
  UNIQUE INDEX `product_id_UNIQUE` (`product_id` ASC) VISIBLE);

CREATE TABLE `shannarts`.`transactions` (
  `transaction_id` INT NOT NULL,
  `user_id` INT NOT NULL REFERENCES user(user_id),
  `transaction_date` DATETIME NOT NULL,
  `payment_method` ENUM('Cash', 'Online', 'Card') NOT NULL,
  `transaction_status` ENUM('Pending', 'Shipped', 'Delivered') NOT NULL,
  PRIMARY KEY (`transaction_id`));

CREATE TABLE `shannarts`.`transaction_details` (
  `transaction_detail_id` INT NOT NULL,
  `transaction_id` INT NOT NULL REFERENCES transactions(transaction_id),
  `product_id` INT NOT NULL REFERENCES products(product_id),
  `quantity` INT NOT NULL,
  `unit_price` DECIMAL(10,2) NOT NULL,
  `subtotal` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`transaction_detail_id`));