
/*Creación de tablas*/

drop table detallepedidos;
drop table lineas;
drop table productos;
drop table pedidos;
drop table clientes;

CREATE TABLE CLIENTES (	
CODIGO NUMBER(4,0)  PRIMARY KEY,	
NOMBRE VARCHAR2(30) NOT NULL,	
APELLIDOS VARCHAR2(30) NOT NULL, 	
EDAD	NUMBER(2,0) NOT NULL	
);

CREATE TABLE PEDIDOS (
NUM	NUMBER(5,0) PRIMARY KEY,	
FECHA	DATE NOT NULL,
GASTOS_ENVIO	NUMBER(5,2),	
FECHA_PREVISTA DATE NOT NULL,
TOTAL NUMBER(10,2) ,
CLIENTE NUMBER(4,0),
CONSTRAINT CLIENTES_FK FOREIGN KEY (CLIENTE) REFERENCES CLIENTES (CODIGO)
);


CREATE TABLE PRODUCTOS (
CODIGO  NUMBER(5,0) PRIMARY KEY,
NOMBRE  VARCHAR2(30) NOT NULL,
PRECIO   NUMBER(7,2) NOT NULL
);

CREATE TABLE  LINEAS (	
NUM NUMBER(2,0), 
NUM_PEDIDO NUMBER(5,0), 
PRODUCTO NUMBER(5,0) NOT NULL , 
CANTIDAD NUMBER(8,0) NOT NULL , 
IMPORTE NUMBER(6,2), 
 CONSTRAINT DETALLE_PK PRIMARY KEY (NUM, NUM_PEDIDO) , 
 CONSTRAINT PEDIDO_FK FOREIGN KEY (NUM_PEDIDO)
  REFERENCES  PEDIDOS (NUM) , 
 CONSTRAINT PRODUCTO_FK FOREIGN KEY (PRODUCTO)
  REFERENCES  PRODUCTOS (CODIGO) 
   );

/*Insertar datos*/

INSERT INTO CLIENTES VALUES ('0001', 'Luis', 'Garcia Perez', 30);
INSERT INTO CLIENTES VALUES ('0002', 'Maria', 'Lopez Garrido', 50);
INSERT INTO CLIENTES VALUES ('0003', 'Javier', 'Gamez Valiente', 30);
INSERT INTO CLIENTES VALUES ('0004', 'Luis M', 'Rico Martin', 17);
INSERT INTO CLIENTES VALUES ('0005', 'Ana Belen', 'Dimas Marco', 15);
INSERT INTO CLIENTES VALUES ('0006', 'Jose Luis', 'Garcia Sanchez', 50);
INSERT INTO CLIENTES VALUES ('0007', 'M Pilar', 'Perez Bermejo', 45);

INSERT INTO PEDIDOS VALUES (1, '10/10/2015', NULL,'10/11/2015', 310, '0001');
INSERT INTO PEDIDOS VALUES (2, '10/02/2016',    5,'10/03/2016', 185, '0001');
INSERT INTO PEDIDOS VALUES (3, '20/02/2016',    3,'20/04/2016', 180, '0001');
INSERT INTO PEDIDOS VALUES (4, '25/03/2016', NULL,'20/04/2016', 100, '0002');
INSERT INTO PEDIDOS VALUES (5, '25/03/2016', NULL,'20/05/2016', 135, '0003');
INSERT INTO PEDIDOS VALUES (6, '15/04/2016', NULL,'20/05/2016', 45 , '0004');
INSERT INTO PEDIDOS VALUES (7, '15/04/2016', NULL,'20/05/2016', 45 , '0005');
INSERT INTO PEDIDOS VALUES (8, '15/05/2016',   10,'20/05/2016', 45 , '0006');
INSERT INTO PEDIDOS VALUES (9, '15/07/2016',   10,'20/06/2016', 85 , '0007');
INSERT INTO PEDIDOS VALUES (10,'15/01/2017',   10,'15/02/2017', 90 , '0007');

INSERT INTO PRODUCTOS VALUES (10001, 'PANTALoN', 50);
INSERT INTO PRODUCTOS VALUES (10002, 'PANTALoN PITILLO', 60);
INSERT INTO PRODUCTOS VALUES (10003, 'PANTALoN CAMPANA', 55);
INSERT INTO PRODUCTOS VALUES (20001, 'CAMISA M/L', 65);
INSERT INTO PRODUCTOS VALUES (20002, 'CAMISA M/C', 45);
INSERT INTO PRODUCTOS VALUES (30001, 'VESTIDO C', 80);
INSERT INTO PRODUCTOS VALUES (30002, 'VESTIDO L', 90);
INSERT INTO PRODUCTOS VALUES (40001, 'FALDA LARGA', 50);
INSERT INTO PRODUCTOS VALUES (40002, 'FALDA CORTA', 45);
INSERT INTO PRODUCTOS VALUES (40003, 'FALDA MINI', 40);

