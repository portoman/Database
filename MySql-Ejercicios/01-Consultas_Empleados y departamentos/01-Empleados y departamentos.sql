# DiscoDurodeRoer - Youtube


CREATE DATABASE sqlYoutube;

USE sqlYoutube;

CREATE TABLE departamentos(
id                  int(4) auto_increment not null,
nombre              varchar(20) not null,
ciudad              varchar(15) not null,
cod_Director        varchar(12) not null,
CONSTRAINT pk_departamentos PRIMARY KEY (id)
)ENGINE=InnoDb;


CREATE TABLE empleados(
id                  int(12) auto_increment not null,
jefe_id             int(12),
cod_Depto           int(4) not null,
nombre              varchar(30) not null,
sexo                char(1) not null,
fecha_nacimiento    date,
fecha_incorporacion date,
salario             float(10,2) not null,
comision            float(10,2),
cargo               varchar(15) not null,
CONSTRAINT      pk_empleados                    PRIMARY KEY (id),
CONSTRAINT      fk_empleados_departamentos      FOREIGN KEY(cod_Depto)       REFERENCES departamentos(id),
CONSTRAINT      fk_empleados_jefe               FOREIGN KEY(jefe_id)         REFERENCES empleados(id)
)ENGINE=InnoDb;

# Insertar # 

INSERT INTO departamentos VALUES(null, "Calidad","Valencia", "Pablo");
INSERT INTO departamentos VALUES(null, "Produccíon","Barcelona", "David");
INSERT INTO departamentos VALUES(null, "Procesos","Logroño", "Sonia");
INSERT INTO departamentos VALUES(null, "Logística","Coruña", "Maria");
INSERT INTO departamentos VALUES(null, "Informática","Ferrol", "Suso");

ALTER TABLE empleados MODIFY comision float(10,2);

INSERT INTO empleados VALUES(null, null, 2, "Alfonso","H", "1985-05-04", "2010-08-07", 30000, null, "Developer");
INSERT INTO empleados VALUES(null, 1,1, "Lurdes","M", "1983-05-04", "2010-01-07", 40000, 20, "Planificadora");
INSERT INTO empleados VALUES(null, 2,3, "Pablo","H", "1989-04-24", "2008-01-07", 20000, 20, "Operario");
INSERT INTO empleados VALUES(null, 3,2, "Marcos","H", "1989-05-14", "2010-01-07", 30000, 40, "Portero");
INSERT INTO empleados VALUES(null, 3,2, "Miguel","H", "1989-05-14", "2010-01-07", 30000, 400000, "Jefe de taller");
INSERT INTO empleados VALUES(null, 3,2, "Sonia","M", "1989-05-14", "2010-01-07", 20000, 450000, "Jefe de taller");
INSERT INTO empleados VALUES(null, 3,2, "Paco","H", "1988-05-14", "2010-01-08", 30000, 450000, "Jefe de taller");
INSERT INTO empleados VALUES(null, 3,2, "Sara","M", "1987-05-14", "2010-01-07", 40000, 40000, "Secretaria");
INSERT INTO empleados VALUES(null, 2,2, "Benito","H", "1985-05-14", "2010-01-07", 10000, 40000, "Mozo de almacén");
INSERT INTO empleados VALUES(null, 2,1, "Raquel","H", "1987-05-14", "2010-01-07", 10000, 40000, "Administrativa");
INSERT INTO empleados VALUES(null, 2,1, "Pedro","H", "1985-05-14", "2010-01-07", 20000, 30000, "Jefe de taller");



# 1/2. Obtener los datos completos de los empleados y departamentos.

SELECT * FROM empleados;
SELECT * FROM departamentos;

# 3. Obtener los cargos de los empleados con cargo "Operario"

 SELECT * FROM empleados WHERE cargo="Operario";

# 4. Obtener el nombre y el salario de los empleados

SELECT nombre, salario FROM empleados;

# 5. Obtener los datos de los empleados Portero, ordenado por nombre

SELECT nombre FROM empleados WHERE cargo="Portero" ORDER BY nombre;

# 6. Listar el nombre de los departamentos

SELECT nombre FROM departamentos;

#  7. Obtener el nombre y cargo de todos los empleados, ordenado por salario

SELECT nombre, cargo FROM empleados ORDER BY salario;

# 8. Listar los salarios y comisiones de los empleados del departamento Producción, #
# ordenado por comisión                                                             #

SELECT e.salario, e.comision FROM empleados e
    INNER JOIN departamentos d ON d.id=e.cod_Depto WHERE d.nombre="Produccion";

# 9.Listar todas las comisiones

SELECT comision FROM empleados;

# 10. Obtener el valor total a pagar que resulta de sumar a los empleados del departamento
# Produccion + una bonificación de 40000

SELECT SUM(e.salario)+40000, d.nombre FROM empleados e
    INNER JOIN departamentos d ON d.id=e.cod_Depto GROUP BY d.nombre 
        HAVING d.nombre="Produccion";

# 11. Obtener la lista de los empleados que ganan una comisión superior a su sueldo

SELECT * FROM empleados WHERE comision>salario;

# 12. Listar los empleados cuya comisión es menor o igual que el 30% de su sueldo

SELECT * FROM empleados WHERE comision<=(0.3*salario);


# 13. Elabore un listado donde para cada fila, figure 'Nombre' y 'Cargo' antes del valor respectivo para cada empleados

SELECT CONCAT("Nombre ", nombre) AS "CONVERSION1", CONCAT("Cargo ", cargo) AS "CONVERSION2" FROM empleados;

