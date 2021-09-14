--3. Inserta un nuevo cliente:
INSERT INTO CLIENTES VALUES ('0008', 'Maria Pilar', 'Quiles Carrera', 25);

--4. Inserta un pedido del cliente anterior con los valores que se indican
INSERT INTO PEDIDOS VALUES ((select max(num)+1 from pedidos), SYSDATE, NULL,SYSDATE + 20, NULL, '0008');

--5. Inserta la primera línea para el pedido anterior
INSERT INTO LINEAS VALUES (1,(select max(num) from pedidos), 10001, 3, (select precio from productos where codigo=10001));

--6. Inserta la segunda línea al pedido anterior:
INSERT INTO LINEAS VALUES (2 ,(select max(num) from pedidos), 10002, 2, (select precio from productos where codigo=10002));

--7. Modifica el pedido 11 para que el importe total tenga el valor que corresponda.
UPDATE PEDIDOS SET TOTAL =(Select sum(importe) from lineas where num_pedido=11)  WHERE NUM = 11;

--8. Haz un SELECT que muestre las líneas del pedido 11. Copia también aquí el resultado. Y confirma definitivamente

select * from lineas where num_pedido=11;

commit;

--9. Ha habido un problema con el reparto en febrero, por lo que hay que retrasar las fechas previstas 
-- de entrega de febrero para 30 días después
UPDATE PEDIDOS P SET P.FECHA_PREVISTA = P.FECHA_PREVISTA +30 WHERE P.NUM = 11;


--10. A todos los pedidos sin gastos de envío hay que ponerles valor 0 en ese atributo.
UPDATE PEDIDOS SET GASTOS_ENVIO = 0 WHERE GASTOS_ENVIO IS NULL;

--11. Hay que subir el precio de todos los productos en un 10%
UPDATE PRODUCTOS SET PRECIO = PRECIO *1.1;

--13. Borra los productos que no hayan sido pedidos nunca. ¿Cuántos se han borrado?
DELETE 
    FROM PRODUCTOS P
        WHERE P.CODIGO IN
            (SELECT  P.CODIGO FROM PRODUCTOS P 
            LEFT JOIN LINEAS L ON L.PRODUCTO = P.CODIGO 
                WHERE L.PRODUCTO IS NULL);
--Borró 3 filas

--14. Borra el producto 10001. ¿Qué ocurre y por qué?
DELETE FROM LINEAS L WHERE L.PRODUCTO = 10001;

--15. Qué sentencias habría que ejecutar y en qué orden hasta poder eliminar de la tabla el producto 10001
DELETE FROM PRODUCTOS P WHERE P.CODIGO = 10001;