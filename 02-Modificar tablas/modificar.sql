# RENOMBRAR UNA TABLA #
ALTER TABLE usuarios RENAME usuarios_renombrado;


# CAMBIAR EL NOMBRE DE UNA COLUMNA #

ALTER TABLE usuarios_renombrado CHANGE apellidos apellido_cambiado varchar(100) null;

# MODIFICAR COLUMNA SIN CAMBIAR NOMBRE #

ALTER TABLE usuarios_renombrado MODIFY apellido_cambiado char(40) not null;

# AÑADIR COLUMNA #

ALTER TABLE usuarios_renombrado ADD website varchar(100) not null;

# AÑADIR RESTRICCIÓN A COLUMNA #

ALTER TABLE usuarios_renombrado ADD CONSTRAINT uq_email UNIQUE(email);

# BORRAR UNA COLUMNA #

ALTER TABLE usuarios_renombrado DROP website;