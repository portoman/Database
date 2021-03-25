/* 
18. Listar los clientes que han hecho algún encargo del coche "Astra"
 */

SELECT co.modelo, cl.nombre
    FROM encargos e
        INNER JOIN coches co ON co.id=e.coche_id
        INNER JOIN clientes cl ON cl.id=e.cliente_id WHERE co.modelo="Astra";


# Por subconsultas #

SELECT * FROM clientes WHERE id 
IN (SELECT cliente_id FROM encargos WHERE coche_id 
IN (SELECT id FROM coches WHERE modelo LIKE "%Astra%"));

