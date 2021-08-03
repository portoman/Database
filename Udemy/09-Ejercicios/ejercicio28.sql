/* 
 28. Listar los vendedores, tengan o no clientes. Se deben mostrar tengan o no clientes
 */

SELECT v.id, v.nombre, COUNT(v.nombre), c.id, c.nombre, COUNT(v.id) 
    FROM vendedores v
        LEFT JOIN clientes c ON v.id=c.vendedor_id GROUP BY v.nombre;
