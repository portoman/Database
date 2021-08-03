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

ALTER TABLE empleados MODIFY comision float(10,2);

INSERT INTO empleados VALUES(null, null, 2, "Alfonso","H", "1985-05-04", "2010-08-07", 30000, null, "Developer");
INSERT INTO empleados VALUES(null, 1,1, "Lurdes","M", "1983-05-04", "2010-01-07", 40000, 20, "Planificadora");
INSERT INTO empleados VALUES(null, 2,3, "Pablo","H", "1989-04-24", "2008-01-07", 20000, 20, "Operario");
INSERT INTO empleados VALUES(null, 3,2, "Marcos","H", "1989-05-14", "2010-01-07", 30000, 40, "Portero");
INSERT INTO empleados VALUES(null, 3,2, "Miguel","H", "1989-05-14", "2010-01-07", 30000, 400000, "Jefe de taller");
INSERT INTO empleados VALUES(null, 3,2, "Sonia","M", "1989-05-14", "2010-01-07", 20000, 450000, "Jefe de taller");



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