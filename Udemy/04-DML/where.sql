# CONSULTA CON UNA CONDICIÓN #

SELECT * FROM usuarios WHERE email="portbuj@yahoo.es";

# SACAME LOS USUARIOS QUE SE APELLIDEN PORTO" 

SELECT * FROM usuarios WHERE apellidos="Porto";

/*
OPERADORES DE COMPARACIÓN:

Igual           =
Distinto        !=
Menor           <
Mayor           >
Menor o igual   <=
Mayor o igual   >=
Entre           between A and B
En              IN
Es nulo         ISNULL
No nulo         IS NOT NULL
Como            like
Distinto        not like

*/
 /*
OPERADORES LÓGICOS:

O       OR
Y       AND
NO      NOT
*/

/*
COMODINES:
Cualquier cantidad de caracteres:   %
Un caracter desconocido:            _
*/

#EJEMPLOS#

# 1. Mostrar nombres y apellidos de todos los usuarios registrados en 2021:

SELECT nombre, apellidos FROM usuarios WHERE YEAR (fecha) =2021;

# 2. Mostrar nombres y apellidos de todos los usuarios QUE NO se registraros en 2021:

SELECT nombre, apellidos FROM usuarios WHERE YEAR (fecha) !=2021 OR ISNULL(fecha);

# 3. Mostrar nombres y apellidos donde la fecha no sea nula:

SELECT nombre, apellidos FROM usuarios WHERE YEAR (fecha) IS NOT NULL;


# 4. Mostrar usuarios cuyo apellido tenga la letra "o" :

SELECT nombre, apellidos, email FROM usuarios WHERE apellidos LIKE "%o%"

# 4. Mostrar usuarios cuyo apellido tenga la letra "o" :
# y que su contraseña sea "123456"

SELECT nombre, apellidos, email FROM usuarios WHERE apellidos LIKE "%o%" AND password ="123456";

# 5. Sacar todos los registros cuyo año sea PAR:

SELECT * FROM usuarios WHERE (YEAR(fecha)%2=0);

# 6.Sacar todos los registros de la tabla usuario cuyo nombre tenga más de
#  5 letras y que hayan registrado antes de 2020, y mostrar el nombre en mayúsculas

SELECT UPPER(nombre) AS "NOMBRE", apellidos FROM usuarios WHERE (LENGTH(nombre)>4) AND (YEAR(fecha)<2020);


