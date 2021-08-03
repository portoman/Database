/* 
13. Sacar la media de sueldos entre todos los vendedores por grupo
 */

SELECT grupo_id,COUNT(grupo_id), AVG(sueldo) FROM vendedores GROUP BY grupo_id;

# Enseñando el nombre de grupo que aparece en otra tabla:
SELECT v.grupo_id, COUNT(v.grupo_id), CEIL(AVG(v.sueldo)) AS "Sueldo medio", g.nombre, g.ciudad
    FROM vendedores v, grupos g
        WHERE v.grupo_id=g.id GROUP BY grupo_id;