INSERT INTO LINEAS VALUES (1,1, 10001, 2, 100);
INSERT INTO LINEAS VALUES (2,1, 30001, 1, 80);
INSERT INTO LINEAS VALUES (3,1, 20001, 2, 130);
INSERT INTO LINEAS VALUES (1,2, 20001, 1, 65);
INSERT INTO LINEAS VALUES (2,2, 40003, 3, 120);
INSERT INTO LINEAS VALUES (1,3, 40002, 2, 180);
INSERT INTO LINEAS VALUES (1,4, 10001, 2, 100);
INSERT INTO LINEAS VALUES (1,5, 20002, 2, 90);
INSERT INTO LINEAS VALUES (2,5, 40002, 1, 45);
INSERT INTO LINEAS VALUES (1,6, 40002, 1, 45);
INSERT INTO LINEAS VALUES (1,7, 40002, 1, 45);
INSERT INTO LINEAS VALUES (1,8, 40002, 1, 45);
INSERT INTO LINEAS VALUES (1,9, 40003, 1, 40);
INSERT INTO LINEAS VALUES (2,9, 20002, 1, 45);
INSERT INTO LINEAS VALUES (1,10,20002, 2, 90);

/*Consultas*/
# 1.Numero e importe de todos los pedidos realizados en los ultimos 60 dias.
# Hacemos una consulta para saber cuál es la fecha mas actual
  
SELECT num "Numero", total "Importe", fecha
FROM pedidos 
WHERE fecha > (SELECT MAX(fecha)-60 from pedidos);

# 2.Numero e importe de los pedidos cuyo importe están entre 100 y 200 euros

SELECT num "NUMERO", TOTAL
FROM PEDIDOS 
where TOTAL BETWEEN 100 AND 200;

#3.Codigo y nombre de los productos ordenados ascendentemente por precio y nombre.

select CODIGO, NOMBRE
FROM PRODUCTOS 
order by PRECIO, NOMBRE;

# 4.Clientes cuyo segundo apellido sea Perez
SELECT * FROM clientes 
WHERE apellidos LIKE '%Perez%' OR apellidos LIKE '%Pérez%';

# 5.Numero total de productos que vende la empresa (en la columna debe aparecer "Número de productos")
SELECT COUNT(*) "Numero de Productos" FROM PRODUCTOS;

# 6. Número total de productos que no han sido pedidos

select count(*) from productos where codigo not in( 
select producto from lineas);


SELECT COUNT(*) "Numero de productos no pedidos" FROM LINEAS l
Right outer join productos p on p.codigo = l.producto
where l.num_pedido IS NULL;

# 7. De cada pedido mostrar su número, importe y datos del cliente

select p.num, p.total, c.codigo, c.nombre, c.apellidos
   from pedidos p, clientes C
      where c.codigo=p.cliente;

SELECT p.num   NUMERO,
       p.total IMPORTE,
       c.*
FROM PEDIDOS p
         JOIN clientes C on p.cliente = C.codigo;

# 8.Codigo, nombre  del cliente y numero total de pedidos que ha realizado cada cliente durante 2016

select  p.cliente, c.nombre, count(p.num) from pedidos p
   join clientes c on p.cliente = c.codigo
      where p.fecha like '%16'
      group by p.cliente, c.nombre
        order by p.cliente;


SELECT codigo, nombre, COUNT(p.cliente) "Numero Pedidos"
FROM clientes c 
INNER JOIN pedidos p ON c.codigo = p.cliente
WHERE p.fecha BETWEEN to_date('01-01-2016', 'dd-mm-yyyy') 
AND to_date('31-12-2016', 'dd-mm-yyyy')
GROUP BY c.codigo, p.cliente, c.nombre
order by codigo;


# 9.Codigo, nombre y numero total de pedidos de los clientes que han realizado mas de un pedido

select  p.cliente, c.nombre, count(p.num) from pedidos p
   join clientes c on p.cliente = c.codigo
    group by p.cliente, c.nombre 
        having count(p.num)>1
            order by p.cliente ;



# 10.Para cada pedido mostrar su numero, codigo  del cliente y  numero total de lineas que tiene.

select p.num, p.cliente, count(p.num)
   from lineas l inner join pedidos p on l.num_pedido=p.num
      group by p.num, p.cliente
         order by p.num;



SELECT 
    p.num "Numero pedido",
    p.cliente "Codigo cliente", 
    COUNT(p.num) "Numero lineas" 
FROM 
    pedidos p
inner join lineas l on l.num_pedido = p.num
group by p.num, p.cliente
order by p.num;

# 11.Codigo de cliente, nombre de producto y cantidad total que ha pedido cada cliente de cada producto