-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema optica
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema optica
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `optica` DEFAULT CHARACTER SET utf8 ;
USE `optica` ;

-- -----------------------------------------------------
-- Table `optica`.`proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`proveedor` (
  `nombre` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(150) NOT NULL,
  `telefono` VARCHAR(15) NOT NULL,
  `fax` VARCHAR(15) NOT NULL,
  `nif` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`nif`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`cliente` (
  `idcliente` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(150) NOT NULL,
  `telefono` VARCHAR(15) NOT NULL,
  `email` VARCHAR(80) NOT NULL,
  `fecha registro` DATETIME NOT NULL,
  `recomendado` VARCHAR(45) NULL,
  PRIMARY KEY (`idcliente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`empleado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`empleado` (
  `idempleado` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idempleado`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`venta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`venta` (
  `idventa` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATE NOT NULL,
  `cliente_idcliente` INT NOT NULL,
  `empleado_idempleado` INT NOT NULL,
  PRIMARY KEY (`idventa`),
  INDEX `fk_venta_cliente1_idx` (`cliente_idcliente` ASC) VISIBLE,
  INDEX `fk_venta_empleado1_idx` (`empleado_idempleado` ASC) VISIBLE,
  CONSTRAINT `fk_venta_cliente1`
    FOREIGN KEY (`cliente_idcliente`)
    REFERENCES `optica`.`cliente` (`idcliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_venta_empleado1`
    FOREIGN KEY (`empleado_idempleado`)
    REFERENCES `optica`.`empleado` (`idempleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`gafas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`gafas` (
  `idgafas` INT NOT NULL AUTO_INCREMENT,
  `marca` VARCHAR(45) NOT NULL,
  `graduacion _RH` FLOAT NOT NULL,
  `graduacion_LH` FLOAT NOT NULL,
  `montura` VARCHAR(10) NOT NULL,
  `color_montura` VARCHAR(20) NOT NULL,
  `color_cristales` VARCHAR(20) NOT NULL,
  `precio` FLOAT NOT NULL,
  `venta_idventa` INT NULL,
  `proveedor_nif` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`idgafas`),
  INDEX `fk_gafas_venta1_idx` (`venta_idventa` ASC) VISIBLE,
  INDEX `fk_gafas_proveedor1_idx` (`proveedor_nif` ASC) VISIBLE,
  CONSTRAINT `fk_gafas_venta1`
    FOREIGN KEY (`venta_idventa`)
    REFERENCES `optica`.`venta` (`idventa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_gafas_proveedor1`
    FOREIGN KEY (`proveedor_nif`)
    REFERENCES `optica`.`proveedor` (`nif`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
