-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`users` (
  `id` INT NOT NULL,
  `fio` VARCHAR(255) NOT NULL,
  `login` VARCHAR(255) NULL,
  `password` VARCHAR(255) NULL,
  `e_mail` VARCHAR(255) NULL,
  `type` VARCHAR(45) NULL,
  PRIMARY KEY (`id`, `fio`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `login_UNIQUE` (`login` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`settings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`settings` (
  `id` INT NOT NULL,
  `host` VARCHAR(45) NULL,
  `db` VARCHAR(45) NULL,
  `user` VARCHAR(255) NULL,
  `password` VARCHAR(255) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`product_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`product_type` (
  `id` INT NOT NULL,
  `name` VARCHAR(255) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`shop`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`shop` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `address` VARCHAR(45) NULL,
  `tel` VARCHAR(45) NULL,
  `site` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`products` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `shop_id` INT NOT NULL,
  `type_id` INT NOT NULL,
  `brand` VARCHAR(255) NULL,
  `model` VARCHAR(255) NULL,
  `data` TINYTEXT NULL,
  `img` VARCHAR(255) NULL,
  `price` VARCHAR(45) NULL,
  `warranty` VARCHAR(45) NULL,
  PRIMARY KEY (`id`, `shop_id`, `type_id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `product_to_type_idx` (`type_id` ASC) VISIBLE,
  INDEX `shop_to_products_idx` (`shop_id` ASC) VISIBLE,
  CONSTRAINT `product_to_type`
    FOREIGN KEY (`type_id`)
    REFERENCES `mydb`.`product_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `shop_to_products`
    FOREIGN KEY (`shop_id`)
    REFERENCES `mydb`.`shop` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`deliveries`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`deliveries` (
  `order_id` INT NOT NULL AUTO_INCREMENT,
  `fio` INT NOT NULL,
  `address` VARCHAR(255) NULL,
  `time` VARCHAR(255) NULL,
  `date` DATE NULL,
  `confirm` TINYINT NULL,
  PRIMARY KEY (`order_id`, `fio`),
  UNIQUE INDEX `order_id_UNIQUE` (`order_id` ASC) VISIBLE,
  CONSTRAINT `deliveries_to_orders`
    FOREIGN KEY (`order_id`)
    REFERENCES `mydb`.`oreders` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`oreders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`oreders` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `shop_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `fio` INT NOT NULL,
  `date` DATE NULL,
  `quantity` INT NULL,
  `tel` VARCHAR(255) NULL,
  `confirm` TINYINT NULL,
  PRIMARY KEY (`id`, `shop_id`, `product_id`, `fio`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `orders_to_products_idx` (`product_id` ASC) VISIBLE,
  INDEX `orders_to_shop_idx` (`shop_id` ASC) VISIBLE,
  INDEX `ordersf_todoliveriesf_idx` (`fio` ASC) VISIBLE,
  CONSTRAINT `orders_to_products`
    FOREIGN KEY (`product_id`)
    REFERENCES `mydb`.`products` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `orders_to_shop`
    FOREIGN KEY (`shop_id`)
    REFERENCES `mydb`.`shop` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `orders_to_users`
    FOREIGN KEY (`id`)
    REFERENCES `mydb`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ordersf_todoliveriesf`
    FOREIGN KEY (`fio`)
    REFERENCES `mydb`.`deliveries` (`fio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
