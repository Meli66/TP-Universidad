
DROP SCHEMA IF EXISTS `universidad`;
CREATE SCHEMA `universidad` DEFAULT CHARACTER SET utf8mb4 ;

CREATE TABLE `universidad`.`categoria` (
  `IdCategoria` TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `CategoriaNombre` VARCHAR(45) NOT NULL,
  `Sueldo` DOUBLE(20,10) NOT NULL DEFAULT 0,
  `Contratado` TINYINT(1) NOT NULL DEFAULT 1,
  `Titular` TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`IdCategoria`));
  
 CREATE TABLE `universidad`.`direccion` (
  `IdDireccion` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Pais` VARCHAR(50) NOT NULL,
  `Provincia` VARCHAR(50) NOT NULL,
  `Ciudad` VARCHAR(50) NOT NULL,
  `Calle` VARCHAR(10) NOT NULL,
  `Numero` SMALLINT UNSIGNED NOT NULL,
  `Piso` TINYINT UNSIGNED NOT NULL,
  `Depto` VARCHAR(5) NOT NULL,
  PRIMARY KEY (`IdDireccion`));
  
 CREATE TABLE `universidad`.`persona` (
  `IdPersona` MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `IdDireccion` SMALLINT UNSIGNED NOT NULL,
  `Nombre` VARCHAR(50) NOT NULL,
  `Apellido` VARCHAR(50) NOT NULL,
  `Dni` VARCHAR(20) NOT NULL,
  `FechaNacimiento` DATE NOT NULL,
  PRIMARY KEY (`IdPersona`),
  INDEX `Persona_Direccion_idx` (`IdDireccion` ASC) VISIBLE,
  CONSTRAINT `Persona_Direccion`
    FOREIGN KEY (`IdDireccion`)
    REFERENCES `universidad`.`direccion` (`IdDireccion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
CREATE TABLE `universidad`.`alumnocurso` (
  `IdAlumnoCurso` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `IdPersona` MEDIUMINT UNSIGNED NOT NULL,
  `NotaCurso` DOUBLE(2,2) NOT NULL DEFAULT 0,
  PRIMARY KEY (`IdAlumnoCurso`),
  INDEX `AlumnoCurso_Persona_idx` (`IdPersona` ASC) VISIBLE,
  CONSTRAINT `AlumnoCurso_Persona`
    FOREIGN KEY (`IdPersona`)
    REFERENCES `universidad`.`persona` (`IdPersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
CREATE TABLE `universidad`.`profesorcurso` (
  `IdProfesorCurso` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `IdPersona` MEDIUMINT UNSIGNED NOT NULL,
  `IdCategoria` TINYINT UNSIGNED NOT NULL,
  PRIMARY KEY (`IdProfesorCurso`),
  INDEX `ProfesorCurso_Persona_idx` (`IdPersona` ASC) VISIBLE,
  INDEX `ProfesorCurso_Categoria_idx` (`IdCategoria` ASC) VISIBLE,
  CONSTRAINT `ProfesorCurso_Persona`
    FOREIGN KEY (`IdPersona`)
    REFERENCES `universidad`.`persona` (`IdPersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ProfesorCurso_Categoria`
    FOREIGN KEY (`IdCategoria`)
    REFERENCES `universidad`.`categoria` (`IdCategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
CREATE TABLE `universidad`.`sede` (
  `IdSede` MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `IdDireccion` SMALLINT UNSIGNED NOT NULL,
  `IdCarreraSede` SMALLINT UNSIGNED NOT NULL,
  PRIMARY KEY (`IdSede`),
  INDEX `Sede_Direccion_idx` (`IdDireccion` ASC) VISIBLE,
  CONSTRAINT `Sede_Direccion`
    FOREIGN KEY (`IdDireccion`)
    REFERENCES `universidad`.`direccion` (`IdDireccion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
CREATE TABLE `universidad`.`carreraSede` (
  `IdCarreraSede` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `IdCarrera` SMALLINT UNSIGNED NOT NULL,
  `IdSede` MEDIUMINT UNSIGNED NOT NULL,
  PRIMARY KEY (`IdCarreraSede`),
  INDEX `CarreraSede_Sede_idx` (`IdSede` ASC) VISIBLE,
  CONSTRAINT `CarreraSede_Sede`
    FOREIGN KEY (`IdSede`)
    REFERENCES `universidad`.`sede` (`IdSede`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
ALTER TABLE `universidad`.`sede`
ADD CONSTRAINT `Sede_CarreraSede`
FOREIGN KEY (`IdCarreraSede`)
REFERENCES `universidad`. `carreraSede` (`IdCarreraSede`)
ON DELETE NO ACTION
ON UPDATE NO ACTION;    
  
CREATE TABLE `universidad`.`carrera` (
  `IdCarrera` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `IdCarreraSede` MEDIUMINT UNSIGNED NOT NULL,
  `NombreCarrera` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`IdCarrera`),
  INDEX `Carrera_CarreraSede_idx` (`IdCarreraSede` ASC) VISIBLE,
  CONSTRAINT `Carrera_CarreraSede`
    FOREIGN KEY (`IdCarreraSede`)
    REFERENCES `universidad`.`carrerasede` (`IdSede`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
  
ALTER TABLE `universidad`.`carrerasede`
ADD CONSTRAINT `CarreraSede_Carrera`
FOREIGN KEY (`IdCarrera`)
REFERENCES `universidad`. `carrera` (`IdCarrera`)
ON DELETE NO ACTION
ON UPDATE NO ACTION;    
 
CREATE TABLE `universidad`.`aula` (
  `IdAula` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `IdSede` MEDIUMINT UNSIGNED NOT NULL,
  PRIMARY KEY (`IdAula`),
  INDEX `Aula_Sede_idx` (`IdSede` ASC) VISIBLE,
  CONSTRAINT `Aula_Sede`
    FOREIGN KEY (`IdSede`)
    REFERENCES `universidad`.`sede` (`IdSede`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE `universidad`.`materia` (
  `IdMateria` MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `IdCarrera` SMALLINT UNSIGNED NOT NULL,
  `Nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`IdMateria`),
  INDEX `Materia_Carrera_idx` (`IdCarrera` ASC) VISIBLE,
  CONSTRAINT `Materia_Carrera`
    FOREIGN KEY (`IdCarrera`)
    REFERENCES `universidad`.`carrera` (`IdCarrera`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE `universidad`.`curso` (
  `IdCurso` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `IdAula` SMALLINT UNSIGNED NOT NULL,
  `IdMateria` MEDIUMINT UNSIGNED NOT NULL,
  `Turno` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`IdCurso`),
  INDEX `Curso_Aula_idx` (`IdAula` ASC) VISIBLE,
  INDEX `Curso_Materia_idx` (`IdMateria` ASC) VISIBLE,
  CONSTRAINT `Curso_Aula`
    FOREIGN KEY (`IdAula`)
    REFERENCES `universidad`.`aula` (`IdAula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Curso_Materia`
    FOREIGN KEY (`IdMateria`)
    REFERENCES `universidad`.`materia` (`IdMateria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
 CREATE TABLE `universidad`.`materiatexto` (
  `IdMateriaTexto` MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `IdMateria` MEDIUMINT UNSIGNED NOT NULL,
  `IdTexto` MEDIUMINT UNSIGNED NOT NULL,
  PRIMARY KEY (`IdMateriaTexto`),
  INDEX `MateriaTexto_Materia_idx` (`IdMateria` ASC) VISIBLE,
  CONSTRAINT `MateriaTexto_Materia`
    FOREIGN KEY (`IdMateria`)
    REFERENCES `universidad`.`materia` (`IdMateria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


CREATE TABLE `universidad`.`texto` (
  `IdTexto` MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `MateriaTexto` MEDIUMINT UNSIGNED NOT NULL,
  `Titulo` VARCHAR(50) NOT NULL,
  `Autor` VARCHAR(50) NOT NULL,
  `Descripcion` VARCHAR(50) NOT NULL,
  `FechaPublicacion` DATE NOT NULL,
  PRIMARY KEY (`IdTexto`),
  INDEX `Texto_MateriaTexto_idx` (`MateriaTexto` ASC) VISIBLE,
  CONSTRAINT `Texto_MateriaTexto`
    FOREIGN KEY (`MateriaTexto`)
    REFERENCES `universidad`.`materiatexto` (`IdMateriaTexto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

 ALTER TABLE `universidad`.`materiatexto`
ADD CONSTRAINT `MateriaTexto_Texto`
FOREIGN KEY (`IdTexto`)
REFERENCES `universidad`. `texto` (`IdTexto`)
ON DELETE NO ACTION
ON UPDATE NO ACTION;    

