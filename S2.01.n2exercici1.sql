-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema youtube
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema youtube
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `youtube` DEFAULT CHARACTER SET utf8 ;
USE `youtube` ;

-- -----------------------------------------------------
-- Table `youtube`.`canal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`canal` (
  `idcanal` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` MEDIUMTEXT NOT NULL,
  `fecha_creacion` DATETIME NOT NULL,
  PRIMARY KEY (`idcanal`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`usuario` (
  `idusuario` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `nombre_usuario` VARCHAR(45) NOT NULL,
  `fecha_nacimiento` DATE NOT NULL,
  `sexo` VARCHAR(45) NOT NULL,
  `pais` VARCHAR(45) NOT NULL,
  `codigo_postal` VARCHAR(45) NOT NULL,
  `canal_idcanal` INT NULL,
  PRIMARY KEY (`idusuario`),
  INDEX `fk_usuario_canal1_idx` (`canal_idcanal` ASC) VISIBLE,
  CONSTRAINT `fk_usuario_canal1`
    FOREIGN KEY (`canal_idcanal`)
    REFERENCES `youtube`.`canal` (`idcanal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`video`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`video` (
  `idvideo` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(45) NOT NULL,
  `descripcion` MEDIUMTEXT NOT NULL,
  `tamaño` INT NOT NULL,
  `nombre_archivo` VARCHAR(45) NOT NULL,
  `duracion` VARCHAR(45) NOT NULL,
  `thumbnail` BLOB NOT NULL,
  `reproducciones` INT NULL,
  `likes` INT NULL,
  `dislikes` INT NULL,
  `usuario_idusuario` INT NOT NULL,
  `fecha_publicacion` DATETIME NOT NULL,
  PRIMARY KEY (`idvideo`),
  INDEX `fk_video_usuario_idx` (`usuario_idusuario` ASC) VISIBLE,
  CONSTRAINT `fk_video_usuario`
    FOREIGN KEY (`usuario_idusuario`)
    REFERENCES `youtube`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`estados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`estados` (
  `publico` VARCHAR(45) NULL,
  `privado` VARCHAR(45) NULL,
  `oculto` VARCHAR(45) NULL,
  `video_idvideo` INT NOT NULL,
  PRIMARY KEY (`video_idvideo`),
  CONSTRAINT `fk_estados_video1`
    FOREIGN KEY (`video_idvideo`)
    REFERENCES `youtube`.`video` (`idvideo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`etiquetas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`etiquetas` (
  `idetiquetas` INT NOT NULL AUTO_INCREMENT,
  `nombre_etiqueta` VARCHAR(45) NOT NULL,
  `video_idvideo` INT NOT NULL,
  PRIMARY KEY (`idetiquetas`, `video_idvideo`),
  INDEX `fk_etiquetas_video1_idx` (`video_idvideo` ASC) VISIBLE,
  CONSTRAINT `fk_etiquetas_video1`
    FOREIGN KEY (`video_idvideo`)
    REFERENCES `youtube`.`video` (`idvideo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`playlist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`playlist` (
  `idplaylist` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `fecha_creacion` DATETIME NOT NULL,
  `publico/privado` VARCHAR(45) NOT NULL,
  `usuario_idusuario` INT NOT NULL,
  PRIMARY KEY (`idplaylist`),
  INDEX `fk_playlist_usuario1_idx` (`usuario_idusuario` ASC) VISIBLE,
  CONSTRAINT `fk_playlist_usuario1`
    FOREIGN KEY (`usuario_idusuario`)
    REFERENCES `youtube`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`comentarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`comentarios` (
  `idcomentarios` INT NOT NULL AUTO_INCREMENT,
  `comentario` MEDIUMTEXT NOT NULL,
  `fecha` DATETIME NOT NULL,
  `usuario_idusuario` INT NOT NULL,
  `video_idvideo` INT NOT NULL,
  PRIMARY KEY (`idcomentarios`),
  INDEX `fk_comentarios_usuario1_idx` (`usuario_idusuario` ASC) VISIBLE,
  INDEX `fk_comentarios_video1_idx` (`video_idvideo` ASC) VISIBLE,
  CONSTRAINT `fk_comentarios_usuario1`
    FOREIGN KEY (`usuario_idusuario`)
    REFERENCES `youtube`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comentarios_video1`
    FOREIGN KEY (`video_idvideo`)
    REFERENCES `youtube`.`video` (`idvideo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`gusta_nogusta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`gusta_nogusta` (
  `usuario_idusuario` INT NOT NULL,
  `fecha` DATETIME NOT NULL,
  `comentarios_idcomentarios` INT NOT NULL,
  INDEX `fk_gusta/no_gusta_usuario1_idx` (`usuario_idusuario` ASC) VISIBLE,
  INDEX `fk_gusta/no_gusta_comentarios1_idx` (`comentarios_idcomentarios` ASC) VISIBLE,
  PRIMARY KEY (`usuario_idusuario`),
  CONSTRAINT `fk_gusta/no_gusta_usuario1`
    FOREIGN KEY (`usuario_idusuario`)
    REFERENCES `youtube`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_gusta/no_gusta_comentarios1`
    FOREIGN KEY (`comentarios_idcomentarios`)
    REFERENCES `youtube`.`comentarios` (`idcomentarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`suscripcion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`suscripcion` (
  `idsuscripcion` INT NOT NULL AUTO_INCREMENT,
  `usuario_idusuario` INT NOT NULL,
  `canal_idcanal` INT NOT NULL,
  PRIMARY KEY (`idsuscripcion`),
  INDEX `fk_suscripcion_usuario1_idx` (`usuario_idusuario` ASC) VISIBLE,
  INDEX `fk_suscripcion_canal1_idx` (`canal_idcanal` ASC) VISIBLE,
  CONSTRAINT `fk_suscripcion_usuario1`
    FOREIGN KEY (`usuario_idusuario`)
    REFERENCES `youtube`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_suscripcion_canal1`
    FOREIGN KEY (`canal_idcanal`)
    REFERENCES `youtube`.`canal` (`idcanal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`like_dislike`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`like_dislike` (
  `idlike_dislike` INT NOT NULL AUTO_INCREMENT,
  `usuario_idusuario` INT NOT NULL,
  `video_idvideo` INT NOT NULL,
  `fecha_hora` DATETIME NOT NULL,
  PRIMARY KEY (`idlike_dislike`),
  INDEX `fk_like_dislike_usuario1_idx` (`usuario_idusuario` ASC) VISIBLE,
  INDEX `fk_like_dislike_video1_idx` (`video_idvideo` ASC) VISIBLE,
  UNIQUE INDEX `usuario_idusuario_UNIQUE` (`usuario_idusuario` ASC) VISIBLE,
  CONSTRAINT `fk_like_dislike_usuario1`
    FOREIGN KEY (`usuario_idusuario`)
    REFERENCES `youtube`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_like_dislike_video1`
    FOREIGN KEY (`video_idvideo`)
    REFERENCES `youtube`.`video` (`idvideo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
