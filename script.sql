-- MySQL Script generated by MySQL Workbench
-- Tue Jun 25 14:23:17 2019
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema rozo
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema rozo
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `rozo` DEFAULT CHARACTER SET utf8 ;
USE `rozo` ;

-- -----------------------------------------------------
-- Table `rozo`.`productos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `rozo`.`productos` ;

CREATE TABLE IF NOT EXISTS `rozo`.`productos` (
  `idProducto` BIGINT NOT NULL AUTO_INCREMENT,
  `nombreProducto` VARCHAR(45) NULL,
  `descripcionProducto` VARCHAR(45) NULL,
  `created_at` TIMESTAMP(6) NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP(6) NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` TIMESTAMP(6) NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idProducto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rozo`.`articulos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `rozo`.`articulos` ;

CREATE TABLE IF NOT EXISTS `rozo`.`articulos` (
  `idArticulo` BIGINT NOT NULL AUTO_INCREMENT,
  `idProducto` BIGINT NOT NULL,
  `nombreArticulo` VARCHAR(45) NULL,
  `descripcionArticulo` VARCHAR(45) NULL,
  `precioArticulo` INT NULL,
  `stockArticulo` INT NULL,
  `porcentajeGanacia` INT NULL,
  `codigoBarras` VARCHAR(255) NULL,
  `created_at` TIMESTAMP(6) NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP(6) NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` TIMESTAMP(6) NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idArticulo`),
  INDEX `fk_articulo_producto1_idx` (`idProducto` ASC),
  UNIQUE INDEX `precioArticulo_UNIQUE` (`precioArticulo` ASC),
  CONSTRAINT `fk_articulo_producto1`
    FOREIGN KEY (`idProducto`)
    REFERENCES `rozo`.`productos` (`idProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rozo`.`compras`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `rozo`.`compras` ;

CREATE TABLE IF NOT EXISTS `rozo`.`compras` (
  `idCompra` BIGINT NOT NULL AUTO_INCREMENT,
  `fechaCompra` TIME NOT NULL,
  `created_at` TIMESTAMP(6) NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP(6) NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` TIMESTAMP(6) NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idCompra`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rozo`.`detalleCompra`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `rozo`.`detalleCompra` ;

CREATE TABLE IF NOT EXISTS `rozo`.`detalleCompra` (
  `idDetalleCompra` BIGINT NOT NULL AUTO_INCREMENT,
  `idCompra` BIGINT NOT NULL,
  `idArticulo` BIGINT NOT NULL,
  `created_at` TIMESTAMP(6) NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP(6) NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` TIMESTAMP(6) NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idDetalleCompra`),
  INDEX `fk_detalleCompra_compra1_idx` (`idCompra` ASC),
  INDEX `fk_detalleCompra_articulo1_idx` (`idArticulo` ASC),
  CONSTRAINT `fk_detalleCompra_compra1`
    FOREIGN KEY (`idCompra`)
    REFERENCES `rozo`.`compras` (`idCompra`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalleCompra_articulo1`
    FOREIGN KEY (`idArticulo`)
    REFERENCES `rozo`.`articulos` (`idArticulo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rozo`.`ventas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `rozo`.`ventas` ;

CREATE TABLE IF NOT EXISTS `rozo`.`ventas` (
  `idVentas` BIGINT NOT NULL AUTO_INCREMENT,
  `fechaVenta` VARCHAR(45) NOT NULL,
  `valorTotalVenta` INT NOT NULL,
  `estadoVenta` VARCHAR(45) NOT NULL,
  `created_at` TIMESTAMP(6) NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP(6) NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` TIMESTAMP(6) NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idVentas`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rozo`.`detalleVenta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `rozo`.`detalleVenta` ;

CREATE TABLE IF NOT EXISTS `rozo`.`detalleVenta` (
  `idDetalleVenta` BIGINT NOT NULL AUTO_INCREMENT,
  `idVentas` BIGINT NOT NULL,
  `idArticulo` BIGINT NOT NULL,
  `valorUnitario` INT NULL,
  `cantidad` INT NULL,
  `valorTotal` INT NULL,
  `created_at` TIMESTAMP(6) NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` TIMESTAMP(6) NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP(6) NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idDetalleVenta`),
  INDEX `fk_detalleVenta_ventas1_idx` (`idVentas` ASC),
  INDEX `fk_detalleVenta_articulos1_idx` (`idArticulo` ASC),
  CONSTRAINT `fk_detalleVenta_ventas1`
    FOREIGN KEY (`idVentas`)
    REFERENCES `rozo`.`ventas` (`idVentas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalleVenta_articulos1`
    FOREIGN KEY (`idArticulo`)
    REFERENCES `rozo`.`articulos` (`idArticulo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rozo`.`roles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `rozo`.`roles` ;

CREATE TABLE IF NOT EXISTS `rozo`.`roles` (
  `idRol` BIGINT NOT NULL AUTO_INCREMENT,
  `nombreRol` VARCHAR(45) NOT NULL,
  `descripcionRol` VARCHAR(45) NULL,
  PRIMARY KEY (`idRol`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rozo`.`usuarioSistema`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `rozo`.`usuarioSistema` ;

CREATE TABLE IF NOT EXISTS `rozo`.`usuarioSistema` (
  `idUsuarioSistema` BIGINT NOT NULL AUTO_INCREMENT,
  `idRol` BIGINT NOT NULL,
  `nombreUsuario` VARCHAR(45) NOT NULL,
  `contraseña` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idUsuarioSistema`),
  INDEX `fk_usuarioSistema_roles1_idx` (`idRol` ASC),
  CONSTRAINT `fk_usuarioSistema_roles1`
    FOREIGN KEY (`idRol`)
    REFERENCES `rozo`.`roles` (`idRol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;