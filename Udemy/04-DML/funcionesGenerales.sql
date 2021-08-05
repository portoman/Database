# SABER SI LOS ELEMENTOS DE UNA COLUMNA SON NULOS: IS NULL #

SELECT ISNULL(apellidos) FROM usuarios;

# COMPARAR DOS VALORES #

SELECT STRCMP("HOLA", "HOLA") FROM usuarios;

SELECT STRCMP("HOLA", "H1OLA") FROM usuarios;

# SABER VERSION #

SELECT VERSION() FROM usuarios;

# SABER USUARIO #

SELECT USER() FROM usuarios;

# SACAR REGISTROS QUE SEAN DIFERENTES: DISTINCT #

SELECT DISTINCT USER() FROM usuarios;

# SABER EN QUE BASE DE DATOS ESTAMOS #

SELECT DISTINCT DATABASE() FROM usuarios;

# SI ESTÁ VACIO, CAMBIARLO POR ALGO #

SELECT IFNULL(apellidos, "ESTE CAMPO ESTÁ VACIO") AS "IS NULL" FROM usuarios;

# BETWEEN

SELECT column_name(s)
FROM table_name
WHERE column_name BETWEEN value1 AND value2;