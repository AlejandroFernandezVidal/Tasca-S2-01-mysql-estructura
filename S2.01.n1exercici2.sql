-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema pizzeria
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema pizzeria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pizzeria` DEFAULT CHARACTER SET utf8 ;
USE `pizzeria` ;

-- -----------------------------------------------------
-- Table `pizzeria`.`provincia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`provincia` (
  `idprovincia` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idprovincia`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`localidad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`localidad` (
  `idlocalidad` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `provincia_idprovincia` INT NOT NULL,
  PRIMARY KEY (`idlocalidad`),
  INDEX `fk_localidad_provincia_idx` (`provincia_idprovincia` ASC) VISIBLE,
  CONSTRAINT `fk_localidad_provincia`
    FOREIGN KEY (`provincia_idprovincia`)
    REFERENCES `pizzeria`.`provincia` (`idprovincia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`cliente` (
  `idcliente` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(150) NOT NULL,
  `codigo postal` INT NOT NULL,
  `telefono` VARCHAR(15) NOT NULL,
  `localidad_idlocalidad` INT NOT NULL,
  `provincia_idprovincia` INT NOT NULL,
  PRIMARY KEY (`idcliente`),
  INDEX `fk_cliente_localidad1_idx` (`localidad_idlocalidad` ASC) VISIBLE,
  INDEX `fk_cliente_provincia1_idx` (`provincia_idprovincia` ASC) VISIBLE,
  CONSTRAINT `fk_cliente_localidad1`
    FOREIGN KEY (`localidad_idlocalidad`)
    REFERENCES `pizzeria`.`localidad` (`idlocalidad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cliente_provincia1`
    FOREIGN KEY (`provincia_idprovincia`)
    REFERENCES `pizzeria`.`provincia` (`idprovincia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`tienda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`tienda` (
  `idtienda` INT NOT NULL AUTO_INCREMENT,
  `direccion` VARCHAR(45) NOT NULL,
  `codigo postal` INT NOT NULL,
  `localidad_idlocalidad` INT NOT NULL,
  `provincia_idprovincia` INT NOT NULL,
  PRIMARY KEY (`idtienda`),
  INDEX `fk_tienda_localidad1_idx` (`localidad_idlocalidad` ASC) VISIBLE,
  INDEX `fk_tienda_provincia1_idx` (`provincia_idprovincia` ASC) VISIBLE,
  CONSTRAINT `fk_tienda_localidad1`
    FOREIGN KEY (`localidad_idlocalidad`)
    REFERENCES `pizzeria`.`localidad` (`idlocalidad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tienda_provincia1`
    FOREIGN KEY (`provincia_idprovincia`)
    REFERENCES `pizzeria`.`provincia` (`idprovincia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`empleados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`empleados` (
  `idempleados` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `nif` VARCHAR(9) NOT NULL,
  `telefono` VARCHAR(15) NOT NULL,
  `cocinero/repartidor` VARCHAR(10) NOT NULL,
  `tienda_idtienda` INT NOT NULL,
  PRIMARY KEY (`idempleados`),
  INDEX `fk_empleados_tienda1_idx` (`tienda_idtienda` ASC) VISIBLE,
  CONSTRAINT `fk_empleados_tienda1`
    FOREIGN KEY (`tienda_idtienda`)
    REFERENCES `pizzeria`.`tienda` (`idtienda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`pedido` (
  `idpedido` INT NOT NULL AUTO_INCREMENT,
  `fecha/hora` DATETIME NOT NULL,
  `domicilio/local` VARCHAR(45) NOT NULL,
  `cantidad_pizza` INT NULL,
  `cantidad_hamburguesas` INT NULL,
  `cantidad_bebida` INT NULL,
  `domicilio fecha/hora` DATETIME NULL,
  `cliente_idcliente` INT NOT NULL,
  `tienda_idtienda` INT NOT NULL,
  `empleados_idempleados` INT NULL,
  PRIMARY KEY (`idpedido`),
  INDEX `fk_pedido_cliente1_idx` (`cliente_idcliente` ASC) VISIBLE,
  INDEX `fk_pedido_tienda1_idx` (`tienda_idtienda` ASC) VISIBLE,
  INDEX `fk_pedido_empleados1_idx` (`empleados_idempleados` ASC) VISIBLE,
  CONSTRAINT `fk_pedido_cliente1`
    FOREIGN KEY (`cliente_idcliente`)
    REFERENCES `pizzeria`.`cliente` (`idcliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedido_tienda1`
    FOREIGN KEY (`tienda_idtienda`)
    REFERENCES `pizzeria`.`tienda` (`idtienda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedido_empleados1`
    FOREIGN KEY (`empleados_idempleados`)
    REFERENCES `pizzeria`.`empleados` (`idempleados`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`productos` (
  `idproductos` INT NOT NULL AUTO_INCREMENT,
  `pedido_idpedido` INT NOT NULL,
  PRIMARY KEY (`idproductos`, `pedido_idpedido`),
  INDEX `fk_productos_pedido1_idx` (`pedido_idpedido` ASC) VISIBLE,
  CONSTRAINT `fk_productos_pedido1`
    FOREIGN KEY (`pedido_idpedido`)
    REFERENCES `pizzeria`.`pedido` (`idpedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`categoria` (
  `idcategoria` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idcategoria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`categoria1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`categoria1` (
  `idcategoria1` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idcategoria1`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`categoria2`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`categoria2` (
  `idcategoria2` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idcategoria2`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`pizzas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`pizzas` (
  `idpizzas` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(150) NOT NULL,
  `imagen` BLOB NOT NULL,
  `precio` FLOAT NOT NULL,
  `productos_idproductos` INT NULL,
  `categoria_idcategoria` INT NULL,
  `categoria1_idcategoria1` INT NULL,
  `categoria2_idcategoria2` INT NULL,
  PRIMARY KEY (`idpizzas`),
  INDEX `fk_pizzas_productos1_idx` (`productos_idproductos` ASC) VISIBLE,
  INDEX `fk_pizzas_categoria1_idx` (`categoria_idcategoria` ASC) VISIBLE,
  INDEX `fk_pizzas_categoria11_idx` (`categoria1_idcategoria1` ASC) VISIBLE,
  INDEX `fk_pizzas_categoria21_idx` (`categoria2_idcategoria2` ASC) VISIBLE,
  CONSTRAINT `fk_pizzas_productos1`
    FOREIGN KEY (`productos_idproductos`)
    REFERENCES `pizzeria`.`productos` (`idproductos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pizzas_categoria1`
    FOREIGN KEY (`categoria_idcategoria`)
    REFERENCES `pizzeria`.`categoria` (`idcategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pizzas_categoria11`
    FOREIGN KEY (`categoria1_idcategoria1`)
    REFERENCES `pizzeria`.`categoria1` (`idcategoria1`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pizzas_categoria21`
    FOREIGN KEY (`categoria2_idcategoria2`)
    REFERENCES `pizzeria`.`categoria2` (`idcategoria2`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`hamburguesas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`hamburguesas` (
  `idhamburguesas` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(150) NOT NULL,
  `imagen` BLOB NOT NULL,
  `precio` FLOAT NOT NULL,
  `productos_idproductos` INT NULL,
  PRIMARY KEY (`idhamburguesas`),
  INDEX `fk_hamburguesas_productos1_idx` (`productos_idproductos` ASC) VISIBLE,
  CONSTRAINT `fk_hamburguesas_productos1`
    FOREIGN KEY (`productos_idproductos`)
    REFERENCES `pizzeria`.`productos` (`idproductos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`bebidas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`bebidas` (
  `idbebidas` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(150) NOT NULL,
  `imagen` BLOB NOT NULL,
  `precio` FLOAT NOT NULL,
  `productos_idproductos` INT NULL,
  PRIMARY KEY (`idbebidas`),
  INDEX `fk_bebidas_productos1_idx` (`productos_idproductos` ASC) VISIBLE,
  CONSTRAINT `fk_bebidas_productos1`
    FOREIGN KEY (`productos_idproductos`)
    REFERENCES `pizzeria`.`productos` (`idproductos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
