# Introducción MySQL

- [Características](#introducción-mysql)
- [Ventajas](#ventajas-de-mysql)
- [Historia](#historia-de-mysql)
- [Clientes](#clientes-de-mysql)

## Características de MySQL

- **Arquitectura Cliente y Servidor**: En MySQL, la arquitectura cliente-servidor implica que el cliente se conecta al servidor para realizar operaciones en la base de datos. El servidor gestiona la base de datos y procesa las solicitudes del cliente, mientras que el cliente es la interfaz a través de la cual los usuarios interactúan con la base de datos.

- **Compatibilidad con SQL**: MySQL es compatible con el lenguaje estándar de consulta estructurada (SQL), lo que facilita la migración de datos desde y hacia MySQL u otras bases de datos SQL. Puedes utilizar tus consultas y comandos SQL existentes en MySQL sin realizar cambios significativos. MySQL también ofrece herramientas de migración para facilitar la transferencia de datos desde otros sistemas a MySQL, lo que lo hace una opción conveniente para migraciones futuras.

- **Procedimientos almacenados**: Los procedimientos almacenados en MySQL son bloques de código SQL que se guardan en el servidor y se pueden invocar desde aplicaciones o directamente en la base de datos. Permiten estructurar y reutilizar código, mejorando el rendimiento y la seguridad de las operaciones. Se utilizan sentencias como CREATE PROCEDURE y CALL para su definición e invocación.

- **Desencadenantes**: Los desencadenantes en MySQL son objetos de base de datos que se ejecutan automáticamente en respuesta a eventos específicos, como la inserción, actualización o eliminación de datos en una tabla. Permiten ejecutar lógica personalizada antes o después del evento, brindando mayor control y automatización en la manipulación de datos. Son útiles para implementar reglas de negocio y mantener la integridad de los datos.

- **Transacciones**: Las transacciones en MySQL son conjuntos de operaciones que se ejecutan como una unidad indivisible, garantizando la integridad y consistencia de los datos. Permiten agrupar cambios en la base de datos, asegurando que todas las operaciones se completen con éxito o se deshagan si alguna falla. Se utilizan las sentencias BEGIN, COMMIT y ROLLBACK para controlar el inicio, confirmación o cancelación de una transacción.

## Ventajas de MySQL

MySQL ofrece ventajas como escalabilidad, alto rendimiento, flexibilidad, soporte comunitario, seguridad, replicación, disponibilidad, bajo costo y compatibilidad con otros lenguajes y herramientas. Es ampliamente utilizado debido a su rendimiento rápido, su capacidad para manejar grandes volúmenes de datos y su facilidad de integración en diferentes entornos. Además, su comunidad activa brinda soporte y recursos adicionales.

## Historia de MySQL

MySQL se originó en 1994 y se lanzó públicamente en 1995. Ha sido desarrollado por Michael Widenius y David Axmark. En 2000, MySQL AB fue fundada para brindar servicios comerciales y soporte. Sun Microsystems adquirió MySQL AB en 2008, y luego Oracle Corporation adquirió Sun en 2010. MySQL ha evolucionado con múltiples versiones, siendo MySQL 8.0 lanzado en 2019. Ha ganado popularidad por su rendimiento, escalabilidad y facilidad de uso, y es ampliamente utilizado en diferentes aplicaciones y empresas.

## Clientes de MySQL

| Nombre          | S.O                   | Licencia  | Lenguaje de Desarrollo | Descripción                                                                                         | Tutorial/Descarga                                                          |
| --------------- | --------------------- | --------- | ---------------------- | --------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------- |
| MySQL Workbench | Windows, macOS, Linux | Comercial | C/C++                  | MySQL Workbench es una herramienta gráfica de administración y diseño de bases de datos MySQL.      | [Enlace al tutorial/descarga](https://www.youtube.com/watch?v=nv9GCue0YwM) |
| phpMyAdmin      | Multiplataforma       | GPL       | PHP                    | phpMyAdmin es una aplicación web de código abierto escrita en PHP.                                  | [Enlace al tutorial/descarga](https://www.youtube.com/watch?v=36ritPuyd00) |
| Navicat         | Windows, macOS, Linux | Comercial | C/C++                  | Navicat es una herramienta de administración de bases de datos con soporte para múltiples sistemas. | [Enlace al tutorial/descarga](https://www.youtube.com/watch?v=vDugMMcP5xY) |
| HeidiSQL        | Windows               | GPL       | Delphi                 | HeidiSQL es una herramienta de administración de bases de datos MySQL.                              | [Enlace al tutorial/descarga](https://www.youtube.com/watch?v=UB9oPDDlvcI) |
