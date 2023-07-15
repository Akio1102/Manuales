-- Base de datos de Equipos Electronicos

CREATE DATABASE Equipos_Electronicos;

USE Equipos_Electronicos;

CREATE TABLE equipo(
    nombreEquipo VARCHAR(50),
    modelo VARCHAR(50),
    componentes VARCHAR(50),
    fabricante VARCHAR(50),
    fecha DATE,
);

-- La tabla anterior no esta normalizada con esta tomaremos de ejemplo para la normalizacion

-- 1 Forma de normalizacion atomizar los datos y relacionarlos y no se repiten grupos de valores.

CREATE TABLE equipo(
    idEquipo INT NOT NULL AUTO_INCREMENT,
    nombreEquipo VARCHAR(50) NOT NULL,
    modelo VARCHAR(50) NOT NULL,
    componentes VARCHAR(50) NOT NULL,
    fabricante VARCHAR(50) NOT NULL,
    fecha DATE NOT NULL,
    PRIMARY KEY (idEquipo)
);

-- 2 Forma de normalizacion separaremos las columnas que dependen de diferentes claves primarias en tablas separadas.

CREATE TABLE modelos (
    idModelo INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    anio DATE NOT NULL,
    PRIMARY KEY (idModelo)
);

CREATE TABLE fabricantes (
    id INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    pais VARCHAR(50) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE equipo (
    id INT NOT NULL AUTO_INCREMENT,
    nombreEquipo VARCHAR(50),
    idModelo INT,
    idEnsamblador INT,
    PRIMARY KEY (id),
    FOREIGN KEY (idModelo) REFERENCES modelos(idModelo),
    FOREIGN KEY (idEnsamblador) REFERENCES fabricantes(id)
);

-- 3 Forma de normalizacion, crearemos una tabla adicional para eliminar esta dependencia.

CREATE TABLE ensambladores (
    id INT NOT NULL AUTO_INCREMENT,
    idFabricante INT,
    PRIMARY KEY (id),
    FOREIGN KEY (idFabricante) REFERENCES fabricantes(id)
);

ALTER TABLE equipo
ADD COLUMN idEnsamblador INT,
ADD FOREIGN KEY (idEnsamblador) REFERENCES ensambladores(id);

-- Base de datos con las 3 formas de normalizacion cambiando nombre de algunas tablas

CREATE TABLE componentes (
    idComponente INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    marca VARCHAR(50) NOT NULL,
    PRIMARY KEY (idComponente)
);

CREATE TABLE modelos (
    idModelo INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    anio DATE NOT NULL,
    PRIMARY KEY (idModelo)
);

CREATE TABLE fabricantes (
    idFabricante INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    pais VARCHAR(50) NOT NULL,
    PRIMARY KEY (idFabricante)
);

CREATE TABLE ensambladores (
    idEnsamblador INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    idFabricante INT NOT NULL,
    PRIMARY KEY (idEnsamblador),
    FOREIGN KEY (idFabricante) REFERENCES fabricantes (idFabricante)
);

CREATE TABLE ensamblajes (
    idEnsamblaje INT NOT NULL AUTO_INCREMENT,
    idComponente INT NOT NULL,
    idModelo INT NOT NULL,
    idEnsamblador INT NOT NULL,
    PRIMARY KEY (idEnsamblaje),
    FOREIGN KEY (idComponente) REFERENCES componentes (idComponente),
    FOREIGN KEY (idModelo) REFERENCES modelos (idModelo),
    FOREIGN KEY (idEnsamblador) REFERENCES ensambladores (idEnsamblador)
);