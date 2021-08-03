/* 
15. Mostrar los clientes que más pedidos han hecho y mostrar cuantos hicieron
 */

SELECT e.id, cl.id, cl.nombre, COUNT(e.id)
    FROM encargos e
        INNER JOIN clientes cl ON e.cliente_id=cl.id
            GROUP BY e.cliente_id ORDER BY COUNT(e.id) DESC;
        

