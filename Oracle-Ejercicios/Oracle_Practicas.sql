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


/*Insert*/

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

INSERT INTO empleados VALUES(1,'Pedro','Garcia',5000,5,'email@correo.com');
INSERT INTO empleados VALUES(2,'Carmen','Perez',3000,2,'practica@correo.com');
INSERT INTO empleados VALUES(3,'Luis','Mendez',1000,1,'ejemplo@correo.com');
INSERT INTO empleados VALUES(4,'Verónica','Olano',2500,4,'adios@correo.com');
INSERT INTO empleados VALUES(5,'Raquel','Tevez',4000,3,'hola@correo.com');