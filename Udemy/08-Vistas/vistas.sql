/* 
Vistas:
    La podemos definir como una consulta almacenada en la base de datos que se utiliza
como una tabla virtual.
No almacena datos sino que utiliza asociaciones y datos originales de las tablas, de forma que siempre se mantiene actualizada
 */

CREATE VIEW entradas_con_nombre AS
SELECT e.id, e.titulo, u.nombre AS "usuario", c.nombre AS "categoria", e.usuario_id, u.id AS "u.id", e.categoria_id, c.id AS "c.id"
    FROM entradas e
        INNER JOIN usuarios u ON e.usuario_id=u.id
        INNER JOIN categorias c ON e.categoria_id=c.id;

# Para sacar la vista se hace como una tabla normal: #
SELECT * FROM entradas_con_nombre;

# PARA ELIMINARLA #

DROP VIEW entradas_con_nombre;