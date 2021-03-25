/* 
17. Obtener un listado con los encargos realizados por el cliente "Xunta". 
 */
SELECT cl.nombre, e.id, e.cantidad, co.modelo FROM encargos e
    INNER JOIN clientes cl ON e.cliente_id=cl.id
    INNER JOIN coches co ON e.coche_id=co.id
        WHERE cl.nombre="Xunta";
