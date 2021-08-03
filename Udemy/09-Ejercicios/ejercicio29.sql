/* 
29. Crear una vista llamada vendedoresA que incluira todos los vendedores del
grupo que se llame "Breogan"
*/

SELECT v.nombre, g.nombre FROM vendedores v
    INNER JOIN grupos g ON g.id=v.grupo_id
        HAVING g.nombre="Breogan";

