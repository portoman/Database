--3. Inserta un nuevo cliente:
INSERT INTO CLIENTES VALUES ('0008', 'Maria Pilar', 'Quiles Carrera', 25);

--4. Inserta un pedido del cliente anterior con los valores que se indican
INSERT INTO PEDIDOS VALUES ((select max(num)+1 from pedidos), SYSDATE, NULL,SYSDATE + 20, NULL, '0008');

--5. Inserta la primera línea para el pedido anterior
INSERT INTO LINEAS VALUES (1,(select max(num) from pedidos), 10001, 3, (select precio from productos where codigo=10001));

--6. Inserta la segunda línea al pedido anterior:
INSERT INTO LINEAS VALUES (2 ,(select max(num) from pedidos), 10002, 2, (select precio from productos where codigo=10002));