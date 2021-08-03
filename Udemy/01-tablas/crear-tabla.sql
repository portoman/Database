/*
int(nº cifras)                ENTERO
integer(nº cifras)            ENTERO (máximo 4294967295)
varchar(nº caracteres)        STRING/ ALFANUMÉRICO (máximo 255)
char(nº caracteres)           STRING/ ALFANUMÉRICO
float(nºcifras, nºdecimales)  DECIMAL/ COMA FLOTANTE
date, time, timestamp

//STRINGS MÁS GRANDES
TEXT            65535 caracteres
MEDIUMTEXT      16 millones de caracteres
LONGTEXT        4 billones de caracteres

//ENTEROS MÁS GRANDES
MEDIUMINT
BIGINT

*/
# CREAR BASE DE DATOS #
CREATE DATABASE perros;

# MOSTRAR BASES DE DATOS #
SHOW DATABASES;

# BORRAR BASE DE DATOS #
DROP DATABASE perros;

/* CREAR TABLA
 */


CREATE TABLE usuarios (
id          int (11) auto_increment not null,
nombre      varchar(100) not null,
apellidos   varchar(255) default 'hola que tal',
email       varchar(100) not null,
password    varchar(255),
CONSTRAINT pk_usuarios PRIMARY KEY(id)
);

/* BORRAR TABLA
 */

DROP TABLE usuarios;
