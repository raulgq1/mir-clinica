-- MySQL Script generated by MySQL Workbench
-- 07/20/14 17:43:35
-- Model: New Model    Version: 1.0
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema clinica
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `clinica` ;
CREATE SCHEMA IF NOT EXISTS `clinica` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `clinica` ;

-- -----------------------------------------------------
-- Table `clinica`.`PERSONA`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `clinica`.`PERSONA` ;

CREATE TABLE IF NOT EXISTS `clinica`.`PERSONA` (
  `ID_PERSONA` INT(11) NOT NULL AUTO_INCREMENT,
  `NOMBRE` VARCHAR(55) NOT NULL,
  `APELLIDO` VARCHAR(55) NOT NULL,
  `CORREO_ELECTRONICO` VARCHAR(55) NULL,
  `TELEFONO` INT(11) NULL,
  `ESTADO` INT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID_PERSONA`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clinica`.`PACIENTE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `clinica`.`PACIENTE` ;

CREATE TABLE IF NOT EXISTS `clinica`.`PACIENTE` (
  `ID_PACIENTE` INT(11) NOT NULL,
  `FECHA_NACIMIENTO` DATE NOT NULL,
  `SEXO` VARCHAR(45) NOT NULL,
  `DIRECCION` VARCHAR(105) NOT NULL,
  `NOMBRE_PADRE` VARCHAR(45) NULL,
  `RELIGION_PERTENECE` VARCHAR(45) NULL,
  `OCUPACION` VARCHAR(45) NULL,
  PRIMARY KEY (`ID_PACIENTE`),
  INDEX `fk_PACIENTE_PERSONA1_idx` (`ID_PACIENTE` ASC),
  CONSTRAINT `fk_PACIENTE_PERSONA1`
    FOREIGN KEY (`ID_PACIENTE`)
    REFERENCES `clinica`.`PERSONA` (`ID_PERSONA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clinica`.`ESPECIALIDAD`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `clinica`.`ESPECIALIDAD` ;

CREATE TABLE IF NOT EXISTS `clinica`.`ESPECIALIDAD` (
  `ID_ESPECIALIDAD` INT NOT NULL AUTO_INCREMENT,
  `NOMBRE` VARCHAR(45) NOT NULL,
  `NJM` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID_ESPECIALIDAD`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clinica`.`ESTADO_CITA`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `clinica`.`ESTADO_CITA` ;

CREATE TABLE IF NOT EXISTS `clinica`.`ESTADO_CITA` (
  `ID_ESTADO_CITA` INT NOT NULL AUTO_INCREMENT,
  `ESTADO` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`ID_ESTADO_CITA`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clinica`.`CITA`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `clinica`.`CITA` ;

CREATE TABLE IF NOT EXISTS `clinica`.`CITA` (
  `ID_CITA` INT(11) NOT NULL AUTO_INCREMENT,
  `ID_PACIENTE` INT(11) NOT NULL,
  `ID_ESPECIALIDAD` INT(11) NOT NULL,
  `ID_ESTADO_CITA` INT(11) NOT NULL,
  `FECHA_INICIO` DATETIME NOT NULL,
  `FECHA_FIN` DATETIME NOT NULL,
  `MOTIVO` VARCHAR(55) NULL,
  PRIMARY KEY (`ID_CITA`, `ID_PACIENTE`, `ID_ESPECIALIDAD`, `ID_ESTADO_CITA`),
  INDEX `fk_CITA_PACIENTE1_idx` (`ID_PACIENTE` ASC),
  INDEX `fk_CITA_ESPECIALIDAD1_idx` (`ID_ESPECIALIDAD` ASC),
  INDEX `fk_CITA_TIPO_CONSULTA1_idx` (`ID_ESTADO_CITA` ASC),
  CONSTRAINT `fk_CITA_PACIENTE1`
    FOREIGN KEY (`ID_PACIENTE`)
    REFERENCES `clinica`.`PACIENTE` (`ID_PACIENTE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CITA_ESPECIALIDAD1`
    FOREIGN KEY (`ID_ESPECIALIDAD`)
    REFERENCES `clinica`.`ESPECIALIDAD` (`ID_ESPECIALIDAD`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CITA_TIPO_CONSULTA1`
    FOREIGN KEY (`ID_ESTADO_CITA`)
    REFERENCES `clinica`.`ESTADO_CITA` (`ID_ESTADO_CITA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clinica`.`EXPEDIENTE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `clinica`.`EXPEDIENTE` ;

CREATE TABLE IF NOT EXISTS `clinica`.`EXPEDIENTE` (
  `ID_EXPEDIENTE` INT NOT NULL AUTO_INCREMENT,
  `ID_PACIENTE` INT(11) NOT NULL,
  `CODIGO` VARCHAR(45) NULL,
  `FECHA_CREACION` DATETIME NOT NULL,
  `EXONERADO` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID_EXPEDIENTE`, `ID_PACIENTE`),
  INDEX `fk_EXPEDIENTE_PACIENTE1_idx` (`ID_PACIENTE` ASC),
  CONSTRAINT `fk_EXPEDIENTE_PACIENTE1`
    FOREIGN KEY (`ID_PACIENTE`)
    REFERENCES `clinica`.`PACIENTE` (`ID_PACIENTE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clinica`.`EMPLEADO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `clinica`.`EMPLEADO` ;

CREATE TABLE IF NOT EXISTS `clinica`.`EMPLEADO` (
  `ID_EMPLEADO` INT(11) NOT NULL,
  `ID_ESPECIALIDAD` INT NULL,
  `TITULO` VARCHAR(45) NULL,
  PRIMARY KEY (`ID_EMPLEADO`),
  INDEX `fk_EMPLEADO_PERSONA1_idx` (`ID_EMPLEADO` ASC),
  INDEX `fk_EMPLEADO_ESPECIALIDAD1_idx` (`ID_ESPECIALIDAD` ASC),
  CONSTRAINT `fk_EMPLEADO_PERSONA1`
    FOREIGN KEY (`ID_EMPLEADO`)
    REFERENCES `clinica`.`PERSONA` (`ID_PERSONA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_EMPLEADO_ESPECIALIDAD1`
    FOREIGN KEY (`ID_ESPECIALIDAD`)
    REFERENCES `clinica`.`ESPECIALIDAD` (`ID_ESPECIALIDAD`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clinica`.`CONSULTA`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `clinica`.`CONSULTA` ;

CREATE TABLE IF NOT EXISTS `clinica`.`CONSULTA` (
  `ID_CONSULTA` INT(11) NOT NULL AUTO_INCREMENT,
  `ID_EMPLEADO` INT(11) NOT NULL,
  `ID_EXPEDIENTE` INT NOT NULL,
  `OBSERVACIONES` TEXT NOT NULL,
  `DIAGNOSTICO` TEXT NOT NULL,
  `FECHA_INICIO` DATETIME NOT NULL,
  `FECHA_FIN` DATETIME NOT NULL,
  `TEMPERATURA` DECIMAL(10,2) NULL,
  `PESO` DECIMAL(10,2) NULL,
  `PULSO` VARCHAR(45) NULL,
  `TALLA` VARCHAR(45) NULL,
  `TA` VARCHAR(45) NULL,
  `ESTADO` INT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID_CONSULTA`, `ID_EMPLEADO`, `ID_EXPEDIENTE`),
  INDEX `fk_CONSULTAS_EXPEDIENTES1_idx` (`ID_EXPEDIENTE` ASC),
  INDEX `fk_CONSULTA_EMPLEADO1_idx` (`ID_EMPLEADO` ASC),
  CONSTRAINT `fk_CONSULTAS_EXPEDIENTES1`
    FOREIGN KEY (`ID_EXPEDIENTE`)
    REFERENCES `clinica`.`EXPEDIENTE` (`ID_EXPEDIENTE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CONSULTA_EMPLEADO1`
    FOREIGN KEY (`ID_EMPLEADO`)
    REFERENCES `clinica`.`EMPLEADO` (`ID_EMPLEADO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clinica`.`RECETA`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `clinica`.`RECETA` ;

CREATE TABLE IF NOT EXISTS `clinica`.`RECETA` (
  `ID_RECETA` INT(11) NOT NULL AUTO_INCREMENT,
  `ID_CONSULTA` INT(11) NOT NULL,
  PRIMARY KEY (`ID_RECETA`, `ID_CONSULTA`),
  INDEX `fk_RECETAS_CONSULTAS1_idx` (`ID_CONSULTA` ASC),
  CONSTRAINT `fk_RECETAS_CONSULTAS1`
    FOREIGN KEY (`ID_CONSULTA`)
    REFERENCES `clinica`.`CONSULTA` (`ID_CONSULTA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clinica`.`MEDICAMENTO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `clinica`.`MEDICAMENTO` ;

CREATE TABLE IF NOT EXISTS `clinica`.`MEDICAMENTO` (
  `ID_MEDICAMENTO` INT(11) NOT NULL AUTO_INCREMENT,
  `NOMBRE` VARCHAR(45) NOT NULL,
  `CASA_FARMACEUTICA` VARCHAR(45) NOT NULL,
  `CODIGO` VARCHAR(55) NOT NULL,
  `DESCRIPCION` VARCHAR(45) NULL,
  `PRESENTACION` VARCHAR(45) NULL,
  `CANTIDAD_ACTUAL` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`ID_MEDICAMENTO`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clinica`.`DETALLE_RECETA`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `clinica`.`DETALLE_RECETA` ;

CREATE TABLE IF NOT EXISTS `clinica`.`DETALLE_RECETA` (
  `ID_DETALLE_RECETA` INT(11) NOT NULL AUTO_INCREMENT,
  `ID_RECETA` INT(11) NOT NULL,
  `ID_MEDICAMENTO` INT(11) NOT NULL,
  `CANTIDAD` DECIMAL(10,2) NOT NULL,
  `DOSIS` VARCHAR(55) NOT NULL,
  PRIMARY KEY (`ID_DETALLE_RECETA`, `ID_RECETA`, `ID_MEDICAMENTO`),
  INDEX `fk_DETALLE_RECETAS_RECETAS1_idx` (`ID_RECETA` ASC),
  INDEX `fk_DETALLE_RECETAS_MEDICAMENTOS1_idx` (`ID_MEDICAMENTO` ASC),
  CONSTRAINT `fk_DETALLE_RECETAS_RECETAS1`
    FOREIGN KEY (`ID_RECETA`)
    REFERENCES `clinica`.`RECETA` (`ID_RECETA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_DETALLE_RECETAS_MEDICAMENTOS1`
    FOREIGN KEY (`ID_MEDICAMENTO`)
    REFERENCES `clinica`.`MEDICAMENTO` (`ID_MEDICAMENTO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clinica`.`INVENTARIO_MEDICAMENTO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `clinica`.`INVENTARIO_MEDICAMENTO` ;

CREATE TABLE IF NOT EXISTS `clinica`.`INVENTARIO_MEDICAMENTO` (
  `ID_INVENTARIO` INT(11) NOT NULL AUTO_INCREMENT,
  `FECHA_ENTREGA` DATETIME NOT NULL,
  `DONADO_POR` VARCHAR(55) NOT NULL,
  PRIMARY KEY (`ID_INVENTARIO`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clinica`.`ANALISIS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `clinica`.`ANALISIS` ;

CREATE TABLE IF NOT EXISTS `clinica`.`ANALISIS` (
  `ID_ANALISIS` INT(11) NOT NULL AUTO_INCREMENT,
  `ID_CONSULTA` INT(11) NOT NULL,
  `FECHA_A_REALIZAR` DATETIME NULL,
  PRIMARY KEY (`ID_ANALISIS`, `ID_CONSULTA`),
  INDEX `fk_ANALISIS_CONSULTAS1_idx` (`ID_CONSULTA` ASC),
  CONSTRAINT `fk_ANALISIS_CONSULTAS1`
    FOREIGN KEY (`ID_CONSULTA`)
    REFERENCES `clinica`.`CONSULTA` (`ID_CONSULTA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clinica`.`EXAMEN`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `clinica`.`EXAMEN` ;

CREATE TABLE IF NOT EXISTS `clinica`.`EXAMEN` (
  `ID_EXAMEN` INT(11) NOT NULL AUTO_INCREMENT,
  `NOMBRE` VARCHAR(45) NOT NULL,
  `DESCRIPCION` VARCHAR(45) NULL,
  `VALOR_NORMAL` VARCHAR(45) NULL,
  `VALOR_MENOR` VARCHAR(45) NULL,
  `VALOR_SUPERIOR` VARCHAR(45) NULL,
  PRIMARY KEY (`ID_EXAMEN`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clinica`.`DETALLE_ANALISIS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `clinica`.`DETALLE_ANALISIS` ;

CREATE TABLE IF NOT EXISTS `clinica`.`DETALLE_ANALISIS` (
  `ID_DETALLE_ANALISIS` INT(11) NOT NULL AUTO_INCREMENT,
  `ID_ANALISIS` INT(11) NOT NULL,
  `ID_EXAMEN` INT(11) NOT NULL,
  `DESCRIPCION` VARCHAR(55) NULL,
  PRIMARY KEY (`ID_DETALLE_ANALISIS`, `ID_ANALISIS`, `ID_EXAMEN`),
  INDEX `fk_DETALLE_ANALISIS_ANALISIS1_idx` (`ID_ANALISIS` ASC),
  INDEX `fk_DETALLE_ANALISIS_EXAMENES1_idx` (`ID_EXAMEN` ASC),
  CONSTRAINT `fk_DETALLE_ANALISIS_ANALISIS1`
    FOREIGN KEY (`ID_ANALISIS`)
    REFERENCES `clinica`.`ANALISIS` (`ID_ANALISIS`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_DETALLE_ANALISIS_EXAMENES1`
    FOREIGN KEY (`ID_EXAMEN`)
    REFERENCES `clinica`.`EXAMEN` (`ID_EXAMEN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clinica`.`RESULTADO_ANALISIS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `clinica`.`RESULTADO_ANALISIS` ;

CREATE TABLE IF NOT EXISTS `clinica`.`RESULTADO_ANALISIS` (
  `ID_RESULTADO_ANALISIS` INT(11) NOT NULL,
  `ID_EMPLEADO` INT(11) NOT NULL,
  `ID_DETALLE_ANALISIS` INT(11) NOT NULL,
  `FECHA_CREACION` DATETIME NOT NULL,
  `RESULTADO` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID_RESULTADO_ANALISIS`, `ID_EMPLEADO`, `ID_DETALLE_ANALISIS`),
  INDEX `fk_RESULTADO_ANALISIS_DETALLE_ANALISIS1_idx` (`ID_DETALLE_ANALISIS` ASC),
  INDEX `fk_RESULTADO_ANALISIS_EMPLEADO1_idx` (`ID_EMPLEADO` ASC),
  CONSTRAINT `fk_RESULTADO_ANALISIS_DETALLE_ANALISIS1`
    FOREIGN KEY (`ID_DETALLE_ANALISIS`)
    REFERENCES `clinica`.`DETALLE_ANALISIS` (`ID_DETALLE_ANALISIS`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RESULTADO_ANALISIS_EMPLEADO1`
    FOREIGN KEY (`ID_EMPLEADO`)
    REFERENCES `clinica`.`EMPLEADO` (`ID_EMPLEADO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clinica`.`DETALLE_RESULTADO_ANALISIS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `clinica`.`DETALLE_RESULTADO_ANALISIS` ;

CREATE TABLE IF NOT EXISTS `clinica`.`DETALLE_RESULTADO_ANALISIS` (
  `ID_DETALLE_RESULTADO_ANALISIS` INT(11) NOT NULL,
  `ID_DETALLE_ANALISIS` INT(11) NOT NULL,
  `RESULTADO` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID_DETALLE_RESULTADO_ANALISIS`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clinica`.`PAGO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `clinica`.`PAGO` ;

CREATE TABLE IF NOT EXISTS `clinica`.`PAGO` (
  `ID_PAGO` INT(11) NOT NULL AUTO_INCREMENT,
  `ID_CONSULTA` INT(11) NOT NULL,
  `ID_EMPLEADO` INT(11) NOT NULL,
  `PRECIO` DECIMAL(10,2) NOT NULL,
  `EXONERADO` INT(1) NOT NULL DEFAULT 0,
  `MOTIVO_EXONERADO` VARCHAR(55) NULL,
  PRIMARY KEY (`ID_PAGO`, `ID_CONSULTA`, `ID_EMPLEADO`),
  INDEX `fk_PAGOS_CONSULTAS1_idx` (`ID_CONSULTA` ASC),
  INDEX `fk_PAGO_EMPLEADO1_idx` (`ID_EMPLEADO` ASC),
  CONSTRAINT `fk_PAGOS_CONSULTAS1`
    FOREIGN KEY (`ID_CONSULTA`)
    REFERENCES `clinica`.`CONSULTA` (`ID_CONSULTA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PAGO_EMPLEADO1`
    FOREIGN KEY (`ID_EMPLEADO`)
    REFERENCES `clinica`.`EMPLEADO` (`ID_EMPLEADO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clinica`.`DETALLE_INVENTARIO_MEDICAMENTO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `clinica`.`DETALLE_INVENTARIO_MEDICAMENTO` ;

CREATE TABLE IF NOT EXISTS `clinica`.`DETALLE_INVENTARIO_MEDICAMENTO` (
  `ID_DETALLE_INVENTARIO` INT NOT NULL AUTO_INCREMENT,
  `ID_MEDICAMENTO` INT(11) NOT NULL,
  `ID_INVENTARIO` INT(11) NOT NULL,
  `CANTIDAD_UNIDAD` DECIMAL(10,2) NOT NULL,
  `FECHA_VENCIMIENTO` DATETIME NOT NULL,
  PRIMARY KEY (`ID_DETALLE_INVENTARIO`, `ID_MEDICAMENTO`, `ID_INVENTARIO`),
  INDEX `fk_DETALLE_INVENTARIO_MEDICAMENTO_MEDICAMENTOS1_idx` (`ID_MEDICAMENTO` ASC),
  INDEX `fk_DETALLE_INVENTARIO_MEDICAMENTO_INVENTARIO_MEDICAMENTOS1_idx` (`ID_INVENTARIO` ASC),
  CONSTRAINT `fk_DETALLE_INVENTARIO_MEDICAMENTO_MEDICAMENTOS1`
    FOREIGN KEY (`ID_MEDICAMENTO`)
    REFERENCES `clinica`.`MEDICAMENTO` (`ID_MEDICAMENTO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_DETALLE_INVENTARIO_MEDICAMENTO_INVENTARIO_MEDICAMENTOS1`
    FOREIGN KEY (`ID_INVENTARIO`)
    REFERENCES `clinica`.`INVENTARIO_MEDICAMENTO` (`ID_INVENTARIO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clinica`.`ROL`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `clinica`.`ROL` ;

CREATE TABLE IF NOT EXISTS `clinica`.`ROL` (
  `ID_ROL` INT(11) NOT NULL AUTO_INCREMENT,
  `NOMBRE` VARCHAR(45) NOT NULL,
  `DESCRIPCION` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID_ROL`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clinica`.`DETALLE_ROL`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `clinica`.`DETALLE_ROL` ;

CREATE TABLE IF NOT EXISTS `clinica`.`DETALLE_ROL` (
  `ID_DETALLE_ROL` INT(11) NOT NULL AUTO_INCREMENT,
  `ID_EMPLEADO` INT(11) NOT NULL,
  `ID_ROL` INT(11) NOT NULL,
  PRIMARY KEY (`ID_DETALLE_ROL`, `ID_EMPLEADO`, `ID_ROL`),
  INDEX `fk_DETALLE_ROL_EMPLEADO1_idx` (`ID_EMPLEADO` ASC),
  INDEX `fk_DETALLE_ROL_ROL1_idx` (`ID_ROL` ASC),
  CONSTRAINT `fk_DETALLE_ROL_EMPLEADO1`
    FOREIGN KEY (`ID_EMPLEADO`)
    REFERENCES `clinica`.`EMPLEADO` (`ID_EMPLEADO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_DETALLE_ROL_ROL1`
    FOREIGN KEY (`ID_ROL`)
    REFERENCES `clinica`.`ROL` (`ID_ROL`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clinica`.`DOCUMENTO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `clinica`.`DOCUMENTO` ;

CREATE TABLE IF NOT EXISTS `clinica`.`DOCUMENTO` (
  `ID_DOCUMENTO` INT NOT NULL AUTO_INCREMENT,
  `ID_PERSONA` INT(11) NOT NULL,
  `DOCUMENTO` VARCHAR(55) NOT NULL,
  `NUMERO` VARCHAR(55) NOT NULL,
  PRIMARY KEY (`ID_DOCUMENTO`, `ID_PERSONA`),
  INDEX `fk_DOCUMENTO_PERSONA1_idx` (`ID_PERSONA` ASC),
  CONSTRAINT `fk_DOCUMENTO_PERSONA1`
    FOREIGN KEY (`ID_PERSONA`)
    REFERENCES `clinica`.`PERSONA` (`ID_PERSONA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clinica`.`USUARIO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `clinica`.`USUARIO` ;

CREATE TABLE IF NOT EXISTS `clinica`.`USUARIO` (
  `ID_PERSONA` INT(11) NOT NULL,
  `USUARIO` VARCHAR(45) NOT NULL,
  `PASSWORD` TEXT NOT NULL,
  `ESTADO` INT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`ID_PERSONA`),
  INDEX `fk_USUARIO_PERSONA1_idx` (`ID_PERSONA` ASC),
  CONSTRAINT `fk_USUARIO_PERSONA1`
    FOREIGN KEY (`ID_PERSONA`)
    REFERENCES `clinica`.`PERSONA` (`ID_PERSONA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clinica`.`PRE_CONSULTA`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `clinica`.`PRE_CONSULTA` ;

CREATE TABLE IF NOT EXISTS `clinica`.`PRE_CONSULTA` (
  `ID_PRE_CONSULTA` INT NOT NULL AUTO_INCREMENT,
  `ID_EMPLEADO` INT(11) NOT NULL,
  `ID_CITA` INT(11) NOT NULL,
  PRIMARY KEY (`ID_PRE_CONSULTA`, `ID_EMPLEADO`, `ID_CITA`),
  INDEX `fk_PRE_CONSULTA_EMPLEADO1_idx` (`ID_EMPLEADO` ASC),
  INDEX `fk_PRE_CONSULTA_CITA1_idx` (`ID_CITA` ASC),
  CONSTRAINT `fk_PRE_CONSULTA_EMPLEADO1`
    FOREIGN KEY (`ID_EMPLEADO`)
    REFERENCES `clinica`.`EMPLEADO` (`ID_EMPLEADO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PRE_CONSULTA_CITA1`
    FOREIGN KEY (`ID_CITA`)
    REFERENCES `clinica`.`CITA` (`ID_CITA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Data for table `clinica`.`PERSONA`
-- -----------------------------------------------------
START TRANSACTION;
USE `clinica`;
INSERT INTO `clinica`.`PERSONA` (`ID_PERSONA`, `NOMBRE`, `APELLIDO`, `CORREO_ELECTRONICO`, `TELEFONO`, `ESTADO`) VALUES (1, 'Medico 1', 'Medico 1', NULL, NULL, 1);
INSERT INTO `clinica`.`PERSONA` (`ID_PERSONA`, `NOMBRE`, `APELLIDO`, `CORREO_ELECTRONICO`, `TELEFONO`, `ESTADO`) VALUES (2, 'Medico 2', 'Medico 2', NULL, NULL, 1);
INSERT INTO `clinica`.`PERSONA` (`ID_PERSONA`, `NOMBRE`, `APELLIDO`, `CORREO_ELECTRONICO`, `TELEFONO`, `ESTADO`) VALUES (3, 'Secretaria 1', 'Secreataria 1', NULL, NULL, 1);
INSERT INTO `clinica`.`PERSONA` (`ID_PERSONA`, `NOMBRE`, `APELLIDO`, `CORREO_ELECTRONICO`, `TELEFONO`, `ESTADO`) VALUES (4, 'Paciente 1', 'Paciente 1', 'paciente1@gmail.com', NULL, 1);
INSERT INTO `clinica`.`PERSONA` (`ID_PERSONA`, `NOMBRE`, `APELLIDO`, `CORREO_ELECTRONICO`, `TELEFONO`, `ESTADO`) VALUES (5, 'Paciente 2', 'Paciente 2', 'paciente2@gmail.com', NULL, 1);
INSERT INTO `clinica`.`PERSONA` (`ID_PERSONA`, `NOMBRE`, `APELLIDO`, `CORREO_ELECTRONICO`, `TELEFONO`, `ESTADO`) VALUES (6, 'Pacienet 3 ', 'Paciente 3', 'paciente3@gmail.com', NULL, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `clinica`.`PACIENTE`
-- -----------------------------------------------------
START TRANSACTION;
USE `clinica`;
INSERT INTO `clinica`.`PACIENTE` (`ID_PACIENTE`, `FECHA_NACIMIENTO`, `SEXO`, `DIRECCION`, `NOMBRE_PADRE`, `RELIGION_PERTENECE`, `OCUPACION`) VALUES (4, '1980-01-01', 'Masculino', 'calle  nueva', NULL, NULL, NULL);
INSERT INTO `clinica`.`PACIENTE` (`ID_PACIENTE`, `FECHA_NACIMIENTO`, `SEXO`, `DIRECCION`, `NOMBRE_PADRE`, `RELIGION_PERTENECE`, `OCUPACION`) VALUES (5, '1980-01-01', 'Masculino', 'calle nueva', NULL, NULL, NULL);
INSERT INTO `clinica`.`PACIENTE` (`ID_PACIENTE`, `FECHA_NACIMIENTO`, `SEXO`, `DIRECCION`, `NOMBRE_PADRE`, `RELIGION_PERTENECE`, `OCUPACION`) VALUES (6, '1980-01-01', 'Femenino', 'calle nueva', NULL, NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `clinica`.`ESPECIALIDAD`
-- -----------------------------------------------------
START TRANSACTION;
USE `clinica`;
INSERT INTO `clinica`.`ESPECIALIDAD` (`ID_ESPECIALIDAD`, `NOMBRE`, `NJM`) VALUES (1, 'General', 'G001');
INSERT INTO `clinica`.`ESPECIALIDAD` (`ID_ESPECIALIDAD`, `NOMBRE`, `NJM`) VALUES (2, 'Odontologico', 'O001');

COMMIT;


-- -----------------------------------------------------
-- Data for table `clinica`.`ESTADO_CITA`
-- -----------------------------------------------------
START TRANSACTION;
USE `clinica`;
INSERT INTO `clinica`.`ESTADO_CITA` (`ID_ESTADO_CITA`, `ESTADO`) VALUES (1, 'Sin Validar');
INSERT INTO `clinica`.`ESTADO_CITA` (`ID_ESTADO_CITA`, `ESTADO`) VALUES (2, 'Validada');
INSERT INTO `clinica`.`ESTADO_CITA` (`ID_ESTADO_CITA`, `ESTADO`) VALUES (3, 'Iniciada');
INSERT INTO `clinica`.`ESTADO_CITA` (`ID_ESTADO_CITA`, `ESTADO`) VALUES (4, 'Terminada');
INSERT INTO `clinica`.`ESTADO_CITA` (`ID_ESTADO_CITA`, `ESTADO`) VALUES (5, 'Cancelada');

COMMIT;


-- -----------------------------------------------------
-- Data for table `clinica`.`EXPEDIENTE`
-- -----------------------------------------------------
START TRANSACTION;
USE `clinica`;
INSERT INTO `clinica`.`EXPEDIENTE` (`ID_EXPEDIENTE`, `ID_PACIENTE`, `CODIGO`, `FECHA_CREACION`, `EXONERADO`) VALUES (1, 4, '004', '2014-07-07', 0);
INSERT INTO `clinica`.`EXPEDIENTE` (`ID_EXPEDIENTE`, `ID_PACIENTE`, `CODIGO`, `FECHA_CREACION`, `EXONERADO`) VALUES (2, 5, '005', '204-07-07', 0);
INSERT INTO `clinica`.`EXPEDIENTE` (`ID_EXPEDIENTE`, `ID_PACIENTE`, `CODIGO`, `FECHA_CREACION`, `EXONERADO`) VALUES (3, 6, '006', '204-07-07', 0);

COMMIT;


-- -----------------------------------------------------
-- Data for table `clinica`.`EMPLEADO`
-- -----------------------------------------------------
START TRANSACTION;
USE `clinica`;
INSERT INTO `clinica`.`EMPLEADO` (`ID_EMPLEADO`, `ID_ESPECIALIDAD`, `TITULO`) VALUES (1, 1, NULL);
INSERT INTO `clinica`.`EMPLEADO` (`ID_EMPLEADO`, `ID_ESPECIALIDAD`, `TITULO`) VALUES (2, 2, NULL);
INSERT INTO `clinica`.`EMPLEADO` (`ID_EMPLEADO`, `ID_ESPECIALIDAD`, `TITULO`) VALUES (3, NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `clinica`.`MEDICAMENTO`
-- -----------------------------------------------------
START TRANSACTION;
USE `clinica`;
INSERT INTO `clinica`.`MEDICAMENTO` (`ID_MEDICAMENTO`, `NOMBRE`, `CASA_FARMACEUTICA`, `CODIGO`, `DESCRIPCION`, `PRESENTACION`, `CANTIDAD_ACTUAL`) VALUES (1, 'Aspirina', 'bayer', '002', 'aspririna', 'pastilla', 15);
INSERT INTO `clinica`.`MEDICAMENTO` (`ID_MEDICAMENTO`, `NOMBRE`, `CASA_FARMACEUTICA`, `CODIGO`, `DESCRIPCION`, `PRESENTACION`, `CANTIDAD_ACTUAL`) VALUES (2, 'Dolofin', 'Lopez', '003', 'dolofin', 'pastilla', 25);
INSERT INTO `clinica`.`MEDICAMENTO` (`ID_MEDICAMENTO`, `NOMBRE`, `CASA_FARMACEUTICA`, `CODIGO`, `DESCRIPCION`, `PRESENTACION`, `CANTIDAD_ACTUAL`) VALUES (3, 'Ibuprofeno', 'Lestr', '004', 'Ibuprofena', 'pastilla', 25);
INSERT INTO `clinica`.`MEDICAMENTO` (`ID_MEDICAMENTO`, `NOMBRE`, `CASA_FARMACEUTICA`, `CODIGO`, `DESCRIPCION`, `PRESENTACION`, `CANTIDAD_ACTUAL`) VALUES (4, 'Zorritone', 'Lopez', '005', 'Jarabe', 'jarabe', 15);

COMMIT;


-- -----------------------------------------------------
-- Data for table `clinica`.`ROL`
-- -----------------------------------------------------
START TRANSACTION;
USE `clinica`;
INSERT INTO `clinica`.`ROL` (`ID_ROL`, `NOMBRE`, `DESCRIPCION`) VALUES (1, 'Medico', 'Usuario Operativo');
INSERT INTO `clinica`.`ROL` (`ID_ROL`, `NOMBRE`, `DESCRIPCION`) VALUES (2, 'Secretaria', 'Usuario Operativo');
INSERT INTO `clinica`.`ROL` (`ID_ROL`, `NOMBRE`, `DESCRIPCION`) VALUES (3, 'Administrador', 'Usuario Administrador');

COMMIT;


-- -----------------------------------------------------
-- Data for table `clinica`.`DETALLE_ROL`
-- -----------------------------------------------------
START TRANSACTION;
USE `clinica`;
INSERT INTO `clinica`.`DETALLE_ROL` (`ID_DETALLE_ROL`, `ID_EMPLEADO`, `ID_ROL`) VALUES (1, 1, 1);
INSERT INTO `clinica`.`DETALLE_ROL` (`ID_DETALLE_ROL`, `ID_EMPLEADO`, `ID_ROL`) VALUES (2, 2, 1);
INSERT INTO `clinica`.`DETALLE_ROL` (`ID_DETALLE_ROL`, `ID_EMPLEADO`, `ID_ROL`) VALUES (3, 3, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `clinica`.`USUARIO`
-- -----------------------------------------------------
START TRANSACTION;
USE `clinica`;
INSERT INTO `clinica`.`USUARIO` (`ID_PERSONA`, `USUARIO`, `PASSWORD`, `ESTADO`) VALUES (1, 'medico1', 'e10adc3949ba59abbe56e057f20f883e', 1);
INSERT INTO `clinica`.`USUARIO` (`ID_PERSONA`, `USUARIO`, `PASSWORD`, `ESTADO`) VALUES (2, 'medico2', 'e10adc3949ba59abbe56e057f20f883e', 1);
INSERT INTO `clinica`.`USUARIO` (`ID_PERSONA`, `USUARIO`, `PASSWORD`, `ESTADO`) VALUES (3, 'secretaria1', 'e10adc3949ba59abbe56e057f20f883e', 1);

COMMIT;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
