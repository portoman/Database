/* 
6. Visualizar el nombre y los apellidos y los vendedores en una misma columna, su fecha de registro
y el dia de la semana que se registraron.
 */

SELECT CONCAT(nombre," ", apellidos) AS "Nombre completo", fecha_alta, DAY(fecha_alta), DAYNAME(fecha_alta) from vendedores;
