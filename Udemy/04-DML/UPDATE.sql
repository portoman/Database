# ACTUALIZAR DATOS #

# Actualizar todas las filas:
UPDATE usuarios SET fecha =CURDATE();

# Actualizar los campos selecionados 

UPDATE usuarios SET fecha ="2019-05-21" WHERE id=4;
UPDATE entradas SET fecha ="2021-03-16" WHERE id=4;


