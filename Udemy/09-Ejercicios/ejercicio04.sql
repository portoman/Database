/* 
4. Sacar a todos los vendedores cuya fecha de alta sea posterior al 1 de Julio de 2018
 */

UPDATE vendedores SET fecha_alta="2018-06-01" WHERE id=5;


SELECT nombre, apellidos from vendedores WHERE fecha_alta>="2018-07-01";
