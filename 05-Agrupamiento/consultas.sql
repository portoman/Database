# CONSULTAS AGRUPAMIENTO #

SELECT COUNT(titulo) AS "NUMERO DE ENTRADAS", categoria_id FROM entradas GROUP BY categoria_id;

# CONSULTAS AGRUPAMIENTO CON CONDICIONES: HAVING#

SELECT COUNT(titulo) AS "NUMERO DE ENTRADAS", categoria_id 
FROM entradas GROUP BY categoria_id HAVING COUNT(titulo)>=4;

/* 
AVG     Sacar la media
COUNT   Contar el número de elementos
MAX     Valor máximo del grupo
MIN     Valor mínimo del grupo
SUM     Sumar todo el contenido del grupo
*/

# 1- Calcular media de las entradas:
SELECT AVG(id) AS "Media de entradas" FROM entradas;

# 2- Contar el número de ids:
SELECT COUNT(id) AS "Suma de ids" FROM entradas;

# 3- Valor id máximo:
SELECT MAX(id) AS "Id máximo" FROM entradas;

# 4- Valor id mínimo:
SELECT MIN(id) AS "Id mínimo" FROM entradas;

# 5- Sumar todos los ids:
SELECT SUM(id) AS "Suma Ids" FROM entradas;




