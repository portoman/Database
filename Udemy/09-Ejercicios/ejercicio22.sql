/* 
22. Mostrar listado de clientes (número de cliente y nombre)
mostrar también el número de vendedor y su nombre. 
*/
SELECT DISTINCT USER() FROM usuarios;

SELECT c.id, c.nombre, v.id, v.nombre
    FROM clientes c
        INNER JOIN vendedores v ON v.id=c.vendedor_id;
