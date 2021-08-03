#INSERTAR NUEVOS REGISTROS#

# INSERTS PARA USUARIOS #

INSERT INTO usuarios VALUES(null, "Alfonso", "Porto", "portbuj@yahoo.es", "123456", "2021-03-17"); 
INSERT INTO usuarios VALUES(null, "Paco", "Perez", "pj@yahoo.es", "987956", "2008-03-17"); 
INSERT INTO usuarios VALUES(null, "Maria", "Porto", "mporto@yahoo.es", "9844984", "2019-08-20"); 
INSERT INTO usuarios VALUES(null, "Lurdes", "Martinez", "lmartinez@gmail.com", "789465", CURDATE()); 

# INSERTAR FILAS SOLO EN CIERTAS COLUMNAS #

INSERT INTO usuarios(email, password) VALUES("nuevoEmail", "nuevoPW");



# INSERTS PARA CATEGORIAS #
INSERT INTO categorias VALUES(null, "Acción");
INSERT INTO categorias VALUES(null, "Rol");
INSERT INTO categorias VALUES(null, "Deportes");



# INSERTS PARA ENTRADAS #
INSERT INTO entradas VALUES(null, 1, 1, "Novedades de GTA 5 Online", "Review del GTA 5", CURDATE());
INSERT INTO entradas VALUES(null, 1, 2, "Review de Dota Online", "Todo sobre el dota", CURDATE());
INSERT INTO entradas VALUES(null, 1, 3, "Nuevos jugadores del FIFA 19", "Review del FIFA 19", CURDATE());

INSERT INTO entradas VALUES(null, 2, 1, "Call of Duty", "Nuevas armas", CURDATE());
INSERT INTO entradas VALUES(null, 2, 2, "Zelda", "Ocarina of Time review", CURDATE());
INSERT INTO entradas VALUES(null, 2, 3, "NBA live", "Review del NBA Live", CURDATE());

INSERT INTO entradas VALUES(null, 3, 1, "Street Fighter 2", "Review Street Fighter 2", CURDATE());
INSERT INTO entradas VALUES(null, 3, 2, "World of Warcraft", "World of Warcraft review", CURDATE());
INSERT INTO entradas VALUES(null, 3, 3, "Bowling 20", "Review del Bowling 20", CURDATE());

INSERT INTO entradas VALUES(null, 4, 1, "Goldeneye", "Review del Goldeneye", CURDATE());
INSERT INTO entradas VALUES(null, 4, 2, "Catan", "Catan online", CURDATE());
INSERT INTO entradas VALUES(null, 4, 3, "Golf 2021", "Review del Golf", CURDATE());

