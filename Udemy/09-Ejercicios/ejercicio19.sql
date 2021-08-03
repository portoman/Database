/* 
 19.Obtener los vendedores con 2 o más clientes
 */

SELECT cl.vendedor_id, v.nombre, COUNT(v.nombre) 
    FROM clientes cl
        INNER JOIN vendedores v ON cl.vendedor_id=v.id 
            GROUP BY v.nombre HAVING COUNT(v.nombre)>=2;