-- Tipos de creacion de una base de datos llamada vehiculos

CREATE DATABASE vehiculos;

-- Otra forma seria usando el IF NOT EXISTS para crear una base de datos llamada "mundo" si aún no existe.

CREATE DATABASE IF NOT EXISTS vehiculos;

-- Borrar una base de datos(bd) con la sintaxis sencilla

DROP DATABASE vehiculos

-- Borrar una bd usando la clausula IF EXISTS

DROP DATABASE IF EXISTS vehiculos;

-- Sentencia (Query) USE para entrar a la bd

USE vehiculos;

-- Crear Tablas (Tables) Carros

CREATE TABLE carros (
    id INT NOT NULL AUTO_INCREMENT,
    marca VARCHAR(50) NOT NULL,
    modelo VARCHAR(50) NOT NULL,
    anio INT NOT NULL,
    color VARCHAR(20) NOT NULL,
    precio DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (id)
);

-- Crear Tablas (Tables) Carros IF NOT EXISTS

CREATE TABLE IF NOT EXISTS carros (
    id INT,
    marca VARCHAR(50),
    modelo VARCHAR(50),
    anio INT,
    color VARCHAR(20),
    precio DECIMAL(10, 2),
    PRIMARY KEY (id)
);

/*
En esta tabla de carros, se definen las siguientes columnas:

- id: un identificador único para cada carro, que se genera automáticamente.
- marca: el nombre de la marca del carro.
- modelo: el nombre del modelo del carro.
- anio: el año de fabricación del carro.
- color: el color del carro.
-precio: el precio del carro.

La columna id se establece como clave primaria (PRIMARY KEY) para garantizar que cada registro tenga un identificador único. Otros campos se definen como NOT NULL para asegurarse de que siempre tengan valores. El tipo de dato DECIMAL(10, 2) se utiliza para representar el precio con dos decimales.
*/


-- Borrar tables

DROP TABLE carros;

-- Borrar tables usando IF EXISTS

DROP TABLE IF EXISTS carros;

-- Crear una Table con Llave Primary (Primary Key) se pueden usar las 2 siguientes formas

CREATE TABLE carros (
    id INT,
    marca VARCHAR(50),
    modelo VARCHAR(50),
    anio INT,
    color VARCHAR(20),
    precio DECIMAL(10, 2),
    PRIMARY KEY (id)
);

CREATE TABLE carros (
    id INT PRIMARY KEY,
    marca VARCHAR(50),
    modelo VARCHAR(50),
    anio INT,
    color VARCHAR(20),
    precio DECIMAL(10, 2)
);

-- Se puede definir la Primary Key despues de crear la tabla de la siguiente forma

ALTER TABLE carros
ADD PRIMARY KEY (id);

/* Si no tenemos creado la columna id podemos modificarla la tabla para agregarla para que sea de tipo INT, NOT NULL y AUTO_INCREMENT y por ultimo que es PRIMARY KEY , para generar automáticamente valores enteros únicos. */

ALTER TABLE carros
ADD COLUMN id INT NOT NULL AUTO_INCREMENT PRIMARY KEY FIRST;

-- Insertar Datos (INSERT) en la Table en el Insert into le pasamos la tabla y luego entre () los valores que tiene la tabla para agregar posteriormente en los VALUES los mismo valores dentro de ()

INSERT INTO carros (marca, modelo, anio, color, precio)
VALUES ('Toyota', 'Corolla', 2022, 'Rojo', 25000.00);

-- Tambien se puede agregar varios datos 

INSERT INTO carros (marca, modelo, anio, color, precio)
VALUES ('Nissan', 'Sentra', 2018, 'Gris', 15000.00);

INSERT INTO carros (marca, modelo, anio, color, precio)
VALUES ('Volkswagen', 'Golf', 2020, 'Blanco', 20000.00);

INSERT INTO carros (marca, modelo, anio, color, precio)
VALUES ('Audi', 'A4', 2017, 'Azul', 22000.00);

-- Aun que esta no es la forma más optica la siguiente es la forma correcta ya que solo invocamos la sentencia una sola vez y podemos pasarle varios valores (VALUES)

INSERT INTO carros (marca, modelo, anio, color, precio)
VALUES
    ('Honda', 'Civic', 2021, 'Azul', 22000.00),
    ('Ford', 'Mustang', 2020, 'Negro', 35000.00),
    ('Chevrolet', 'Cruze', 2019, 'Plata', 18000.00);

--  Modificar Datos de una columna

UPDATE carros SET precio = 28000.00 WHERE marca = 'Toyota';

/*
En este ejemplo, se actualiza el valor de la columna precio en la tabla de carros. La cláusula SET establece el nuevo valor que deseas asignar, en este caso, se actualiza el precio a 28000.00. La cláusula WHERE se utiliza para especificar la condición que debe cumplir el registro que se desea actualizar, en este caso, se actualizan los carros de marca 'Toyota'.
*/

-- Tambien se pueden modificar varios valores de una columna 

UPDATE carros SET precio = 30000.00, color = 'Rojo' WHERE marca = 'Honda';

-- Eliminar datos (DELETE)

DELETE FROM carros;

