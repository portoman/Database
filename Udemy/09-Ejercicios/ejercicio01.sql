/* 
 1. Diseñar y crear la base de datos de un concesionario
 */
CREATE DATABASE IF NOT EXISTS concesionario;
USE concesionario;


CREATE TABLE coches(
id          int(10) auto_increment not null,
modelo      varchar(100) not null,
marca       varchar(50) not null,
precio      int(20) not null,
stock       int(255) not null,
CONSTRAINT pk_coches PRIMARY KEY (id)
)ENGINE=InnoDb;

CREATE TABLE grupos(
id          int(10) auto_increment not null,
nombre      varchar(100) not null,
ciudad      varchar(100),
CONSTRAINT pk_grupos PRIMARY KEY (id)
)ENGINE=InnoDb;

CREATE TABLE vendedores(
id              int(10) auto_increment not null,
grupo_id        int(10) not null, 
jefe            int(10),
nombre          varchar(100) not null,
apellidos       varchar(150),
cargo           varchar(50),
fecha_alta      date,
sueldo          float(20,2),
comision        float(10,2),
CONSTRAINT      pk_vendedores           PRIMARY KEY (id),
CONSTRAINT      fk_vendedor_grupo       FOREIGN KEY(grupo_id)       REFERENCES grupos(id),
CONSTRAINT      fk_vendedor_jefe        FOREIGN KEY(jefe)       REFERENCES vendedores(id)
)ENGINE=InnoDb;

CREATE TABLE clientes(
id              int(10) auto_increment not null,
vendedor_id     int(10), 
nombre          varchar(150) not null,
ciudad          varchar(100),
gastado         float(50,2),
CONSTRAINT      pk_clientes             PRIMARY KEY (id),
CONSTRAINT      fk_cliente_vendedor     FOREIGN KEY(vendedor_id)       REFERENCES vendedores(id)
)ENGINE=InnoDb;

CREATE TABLE encargos(
id              int(10) auto_increment not null,
cliente_id      int(10) not null,
coche_id        int(10) not null,
cantidad        int(100) not null,
fecha           date,
CONSTRAINT      pk_encargos             PRIMARY KEY (id),
CONSTRAINT      fk_encargo_cliente      FOREIGN KEY(cliente_id)         REFERENCES clientes(id),
CONSTRAINT      fk_encargo_coche        FOREIGN KEY(coche_id)           REFERENCES coches(id)
)ENGINE=InnoDb;

# Inserts #

# INSERTS PARA USUARIOS #

# Coches #
INSERT INTO coches VALUES(null, "Astra", "Opel", 16000, 3); 
INSERT INTO coches VALUES(null, "Captur", "Renault", 18000, 2); 
INSERT INTO coches VALUES(null, "Corolla", "Toyota", 20000, 1); 

# Grupos #
INSERT INTO grupos VALUES(null, "Breogan", "Coruña"); 
INSERT INTO grupos VALUES(null, "Manolo.sl", "Ferrol"); 
INSERT INTO grupos VALUES(null, "Lombao", "Arteixo"); 

# Vendedores #
INSERT INTO vendedores VALUES(null, 1, null,"Pedro", "Lopez", "Vendedor", CURDATE(), 15000, 4);
INSERT INTO vendedores VALUES(null, 3, 1,"David", "Vazquez", "Comercial", CURDATE(), 15000, 4);
INSERT INTO vendedores VALUES(null, 1, null,"Alfonso", "Porto", "Gerente", CURDATE(), 50000, 10);
INSERT INTO vendedores VALUES(null, 3, null,"Lurdes", "Martinez", "Responsable comercial", CURDATE(), 30000, 8);
INSERT INTO vendedores VALUES(null, 2, 3,"Marta", "Etxeberria", "Responsable ventas", CURDATE(), 30000, 8);
INSERT INTO vendedores VALUES(null, 1, null,"Pablo", "Gonzalez", "Mecánico", CURDATE(), 15000, 4);
INSERT INTO vendedores VALUES(null, 2, 5, "Rodrigo", "Garcia", "Mecánico", CURDATE(), 15000, 4);
INSERT INTO vendedores VALUES(null, 2, null,"Fernando", "Sande", "Jefe taller", CURDATE(), 30000, 8);
INSERT INTO vendedores VALUES(null, 1, null,"Sandra", "Perez", "Comercial", CURDATE(), 15000, 4);

# Clientes #
INSERT INTO clientes VALUES(null,1, "Construcciones DIA", "Ferrol", 20000);
INSERT INTO clientes VALUES(null,5, "Xunta", "Santiago", 100000);
INSERT INTO clientes VALUES(null,4, "Faurecia", "Ourense", 30000);
INSERT INTO clientes VALUES(null,7, "Alcoa", "Coruña", 45000);
INSERT INTO clientes VALUES(null,1, "Talleres Benito", "Fene", 20000);
INSERT INTO clientes VALUES(null,3, "Deportivo de La Coruña", "Coruña", 30000);
INSERT INTO clientes VALUES(null,2, "Fabril", "Coruña", 0);

# Encargos #
INSERT INTO encargos VALUES(null,1,2,3,CURDATE());
INSERT INTO encargos VALUES(null,3,1,8,CURDATE());
INSERT INTO encargos VALUES(null,4,2,7,CURDATE());
INSERT INTO encargos VALUES(null,2,3,5,CURDATE());
INSERT INTO encargos VALUES(null,2,1,7,CURDATE());
INSERT INTO encargos VALUES(null,1,3,2,CURDATE());
INSERT INTO encargos VALUES(null,6,2,2,CURDATE());

/*
id              int(10) auto_increment not null,
cliente_id      int(10) not null,
coche_id        int(10) not null,
cantidad        int(100) not null,
fecha           date,
*/