/* 
5. Mostrar todos los vendedores con su nombre y el dias que llevan en el concesionario

 */

SELECT nombre, DATEDIFF(CURDATE(),fecha_alta) AS "Diferencia entre fechas" FROM vendedores;