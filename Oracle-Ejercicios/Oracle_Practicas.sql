/*DDL*/

CREATE TABLE empresas(
    id_empresa          NUMBER CONSTRAINT id_empresa_pk PRIMARY KEY,
    nombre              VARCHAR2(10),
    localización        VARCHAR2(10)
)

CREATE TABLE departamentos(
    id_departamento     NUMBER CONSTRAINT id_departamento PRIMARY KEY,
    nombre              VARCHAR2(10),
    numero_trabajadores NUMBER,
    id_empresa          NUMBER CONSTRAINT id_empresa_fk REFERENCES  empresas(id_empresa)

)

CREATE TABLE empleados(
    id_empleado         NUMBER,
    nombre              VARCHAR2(10),
    apellidos           VARCHAR2(20),
    fecha_contratación  DATE,
    salario             NUMBER,
    email               VARCHAR(10) CONSTRAINT email_uk UNIQUE,
    id_departamento     NUMBER,
    CONSTRAINT id_empleado_pk PRIMARY KEY (id_empleado),
    CONSTRAINT id_departamento_fk FOREIGN KEY (id_departamento) REFERENCES departamentos(id_departamento)
)

ALTER TABLE empleados MODIFY salario NUMBER CONSTRAINT salario_nn NOT NULL;

ALTER TABLE empleados MODIFY email VARCHAR(20) CONSTRAINT email_uk UNIQUE;

ALTER TABLE empleados DROP (email);

DROP TABLE empleados;
DROP TABLE empleados PURGE;


TRUNCATE TABLE empleados;

/*DML*/

INSERT INTO empresas VALUES(1,'Altia', 'Oleiros');
INSERT INTO empresas VALUES(2,'Corunet', 'Coruña');
INSERT INTO empresas VALUES(3,'Inditex', 'Arteixo');
INSERT INTO empresas VALUES(4,'Odesia', 'Coruña');
INSERT INTO empresas VALUES(5,'Plexus', 'Santiago');

INSERT INTO departamentos VALUES(1,'Seguridad', 5, 2);
INSERT INTO departamentos VALUES(2,'Desarrollo', 8, 1);
INSERT INTO departamentos VALUES(3,'Front-End', 40, 4);
INSERT INTO departamentos VALUES(4,'Back-End', 4, 3);
INSERT INTO departamentos VALUES(5,'Sistemas', 55, 5);
INSERT INTO departamentos VALUES(6,'Redes', 25, 2);

INSERT INTO empleados VALUES(1,'Pedro','Garcia',5000,5,'email@correo.com');
INSERT INTO empleados VALUES(2,'Carmen','Perez',3000,2,'practica@correo.com');
INSERT INTO empleados VALUES(3,'Luis','Mendez',1000,1,'ejemplo@correo.com');
INSERT INTO empleados VALUES(4,'Verónica','Olano',2500,4,'adios@correo.com');
INSERT INTO empleados VALUES(5,'Raquel','Tevez',4000,3,'hola@correo.com');
INSERT INTO empleados VALUES(6,'Pablo','Rodriguez',5000,null,'hola2@correo.com');


UPDATE empleados SET nombre='Joaquin' WHERE id_empleado=2;

DELETE FROM empleados WHERE id_empleado=2;


/*DML-TCL*/

COMMIT;
SAVE POINT;
ROLLBACK;
ROLLBACK TO SAVE POINT;

/*JOINING TABLES*/


/*NATURAL JOIN*/

select * from empleados NATURAL JOIN departamentos;

/*USING CLAUSE*/
SELECT e.nombre, d.nombre, d.numero_trabajadores
    FROM empleados e JOIN departamentos d
        USING (id_departamento);

/*ON CLAUSE*/
SELECT e.nombre, d.nombre, d.numero_trabajadores
    FROM empleados e JOIN departamentos d
        ON (e.id_departamento=d.id_departamento);

