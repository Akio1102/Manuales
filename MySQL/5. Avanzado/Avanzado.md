# BASES DE DATOS RELACIONALES - AVANZADO

- [Procedimientos Almacenados](#procedimientos-almacenados)
- [Funciones Definidas por el Usuario](#funciones-definidas-por-el-usuario)
- [Triggers](#triggers)
- [Seguridad y permisos](#seguridad-y-permisos)

## Procedimientos Almacenados

Los procedimientos almacenados en MySQL son fragmentos de código SQL que se almacenan en el servidor de la base de datos y se pueden ejecutar de manera repetitiva y controlada. Aquí están algunas ventajas de utilizar procedimientos almacenados:

1. **Reutilización de código**: Los procedimientos almacenados permiten encapsular lógica de programación compleja en un solo lugar, lo que facilita su reutilización en diferentes partes de una aplicación o en múltiples aplicaciones.

2. **Mejora del rendimiento**: Al ejecutar un procedimiento almacenado, se reduce la cantidad de tráfico de red entre la aplicación y el servidor de la base de datos, lo que puede mejorar significativamente el rendimiento, especialmente en casos de operaciones repetitivas.

3. **Seguridad**: Los procedimientos almacenados permiten controlar el acceso a los datos al definir permisos específicos para su ejecución. Esto ayuda a proteger la integridad y seguridad de los datos, ya que solo se pueden realizar operaciones autorizadas a través de los procedimientos almacenados.

4. **Simplificación de la lógica de la aplicación**: Al mover la lógica de negocio a los procedimientos almacenados, se puede simplificar la aplicación y reducir la complejidad del código. Esto facilita el mantenimiento y la evolución de la aplicación a medida que se realizan cambios en los requisitos.

5. **Manejo de transacciones**: Los procedimientos almacenados pueden ayudar a mantener la consistencia de los datos al permitir el manejo de transacciones. Esto significa que se pueden realizar varias operaciones como una sola unidad, asegurando que todas se completen correctamente o se deshagan si ocurre algún error.

- [Sintaxis de un Procedimientos Almacenados](#sintaxis-de-un-procedimientos-almacenados)
- [DELIMITER](#delimiter)
- [Llamadas de Procedimientos](#llamadas-de-procedimientos)
- [Estructuras de Control](#estructuras-de-control)
- [Manejo de Errores](#manejo-de-errores)

### Sintaxis de un Procedimientos Almacenados

La sintaxis básica de un procedimiento almacenado en MySQL es la siguiente:

```sql
CREATE PROCEDURE nombre_procedimiento ([parametros])
BEGIN
    -- Cuerpo del procedimiento (sentencias SQL)
END;
```

- nombre_procedimiento es el nombre que se le asigna al procedimiento almacenado.
- [parametros] es una lista opcional de parámetros que se pueden pasar al procedimiento almacenado.
- BEGIN y END delimitan el cuerpo del procedimiento, donde se colocan las sentencias SQL que forman parte de la lógica del procedimiento.

Ejemplos de Procedimientos Almacenados:

Procedimiento para obtener la cantidad de personas en la tabla

```sql
CREATE PROCEDURE obtener_cantidad_personas()
BEGIN
    SELECT COUNT(*) AS cantidad FROM Personas;
END;
```

Procedimiento para insertar una nueva persona

```sql
CREATE PROCEDURE insertar_persona(
    IN p_nombre VARCHAR(50),
    IN p_apellido VARCHAR(50),
    IN p_edad INT,
    IN p_idCiudad INT
)
BEGIN
    INSERT INTO Personas (nombre, apellido, edad, idCiudad)
    VALUES (p_nombre, p_apellido, p_edad, p_idCiudad);
END;
```

Procedimiento para actualizar la edad de una persona

```sql
CREATE PROCEDURE actualizar_edad_persona(
    IN p_id INT,
    IN p_nueva_edad INT
)
BEGIN
    UPDATE Personas SET edad = p_nueva_edad WHERE id = p_id;
END;
```

### DELIMITER

La cláusula DELIMITER en MySQL se utiliza para cambiar el delimitador predeterminado que separa las sentencias SQL en un script. Por defecto, el delimitador en MySQL es el punto y coma ( ; ).

Cuando escribimos procedimientos almacenados, funciones o desencadenadores en MySQL, a menudo necesitamos usar múltiples sentencias SQL dentro de su definición. Sin embargo, el uso del delimitador predeterminado ( ; ) puede causar conflictos, ya que MySQL interpretará cada punto y coma como el final de la definición del objeto.

Para evitar esto, podemos utilizar la cláusula DELIMITER para cambiar temporalmente el delimitador a otro carácter, como //, $$, //, etc. Esto permite que MySQL reconozca el nuevo delimitador como el separador de sentencias en lugar del punto y coma predeterminado.

Aquí tienes un ejemplo básico de cómo usar la cláusula DELIMITER en un procedimiento almacenado:

```sql
DELIMITER //
CREATE PROCEDURE obtener_cantidad_personas()
BEGIN
    SELECT COUNT(*) AS cantidad FROM Personas;
END //
DELIMITER ;
```

En este ejemplo, se cambiado el delimitador a // antes de la definición del procedimiento almacenado y lo hemos restaurado a ; después de la definición. Esto permite que las sentencias dentro del procedimiento almacenado se interpreten correctamente.

### Parámetros de Entrada, Salida y de Entrada/Salida

En MySQL, los parámetros de entrada, salida y de entrada/salida son utilizados en la definición de procedimientos almacenados y funciones para recibir y devolver valores.

1. **Parámetros de entrada**: Son utilizados para pasar valores a un procedimiento almacenado o función. Estos parámetros son definidos con un tipo de dato y un nombre, y pueden ser utilizados dentro del cuerpo del procedimiento o función para realizar operaciones con los valores proporcionados.

2. **Parámetros de salida**: Son utilizados para devolver valores desde un procedimiento almacenado o función. Estos parámetros se definen con un tipo de dato y un nombre, y su valor es asignado dentro del cuerpo del procedimiento o función. Al finalizar la ejecución, el valor asignado será retornado al llamador del procedimiento o función.

3. **Parámetros de entrada/salida**: Son utilizados para pasar valores a un procedimiento almacenado o función y también recibir valores de vuelta. Estos parámetros se definen con un tipo de dato y un nombre, y pueden ser utilizados para enviar valores al procedimiento o función y para devolver valores al llamador.

```sql
DELIMITER //

CREATE PROCEDURE obtener_datos(
    IN nombre VARCHAR(50),
    OUT edad INT,
    INOUT contador INT
)
BEGIN
    -- Utilizar el parámetro de entrada
    SELECT nombre INTO nombre_persona FROM Personas WHERE nombre = nombre;

    -- Utilizar el parámetro de salida
    SELECT MAX(edad) INTO edad FROM Personas;

    -- Utilizar el parámetro de entrada/salida
    SET contador = contador + 1;
END //

DELIMITER ;
```

En este caso, se utiliza DELIMITER // para cambiar el delimitador a // antes de la definición del procedimiento almacenado. Luego, se define el procedimiento con los parámetros de entrada (IN), salida (OUT) y de entrada/salida (INOUT). Dentro del cuerpo del procedimiento, se utilizan los parámetros según corresponda.

Recuerda que al final de la definición del procedimiento, se establece el delimitador original utilizando DELIMITER ; para restaurar el delimitador predeterminado.

De esta manera, se asegura que el procedimiento almacenado se defina correctamente con los parámetros de entrada, salida y de entrada/salida, y se evitan conflictos con el delimitador predeterminado.

### Llamadas de Procedimientos

Las llamadas de procedimientos en MySQL se utilizan para ejecutar un procedimiento almacenado.

Para llamar a un procedimiento almacenado, se utiliza la siguiente sintaxis:

```sql
CALL nombre_procedimiento(argumento1, argumento2, ...);
```

Donde nombre_procedimiento es el nombre del procedimiento almacenado que deseas llamar, y argumento1, argumento2, ... son los valores que se pasan a los parámetros de entrada del procedimiento.

```sql
CALL obtener_datos('John Doe', @edad, @contador);
```

En esta llamada al procedimiento, se pasa el valor 'John Doe' al parámetro de entrada nombre, y los valores de salida se guardarán en las variables @edad y @contador. Asegúrate de haber declarado y asignado valores iniciales a las variables @edad y @contador antes de realizar la llamada al procedimiento.

Para declarar y asignar valores a las variables que recibirán los resultados devueltos por un procedimiento almacenado en MySQL, puedes utilizar las variables de sesión del tipo @variable. Aquí tienes un ejemplo de cómo hacerlo:

```sql
-- Declarar y asignar valores iniciales a las variables
SET @edad = 0;
SET @contador = 0;

-- Llamar al procedimiento y obtener los valores de salida
CALL obtener_datos('John Doe', @edad, @contador);

-- Utilizar los valores devueltos
SELECT @edad AS edad_obtenida, @contador AS contador_actual;
```

Las variables de sesión en MySQL (@variable) se pueden utilizar dentro de una base de datos específica. Estas variables son persistentes a lo largo de la conexión de un cliente a la base de datos, lo que significa que se pueden usar en múltiples consultas dentro de la misma conexión.

En el ejemplo las variables @edad y @contador se declaran y se utilizan dentro de la misma conexión de la base de datos. Se pueden utilizar estas variables en consultas posteriores dentro de la misma conexión, pero no se almacenarán permanentemente en una tabla. Son variables de sesión temporales.

Para almacenar los valores devueltos por un procedimiento en una tabla, debes utilizar una sentencia INSERT INTO para insertar los valores en una tabla específica. Por ejemplo:

```sql
-- Crear una tabla para almacenar los valores devueltos
CREATE TABLE resultados (
    edad_obtenida INT,
    contador_actual INT
);

-- Declarar y asignar valores iniciales a las variables
SET @edad = 0;
SET @contador = 0;

-- Llamar al procedimiento y obtener los valores de salida
CALL obtener_datos('John Doe', @edad, @contador);

-- Insertar los valores devueltos en la tabla
INSERT INTO resultados (edad_obtenida, contador_actual)
VALUES (@edad, @contador);
```

En este caso, se crea una tabla llamada resultados con columnas edad_obtenida y contador_actual, y luego se utiliza la sentencia INSERT INTO para insertar los valores devueltos por el procedimiento en esa tabla.

### Estructuras de Control

Las estructuras de control son bloques de código utilizados para controlar el flujo de ejecución de un programa. Permiten tomar decisiones y repetir instrucciones según ciertas condiciones. En MySQL, las estructuras de control más comunes son las siguientes

- [Estructuras Condicionales](#estructuras-condicionales)
- [Estructuras Repetitivas](#estructuras-repetitivas)

#### Estructuras Condicionales

- **Estructura IF-THEN-ELSE**: Permite ejecutar un bloque de código si una condición especificada es verdadera. Puede incluir una cláusula ELSE para ejecutar un bloque de código alternativo si la condición es falsa.

```sql
IF condicion THEN
    -- Bloque de código a ejecutar si la condición es verdadera
ELSE
    -- Bloque de código a ejecutar si la condición es falsa
END IF;
```

- **Estructura CASE**: Permite evaluar múltiples condiciones y ejecutar diferentes bloques de código según el valor de una expresión.

```sql
CASE expresion
    WHEN valor1 THEN
        -- Bloque de código a ejecutar si la expresión coincide con valor1
    WHEN valor2 THEN
        -- Bloque de código a ejecutar si la expresión coincide con valor2
    ELSE
        -- Bloque de código a ejecutar si no se cumple ninguna condición anterior
END CASE;
```

#### Estructuras Repetitivas

Las estructuras repetitivas permiten ejecutar un bloque de código múltiples veces. Las estructuras repetitivas más comunes en MySQL son:

- **Estructura WHILE**: Permite repetir un bloque de código mientras una condición sea verdadera. El bloque de código se ejecuta antes de evaluar la condición.

```sql
WHILE condicion DO
    -- Bloque de código a repetir mientras la condición sea verdadera
END WHILE;
```

- **Estructura REPEAT**: Permite repetir un bloque de código hasta que se cumpla una condición de salida. El bloque de código se ejecuta al menos una vez.

```sql
REPEAT
    -- Bloque de código a repetir
UNTIL condicion;
```

- **Estructura REPEAT-UNTIL**: Permite repetir un bloque de código hasta que se cumpla una condición de salida. El bloque de código se ejecuta al menos una vez.

```sql
REPEAT
    -- Código a ejecutar al menos una vez
UNTIL condicion END REPEAT;
```

- **Estructura LOOP**: Permite repetir un bloque de código de manera indefinida hasta que se alcance una condición de salida.

```sql
LOOP
    -- Bloque de código a repetir
    IF condicion THEN
        LEAVE; -- Sale del bucle si se cumple la condición
    END IF;
END LOOP;
```

Ejemplo de los 2 Tipos de Estrucutras:

```sql
SET @edad_resultado = 0;
SET @contador_resultado = 0;

DELIMITER //

CREATE PROCEDURE obtener_datos(
    IN nombre VARCHAR(50),
    OUT edad INT,
    INOUT contador INT
)
BEGIN
    -- Utilizar el parámetro de entrada
    SELECT nombre INTO nombre_persona FROM Personas WHERE nombre = nombre;

    -- Utilizar el parámetro de salida
    SELECT MAX(edad) INTO edad FROM Personas;

    -- Utilizar el parámetro de entrada/salida
    SET contador = contador + 1;

    -- Estructura IF
    IF edad > 18 THEN
        SET mensaje = 'Es mayor de edad';
    ELSE
        SET mensaje = 'Es menor de edad';
    END IF;

    -- Estructura CASE
    CASE contador
        WHEN 1 THEN
            SET resultado = 'Uno';
        WHEN 2 THEN
            SET resultado = 'Dos';
        ELSE
            SET resultado = 'Otro número';
    END CASE;

    -- Estructura WHILE
    WHILE contador < 10 DO
        SET contador = contador + 1;
    END WHILE;

    -- Estructura REPEAT
    REPEAT
        SET contador = contador - 1;
    UNTIL contador = 0 END REPEAT;

    -- Estructura REPEAT-UNTIL
    REPEAT
        SET contador = contador + 1;
    UNTIL contador = 10 END REPEAT;

    -- Estructura LOOP
    mi_loop: LOOP
        SET contador = contador - 1;
        IF contador = 0 THEN
            LEAVE mi_loop;
        END IF;
    END LOOP;

END //

DELIMITER ;

--Invocar el Procedimiento
CALL obtener_datos('Juan', @edad_resultado, @contador_resultado);
```

### Manejo de Errores

En MySQL se puedes manejar errores utilizando la estructura BEGIN...END con bloques de código condicionales y constructos de control de flujo. Aquí hay algunos aspectos importantes para manejar errores en MySQL:

1. Utilizar la declaración DECLARE para definir variables que almacenen información sobre errores, como códigos y mensajes de error.

2. Utilizar la declaración DECLARE EXIT HANDLER FOR SQLSTATE para capturar errores específicos. Puedes especificar uno o más códigos de estado SQL para los cuales deseas manejar errores. Por ejemplo:

```sql
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
    -- Acciones a realizar cuando se produce una excepción
    -- Puede incluir registro de errores, notificaciones, etc.
    ROLLBACK; -- Si es necesario, realizar una operación de rollback
    RESIGNAL; -- Opcionalmente, relanzar la excepción para que se propague
END;
```

3. Utilizar la sentencia SIGNAL para lanzar manualmente errores personalizados. Por ejemplo:

```sql
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
    -- Acciones a realizar cuando se produce una excepción
    -- Puede incluir registro de errores, notificaciones, etc.
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error personalizado';
END;
```

Ejemplo de Manejo de Errores

```sql
SET @edad = 0;
SET @contador = 0;

DELIMITER //

CREATE PROCEDURE obtener_datos(
    IN nombre VARCHAR(50),
    OUT edad INT,
    INOUT contador INT
)
BEGIN
    -- Declarar variable adicional
    DECLARE nombre_persona VARCHAR(50);

    -- Declarar variables de manejo de errores
    DECLARE error_msg VARCHAR(255) DEFAULT '';
    DECLARE error_occurred BOOLEAN DEFAULT FALSE;

    -- Estructura TRY
    BEGIN
        -- Utilizar el parámetro de entrada
        SELECT nombre INTO nombre_persona FROM Personas WHERE nombre = nombre;

        -- Utilizar el parámetro de salida
        SELECT MAX(edad) INTO edad FROM Personas;

        -- Utilizar el parámetro de entrada/salida
        SET contador = contador + 1;
    END TRY
    BEGIN
        -- Manejo de errores
        DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
        BEGIN
            GET DIAGNOSTICS CONDITION 1 error_occurred = TRUE, error_msg = MESSAGE_TEXT;
        END;
    END;

    -- Manejo de errores
    IF error_occurred THEN
        -- Acciones a realizar cuando se produce un error
        SET error_msg = CONCAT('Error: ', error_msg);
        -- Puedes realizar acciones como registrar el error en una tabla de registro, notificar al administrador, etc.
    END IF;

    -- Devolver resultados
    SELECT edad, contador INTO @edad, @contador;
    SELECT error_msg AS mensaje;
END //

DELIMITER ;

CALL obtener_datos('John Doe', @edad, @contador);
```

## Funciones definidas por el usuario

Las funciones definidas por el usuario en MySQL son bloques de código que se crean para realizar operaciones específicas y devolver un resultado. Estas funciones se pueden utilizar en consultas SQL para simplificar y automatizar tareas.

Las funciones definidas por el usuario se crean utilizando la sintaxis CREATE FUNCTION seguida del nombre de la función, los parámetros de entrada y el cuerpo de la función que contiene la lógica de procesamiento. Estas funciones pueden aceptar parámetros de entrada, realizar cálculos, consultas a la base de datos u otras operaciones y devolver un valor de salida.

- **Reutilización de Código**: Las funciones permiten encapsular lógica y cálculos complejos en un solo lugar. Esto facilita la reutilización del código en múltiples consultas y evita la repetición de código en diferentes partes de la base de datos.

- **Modularidad**: Al dividir la lógica en funciones más pequeñas y específicas, se mejora la modularidad del código. Esto facilita el mantenimiento y la comprensión del código, ya que cada función se centra en una tarea específica.

- **Simplificación de Consultas**: Las funciones pueden simplificar consultas complejas al realizar cálculos o manipulaciones de datos en una sola llamada. Esto reduce la complejidad de las consultas y mejora la legibilidad del código.

- **Mejora del Rendimiento**: Al utilizar funciones, se pueden realizar operaciones de cálculo y manipulación de datos directamente en la base de datos, lo que puede mejorar el rendimiento general de las consultas. Esto evita la necesidad de extraer datos y realizar cálculos en aplicaciones externas.

- **Facilidad de Mantenimiento**: Al encapsular la lógica en funciones, los cambios o actualizaciones en la lógica solo requieren modificaciones en un lugar. Esto simplifica el proceso de mantenimiento y evita posibles errores al actualizar múltiples consultas.

- **Control de Acceso**: Las funciones pueden proporcionar un nivel adicional de control de acceso al permitir que solo ciertos usuarios o roles tengan permiso para ejecutarlas. Esto ayuda a proteger la integridad de los datos y garantiza que las operaciones se realicen según las políticas de seguridad establecidas.

Un ejemplo sencillo de una función definida por el usuario en MySQL que suma dos números:

```sql
CREATE FUNCTION sumar_numeros(a INT, b INT) RETURNS INT
BEGIN
    DECLARE resultado INT;
    SET resultado = a + b;
    RETURN resultado;
END;
```

En este ejemplo, la función sumar_numeros recibe dos parámetros de entrada a y b, realiza la suma de estos dos números y devuelve el resultado. Puedes utilizar esta función en una consulta SQL de la siguiente manera:

```sql
SELECT sumar_numeros(5, 3) AS suma;
```

Esto devolverá el valor 8 como resultado de la función.

El atributo NOT DETERMINISTIC es una opción que se puede agregar al definir una función en MySQL. Indica que la función no es determinista, es decir, que su resultado puede variar incluso si se le proporcionan los mismos valores de entrada en diferentes llamadas.

Cuando se declara una función como no determinista, se informa a MySQL de que la función puede generar resultados diferentes en llamadas consecutivas con los mismos valores de entrada. Esto puede ocurrir cuando una función utiliza datos o recursos externos que pueden cambiar entre llamadas, como valores de fecha y hora actuales, generadores aleatorios u otras fuentes de datos cambiantes.

El uso del atributo NOT DETERMINISTIC tiene implicaciones importantes en la optimización de consultas y la cache de resultados en MySQL. Cuando se marca una función como no determinista, MySQL asume que los resultados de la función pueden cambiar en cada llamada y no realiza optimizaciones como la cache de resultados.

Aquí tienes un ejemplo de cómo se puede usar el atributo NOT DETERMINISTIC al definir una función en MySQL:

```sql
CREATE FUNCTION obtener_fecha_actual() RETURNS DATE
NOT DETERMINISTIC
BEGIN
    RETURN CURDATE();
END;
```

En este ejemplo, la función obtener_fecha_actual devuelve la fecha actual utilizando la función CURDATE(). Como la fecha actual puede cambiar en cada llamada, se declara la función como no determinista.

Las funciones definidas por el usuario en MySQL son herramientas que permiten encapsular lógica y cálculos personalizados dentro de la base de datos. Estas funciones se pueden utilizar en consultas para realizar cálculos matemáticos, manipulación de cadenas de texto, validación de datos y otras operaciones personalizadas.

## Triggers

Los triggers en MySQL son objetos de la base de datos que se ejecutan automáticamente en respuesta a eventos específicos en una tabla, como inserción, actualización o eliminación de registros. Su función es ejecutar instrucciones SQL predefinidas en el momento adecuado para automatizar tareas y aplicar lógica de negocio en la base de datos. Los triggers se utilizan para mejorar la integridad de los datos, realizar validaciones, registrar cambios y automatizar procesos en la base de datos.

La creación de Triggers en MySQL sigue una sintaxis específica. Aquí está el formato general para crear un trigger:

```sql
CREATE TRIGGER nombre_trigger {BEFORE | AFTER} {INSERT | UPDATE | DELETE}
ON nombre_tabla FOR EACH ROW
BEGIN
    -- Código de la lógica del trigger
END;
```

Explicación de los elementos clave:

- **nombre_trigger**: es el nombre que le asignas al trigger.
- **BEFORE o AFTER**: indica si el trigger se ejecuta antes o después de que ocurra el evento en la tabla.
- **INSERT, UPDATE o DELETE**: especifica el tipo de evento al que se vincula el trigger.
- **nombre_tabla**: es el nombre de la tabla en la que se activará el trigger.
- **FOR EACH ROW**: indica que el trigger se ejecutará para cada fila afectada por el evento.
- **BEGIN y END**: encierran el código de la lógica del trigger.

Para editar un trigger existente, se utiliza el comando ALTER TRIGGER. Se puede modificar el nombre, el evento, la tabla o la lógica del trigger según sea necesario.

```sql
ALTER TRIGGER nombre_trigger [BEFORE | AFTER] evento ON nombre_tabla
FOR EACH ROW
BEGIN
    -- Nuevo código de la lógica del trigger
END;
```

Para eliminar un trigger, se utiliza el comando DROP TRIGGER seguido del nombre del trigger.

```sql
DROP TRIGGER nombre_trigger;
```

Para ver la información de un trigger en MySQL, puedes utilizar la siguiente consulta en la base de datos:

```sql
SHOW TRIGGERS LIKE 'nombre_tabla';
```

Observar todos los Triggers de una Base de Datos:

```sql
SHOW TRIGGERS;
```

Los identificadores NEW y OLD se utilizan para acceder a los valores de las filas afectadas durante la ejecución del trigger. Aquí te explico su significado:

- **NEW**: Es un identificador que se utiliza dentro de un trigger para hacer referencia a los valores de la nueva fila que está siendo insertada o actualizada. Puedes acceder a los valores de las columnas de la nueva fila utilizando la sintaxis NEW.nombre_columna.

- **OLD**: Es un identificador que se utiliza dentro de un trigger para hacer referencia a los valores de la fila original antes de ser modificada o eliminada. Se utiliza principalmente en los triggers de actualización y eliminación.

Tenemos una tabla llamada "Empleados" con las siguientes columnas: id, nombre, salario.

```sql
CREATE TRIGGER before_update_empleados
BEFORE UPDATE ON Empleados
FOR EACH ROW
BEGIN
    IF NEW.salario > OLD.salario THEN
        INSERT INTO Registro_aumento_salario (idEmpleado, fecha, aumento)
        VALUES (NEW.id, NOW(), NEW.salario - OLD.salario);
    END IF;
END;
```

En este ejemplo de trigger, se utiliza el identificador NEW para acceder a los nuevos valores de una fila que se está actualizando en la tabla "Empleados". El identificador OLD se utiliza para acceder a los valores originales de la fila antes de la actualización.

En el código, se verifica si el nuevo salario es mayor que el salario anterior. Si esto se cumple, se registra un aumento de salario en la tabla "Registro_aumento_salario". El registro incluye el id del empleado, la fecha actual y la diferencia de salarios.

## Seguridad y permisos

La seguridad y los permisos en MySQL se refieren a las medidas implementadas para proteger la base de datos y controlar el acceso a los datos y funcionalidades del sistema. MySQL ofrece una variedad de mecanismos de seguridad y permisos para garantizar la confidencialidad, integridad y disponibilidad de los datos.

Algunos aspectos importantes de la seguridad y permisos en MySQL son:

- **Autenticación**: MySQL proporciona métodos de autenticación para verificar la identidad de los usuarios antes de permitirles acceder a la base de datos. Esto incluye autenticación basada en contraseñas, autenticación basada en certificados SSL y autenticación basada en plugins.

- **Autorización**: MySQL permite definir permisos y privilegios a nivel de base de datos, tablas y columnas. Los permisos controlan qué acciones pueden realizar los usuarios, como SELECT, INSERT, UPDATE y DELETE. Los privilegios más avanzados incluyen la capacidad de crear tablas, modificar la estructura de la base de datos y administrar usuarios.

- **Encriptación**: MySQL ofrece capacidades de encriptación para proteger la confidencialidad de los datos. Esto incluye encriptación de datos en reposo y en tránsito mediante el uso de conexiones seguras SSL/TLS.

- **Auditoría**: MySQL permite realizar un seguimiento de las actividades realizadas en la base de datos mediante registros de auditoría. Estos registros pueden incluir información sobre intentos de acceso no autorizados, cambios en los datos y otras operaciones relevantes.

- **Gestión de Usuarios**: MySQL proporciona herramientas y comandos para administrar usuarios y sus permisos. Esto incluye la capacidad de crear y eliminar usuarios, cambiar contraseñas y asignar privilegios.

En MySQL, puedes utilizar el siguiente comando para obtener información sobre los usuarios del sistema:

```sql
SELECT * FROM mysql.user;
```

- **Usuario "root"**: Es el usuario administrador por defecto. Tiene todos los privilegios y acceso completo al servidor de MySQL. Por lo general, se utiliza para realizar tareas de administración y configuración.
- **Usuario "mysql.session"**: Es un usuario interno utilizado por el servidor de MySQL para gestionar las conexiones de sesión.
- **Usuario "mysql.sys"**: Es otro usuario interno utilizado por el servidor de MySQL para recopilar y proporcionar información de monitoreo y diagnóstico del sistema.

MySQL ofrece una serie de comandos y herramientas para administrar estos privilegios y usuarios. Algunas de las tareas comunes de administración de privilegios y usuarios en MySQL incluyen:

1. **Crear usuarios**: Puedes crear nuevos usuarios en MySQL utilizando el comando CREATE USER. Por ejemplo:

```sql
CREATE USER 'nombre_usuario'@'host' IDENTIFIED BY 'contraseña';
```

El código anterior se utiliza para crear un nuevo usuario en MySQL. Se especifica un nombre de usuario, un host y una contraseña para autenticación. El usuario creado podrá iniciar sesión y realizar operaciones según los privilegios asignados.

2. **Asignar privilegios**: Puedes asignar privilegios específicos a los usuarios utilizando el comando GRANT. Por ejemplo:

Si el usuario no existe en la base de datos, este se crea. Entonces, también se puede usar el comando GRANT para crear usuarios nuevos en la base de datos. Cuando y existe se asignan o modifican privilegios y accesos a un usuario. En resumen, las 3 partes principales del comando GRANT son:

```sql
GRANT SELECT, INSERT ON nombre_base_datos.* TO 'nombre_usuario'@'host';
FLUSH PRIVILEGES
```

El código GRANT se utiliza para otorgar privilegios a un usuario específico en una base de datos de MySQL. En este caso, se están otorgando los privilegios de SELECT (selección de datos) y INSERT (inserción de datos) en todas las tablas de la base de datos llamada nombre_base_datos. Estos privilegios se asignan al usuario 'nombre_usuario'@'host', lo que significa que el usuario tendrá permisos para realizar estas operaciones desde la ubicación o host especificado.

El comando FLUSH PRIVILEGES en MySQL se utiliza para recargar los privilegios del servidor en tiempo de ejecución. Cuando se realizan cambios en los privilegios de los usuarios, como agregar o eliminar usuarios, otorgar o revocar permisos, el comando FLUSH PRIVILEGES se utiliza para asegurarse de que los cambios sean aplicados de inmediato.

Para permitir la conexión desde cualquier host o dirección IP, se utiliza el símbolo '%'. Por ejemplo:

```sql
GRANT ALL PRIVILEGES ON database.* TO 'usuario'@'%';
```

Para permitir la conexión desde un host específico o una dirección IP, se utiliza la dirección IP o el nombre del host. Por ejemplo:

```sql
GRANT ALL PRIVILEGES ON database.* TO 'usuario'@'255.255.255.255';
```

En este ejemplo, se asignan todos los privilegios disponibles en nombre_base_datos y todas las tablas al usuario "nombre_usuario" desde el host especificado.

```sql
GRANT ALL PRIVILEGES ON nombre_base_datos.* TO 'nombre_usuario'@'host';
```

En este ejemplo, se asignan todos los privilegios disponibles en todas las bases de datos y tablas al usuario "nombre_usuario" desde el host especificado. El asterisco utilizado en `*.*` indica que se aplicará a todas las bases de datos y tablas.

```sql
GRANT ALL PRIVILEGES ON *.* TO 'nombre_usuario'@'host';
```

| Opción   | Significado                                     |
| -------- | ----------------------------------------------- |
| `*.*`    | Todas las bases de datos y todas las tablas     |
| `base.*` | Todas las tablas de la base de datos específica |
| `tabla`  | Tabla específica de la base de datos en uso     |
| `*`      | Todas las tablas de la base de datos en uso     |

Para aplicar el privilegio UPDATE solo a dos campos de la tabla país en MySQL, puedes utilizar la siguiente sintaxis:

```sql
GRANT UPDATE (campo1, campo2) ON nombre_base_datos.nombre_tabla TO 'nombre_usuario'@'host';
```

| Tipo de privilegio      | Operación que permite                                          |
| ----------------------- | -------------------------------------------------------------- |
| all [privileges]        | Otorga todos los privilegios excepto grant option              |
| Usage                   | No otorga ningún privilegio                                    |
| Alter                   | Privilegio para alterar la estructura de una tabla             |
| Create                  | Permite el uso de create table                                 |
| Delete                  | Permite el uso de delete                                       |
| Drop                    | Permite el uso de drop table                                   |
| Index                   | Permite el uso de index y drop index                           |
| Insert                  | Permite el uso de insert                                       |
| Select                  | Permite el uso de select                                       |
| Update                  | Permite el uso de update                                       |
| File                    | Permite el uso de select . . . into outfile y load data infile |
| Process                 | Permite el uso de show full procces list                       |
| Super                   | Permite la ejecución de comandos de supervisión                |
| Reload                  | Permite el uso de flush                                        |
| Replication client      | Permite preguntar la localización de maestro y esclavo         |
| Replication slave       | Permite leer los binlog del maestro                            |
| Grant option            | Permite el uso de grant y revoke                               |
| Shutdown                | Permite dar de baja al servidor                                |
| Lock tables             | Permite el uso de lock tables                                  |
| Show tables             | Permite el uso de show tables                                  |
| Create temporary tables | Permite el uso de create temporary table                       |

Para configurar límites de usuario en MySQL, puedes utilizar las variables de sistema que controlan el uso de recursos por parte de los usuarios. Aquí hay algunas variables clave que puedes ajustar:

1. **max_connections**: Esta variable limita el número máximo de conexiones simultáneas permitidas en el servidor. Puedes establecer un valor adecuado para limitar la cantidad de usuarios que pueden conectarse al mismo tiempo.

Ejemplo:

```sql
SET GLOBAL max_connections = 100;
```

2. **max_user_connections**: Esta variable limita el número máximo de conexiones simultáneas permitidas para un usuario específico. Puedes establecer un valor para cada usuario individualmente.

Ejemplo:

```sql
GRANT USAGE ON *.* TO 'nombre_usuario'@'host' WITH MAX_USER_CONNECTIONS 10;
```

3. **max_questions**: Esta variable limita la cantidad máxima de consultas que un usuario puede hacer durante un período de tiempo determinado. Puedes establecer un valor para limitar la carga de consultas que un usuario puede generar.

Ejemplo:

```sql
GRANT USAGE ON *.* TO 'nombre_usuario'@'host' WITH MAX_QUESTIONS_PER_HOUR 100;
```

4. **max_updates**: Esta variable limita la cantidad máxima de instrucciones de actualización (INSERT, UPDATE, DELETE) que un usuario puede ejecutar durante un período de tiempo determinado. Puedes establecer un valor para limitar la carga de actualizaciones que un usuario puede realizar.

Ejemplo:

```sql
GRANT USAGE ON *.* TO 'nombre_usuario'@'host' WITH MAX_UPDATES_PER_HOUR 50;
```

Tambien se puede utilizar el siguiente comando para establecer los límites de max_user_connections, max_questions y max_updates en una sola consulta:

```sql
GRANT USAGE ON *.* TO 'nombre_usuario'@'host'
WITH MAX_USER_CONNECTIONS 10
MAX_QUESTIONS_PER_HOUR 100
MAX_UPDATES_PER_HOUR 50;
```

Este comando otorgará al usuario nombre_usuario el uso de todas las bases de datos y todas las tablas con los límites especificados: un máximo de 10 conexiones simultáneas, 100 consultas por hora y 50 actualizaciones por hora. Asegúrate de reemplazar 'nombre_usuario' y 'host' con los valores correspondientes para tu caso.

3. **Revocar privilegios**: Puedes revocar privilegios de un usuario utilizando el comando REVOKE. Por ejemplo:

```sql
REVOKE INSERT ON nombre_base_datos.* FROM 'nombre_usuario'@'host';
```

El código REVOKE se utiliza para revocar o quitar los privilegios previamente otorgados a un usuario en una base de datos de MySQL. En este caso, se está revocando el privilegio de INSERT (inserción de datos) en todas las tablas de la base de datos llamada nombre_base_datos. Esta revocación se aplica al usuario 'nombre_usuario'@'host', lo que significa que el usuario ya no tendrá permisos para realizar la operación de inserción de datos en esas tablas desde la ubicación o host especificado.

4. **Eliminar usuarios**: Puedes eliminar usuarios existentes utilizando el comando DROP USER. Por ejemplo:

```sql
DROP USER 'nombre_usuario'@'host';
```

El código DROP USER se utiliza para eliminar un usuario específico de MySQL junto con todos sus privilegios. En este caso, se está eliminando el usuario llamado 'nombre_usuario'@'host'. Esto significa que se eliminarán todas las credenciales de acceso y los privilegios asociados a ese usuario en el servidor de MySQL. Después de ejecutar este código, el usuario ya no podrá iniciar sesión ni realizar ninguna operación en la base de datos.

5. **Ver privilegios de usuarios**: Puedes ver los privilegios asignados a un usuario utilizando el comando SHOW GRANTS. Por ejemplo:

```sql
SHOW GRANTS FOR 'nombre_usuario'@'host';
```

El código SHOW GRANTS FOR se utiliza para mostrar los privilegios otorgados a un usuario específico en MySQL. En este caso, se está consultando los privilegios del usuario 'nombre_usuario'@'host'. Al ejecutar este código, se mostrarán los permisos y privilegios asignados a ese usuario, como SELECT, INSERT, UPDATE, DELETE, entre otros. Esta consulta es útil para verificar los privilegios que tiene un usuario en particular en el servidor de MySQL.

6. **Cambiar contraseñas**: Puedes cambiar la contraseña de un usuario utilizando el comando ALTER USER. Por ejemplo:

```sql
ALTER USER 'nombre_usuario'@'host' IDENTIFIED BY 'nueva_contraseña';
```

El código ALTER USER se utiliza para modificar la contraseña de un usuario existente en MySQL. En este caso, se está modificando la contraseña del usuario 'nombre_usuario'@'host' por la 'nueva_contraseña'. Al ejecutar este código, la contraseña del usuario se actualizará con la nueva contraseña especificada. Esto es útil cuando se necesita cambiar la contraseña de un usuario existente por razones de seguridad o si el usuario olvidó su contraseña y necesita restablecerla.

Para realizar conexiones seguras a MySQL, puedes utilizar el comando mysql con los siguientes parámetros:

- **--ssl-mode**: Este parámetro permite establecer el nivel de seguridad SSL/TLS para la conexión. Puedes utilizar los siguientes valores:

- **DISABLED**: No se utiliza SSL/TLS.
- **REQUIRED**: Se requiere una conexión segura. Si el servidor MySQL no admite SSL/TLS, la conexión no se establecerá.
- **VERIFY_CA**: Se requiere una conexión segura y el servidor MySQL debe tener un certificado válido emitido por una autoridad de certificación confiable.
- **VERIFY_IDENTITY**: Se requiere una conexión segura y el servidor MySQL debe tener un certificado válido emitido por una autoridad de certificación confiable. Además, el nombre del servidor en el certificado debe coincidir con el nombre del servidor al que estás intentando conectarte.

Para requerir una conexión segura mediante un protocolo específico (como SSL/TLS) utilizando el comando GRANT en MySQL, puedes agregar la cláusula REQUIRE SSL al otorgar los privilegios al usuario. Aquí tienes un ejemplo:

```sql
GRANT ALL PRIVILEGES ON base_datos.* TO 'nombre_usuario'@'host' REQUIRE SSL;
```

Tambien se puede requerir una conexión segura mediante un protocolo específico (como SSL/TLS) para un usuario en MySQL, puedes utilizar la siguiente sentencia de SQL:

```sql
ALTER USER 'nombre_usuario'@'host' REQUIRE SSL;
```

Ejemplo de comando para hacer una conexión segura a MySQL con SSL/TLS requerido:

```bash
mysql --ssl-mode=REQUIRED -h hostname -u username -p
```

Reemplaza hostname con el nombre o la dirección IP del servidor MySQL, username con el nombre de usuario y password con la contraseña correspondiente.

La seguridad y los permisos en MySQL son fundamentales para garantizar la protección y el control adecuado de los datos. Es importante implementar buenas prácticas de seguridad y seguir las recomendaciones de MySQL para proteger la base de datos contra amenazas potenciales.
