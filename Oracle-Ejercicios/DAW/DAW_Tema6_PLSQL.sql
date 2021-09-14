
### Ejercicios de https://gradosuperiordam.top/ a revisar ###


-- 1.Función que compruebe si existe un pedido con el número que se le pase. Devolverá verdadero o falso.
SET SERVEROUTPUT ON;

CREATE OR REPLACE FUNCTION existe_pedido (
    v_numero IN pedidos.num%TYPE
) RETURN VARCHAR AS
    v_existe   VARCHAR(10) := 'falso';
    v_count    NUMBER(8);
BEGIN
    SELECT
        COUNT(*)
    INTO v_count
    FROM
        pedidos
    WHERE
        pedidos.num = v_numero;

    IF v_count = 1 THEN
        v_existe := 'verdadero';
        RETURN v_existe;
    ELSE
        RETURN v_existe;
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('No existe ningun pedido con ese número');
END;
/

DECLARE
    v_numero   pedidos.num%TYPE := &numero;
    v_existe   VARCHAR(10);
BEGIN
    v_existe := existe_pedido(v_numero);
    dbms_output.put_line(v_existe);
END;
/

-- 2. Función que devuelve todos los datos de un pedido a partir de su número (toda la fila de la tabla pedidos)

CREATE OR REPLACE FUNCTION datos_pedido (
    v_codigopedidos pedidos.num%TYPE
) RETURN pedidos%rowtype AS
    v_pedido pedidos%rowtype;
BEGIN
    SELECT
        *
    INTO v_pedido
    FROM
        pedidos
    WHERE
        num = v_codigopedidos;

    RETURN v_pedido;
END;
/

DECLARE
    v_codigopedidos   pedidos.num%TYPE := &numero;
    v_pedido          pedidos%rowtype;
BEGIN
    v_pedido := datos_pedido(v_codigopedidos);
    dbms_output.put_line('El numero de pedido es '
                         || v_pedido.num
                         || ', la fecha '
                         || v_pedido.fecha
                         || ' los gastos de envío son '
                         || v_pedido.gastos_envio
                         || ' la fecha prevista de entrega  es '
                         || v_pedido.total
                         || ' el numero de cliente que hizo el pedido es '
                         || v_pedido.cliente);

END;
/
-- 3. Procedimiento que devuelve los datos de un cliente a partir del código de cliente

CREATE OR REPLACE PROCEDURE datos_cliente (
    v_codigocliente clientes.codigo%TYPE
) AS
    v_cliente clientes%rowtype;
BEGIN
    SELECT
        *
    INTO v_cliente
    FROM
        clientes
    WHERE
        codigo = v_codigocliente;

    dbms_output.put_line('codigo cliente '
                         || v_cliente.codigo
                         || ', nombre completo '
                         || v_cliente.nombre
                         || ' '
                         || v_cliente.apellidos
                         || ', edad '
                         || v_cliente.edad
                         || ' años');

EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('El cliente no existe');
END;
/

DECLARE
    v_codigocliente clientes.codigo%TYPE := &codigo;
BEGIN
    datos_cliente(v_codigocliente);
END;
/

-- 4. Procedimiento que muestra un listado con las líneas de un pedido (a partir de su número), de la siguiente manera:
-- Nº Línea    NombreProducto       Precio    Cantidad     Importe

CREATE OR REPLACE PROCEDURE mostrar_lineas_pedido (
    p_codigopedido pedidos.num%TYPE
) AS

    CURSOR lineas_cursor IS
    SELECT
        l.num,
        p.nombre,
        p.precio,
        l.cantidad,
        l.importe
    FROM
        lineas      l,
        productos   p
    WHERE
        p_codigopedido = l.num_pedido
        AND l.producto = p.codigo;

BEGIN
-- no se cómo hacer para que aparezca cada línea debajo de la otra
    dbms_output.put_line('Nº Línea    NombreProducto       Precio    Cantidad     Importe');
    FOR registro IN lineas_cursor LOOP dbms_output.put_line('    '
                                                            || registro.num
                                                            || '         '
                                                            || registro.nombre
                                                            || '           '
                                                            || registro.precio
                                                            || '         '
                                                            || registro.cantidad
                                                            || '          '
                                                            || registro.importe);
    END LOOP;

EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('No existe ningun pedido con ese número');
END;
/

DECLARE
    v_codigopedido pedidos.num%TYPE := &num;
BEGIN
    mostrar_lineas_pedido(v_codigopedido);
END;
/

/* 5. Procedimiento o bloque anónimo que, a partir de un número de pedido, si existe, nos muestre todos los datos del pedido,
 del cliente y el listado de todas las líneas que tiene, utilizando los subprogramas anteriores
*/

DECLARE
    v_codigopedido    pedidos.num%TYPE := &numero;
    v_datospedido     pedidos%rowtype;
    v_numerocliente   clientes.codigo%TYPE;
BEGIN
    SELECT
        c.codigo
    INTO v_numerocliente
    FROM
        pedidos    p,
        clientes   c
    WHERE
        p.cliente = c.codigo
        AND p.num = v_codigopedido;

    IF existe_pedido(v_codigopedido) = 'falso' THEN
        RAISE no_data_found;
    END IF;
    IF v_codigopedido IS NULL THEN
        RAISE no_data_found;
    ELSE
        v_datospedido := datos_pedido(v_codigopedido);
        dbms_output.put_line('El numero de pedido es '
                             || v_datospedido.num
                             || ', la fecha '
                             || v_datospedido.fecha
                             || ' los gastos de envío son '
                             || v_datospedido.gastos_envio
                             || ' la fecha prevista de entrega  es '
                             || v_datospedido.total
                             || ' el numero de cliente que hizo el pedido es '
                             || v_datospedido.cliente);

        datos_cliente(v_numerocliente);
    
--Muestra un fallo con las lineas de pedido
        mostrar_lineas_pedido(v_codigopedido);
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('No existe ningún pedido con ese número');
END;
/

-- 6. Deben tratarse las excepciones oportunas en cada uno de los subprogramas (si no existe el pedido, o no tiene líneas...).

/*Actividad 2.
Trigger para cada vez que se vaya a insertar o modificar una línea de un pedido se actualice correctamente
el importe de la misma (cantidad X precio del producto).
*/
CREATE OR REPLACE TRIGGER actualizar_importe
    BEFORE
        INSERT OR UPDATE
    ON lineas
    FOR EACH ROW
DECLARE
    v_producto PRODUCTOS%rowtype;
BEGIN
    select * into v_producto from PRODUCTOS p where p.CODIGO = :new.producto;
    if :new.importe < 0 then
        raise_application_error(-20001, 'El importe tiene que ser mayor que cero');
    end if;
    if :new.cantidad <= 0 then
        raise_application_error(-20002, 'La cantidad como mínimo tiene que ser 1');
    end if;
    if v_producto.CODIGO is null then
        raise_application_error(-20003, 'La línea debe hacer referencia a un producto');
    end if;
    :new.importe := v_producto.precio * :new.cantidad;
END;
/

-- Trigger para cada vez que se inserten, se borren o modifiquen líneas hay que actualizar el importe del pedido correspondiente

CREATE OR REPLACE TRIGGER actualizar_precio_pedido
    after
        insert or update or delete
    ON lineas
    FOR EACH ROW
DECLARE
    v_precio_producto productos.precio%type;
BEGIN
    select p.PRECIO
    into v_precio_producto
    from PRODUCTOS p
    where p.CODIGO = :new.producto;

    if inserting then
        if :new.importe <> v_precio_producto * :new.cantidad then
            raise_application_error(-20003,'El nuevo importe tiene que ser igual a la cantidad por el precio del producto');
        end if;
        UPDATE pedidos
        SET total = total + :new.importe
        WHERE num = :new.num_pedido;

    end if;
    if updating then
        if :new.num_pedido <> :old.num_pedido then
            raise_application_error(-20003, 'No puedes cambiar una linea a otro pedido');
        end if;
        UPDATE pedidos
        SET total = total + (:new.importe - :old.importe)
        WHERE num = :old.num_pedido;
    end if;
    -- no se por que no funciona el delete
    if deleting then
        UPDATE pedidos
        SET total = total - :old.importe
        WHERE num = :old.num_pedido;
    end if;

EXCEPTION
    WHEN
        no_data_found THEN
        dbms_output.put_line('No se puede insertar una linea a un pedido que no existe');
END;
/