/*ON CLAUSE- 3 Tables*/
SELECT e.nombre, d.nombre, d.numero_trabajadores, em.localización
    FROM empleados e JOIN departamentos d
        ON (e.id_departamento=d.id_departamento)
            JOIN empresas em
                ON(d.id_empresa=em.id_empresa);

/*LEFT OUTER JOIN*/
SELECT e.nombre, d.nombre, d.numero_trabajadores
    FROM empleados e LEFT OUTER JOIN departamentos d
        ON (e.id_departamento=d.id_departamento);

/*RIGHT*/
SELECT e.nombre, d.nombre, d.numero_trabajadores
    FROM empleados e RIGHT OUTER JOIN departamentos d
        ON (e.id_departamento=d.id_departamento);

/*FULL*/
SELECT e.nombre, d.nombre, d.numero_trabajadores
    FROM empleados e FULL OUTER JOIN departamentos d
        ON (e.id_departamento=d.id_departamento);


SELECT e.nombre, d.numero_trabajadores
    FROM empleados e CROSS JOIN departamentos d;

/*Tabla para probar números*/
CREATE TABLE prueba_numero(
    numero NUMBER(8,2)
)

INSERT INTO prueba_numero VALUES(25);
INSERT INTO prueba_numero VALUES(12345678);/*Error: tiene que haber 2 decimales al menos*/
INSERT INTO prueba_numero VALUES(123456.786);/*Redondea a .79*/
INSERT INTO prueba_numero VALUES(123456.785);/*Redondea a .79*/
INSERT INTO prueba_numero VALUES(123456.784);/*Redondea a .78*/
INSERT INTO prueba_numero VALUES(null);

ALTER TABLE prueba_numero ADD _letra VARCHAR(20);/*_letra no válido*/

/*Puebas alias*/

SELECT numero || 'Numero' as "Numero" FROM prueba_numero;/*Query valido*/
SELECT numero || 'Numero' "Numero" FROM prueba_numero;/*Query valido*/
SELECT numero || 'Numero' Numero FROM prueba_numero;/*Query valido*/

/*NULL devoluciones*/

select ((10 + 20) * 50) + null from prueba_numero;/*Returns null. There are numbers*/
select 'this is a '||null||'test with nulls' from prueba_numero;/*Do not return null. There are not numbers*/
select null/0 from prueba_numero;/*Returns null. There are numbers*/
select null||'test'||null as “Test” from prueba_numero;/*Do not return null. There are not numbers*/

/*NULL uso*/

SELECT * FROM prueba_numero WHERE numero IS NULL;/*OK*/
SELECT * FROM prueba_numero WHERE numero = NULL;/*NOK*/


/*'*/

select 'Coda''s favorite fetch toy is his orange ring' from prueba_numero;/*OK*/
select 'Coda's favorite fetch toy is his orange ring' from prueba_numero;/*NOK*/
select ''Coda''s favorite fetch toy is his orange ring' from prueba_numero;/*NOK*/


/*There are four rows of data in the REGIONS table. Consider the following SQL statement:
SELECT '6 * 6' “Area” FROM REGIONS;
How many rows of results are returned and what value is returned by the Area column? 
 4 rows returned, Area column contains value 6 * 6 for all 4 rows
*/

/*Equivalent expresions*/
A. WHERE SALARY <=5000 AND SALARY >=2000
C. WHERE SALARY BETWEEN 2000 AND 5000
D. WHERE SALARY > 1999 AND SALARY < 5001


/*The terms specified in an ORDER BY clause can include column names, positional 
sorting, numeric values, and expressions.*/

/*Order by*/

SELECT nombre, apellidos, salario FROM empleados
ORDER BY 3 DESC, 2 ASC NULLS LAST;

/*CHAR*/

ALTER TABLE prueba_numero ADD letra5 CHAR(5);

INSERT INTO prueba_numero VALUES(25, 'Hola' || ' Que tal ', 'poiuyp' );


Como veo que de momento se pueden añadir documentos y no se si has recibido los mensajes, voy a incluir los documentos firmados y escaneados.
Un saludo