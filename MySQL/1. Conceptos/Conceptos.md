# Conceptos Generales de Base de Datos

- [Base de datos](#que-es-una-base-de-datos)
- [Sistema de gestión de bases de datos (SGBD)](#que-es-un-sistema-de-gestión-de-bases-de-datos-sgbd)
- [Tabla](#que-es-una-tabla)
- [Tupla](#que-es-una-tupla)
- [Atributo](#que-es-un-atributo)
- [Relación](#que-es-una-relación)
- [Claves (Key)](#que-son-las-claves-key)
- [Modelo entidad relación](#que-es-el-modelo-entidad-relación)
- [Modelo relacional](#que-es-el-modelo-relacional)
- [Formas normales](#formas-de-normalización)

## Que es una Base de Datos

Una base de datos es una colección estructurada de datos que se organizan y almacenan de manera eficiente en un sistema de gestión de bases de datos. Proporciona una forma centralizada y coherente de almacenar información para su posterior uso.

## Que es un Sistema de gestión de bases de datos (SGBD)

Es un software que permite administrar y manipular bases de datos. Proporciona una interfaz para interactuar con los datos, asegura la integridad y seguridad de la información, y gestiona las consultas y transacciones.

## Que es una Tabla

En una base de datos relacional, una tabla es una estructura que organiza los datos en filas y columnas. Cada columna representa un atributo o característica de los datos.

## Que es una Tupla

Una tupla se refiere a un conjunto de valores que representan una fila individual en una tabla. En el contexto de una base de datos relacional, una tupla es equivalente a un registro o una entidad específica dentro de una tabla.

## Que es un Atributo

Un atributo se refiere a una columna específica dentro de una tabla. También se le conoce como campo o propiedad. Cada atributo almacena un tipo de datos particular y representa una característica o información específica de los registros en la tabla.

## Que es una Relación

Una relación establece la conexión lógica entre dos o más tablas en una base de datos relacional. Se basa en claves primarias y claves externas para representar las asociaciones entre los registros de diferentes tablas.

## Que son las Claves (Key)

| Tipos                      | Descripcion                                                                                                                                                                                                                                                                    |
| :------------------------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Superclave**             | Una superclave es un conjunto de uno o más atributos que pueden identificar de forma única cada registro dentro de una tabla.                                                                                                                                                  |
| **Primaria (Primary Key)** | Una clave primaria es un atributo o conjunto de atributos que identifica de forma única cada registro en una tabla. Proporciona integridad y coherencia en la base de datos, permite un acceso eficiente a los datos y facilita el establecimiento de relaciones entre tablas. |
| **Externa (Foreign Key)**  | Una clave externa es un atributo o conjunto de atributos en una tabla que establece una relación con la clave primaria de otra tabla. Sirve para vincular y mantener la integridad referencial entre las tablas relacionadas.                                                  |

### Algunas Reglas de las claves

1. **Clave Primaria (Primary Key)**

- Debe ser única: Cada valor de la clave primaria debe ser único en la tabla.
- No nulidad: La clave primaria no puede contener valores nulos.
- Inmutabilidad: Los valores de la clave primaria no deben cambiar después de que se inserte un registro en la tabla.

2. **Clave Externa (Foreign Key)**

- Debe hacer referencia a una clave primaria existente: La clave externa debe hacer referencia a la clave primaria de otra tabla.
- Debe mantener la integridad referencial: Los valores de la clave externa deben coincidir con los valores existentes en la clave primaria referenciada.
- Puede ser nula o tener un valor válido: Una clave externa puede tener un valor nulo si se permite en la definición, lo que indica una relación opcional.

## Que es el Modelo Entidad Relación

El Modelo Entidad-Relación es un modelo conceptual utilizado para describir la estructura lógica de una base de datos. Se basa en la representación de entidades, atributos y relaciones entre entidades.

- **Entidad**: Una entidad representa un objeto o concepto del mundo real, como una persona, un lugar o un objeto. Se representa como una tabla en la base de datos.
- **Atributo**: Un atributo es una característica o propiedad de una entidad. Por ejemplo, para una entidad "Persona", los atributos pueden ser "Nombre", "Edad" o "Dirección".
- **Relación**: Una relación establece una conexión lógica entre dos o más entidades. Puede ser una relación uno a uno, uno a muchos o muchos a muchos. Por ejemplo, una entidad "Cliente" puede tener una relación uno a muchos con una entidad "Pedido".
- **Cardinalidad**: Una relación establece una conexión lógica entre dos o más entidades. Puede ser una relación uno a uno, uno a muchos o muchos a muchos. Por ejemplo, una entidad "Cliente" puede tener una relación uno a muchos con una entidad "Pedido".
- **Tipos de relación**: existen diferentes tipos de relaciones que se pueden establecer entre tablas en una base de datos relacional. Aquí están los tipos más comunes de relaciones:

| Tipo de Relación         | Descripción                                                                                                                                                      |
| ------------------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Relación Uno a Uno       | Cada registro en una tabla se asocia con un único registro en otra tabla mediante una clave externa. Por ejemplo, una tabla "Persona" tiene una única dirección. |
| Relación Uno a Muchos    | Cada registro en una tabla se asocia con varios registros en otra tabla mediante una clave externa. Por ejemplo, un departamento puede tener varios empleados.   |
| Relación Muchos a Muchos | Varios registros en una tabla se asocian con varios registros en otra tabla mediante una tabla de unión. Por ejemplo, productos pueden estar en varios pedidos.  |

El Modelo ER se utiliza como una herramienta para el análisis y el diseño de bases de datos antes de su implementación en un Modelo Relacional.

## Que es el Modelo Relacional

El Modelo Relacional es un modelo de datos que utiliza tablas para organizar y representar los datos en una base de datos. Se basa en la teoría de conjuntos y la lógica matemática.

- **Tabla**: En el Modelo Relacional, los datos se organizan en tablas con filas y columnas. Cada tabla representa una entidad y cada fila representa un registro único, mientras que las columnas representan los atributos.
- **Clave Primaria**: En el Modelo Relacional, se utiliza una clave primaria para identificar de manera única cada registro en una tabla. La clave primaria puede ser un atributo o una combinación de atributos.
- **Clave Externa**: Una clave externa se utiliza para establecer relaciones entre tablas. Es una referencia a la clave primaria de otra tabla.

El Modelo Relacional es ampliamente utilizado y es el modelo predominante en la mayoría de los sistemas de gestión de bases de datos (SGBD) relacionales, como MySQL, PostgreSQL y Oracle.

## Formas de Normalización

La normalización es un proceso utilizado en el diseño de bases de datos relacionales para organizar los datos de manera eficiente y evitar problemas de redundancia e inconsistencia. Se basa en reglas específicas que buscan lograr una estructura bien organizada y relaciones claras entre las tablas. A continuación, se presentan los principales tipos de normalización que se utilizan:

1. **Primera Forma Normal (1NF)**: Se busca eliminar la redundancia y garantizar que cada columna contenga valores individuales y únicos. Cada registro debe tener un identificador único.

2. **Segunda Forma Normal (2NF)**: Se busca eliminar la dependencia parcial de los datos. Los atributos no clave deben depender completamente de la clave primaria.

3. **Tercera Forma Normal (3NF)**: Se busca eliminar la dependencia transitiva de los datos. Los atributos no clave no deben depender de otros atributos no clave.

Normalmente ya que se considera que una base de datos está bien diseñada si cumple por lo menos 3 formas normales. [Ejemplo](./normalizacion.sql)

4. **Cuarta Forma Normal (4NF)**: Se busca eliminar las dependencias multivaluadas. Los atributos no clave no deben depender de conjuntos de valores de otros atributos no clave.

5. **Quinta Forma Normal (5NF)**: Se busca eliminar las dependencias de unión. No debe haber ninguna dependencia de unión entre conjuntos de atributos que no estén relacionados directamente a través de una clave primaria o clave externa.

El objetivo de aplicar estas formas normales es crear una estructura de base de datos bien organizada que mejore la eficiencia del sistema, facilite el mantenimiento de los datos y proporcione una base sólida para consultas y manipulación de datos. Al seguir las reglas de normalización, se evitan problemas como la actualización inconsistente y la pérdida de integridad en los datos.
