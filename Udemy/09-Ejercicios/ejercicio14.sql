/* 
 14. Visualizar las unidades totales vendidas de cada coche a cada cliente.
Mostrando el nombre del producto, número de cliente y la suma de unidades
 */
 
SELECT cl.id  "Número de cliente", cl.nombre "Nombre cliente", co.modelo, co.marca, SUM(e.cantidad)  "Cantidad", e.coche_id
    FROM coches co, clientes cl, encargos e 
        WHERE e.coche_id=co.id AND e.cliente_id=cl.id
        GROUP BY e.cliente_id, e.coche_id;
