/* 
21. Obtener los nombres y las ciudades de los clientes con encargos igual o mayor a 3 unidades
 */
SELECT  e.id, c.ciudad, c.nombre, SUM(e.cantidad)
    FROM encargos e
        INNER JOIN clientes c ON e.cliente_id=c.id
            GROUP BY c.nombre;

SELECT id, nombre, ciudad FROM clientes WHERE id IN
(SELECT cliente_id FROM encargos GROUP BY cliente_id HAVING SUM(cantidad)>6);