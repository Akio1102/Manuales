
-- Creación de BD

CREATE DATABASE Mundo;

--Entramos a la BD
USE Mundo;

-- Creación de tablas con Primary Key y Foreign Key

CREATE TABLE Ciudades (
    id INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    pais VARCHAR(50) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE Personas (
    id INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    edad INT NOT NULL,
    idCiudad INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (idCiudad) REFERENCES Ciudades(id)
);

-- Insertar Datos a las tablas

INSERT INTO Ciudades (nombre, pais) VALUES 
("Bucaramanga", "Colombia"),
("BarrancaBermeja", "Colombia"),
("Cucuta", "Colombia"),
("Bogota", "Colombia"),
("Medellin", "Colombia");

INSERT INTO Personas (nombre, apellido, edad, idCiudad) VALUES
('John', 'Doe', 25, 1),
('Jane', 'Smith', 17, 2),
('Michael', 'Johnson', 35, 3),
('Michael', 'Rojas', 11, 3),
('Emily', 'Williams', 40, 1),
('Pepe', 'Andres', 15, 1),
('Daniel', 'Brown', 45, 2);

-- En este ejemplo, se crea una nueva tabla llamada "Personas_Nuevas" utilizando la cláusula CREATE TABLE AS. La tabla se crea seleccionando todas las filas de la tabla existente "Personas" donde la columna "edad" sea mayor o igual a 18.

CREATE TABLE Personas_Mayores AS
SELECT *
FROM Personas
WHERE edad >= 18;

-- Para describir una tabla en MySQL, puedes utilizar el comando DESCRIBE o el comando SHOW COLUMNS. Ambos comandos proporcionan información sobre la estructura y las columnas de la tabla. Aquí tienes un ejemplo de cómo describir una tabla

DESCRIBE Personas;

SHOW COLUMNS FROM Personas;

-- Consultas con Alias

SELECT id as Identificador, nombre,apellido,edad, idCiudad as ID_Ciudad FROM Personas;

-- Alias a Funciones

SELECT CONCAT(nombre,' ',apellido) AS NombrePersona FROM Personas;

-- Alias a la tabla 

SELECT p.nombre, p.apellido, p.edad FROM Personas p;

-- Alias de tablas con Inner Join

SELECT p.id, p.nombre AS Nombre_Persona, p.apellido, p.edad, c.id, c.nombre AS Nombre_Ciudad, c.pais 
FROM Personas p INNER JOIN Ciudades c ON p.idCiudad = c.id;

-- Alias a comando IF

SELECT p.id, CONCAT(p.nombre,' ',p.apellido) AS NombrePersona, IF(p.edad > 18, "Mayor de Edad","Menor de Edad") AS Edad_Persona
FROM Personas p;

-- Inner Join devuelve solo los registros que tienen coincidencias en ambas tablas

SELECT * FROM Personas p INNER JOIN Ciudades c ON p.idCiudad = c.id;

-- Podemos especificar que 

SELECT p.id, p.nombre AS Nombre_Persona, p.apellido, p.edad, c.id, c.nombre AS Nombre_Ciudad, c.pais 
FROM Personas p INNER JOIN Ciudades c ON p.idCiudad = c.id;

-- Left Join devuelve todos los registros de la tabla izquierda y los registros coincidentes de la tabla derecha

SELECT * FROM Personas p LEFT JOIN Ciudades c ON p.idCiudad = c.id;

-- Right Join devuelve todos los registros de la tabla derecha y los registros coincidentes de la tabla izquierda

SELECT * FROM Personas p RIGHT JOIN Ciudades c ON p.idCiudad = c.id;

-- Full Outer Join devuelve todos los registros de ambas tablas, mostrando registros coincidentes y no coincidentes

SELECT * FROM Personas p FULL OUTER JOIN Ciudades c ON p.idCiudad = c.id;

-- Cross Join genera todas las combinaciones posibles entre los registros de ambas tablas.

SELECT * FROM Personas CROSS JOIN Ciudades;

-- Obtener todas las personas que viven en una ciudad específica, la consulta anidada se utiliza en la cláusula WHERE para obtener el ID de la ciudad con nombre 'Ciudad Ejemplo'. Luego, la consulta principal selecciona los nombres y apellidos de las personas que tienen ese ID de ciudad.

SELECT nombre, apellido FROM Personas WHERE idCiudad = (SELECT id FROM Ciudades WHERE nombre = 'Bucaramanga');

-- Obtener el número de personas en cada ciudad, la consulta anidada se encuentra en la cláusula SELECT. Cuenta el número de personas en cada ciudad relacionando el ID de ciudad de la subconsulta con el ID de ciudad de la consulta principal. El resultado se muestra como una columna adicional llamada "total_personas".

SELECT nombre, (SELECT COUNT(*) FROM Personas WHERE idCiudad = Ciudades.id) AS total_personas FROM Ciudades;

-- Obtener la edad promedio de las personas en cada ciudad, la consulta anidada calcula la edad promedio de las personas en cada ciudad. Se relaciona el ID de ciudad de la subconsulta con el ID de ciudad de la consulta principal. El resultado se muestra como una columna adicional llamada "edad_promedio".

SELECT nombre, (SELECT AVG(edad) FROM Personas WHERE idCiudad = Ciudades.id) AS edad_promedio FROM Ciudades;

-- Este indice simple mejora el rendimiento de las consultas que involucren la columna nombre en la tabla Ciudades

CREATE INDEX idx_nombre_ciudades ON Ciudades (nombre);

-- Este indice compuesto mejora el rendimiento de las consultas que involucren las columnas nombre y apellido en la tabla Personas

CREATE INDEX idx_nombre_apellido ON Personas(nombre, apellido);

-- Este indice permite realizar búsquedas de texto completo de manera eficiente en la columna nombre de la tabla Ciudades. Es importante tener en cuenta que los indices de texto completo solo se pueden aplicar en campos de texto, como VARCHAR y TEXT. Estos indices son útiles para buscar palabras clave, frases o realizar búsquedas más avanzadas en texto

CREATE FULLTEXT INDEX idx_nombre_ciudad ON Ciudades(nombre);

-- Esta vista devuelve todas las personas de la tabla Personas que tengan una edad igual o superior a 18 años

CREATE VIEW PersonasMayoresDeEdad AS SELECT * FROM Personas WHERE edad >= 18;

-- Esta vista devuelve todas las personas de la tabla Personas junto con el nombre de la ciudad a la que pertenecen

CREATE VIEW PersonasPorCiudad AS SELECT p.*, c.nombre AS nombre_ciudad FROM Personas p JOIN Ciudades c ON p.idCiudad = c.id;

-- Uso de las Vistas

SELECT * FROM PersonasMayoresDeEdad;

SELECT * FROM PersonasPorCiudad;

-- Eliminar Vistas

DROP VIEW PersonasMayoresDeEdad;

DROP VIEW PersonasPorCiudad;
