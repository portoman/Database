/* 
16. Obtener listado de clientes atendidos por el vendedor Alfonso Porto
 */

SELECT cl.nombre, v.nombre
    FROM clientes cl
        INNER JOIN vendedores v ON cl.vendedor_id = v.id WHERE v.nombre="Alfonso";