# 14. Hallar el salario y la comisión de aquellos empleados cuyo número de idEmpleado sea superior a 2000

ALTER TABLE empleados ADD idEmpleado int(10) not null;
UPDATE empleados SET idEmpleado =500 WHERE id=4;
UPDATE empleados SET idEmpleado =600 WHERE id=5;


SELECT salario, comision FROM empleados WHERE idEmpleado>=200;

# 15. Mostrar los empleados cuyos nombres empiecen por la letra 'M' y terminen por la letra 'L'

SELECT nombre FROM empleados WHERE nombre LIKE "M%" AND nombre LIKE "%L";

# 16. Listar el salario, la comisión, el salario total (salario+comision), documento de identidad del empleado y nombre,
de aquellos empleados que tienen comision superior a 30, ordenar el informe por el numero de idEmpleado

SELECT salario, comision, (salario+comision) "Salario total", idEmpleado, nombre from empleados WHERE comision>30 ORDER BY idEmpleado DESC;

# 17. Obtener un listado igual al anterior, pero de aquellos empleados que no tengan comisión

SELECT salario, comision, (salario+comision) "Salario total", idEmpleado, nombre from empleados WHERE comision IS NULL ORDER BY idEmpleado DESC;

#18. Hallar los empleados cuyo nombre no contiene la cadena "MA"

SELECT nombre FROM empleados WHERE nombre NOT LIKE "MA%";

#19. Obtener los nombres de los departamentos que no sean "Calidad" ni "Procesos" ordenados por ciudad;

SELECT nombre, ciudad from departamentos WHERE nombre!="Calidad" AND nombre!="Procesos" ORDER BY ciudad DESC;

# Multitablas #

# 20. Obtener el nombre y el departamento de los empleados con cargo "Operario" o "Portero", 
# que no trabajen en el departamento de "Procesos"

SELECT e.nombre, d.nombre, e.cargo
    FROM empleados e, departamentos d
        WHERE e.cod_Depto=d.id AND e.cargo IN (SELECT cargo FROM empleados WHERE cargo="Portero" OR cargo="Operario")
            AND d.nombre !="Procesos";


# 21. Obtener info de los empleados que tienen exactamente 7 caracteres

SELECT nombre FROM empleados WHERE LENGTH(nombre)=7;

# 22. Obtener info de los empleados que tienen al menos 5 caracteres

SELECT nombre FROM empleados WHERE LENGTH(nombre)>=6;

# 23. Listar los datos de los empleados cuyo nombre empieza por  "M", 
su sueldo es mayor que 20000 o recibe comisión

SELECT e.nombre , d.nombre
    FROM empleados e, departamentos d
        WHERE e.cod_Depto=d.id 
            AND e.nombre LIKE "M%"
                AND e.salario>20000;

#24. Sacar los nombres y comisiones de los empleados que reciben un salario entre 25 y 35k

SELECT nombre, comision, salario FROM empleados WHERE salario BETWEEN 25000 AND 35000;

#25. Mostrar el salario más alto de la empresa

SELECT MAX(salario) FROM empleados;

#26. Mostrar cada una de las comisiones y el número de empleados que las reciben. Solo si tienen comisión

SELECT COUNT(nombre), comision FROM empleados  WHERE comision IS NOT NULL GROUP BY comision;

#27. Mostrar el nombre del último empleado de la lista por orden alfabético

SELECT nombre FROM empleados ORDER BY nombre DESC LIMIT 1;

#28. Hallar el salario más alto, el más bajo y la diferencia entre ellos

SELECT MAX(salario), MIN(salario), MAX(salario)-MIN(salario) "Diferencia" FROM empleados;

#29. Mostrar el número de empleados de sexo femenino y masculino, por departamento

SELECT COUNT(e.nombre), e.sexo, d.nombre
    FROM empleados e, departamentos d
        WHERE e.cod_Depto=d.id GROUP BY sexo,d.nombre; 

#30. Mostrar el salario promedio por departamento

SELECT AVG(e.salario),d.nombre
    FROM empleados e, departamentos d
        WHERE e.cod_Depto=d.id GROUP BY d.nombre;

#31. Mostrar la lista de empleados cuyo salario es mayor o igual que el promedio
de la empresa. Ordenarlo por departamento.

SELECT e.nombre, e.salario, d.nombre
    FROM empleados e, departamentos d
        WHERE e.cod_Depto=d.id  AND salario>(SELECT AVG(salario) FROM empleados) ORDER BY d.nombre;

#32. Mostrar los departamentos que tienen más de 3 empleados. Mostrar el número de empleados de esos departamentos

SELECT COUNT(e.nombre), d.nombre
    FROM empleados e, departamentos d
        WHERE e.cod_Depto=d.id  GROUP BY(d.nombre) HAVING COUNT(e.nombre)>=3;

#33. Mostrar el código y nombre de cada jefe, junto al número de empleados que dirige.

SELECT j.nombre "Jefe", count(*)
    FROM empleados e, empleados j
        WHERE e.jefe_id=j.id GROUP BY j.nombre;

#34. Mostrar los departamentos que no tienen empleados

SELECt nombre FROM departamentos
    WHERE id NOT IN(SELECT cod_Depto FROM empleados);

#35. Mostrar el nombre del departamento cuya suma de salarios sea la más alta, indicando el valor

SELECT SUM(e.salario), d.nombre 
    FROM empleados e, departamentos d
        WHERE e.cod_Depto=d.id GROUP BY d.nombre ORDER BY d.nombre DESC LIMIT 1;

