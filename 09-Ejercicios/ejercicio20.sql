/* 
20. Seleccionar el grupo en el que trabaja el vendedor con mayor salario 
y mostrar el nombre del grupo
 */
SELECT MAX(v.sueldo) , g.nombre
    FROM vendedores v
        INNER JOIN grupos g ON g.id=v.grupo_id;