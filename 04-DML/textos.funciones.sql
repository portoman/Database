# CONVERTIR CAMPOS EN MAYUSCULAS O MINUSCULAS #

SELECT UPPER(nombre) FROM usuarios;

SELECT LOWER(nombre) FROM usuarios;

# CONCATENAR DIFERENTES CAMPOS #

SELECT CONCAT(nombre, " ", apellidos) AS "CONVERSION" FROM usuarios;

SELECT UPPER(CONCAT(nombre, " ", apellidos)) AS "CONVERSION" FROM usuarios;

# SACAR LONGITUD. LENGTH #

SELECT LENGTH(CONCAT(nombre, " ", apellidos)) AS "CONVERSION" FROM usuarios;

# Borrar espacios innecesarios. Con TRIM #

SELECT TRIM(CONCAT("              ", nombre, " ", apellidos, "      ")) AS "CONVERSION" FROM usuarios;