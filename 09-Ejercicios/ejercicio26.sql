/* 
26. Sacar vendedores que tienen jefe y sacar el nombre del jefe
 */

SELECT v1.id, v1.nombre, v2.id,v2.nombre AS "JEFE" FROM vendedores v1
    INNER JOIN vendedores v2 ON v1.jefe=v2.id;