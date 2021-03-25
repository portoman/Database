/* 
CONSULTA MULTITABLA:
Son consultas que sirven para consultar varias tablas en una sola sentencia
 */

# Mostrar las entradas con el nombre del autor y el nombre de la categoría #

SELECT entradas.titulo, usuarios.nombre, categorias.nombre FROM entradas, usuarios, categorias;

# Para reducir código se puede hacer como abajo:

SELECT e.titulo, u.nombre, c.nombre, e.usuario_id, u.id AS "u.id", e.categoria_id, c.id AS "c.id"
    FROM entradas e, usuarios u, categorias c;
        

SELECT e.id, e.titulo, u.nombre, c.nombre, e.usuario_id, u.id AS "u.id", e.categoria_id, c.id AS "c.id"
    FROM entradas e, usuarios u, categorias c
        WHERE e.usuario_id=u.id AND e.categoria_id=c.id;

#INNER JOIN-> Para ser más eficiente#

SELECT e.id, e.titulo, u.nombre, c.nombre, e.usuario_id, u.id AS "u.id", e.categoria_id, c.id AS "c.id"
    FROM entradas e
        INNER JOIN usuarios u ON e.usuario_id=u.id
        INNER JOIN categorias c ON e.categoria_id=c.id;

# Mostrar el nombre de las categorias y al lado cuantas entradas tienen #

SELECT  COUNT(e.id) ,  c.nombre, e.categoria_id 
    FROM entradas e, categorias c
        WHERE e.categoria_id=c.id GROUP BY e.categoria_id;

# INNER JOIN #
SELECT  COUNT(e.id) ,  c.nombre, e.categoria_id 
    FROM entradas e
        INNER JOIN categorias c ON e.categoria_id=c.id GROUP BY e.categoria_id;

# RIGHT JOIN-> Me saca todos los campos que estén a la derecha #
SELECT  COUNT(e.id) ,  c.nombre, e.categoria_id 
    FROM entradas e
        RIGHT JOIN categorias c ON e.categoria_id=c.id GROUP BY e.categoria_id;



# Mostrar el email de los usuarios y al lado cuantas entradas tienen #

SELECT COUNT(e.id) ,  u.id, u.email
    FROM entradas e, usuarios u
        WHERE e.usuario_id=u.id GROUP BY u.email;

#INNER JOIN#
SELECT COUNT(e.id) ,  u.id, u.email
    FROM entradas e 
        INNER JOIN usuarios u ON e.usuario_id=u.id GROUP BY u.email;

# Mostrar los usuarios que crearon una entrada un martes. Ejercicio realizado antes con subconsultas#

SELECT u.id, u.nombre, e.id, u.id, e.fecha 
    FROM usuarios u, entradas e 
        WHERE u.id=e.usuario_id AND DAYOFWEEK(e.fecha)=3;

#INNER JOIN#
SELECT u.id, u.nombre, e.id, u.id, e.fecha 
    FROM entradas e 
        INNER JOIN usuarios u ON u.id=e.usuario_id AND DAYOFWEEK(e.fecha)=3;