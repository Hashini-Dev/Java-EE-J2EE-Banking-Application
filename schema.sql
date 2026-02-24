-- Banking System Database Schema
-- Based on ER Diagram provided by the user

SET FOREIGN_KEY_CHECKS = 0;

-- -----------------------------------------------------
-- Table `status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `status` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `status` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `user_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `user_type` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `transfer_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `transfer_type` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `account_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `account_type` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `bank`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bank` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NULL,
  `username` VARCHAR(45) NOT NULL,
  `email` VARCHAR(100) NULL,
  `password` VARCHAR(255) NOT NULL,
  `contact` VARCHAR(10) NULL,
  `nic` VARCHAR(20) NOT NULL,
  `user_type_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC),
  UNIQUE INDEX `nic_UNIQUE` (`nic` ASC),
  INDEX `fk_users_user_type_idx` (`user_type_id` ASC),
  CONSTRAINT `fk_users_user_type`
    FOREIGN KEY (`user_type_id`)
    REFERENCES `user_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `account`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `account` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `account_no` BIGINT NOT NULL,
  `users_id` INT NOT NULL,
  `balance` DOUBLE NOT NULL DEFAULT 0,
  `interest_rate` DECIMAL(5,2) NULL,
  `account_type_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `account_no_UNIQUE` (`account_no` ASC),
  INDEX `fk_account_users1_idx` (`users_id` ASC),
  INDEX `fk_account_account_type1_idx` (`account_type_id` ASC),
  CONSTRAINT `fk_account_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_account_account_type1`
    FOREIGN KEY (`account_type_id`)
    REFERENCES `account_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `fund_transfer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fund_transfer` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `from_account_id` INT NOT NULL,
  `to_account_id` INT NOT NULL,
  `amount` DOUBLE NOT NULL,
  `payment_date` DATE NOT NULL,
  `description` TEXT NULL,
  `status_id` INT NOT NULL,
  `transfer_type_id` INT NOT NULL,
  `processed` TINYINT NOT NULL DEFAULT 0,
  `bank_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_fund_transfer_account1_idx` (`from_account_id` ASC),
  INDEX `fk_fund_transfer_account2_idx` (`to_account_id` ASC),
  INDEX `fk_fund_transfer_status1_idx` (`status_id` ASC),
  INDEX `fk_fund_transfer_transfer_type1_idx` (`transfer_type_id` ASC),
  INDEX `fk_fund_transfer_bank1_idx` (`bank_id` ASC),
  CONSTRAINT `fk_fund_transfer_account1`
    FOREIGN KEY (`from_account_id`)
    REFERENCES `account` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fund_transfer_account2`
    FOREIGN KEY (`to_account_id`)
    REFERENCES `account` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fund_transfer_status1`
    FOREIGN KEY (`status_id`)
    REFERENCES `status` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fund_transfer_transfer_type1`
    FOREIGN KEY (`transfer_type_id`)
    REFERENCES `transfer_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fund_transfer_bank1`
    FOREIGN KEY (`bank_id`)
    REFERENCES `bank` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

SET FOREIGN_KEY_CHECKS = 1;

-- -----------------------------------------------------
-- Sample Data
-- -----------------------------------------------------

INSERT INTO `user_type` (`type`) VALUES ('Admin'), ('Customer');
INSERT INTO `status` (`status`) VALUES ('Active'), ('Inactive'), ('Pending'), ('Success'), ('Failed');
INSERT INTO `account_type` (`type`) VALUES ('Savings'), ('Current');
INSERT INTO `transfer_type` (`type`) VALUES ('Instant'), ('Scheduled');
INSERT INTO `bank` (`name`) VALUES ('Antigravity Bank'), ('Other Bank');
