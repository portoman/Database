# MOSTRAR TODOS LOS REGISTROS/FILAS DE UNA TABLA #

SELECT  email, nombre, apellidos FROM usuarios;

# MOSTRAR TODOS LOS CAMPOS #

SELECT * FROM usuarios;

# OPERADORES ARITMÉTICOS #

SELECT email, (4+7) FROM usuarios;

SELECT id, email, (id+7) AS "OPERACION" FROM usuarios;

SELECT id, email, (id*7) AS "OPERACION" FROM usuarios;

# FUNCIONES MATEMÁTICAS #

# Valor absoluto:

SELECT ABS(-7) AS "OPERACION" FROM usuarios;

# Redondeo a lo alto:
SELECT CEIL(2.5469) AS "OPERACION" FROM usuarios;

# Redondeo a lo bajo:
SELECT FLOOR(2.5469) AS "OPERACION" FROM usuarios;

# Redondeo normal, con decimales:
SELECT ROUND(2.5449,2) AS "OPERACION" FROM usuarios;

# Truncar, quitar decimales:

SELECT TRUNCATE(7.9123, 1) AS "OPERACION" FROM usuarios;