-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema nexus_entry
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema nexus_entry
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `nexus_entry` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `nexus_entry` ;

-- -----------------------------------------------------
-- Table `nexus_entry`.`attendance`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nexus_entry`.`attendance` (
  `Attendance_ID` INT NOT NULL,
  `Attendance_Date` DATE NOT NULL,
  `Check_In_Time` DATETIME NOT NULL,
  `Check_Out_Time` DATETIME NOT NULL,
  PRIMARY KEY (`Attendance_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `nexus_entry`.`member`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nexus_entry`.`member` (
  `Member_ID` INT NOT NULL,
  `First_Name` VARCHAR(60) NOT NULL,
  `Last_Name` VARCHAR(60) NOT NULL,
  `Email` VARCHAR(100) NOT NULL,
  `Gender` VARCHAR(50) NOT NULL,
  `Membership_Type` VARCHAR(60) NOT NULL,
  `Membership_StartDate` DATE NOT NULL,
  `Membership_EndDate` DATE NOT NULL,
  `Phone` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`Member_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `nexus_entry`.`feedback`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nexus_entry`.`feedback` (
  `Feedback_ID` INT NOT NULL,
  `Member_ID` INT NOT NULL,
  `Rating` INT NOT NULL,
  `Comments` TEXT NOT NULL,
  `Feedback_Date` DATE NOT NULL,
  `member_Member_ID` INT NOT NULL,
  PRIMARY KEY (`Feedback_ID`, `member_Member_ID`),
  INDEX `fk_feedback_member_idx` (`member_Member_ID` ASC) VISIBLE,
  CONSTRAINT `fk_feedback_member`
    FOREIGN KEY (`member_Member_ID`)
    REFERENCES `nexus_entry`.`member` (`Member_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `nexus_entry`.`staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nexus_entry`.`staff` (
  `Staff_ID` INT NOT NULL,
  `First_Name` VARCHAR(45) NOT NULL,
  `Last_Name` VARCHAR(45) NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  `Role` VARCHAR(45) NOT NULL,
  `Shift_Start_Time` VARCHAR(45) NOT NULL,
  `Shift_End_Time` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Staff_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `nexus_entry`.`member_staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nexus_entry`.`member_staff` (
  `Member_ID` INT NOT NULL,
  `Staff_ID` INT NOT NULL,
  `Check_In_Time` DATETIME NOT NULL,
  `staff_Staff_ID` INT NOT NULL,
  `member_Member_ID` INT NOT NULL,
  PRIMARY KEY (`Member_ID`, `Staff_ID`, `staff_Staff_ID`, `member_Member_ID`),
  INDEX `fk_member_staff_staff1_idx` (`staff_Staff_ID` ASC) VISIBLE,
  INDEX `fk_member_staff_member1_idx` (`member_Member_ID` ASC) VISIBLE,
  CONSTRAINT `fk_member_staff_staff1`
    FOREIGN KEY (`staff_Staff_ID`)
    REFERENCES `nexus_entry`.`staff` (`Staff_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_member_staff_member1`
    FOREIGN KEY (`member_Member_ID`)
    REFERENCES `nexus_entry`.`member` (`Member_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `nexus_entry`.`payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nexus_entry`.`payment` (
  `Payment_ID` INT NOT NULL,
  `Member_ID` VARCHAR(45) NOT NULL,
  `Amount` DECIMAL(10,0) NOT NULL,
  `Payment_Date` DATE NOT NULL,
  `Payment_Method` VARCHAR(45) NOT NULL,
  `member_Member_ID` INT NOT NULL,
  PRIMARY KEY (`Payment_ID`, `member_Member_ID`),
  INDEX `fk_payment_member1_idx` (`member_Member_ID` ASC) VISIBLE,
  CONSTRAINT `fk_payment_member1`
    FOREIGN KEY (`member_Member_ID`)
    REFERENCES `nexus_entry`.`member` (`Member_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `nexus_entry`.`staff_attendance`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nexus_entry`.`staff_attendance` (
  `Staff_ID` INT NOT NULL,
  `Attendance_ID` INT NOT NULL,
  `Log_By_Role` VARCHAR(50) NOT NULL,
  `Log_DateTime` DATETIME NOT NULL,
  `attendance_Attendance_ID` INT NOT NULL,
  `staff_Staff_ID` INT NOT NULL,
  PRIMARY KEY (`Staff_ID`, `Attendance_ID`, `attendance_Attendance_ID`, `staff_Staff_ID`),
  INDEX `fk_staff_attendance_attendance1_idx` (`attendance_Attendance_ID` ASC) VISIBLE,
  INDEX `fk_staff_attendance_staff1_idx` (`staff_Staff_ID` ASC) VISIBLE,
  CONSTRAINT `fk_staff_attendance_attendance1`
    FOREIGN KEY (`attendance_Attendance_ID`)
    REFERENCES `nexus_entry`.`attendance` (`Attendance_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_staff_attendance_staff1`
    FOREIGN KEY (`staff_Staff_ID`)
    REFERENCES `nexus_entry`.`staff` (`Staff_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
