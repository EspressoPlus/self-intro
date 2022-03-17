-- MySQL Script generated by MySQL Workbench
-- Thu Mar 17 01:02:23 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema gogobudget
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `gogobudget` ;

-- -----------------------------------------------------
-- Schema gogobudget
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `gogobudget` ;
USE `gogobudget` ;

-- -----------------------------------------------------
-- Table `gogobudget`.`User`
-- money_info references money_info table
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gogobudget`.`User` ;

CREATE TABLE IF NOT EXISTS `gogobudget`.`User` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NULL,
  `email` VARCHAR(45) NOT NULL,
  `username` VARCHAR(100) NOT NULL,
  `password` VARCHAR(250) NOT NULL,
  `money_info` VARCHAR(45) NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE (email, username))
ENGINE = InnoDB;

INSERT INTO `gogobudget`.`User`
	(`user_id`, `first_name`, `last_name`, `email`, `username`, `password`, `money_info`)
VALUES
	(1, "Miles", "Morales", "spdrvrs2@test.com", "spdvrs2", MD5('Gwens4L%'), 1),
    (2, "Barry", "Allen", "realfast@test.com", "speedy1", MD5('IrisNoraBart3*'), 2),
	(3, "James", "Howlett", "weaponx@test.com", "Logan1", MD5('4JeanandLaura#'), NULL),
    (4, "Eric", "Brooks", "nomorevamps@test.com", "Blade", MD5('daywalkder98'), NULL),
    (5, "Natasha", "Romanoff", "bwidow@test.com", "Nat21", MD5('redroomsurvivor2'), NULL);

-- -----------------------------------------------------
-- Table `gogobudget`.`Money_Info`
-- Table combines user and ledgers/transactions
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gogobudget`.`Money_Info` ;

CREATE TABLE IF NOT EXISTS `gogobudget`.`Money_Info` (
  `money_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`money_id`),
  INDEX `user_key_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `user_key`
    FOREIGN KEY (`user_id`)
    REFERENCES `gogobudget`.`User` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO `gogobudget`.`Money_Info`
	(`money_id`, `user_id`)
VALUES
	(1, 1),
    (2,2);
    
-- -----------------------------------------------------
-- Table `gogobudget`.`Transactions`
-- tran_title example (Mortgage, Rent, Phone Bill, etc)
-- occurence_type ex (recurring or one time fee)
-- expense or income
-- tran_date = date income or expense will withdraw or deposit
-- entry_date = date transaction was input
-- money_id ties money info to table
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gogobudget`.`Transactions` ;

CREATE TABLE IF NOT EXISTS `gogobudget`.`Transactions` (
  `tran_id` INT NOT NULL AUTO_INCREMENT,
  `tran_title` VARCHAR(45) NOT NULL,
  `occurence_type` VARCHAR(15) NOT NULL,
  `exp_or_income` VARCHAR(7) NOT NULL,
  `tran_date` DATE NOT NULL,
  `amount` DOUBLE NOT NULL,
  `entry_date` DATE NOT NULL,
  `money_id` INT NOT NULL,
  PRIMARY KEY (`tran_id`),
  INDEX `money_key_idx` (`money_id` ASC) VISIBLE,
  CONSTRAINT `money_key`
    FOREIGN KEY (`money_id`)
    REFERENCES `gogobudget`.`Money_Info` (`money_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO `gogobudget`.`Transactions`
	
VALUES
	(1, 'Mortgage', 'recurring', 'expense', STR_TO_DATE("2022-04-22", "%Y-%m-%d"), 1345.00, STR_TO_DATE("2022-03-24", "%Y-%m-%d"), 1),
    (2, 'Electric Bill', 'recurring', 'expense', STR_TO_DATE("2022-04-01", "%Y-%m-%d"), 245.00, STR_TO_DATE("2022-03-24", "%Y-%m-%d"), 1),
    (3, 'Paycheck', 'recurring', 'income', STR_TO_DATE("2022-04-15", "%Y-%m-%d"), 1600.00, STR_TO_DATE("2022-03-24", "%Y-%m-%d"), 1),
    (4, 'Paycheck', 'recurring', 'income', STR_TO_DATE("2022-04-30", "%Y-%m-%d"), 1600.00, STR_TO_DATE("2022-03-24", "%Y-%m-%d"), 1),
    (5, 'Web Shooter Silk', 'one time fee', 'expense', STR_TO_DATE("2022-04-02", "%Y-%m-%d"), 25.00, STR_TO_DATE("2022-03-24", "%Y-%m-%d"), 1),
    (6, 'Mortgage', 'recurring', 'expense', STR_TO_DATE("2022-04-12", "%Y-%m-%d"), 845.00, STR_TO_DATE("2022-03-12", "%Y-%m-%d"), 2),
    (7, 'Shoes', 'one time fee', 'expense', STR_TO_DATE("2022-03-12", "%Y-%m-%d"), 300.00, STR_TO_DATE("2022-03-12", "%Y-%m-%d"), 2),
    (8, 'Paycheck', 'recurring', 'income', STR_TO_DATE("2022-04-01", "%Y-%m-%d"), 2100.00, STR_TO_DATE("2022-03-12", "%Y-%m-%d"), 2);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
