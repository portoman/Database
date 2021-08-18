Ejercicio 1:

CREATE TABLE profesores(

    profesor_nif NCHAR(9) CONSTRAINT profesor_pk PRIMARY KEY,
    nombre VARCHAR(15),
    apellido_1 VARCHAR(15),
    apellido_2 VARCHAR(15),
    direccion VARCHAR(20),
    titulacion VARCHAR(20),
    salario NUMBER(6,2)
);

CREATE TABLE cursos(
    codigo VARCHAR(15) CONSTRAINT curso_pk PRIMARY KEY,
    nombre VARCHAR (20) UNIQUE,
    total_plazas NUMBER(3),
    fecha_inicio DATE,
    fecha_fin DATE, 
    CONSTRAINT fecha_constraint CHECK (fecha_inicio<fecha_fin),
    duracion NUMBER(3),
    profesor_nif NCHAR(9) NOT NULL,
    CONSTRAINT profesor_fk FOREIGN KEY (profesor_nif) REFERENCES profesores(profesor_nif) 
);

CREATE TABLE alumnos(
    nif NCHAR(9) CONSTRAINT alumno_pk PRIMARY KEY,
    nombre VARCHAR(15),
    apellido_1 VARCHAR(15),
    apellido_2 VARCHAR(15),
    direccion VARCHAR(20),
    sexo CHAR(1) CONSTRAINT sexo_constraint CHECK(sexo='F' OR sexo='M'),
    curso VARCHAR(15),
    CONSTRAINT alumno_fk FOREIGN KEY (curso) REFERENCES cursos(codigo)
)

#1. Añade un nuevo atributo llamado EDAD de tipo numérico a la tabla ALUMNOS 
(las edades deberán estar comprendidas entre 14 y 65 años)

ALTER TABLE alumnos ADD edad NUMBER (2) CONSTRAINT edad_constraint CHECK(edad>=14 AND edad <=65);

#2. Modifica el campo Número de horas del curso de manera que solo pueda haber cursos con 
30, 40, o 60 horas

ALTER TABLE cursos ADD CONSTRAINT num_horas_constraint CHECK(duracion IN(30,40,60));

#3. Elimina la restricción que controla los valores que puede tomar el atributo SEXO

ALTER TABLE alumnos DROP CONSTRAINT sexo_constraint;

#4. Elimina la columna DIRECCION de la tabla PROFESORES

ALTER TABLE profesores DROP COLUMN direccion;

#5. Cambia el nombre a la tabla PROFESORES por TUTORES

RENAME profesores TO tutores;

#6. Elimina la tabla ALUMNOS

DROP TABLE alumnos;

#7. Elimina la restricción de clave primaria de la tabla CURSOS

ALTER TABLE  cursos DROP PRIMARY KEY CASCADE;

#8. Haz que la clave primaria de CURSOS sea CODIGO+FECHA_INICIO

ALTER TABLE cursos ADD CONSTRAINT cursos_pk PRIMARY KEY (codigo, fecha_inicio);

#9. Cambia la clave primaria de la tabla PROFESORES por Nombre y Apellidos

ALTER TABLE tutores DROP PRIMARY KEY CASCADE;
ALTER TABLE tutores ADD CONSTRAINT tutores_pk PRIMARY KEY(nombre, apellido_1, apellido_2);