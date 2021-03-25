/* 
    SUBCONSULTAS:
- Son consultas que se ejecutan dentro de otras 
- Consiste en utilizar los resultados de la subconsulta para operar en la consulta principal
- Utilizando clases ajenas(Foreign Keys)
 */

# Introducimos nuevo usuario para ver el ejemplo:

INSERT INTO usuarios VALUES(null, "Admin", "Admin", "Admin", "87987987", CURDATE()); 

# Sácame los usuarios que tengan el id dentro de entradas:

SELECT * FROM usuarios WHERE id IN(SELECT usuario_id FROM entradas);

# Sácame los usuarios que no tengan el id dentro de entradas:

SELECT * FROM usuarios WHERE id NOT IN(SELECT usuario_id FROM entradas);

# Sácame los usuarios que tengan alguna entrada que en su título hable de GTA #

SELECT nombre, apellidos FROM usuarios WHERE id IN(SELECT usuario_id FROM entradas WHERE titulo LIKE "%GTA%");

# Sacar todas las entradas de la categoría acción utilizando su nombre:

SELECT * FROM entradas WHERE categoria_id IN(SELECT id FROM categorias WHERE nombre="accion");

# Mostrar las categorías con 5 o más entradas #

SELECT nombre FROM categorias WHERE 
    id IN(SELECT categoria_id FROM entradas GROUP BY categoria_id HAVING COUNT(categoria_id)>=5);

# Mostrar los usuarios que crearon una entrada un martes #
SELECT * FROM usuarios WHERE id IN (SELECT usuario_id FROM entradas WHERE DAYOFWEEK(fecha)=3);

# Mostrar el nombre del usuario que tenga más entradas #
 
SELECT nombre FROM usuarios WHERE
id =(SELECT usuario_id FROM entradas GROUP BY usuario_id ORDER BY  COUNT(usuario_id) DESC LIMIT 1);

# Mostrar las categorias sin entradas #

SELECT nombre FROM categorias WHERE 
id NOT IN(SELECT categoria_id FROM entradas);