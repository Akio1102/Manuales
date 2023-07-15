# BASES DE DATOS RELACIONALES - INTERMEDIO

- [Creación Tablas](#creación-de-tablas)
- [Revisar la Estructura de una Tabla](#revisar-la-estructura-de-una-tabla)
- [Relaciones entre Tablas](#relaciones-entre-tablas)
- [Campos y Alias en MySQL](#campos-y-alias-en-mysql)
- [Combinación de Tablas](#combinación-de-tablas)
- [Consultas Anidadas](#consultas-anidadas)
- [Indices y Vistas](#indices-y-vistas)

## Creación de Tablas

Para crear una tabla en MySQL, se utilizan los siguientes pasos: [Ejemplo](./Consultas_Intermedias.sql)

1. **Decidir la estructura de la tabla**: Antes de crear la tabla, debes determinar qué columnas o campos necesitas y el tipo de datos que contendrán. Por ejemplo, si quieres crear una tabla de usuarios, puedes tener columnas como id, nombre, email y edad.

2. **Escribir el comando CREATE TABLE**: Utilizando el comando CREATE TABLE, puedes crear una nueva tabla en la base de datos. El comando tiene la siguiente estructura básica:

```sql
CREATE TABLE nombre_tabla (
    columna1 tipo_dato,
    columna2 tipo_dato,
...
);
```

3. **Definir los tipos de datos y restricciones**: Para cada columna de la tabla, debes especificar el tipo de dato que contendrá. MySQL ofrece una variedad de tipos de datos.

| Tipo de Dato | Descripción                                                   | Ejemplo               |
| ------------ | ------------------------------------------------------------- | --------------------- |
| INT          | Número entero con signo.                                      | 10                    |
| FLOAT        | Número de coma flotante.                                      | 3.14                  |
| DOUBLE       | Número de coma flotante de doble precisión.                   | 3.141592653589793     |
| DECIMAL      | Número decimal de precisión fija.                             | 10.99                 |
| VARCHAR      | Cadena de texto variable con longitud máxima especificada.    | "Hola"                |
| CHAR         | Cadena de texto de longitud fija.                             | "OpenAI"              |
| TEXT         | Texto de longitud variable.                                   | "Lorem ipsum..."      |
| DATE         | Fecha en formato 'YYYY-MM-DD'.                                | "2022-01-01"          |
| TIME         | Hora en formato 'HH:MM:SS'.                                   | "12:30:45"            |
| DATETIME     | Combinación de fecha y hora en formato 'YYYY-MM-DD HH:MM:SS'. | "2022-01-01 12:30:45" |
| TIMESTAMP    | Marca de tiempo indicando fecha y hora del evento.            | 1641101445            |
| BOOLEAN      | Valor booleano, puede ser TRUE o FALSE.                       | TRUE                  |
| BLOB         | Datos binarios de longitud variable.                          | (binary data)         |
| BIT          | Valor binario de longitud fija.                               | b'1010'               |
| ENUM         | Valor de una lista predefinida de opciones.                   | "Rojo"                |
| SET          | Conjunto de valores seleccionables.                           | "Manzana, Naranja"    |

También puedes agregar restricciones, como PRIMARY KEY para indicar una clave primaria única o NOT NULL para evitar valores nulos en una columna.

4. **Ejecutar el comando**: Una vez que hayas escrito el comando CREATE TABLE con las columnas y restricciones adecuadas, puedes ejecutarlo en MySQL para crear la tabla. Puedes utilizar herramientas como la línea de comandos de MySQL, una interfaz gráfica o lenguajes de programación que interactúan con la base de datos.

```sql
CREATE TABLE usuarios (
    id INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    edad INT NOT NULL,
    PRIMARY KEY (id)
);
```

## Revisar la Estructura de una Tabla

El comando para describir una tabla en MySQL es DESCRIBE o DESC. Estos comandos te permiten ver la estructura y los detalles de una tabla existente en la base de datos.

La sintaxis básica del comando DESCRIBE es la siguiente:

```sql
DESCRIBE nombre_tabla;
```

Para describir la tabla de usuario el comando seria el siguiente:

```sql
DESCRIBE usuarios;
```

El comando DESCRIBE en MySQL muestra información detallada sobre la estructura de una tabla, incluyendo nombre, tipo de dato, longitud, nulabilidad y restricciones. Es útil para obtener rápidamente propiedades y características de una tabla sin revisar su definición completa. Es específico de MySQL y ampliamente utilizado para describir tablas de forma rápida y sencilla.

## Relaciones entre Tablas

Para relacionar tablas en MySQL, se utiliza el concepto de claves primarias y claves externas:

1. **Clave Primaria (PRIMARY KEY)**: Es un campo o conjunto de campos que identifica de forma única cada registro en una tabla. Se utiliza el comando PRIMARY KEY al definir una columna como clave primaria. Por ejemplo:

```sql
CREATE TABLE usuarios (
    id INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    edad INT NOT NULL,
    PRIMARY KEY (id)
);
```

2. **Clave Externa (FOREIGN KEY)**: Es un campo o conjunto de campos en una tabla que establece una relación con la clave primaria de otra tabla. Se utiliza el comando FOREIGN KEY al definir una columna como clave externa. Por ejemplo, si tienes una tabla productos y deseas relacionarla con la tabla usuarios, puedes hacerlo de la siguiente manera:

```sql
CREATE TABLE productos (
  id INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(50) NOT NULL,
  usuario_id INT,
  PRIMARY KEY (id),
  FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);
```

La columna usuario_id en la tabla productos se define como clave externa haciendo referencia a la clave primaria id en la tabla usuarios. Esto asegura la integridad referencial de los datos relacionados. En MySQL, se relacionan tablas utilizando claves primarias y externas, asegurando que las claves tengan el mismo tipo de dato y tamaño para establecer una relación adecuada.

## Campos y Alias en MySQL

- **Campos**: Los campos se refieren a las columnas de una tabla. Al realizar consultas, puedes seleccionar los campos específicos que deseas recuperar utilizando la cláusula SELECT. Por ejemplo:

```sql
SELECT campo1, campo2, campo3 FROM tabla;
```

- **Alias**: Un alias es un nombre alternativo que se le da a un campo o tabla en una consulta. Puedes utilizar alias para dar nombres más descriptivos o para abreviar los nombres de los campos o tablas largos. Se utiliza la palabra clave AS para asignar un alias a un campo o tabla. Por ejemplo:

```sql
SELECT campo1 AS alias1, campo2 AS alias2 FROM tabla AS t;
```

En este caso, los campos `campo1` y `campo2` se seleccionan y se les asignan los alias `alias1` y `alias2`, respectivamente. También se utiliza un alias para la tabla tabla llamándola `t`.

```sql
SELECT AVG(precio) AS PromedioPrecio
FROM productos;
```

En este ejemplo, se utiliza el alias "PromedioPrecio" para asignar un nombre más descriptivo al resultado de la función AVG, que calcula el promedio del campo "precio" en la tabla "productos".

```sql
SELECT nombre, cantidad * precio AS TotalVenta
FROM ventas;
```

En este ejemplo, se utiliza el alias "TotalVenta" para asignar un nombre al campo calculado "cantidad \* precio", que representa el total de venta en la tabla "ventas".

```sql
SELECT c.nombre AS Cliente, p.nombre AS Producto
FROM clientes c
INNER JOIN pedidos p ON c.id = p.cliente_id;
```

En este ejemplo, se utilizan alias como "Cliente" y "Producto" para asignar nombres más descriptivos a los campos de las tablas "clientes" y "pedidos" respectivamente, al realizar un join entre ellas.

```sql
SELECT p.nombre AS Producto, (SELECT AVG(precio) FROM productos) AS PromedioPrecio
FROM productos p;
```

En este ejemplo, se utiliza el alias "PromedioPrecio" para asignar un nombre al resultado de la subconsulta, que calcula el promedio del campo "precio" en la tabla "productos".

Estos tabla muestra cómo usar algunas funciones comunes en campos en MySQL. Puedes adaptarlos a tus necesidades y combinarlos con otras cláusulas y condiciones para obtener los resultados deseados en tus consultas SQL.

| Función     | Descripción                                                                                | Ejemplo                                                |
| ----------- | ------------------------------------------------------------------------------------------ | ------------------------------------------------------ |
| SUM         | Calcula la suma de los valores de un campo específico en un conjunto de registros.         | `SELECT SUM(precio) FROM productos;`                   |
| AVG         | Calcula el promedio de los valores de un campo específico en un conjunto de registros.     | `SELECT AVG(edad) FROM usuarios;`                      |
| COUNT       | Cuenta el número de registros en un conjunto, ya sea en general o basado en una condición. | `SELECT COUNT(*) FROM productos;`                      |
| MAX         | Obtiene el valor máximo de un campo específico en un conjunto de registros.                | `SELECT MAX(precio) FROM productos;`                   |
| MIN         | Obtiene el valor mínimo de un campo específico en un conjunto de registros.                | `SELECT MIN(edad) FROM usuarios;`                      |
| CONCAT      | Concatena dos o más cadenas de texto en una sola.                                          | `SELECT CONCAT(nombre, ' ', apellido) FROM usuarios;`  |
| UPPER       | Convierte un texto a mayúsculas.                                                           | `SELECT UPPER(nombre) FROM usuarios;`                  |
| LOWER       | Convierte un texto a minúsculas.                                                           | `SELECT LOWER(nombre) FROM usuarios;`                  |
| LENGTH      | Obtiene la longitud de una cadena de texto.                                                | `SELECT LENGTH(nombre) FROM usuarios;`                 |
| SUBSTRING   | Extrae una parte específica de una cadena de texto.                                        | `SELECT SUBSTRING(nombre, 1, 3) FROM usuarios;`        |
| NOW         | Obtiene la fecha y hora actual.                                                            | `SELECT NOW();`                                        |
| DATE_FORMAT | Formatea una fecha en un formato específico.                                               | `SELECT DATE_FORMAT(fecha, '%d-%m-%Y') FROM usuarios;` |
| DATEDIFF    | Calcula la diferencia en días entre dos fechas.                                            | `SELECT DATEDIFF('2023-01-01', '2022-12-25');`         |
| YEAR        | Obtiene el año de una fecha.                                                               | `SELECT YEAR(fecha) FROM usuarios;`                    |
| MONTH       | Obtiene el mes de una fecha.                                                               | `SELECT MONTH(fecha) FROM usuarios;`                   |
| TRIM        | Elimina espacios en blanco del principio y final de una cadena de texto.                   | `SELECT TRIM(nombre) FROM usuarios;`                   |
| IFNULL      | Devuelve un valor alternativo si una expresión es nula.                                    | `SELECT IFNULL(edad, 0) FROM usuarios;`                |
| ROUND       | Redondea un número a una cantidad específica de decimales.                                 | `SELECT ROUND(precio, 2) FROM productos;`              |

El comando IF en MySQL se utiliza para realizar una evaluación condicional en un campo o expresión. Permite definir una lógica condicional y especificar diferentes valores o acciones según se cumpla o no una condición.

La sintaxis básica del comando IF en MySQL es la siguiente:

```sql
IF(condición, valor_si_verdadero, valor_si_falso)
```

- condición es la expresión o condición que se evalúa.
- valor_si_verdadero es el valor que se devuelve si la condición es verdadera.
- valor_si_falso es el valor que se devuelve si la condición es falsa.

Aquí tienes un ejemplo de cómo usar el comando IF en un campo de una consulta:

```sql
SELECT nombre, edad, IF(edad >= 18, 'Mayor de edad', 'Menor de edad') AS estado
FROM usuarios;
```

En este ejemplo, la condición evalúa si la edad es mayor o igual a 18. Si la condición es verdadera, se devuelve el texto "Mayor de edad". Si la condición es falsa, se devuelve el texto "Menor de edad". El resultado de esta consulta mostrará el nombre, edad y el estado (mayor de edad o menor de edad) para cada usuario en la tabla "usuarios".

El uso de campos y alias en MySQL permite seleccionar los datos específicos que necesitas y asignar nombres más significativos en tus consultas. Esto facilita la comprensión de los resultados y mejora la legibilidad del código.

## Combinación de Tablas

En MySQL, existen varias operaciones de combinación de tablas que permiten combinar datos de dos o más tablas en una consulta. A continuación, se muestran los principales tipos de operaciones de combinación de tablas con ejemplos:

1. **INNER JOIN**: Combina registros de dos tablas que cumplen con una condición especificada.

```sql
SELECT p.nombre, c.categoria
FROM productos p
INNER JOIN categorias c ON p.id_categoria = c.id;
```

En este ejemplo, se combinan los registros de las tablas "productos" y "categorias" utilizando la condición de igualdad entre la columna "id_categoria" de la tabla "productos" y la columna "id" de la tabla "categorias". Se selecciona el nombre del producto y la categoría correspondiente.

2. **LEFT JOIN**: Combina todos los registros de la tabla de la izquierda y los registros coincidentes de la tabla de la derecha.

```sql
SELECT c.nombre, p.precio
FROM categorias c
LEFT JOIN productos p ON c.id = p.id_categoria;
```

En este ejemplo, se combinan todos los registros de la tabla "categorias" con los registros coincidentes de la tabla "productos" utilizando la condición de igualdad entre la columna "id" de la tabla "categorias" y la columna "id_categoria" de la tabla "productos". Se selecciona el nombre de la categoría y el precio del producto correspondiente.

3. **RIGHT JOIN**: Combina todos los registros de la tabla de la derecha y los registros coincidentes de la tabla de la izquierda.

```sql
SELECT p.nombre, c.nombre_categoria
FROM productos p
RIGHT JOIN categorias c ON p.id_categoria = c.id;
```

En este ejemplo, se combinan todos los registros de la tabla "productos" con los registros coincidentes de la tabla "categorias" utilizando la condición de igualdad entre la columna "id_categoria" de la tabla "productos" y la columna "id" de la tabla "categorias". Se selecciona el nombre del producto y el nombre de la categoría correspondiente.

4. **FULL JOIN**: Combina todos los registros de ambas tablas, incluyendo los registros no coincidentes.

```sql
SELECT p.nombre, c.nombre_categoria
FROM productos p
FULL JOIN categorias c ON p.id_categoria = c.id;
```

En este ejemplo, se combinan todos los registros de las tablas "productos" y "categorias" utilizando la condición de igualdad entre la columna "id_categoria" de la tabla "productos" y la columna "id" de la tabla "categorias". Se selecciona el nombre del producto y el nombre de la categoría correspondiente.

## Consultas Anidadas

Las consultas anidadas, también conocidas como subconsultas, son consultas que se realizan dentro de otra consulta. Son útiles cuando necesitas obtener datos de una tabla basados en los resultados de otra consulta.

Por ejemplo, supongamos que tienes una tabla de empleados y una tabla de departamentos, y quieres obtener los nombres de los empleados que pertenecen a un departamento específico. Puedes usar una consulta anidada para lograr esto.

La estructura de una consulta anidada es la siguiente:

```sql
SELECT columna
FROM tabla
WHERE columna IN (SELECT columna FROM otra_tabla WHERE condicion);
```

En el ejemplo anterior, la subconsulta (SELECT columna FROM otra_tabla WHERE condicion) se ejecuta primero y devuelve un conjunto de valores. Luego, estos valores se utilizan en la consulta principal para filtrar los resultados de la tabla principal.

Las consultas anidadas pueden ser utilizadas en diferentes cláusulas, como SELECT, FROM, WHERE, JOIN, entre otras, y ofrecen flexibilidad y poder para realizar consultas más complejas y específicas.

En resumen, las consultas anidadas te permiten realizar consultas dentro de otras consultas para obtener resultados más precisos y personalizados en base a condiciones y datos específicos.

## Indices y Vistas

Los índices y vistas son características de MySQL que ayudan a mejorar el rendimiento y facilitan la manipulación y visualización de los datos.

**Indices**: Los índices son estructuras de datos utilizadas para acelerar la búsqueda y recuperación de registros en una tabla. Un índice se crea en una o más columnas de una tabla y permite que las consultas encuentren rápidamente los registros que coinciden con ciertos criterios. Por ejemplo, si tienes una tabla de usuarios y deseas buscar usuarios por su nombre, puedes crear un índice en la columna "nombre". Esto acelerará la búsqueda y reducirá el tiempo de ejecución de la consulta.

```sql
CREATE INDEX idx_nombre ON usuarios (nombre);
```

- Indice en varias columnas:
  Si deseas crear un índice en múltiples columnas, puedes especificarlas separadas por comas. Por ejemplo, si tienes una tabla "pedidos" con las columnas "cliente_id" y "fecha", puedes crear un índice en ambas columnas:

  ```sql
  CREATE INDEX idx_cliente_fecha ON pedidos (cliente_id, fecha);
  ```

- Indice único:
  Un índice único garantiza que los valores en la columna indexada sean únicos. Si intentas insertar un valor duplicado, se generará un error. Para crear un índice único, puedes usar la siguiente sintaxis:

  ```sql
  CREATE UNIQUE INDEX idx_email ON usuarios (email);
  ```

- Indice de longitud limitada:
  Si solo deseas indexar los primeros n caracteres de una columna, puedes utilizar un índice de longitud limitada. Por ejemplo, si tienes una columna "descripcion" en una tabla "productos" y solo deseas indexar los primeros 20 caracteres, puedes hacerlo de esta manera:

  ```sql
  CREATE INDEX idx_descripcion ON productos (descripcion(20));
  ```

  Para eliminar índices en MySQL, puedes utilizar el comando ALTER TABLE junto con la cláusula DROP INDEX. A continuación se muestra un ejemplo de cómo eliminar un índice en una tabla:

  ```sql
  ALTER TABLE nombre_tabla DROP INDEX nombre_indice;
  ```

  Donde "nombre_tabla" es el nombre de la tabla y "nombre_indice" es el nombre del índice que deseas eliminar

  | Puntos Positivos de los Índices en una tabla                                     |
  | -------------------------------------------------------------------------------- |
  | Mejoran el rendimiento de las consultas                                          |
  | En columnas utilizadas frecuentemente en cláusulas WHERE                         |
  | En columnas utilizadas para unir tablas                                          |
  | Agilizan la búsqueda de registros en columnas utilizadas frecuentemente en WHERE |
  | Aceleran las operaciones de unión en columnas utilizadas para unir tablas        |
  | Optimizan consultas con cláusulas ORDER BY y GROUP BY                            |

**Vistas**: Las vistas son consultas almacenadas que actúan como tablas virtuales. Una vista es una representación de los datos de una o más tablas, pero no almacena los datos físicamente. En cambio, al ejecutar una consulta a una vista, se realiza una consulta en tiempo real a las tablas subyacentes para obtener los resultados. Las vistas son útiles cuando deseas simplificar consultas complejas o proporcionar una vista personalizada de los datos sin tener que acceder directamente a las tablas originales.

```sql
CREATE VIEW vista_usuarios AS
SELECT nombre, edad, direccion
FROM usuarios
WHERE pais = 'España';
```

Consultar la Vista

```sql
SELECT * FROM vista_usuarios;
```

Los beneficios de utilizar vistas en MySQL son:

- Simplificación de consultas
- Ocultamiento de la complejidad
- Mejora del rendimiento
- Seguridad y control de acceso

Para crear una vista en MySQL, puedes utilizar el comando CREATE VIEW seguido del nombre de la vista y la consulta que define la vista. A continuación, se muestra un ejemplo:

```sql
CREATE VIEW nombre_vista AS
SELECT columna1, columna2
FROM tabla
WHERE condicion;
```

Tambien puedes reemplazar una vista de la siguiente forma

```sql
CREATE OR REPLACE VIEW nombre_vista AS
SELECT columna1, columna2, ...
FROM tabla
WHERE condicion;
```

Una vez que se ha creado una vista, puedes consultarla como si fuera una tabla normal:

```sql
SELECT * FROM nombre_vista;
```

Para eliminar una vista en MySQL, puedes utilizar el siguiente comando:

```sql
DROP VIEW nombre_vista;
```
