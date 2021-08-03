/* 
27. Visualizar los nombres de los clientes y la cantidad de encargos realizados, 
incluyendo los que no hayan realizado encargos
 */

SELECT c.nombre, c.gastado FROM clientes c
    LEFT JOIN encargos e ON c.id=e.cliente_id;
