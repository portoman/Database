/* 
11. Visualizar todos los cargos de los vendedores y el número de vendedores que hay en cada cargo
 */

SELECT COUNT(cargo), cargo FROM vendedores GROUP BY cargo;