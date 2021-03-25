/* 
 8. Visualizar todos los coches en cuyo marca exista la letra "e" y cuyo modelo empiece por "a".
 */

SELECT * FROM coches WHERE marca LIKE "%e%" AND modelo LIKE "a%";