-- El resultado de ejecutar una sentencia como esta es el borrado de todos los registros.

/*
El siguiente comando se utiliza para eliminar todos los registros de una tabla, pero mantiene la estructura de la tabla intacta. Es decir, la sentencia TRUNCATE borra todos los datos de la tabla, pero no elimina la tabla en sí ni afecta a las definiciones de la tabla, como las columnas, las restricciones o los índices.
*/

TRUNCATE TABLE carros;

-- Tambien se puede eliminar datos especificando una condición, En este ejemplo, se eliminan los registros de la tabla de carros que cumplan con la condición especificada. La cláusula WHERE se utiliza para definir la condición que deben cumplir los registros a eliminar. En este caso, se eliminan los carros de la marca 'Ford' cuyo año sea anterior a 2010.

DELETE FROM carros WHERE marca = 'Ford' AND año < 2010;

-- Tambien se le puede poner un limite de registros que se pueden ver afectados por el comando anterior

DELETE FROM carros WHERE marca = 'Ford' LIMIT 5;

--  Consultar datos (SELECT)

SELECT * FROM carros;

/*
En el ejemplo anterior, se seleccionan todos los campos (representados por el asterisco *) de la tabla de carros. Esto devolverá todos los registros y columnas de la tabla.

Si deseas seleccionar columnas específicas en lugar de todas, puedes indicar los nombres de las columnas separados por comas. Por ejemplo:
*/

SELECT marca, modelo, año FROM carros;

-- También puedes agregar condiciones utilizando la cláusula WHERE para filtrar los registros que deseas obtener. Por ejemplo:

SELECT * FROM carros WHERE marca = 'Ford' AND año > 2010;

-- Al SELECT se le puede aplicar LIMIT y WHERE a su vez un ordenamiento de los datos (ORDER BY)

-- Con lIMIT limitamos los datos que recibimos al ejecutar el Query

SELECT * FROM carros LIMIT 5;

-- Con el WHERE seleccionamos los datos que cumplan n condición

SELECT * FROM carros WHERE marca = 'Toyota';

-- Con el ORDER BY seleccionamos el precio de forma descendente por el precio.

SELECT * FROM carros ORDER BY precio DESC;

-- Query con LIMIT,WHERE Y ORDER BY

SELECT * FROM carros
WHERE año >= 2018
ORDER BY precio ASC
LIMIT 10;

-- El Query anterior selecciona los primeros 10 registros de la tabla "carros" donde el año sea mayor o igual a 2018, ordenados de forma ascendente por el precio.

-- Conceder permisos. Este comando otorga al usuario "usuario" el permiso de seleccionar, insertar, actualizar y eliminar registros en la tabla "carros".

GRANT SELECT, INSERT, UPDATE, DELETE ON carros TO 'usuario'@'localhost';

-- Revocar permisos. Este comando revoca al usuario "usuario" los permisos de insertar y actualizar registros en la tabla "carros".

REVOKE INSERT, UPDATE ON carros FROM 'usuario'@'localhost';

-- Crear un nuevo usuario. Este comando crea un nuevo usuario llamado "nuevousuario" con la contraseña especificada.

CREATE USER 'nuevousuario'@'localhost' IDENTIFIED BY 'contraseña';

-- Eliminar un usuario. Este comando elimina el usuario "usuario" de la base de datos.

DROP USER 'usuario'@'localhost';

-- En este ejemplo, utilizamos START TRANSACTION para iniciar la transacción. Luego, realizamos una operación de actualización del precio de un carro mediante el comando UPDATE, donde establecemos el precio del carro con id igual a 1 a 15000. A continuación, eliminamos un registro de la tabla "carros" utilizando el comando DELETE, donde eliminamos el carro con id igual a 2. Finalmente, utilizamos COMMIT para confirmar y aplicar los cambios realizados en la transacción.

START TRANSACTION; -- Iniciamos la transacción

-- Actualizamos el precio del carro
UPDATE carros SET precio = 15000 WHERE id = 1;

-- Eliminamos un registro de carro
DELETE FROM carros WHERE id = 2;

COMMIT; -- Confirmamos y aplicamos los cambios en la transacción

-- En este ejemplo, se inicia una transacción y se realizan cambios en la tabla "carros". Luego, se ejecuta el comando ROLLBACK para deshacer todos los cambios realizados en la transacción. Esto significa que los registros actualizados y eliminados se restauran a su estado original.

START TRANSACTION;
UPDATE carros SET estado = 'vendido' WHERE id = 1;
DELETE FROM carros WHERE id = 2;
ROLLBACK;

-- En este ejemplo, se inicia una transacción y se realizan cambios en la tabla "carros". Luego, se crea un SAVEPOINT llamado "punto1" después de actualizar un registro. A continuación, se elimina otro registro. Sin embargo, al ejecutar el comando ROLLBACK TO SAVEPOINT punto1, se deshacen solo los cambios realizados después del SAVEPOINT, manteniendo los cambios anteriores.

START TRANSACTION;
UPDATE carros SET estado = 'reservado' WHERE id = 1;
SAVEPOINT punto1;
DELETE FROM carros WHERE id = 2;
ROLLBACK TO SAVEPOINT punto1;
