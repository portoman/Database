
#1. Mostrar 'Hola mundo' por pantalla

    begin 

        DBMS_OUTPUT.PUT_LINE('Hola mundo');

    end;


#2. Declarar una variable numérica y mostrar si es mayor de 10 o no

    declare
        mi_numero number(8) := 5;
    begin 

    if (mi_numero>10) then 
        DBMS_OUTPUT.PUT_LINE('Mi número es mayor de 10');
    else
        DBMS_OUTPUT.PUT_LINE('Mi número es menor de 10');
    end if;
    end;

#3. Declarar una variable numérica y pedir su valor y mostrarlo

    declare
        mi_numero number(8) := &numero;
    begin 
        DBMS_OUTPUT.PUT_LINE('El valor introducido es '|| mi_numero);
    end;

#4. Mostrar los números del 1 al 10 con un while

    declare
        i number(8):=1;
    begin
        while(i<=10)
        loop
            DBMS_OUTPUT.PUT_LINE(i);
            i:=i+1;
        end loop;
    end;

#5. Mostrar los números del 1 al 10 con un for

    begin
        for i in 1..10
        loop
            DBMS_OUTPUT.PUT_LINE(i);
        end loop;
    end;

    /*for i in reverse 1..10 - Sería de 10 a 1*/

#6. Mostrar los números del 1 al 10 con un loop

    declare
        i number(8):=1;
    begin
        loop
            exit when i=10;
            DBMS_OUTPUT.PUT_LINE(i);
            i:=i+1;
        end loop;
    end;

#7. Mostrar el nombre de un cliente dado su código

    declare
        v_codigocliente clientes.codigocliente%type := &codigo;
        v_nombrecliente clientes.nombrecliente%type;
    begin
        select nombrecliente into v_nombrecliente
        from clientes
        where codigocliente=v_codigocliente;

        DBMS_OUTPUT.PUT_LINE('El nombre del cliente es '|| v_nombrecliente);
    end;

#8. Mostrar el precioVenta y la gama de un producto dado su código

    declare
        v_codigoproducto productos.codigoproducto%type := &codigo;
        v_nombreproducto productos.nombre%type;
        v_gamaproducto productos.gama%type;
    begin
        select nombre, gama into v_nombreproducto, v_gamaproducto
        from productos
        where codigoproducto=v_codigoproducto;

        DBMS_OUTPUT.PUT_LINE('El código del producto es '|| v_nombreproducto
                            || 'y la gama es '|| v_gamaproducto);
    end;


#9. Mostrar toda la información de un pedido dado su código(fechaEsperada, fechaEntrega, fechaPedido, estado, comentarios)

declare
        v_codigopedido pedidos.codigopedido%type := &codigo;
        v_pedido pedidos%rowtype;
    begin
        select * into v_pedido
        from pedidos
        where codigopedido=v_codigopedido;

        DBMS_OUTPUT.PUT_LINE('La fecha de pedido es '|| v_pedido.fechapedido
                            || ', la fecha esperada es '|| v_pedido.fechaesperada
                            || ', la fecha de entrega es '|| v_pedido.fechaentrega
                            || ', el estado es '|| v_pedido.estado
                            || ' y los comentarios son '|| v_pedido.comentarios
                            );
    end;

#10. Realizar una función que me devuelva la suma de pagos que ha realizado. Pasa el código por parámetro.

/*Creando la función*/
create or replace function Pagos_cliente(v_codigocliente clientes.codigocliente%type)
return Number 
as 
    v_sumapagos pagos.cantidad%type :=0;
begin

    select sum(cantidad) into v_sumapagos
    from pagos
    where codigocliente=v_codigocliente;

    return v_sumapagos;

end;

/*Usando la función*/
declare 
    v_codigocliente pedidos.codigocliente%type := &codigo;
    v_suma pagos.cantidad%type;
begin
    v_suma := Pagos_cliente(v_codigocliente);
    DBMS_OUTPUT.PUT_LINE('La suma de pagos es ' || v_suma);

end;

#11. Realizar un método o procedimiento que muestre el total en euros de un pedido, pasale el código por parámetro.

/*Creando el procedimiento*/
create or replace procedure total_pedido(v_codigopedido pedidos.codigopedido%type)
as 
    v_total number(8) :=0;
begin

    select sum(dp.cantidad * dp.preciounidad) into v_total
    from pedidos p, detallepedidos dp
    where p.codigopedido=dp.codigopedido and p.codigopedido=v_codigopedido;

    DBMS_OUTPUT.PUT_LINE('EL pedido total es  ' || v_total);

end;

/*Usando el procedimiento*/
declare 
    v_codigopedido pedidos.codigopedido%type := &codigo;
begin
    total_pedido(v_codigopedido);
end;


#12. Mostrar el nombre de un cliente dado su código. Controla en caso de que no se encuentre, mostrando un mensaje por ejemplo

 declare
        v_codigocliente clientes.codigocliente%type := &codigo;
        v_nombrecliente clientes.nombrecliente%type;
    begin
        select nombrecliente into v_nombrecliente
        from clientes
        where codigocliente=v_codigocliente;

        DBMS_OUTPUT.PUT_LINE('El nombre del cliente es '|| v_nombrecliente);
        exception
         when no_data_found then 
            DBMS_OUTPUT.PUT_LINE('El cliente no existe');
    end;

#13. Realizar una función que me devuelva la suma de pagos que ha realizado. Pasa el código por parámetro . 
Controla en caso de que no se encuentre, en ese caso devuelve un -1.

create or replace function Pagos_cliente(v_codigocliente clientes.codigocliente%type)
return Number 
as 
    v_sumapagos pagos.cantidad%type :=0;
begin

    select sum(cantidad) into v_sumapagos
    from pagos
    where codigocliente=v_codigocliente;

    if v_sumapagos is null then
        raise no_data_found;
    else
        return v_sumapagos;
    end if;

    exception
            when no_data_found then 
                return -1;
end;
/
declare 
    v_codigocliente pedidos.codigocliente%type := &codigo;
    v_suma pagos.cantidad%type;
begin
    v_suma := Pagos_cliente(v_codigocliente);
    if v_suma =-1 then 
    DBMS_OUTPUT.PUT_LINE('El cliente no existe');
    else
    DBMS_OUTPUT.PUT_LINE('La suma de pagos es ' || v_suma);
    end if;
end;

#14. Realizar un método o procedimiento que muestre el total en euros de un pedido, pásale el código por parámetro.
Controla en caso de que no se encuentre, en ese caso devuelve un 0. Pásale otro parámetro, si supera ese límite, lanzaremos una 
excepción propia y devolveremos un 0.

create or replace function total_pedido_f(v_codigopedido pedidos.codigopedido%type, limite number)
return number
as 
    v_total number(8) :=0;
    limite_superado exception;
begin

    select sum(dp.cantidad * dp.preciounidad) into v_total
    from pedidos p, detallepedidos dp
    where p.codigopedido=dp.codigopedido and p.codigopedido=v_codigopedido;

    if v_total is null then
        raise no_data_found;
    else
        if v_total > limite then 
            raise limite_superado;
            return v_total;
        else
            return v_total;
        end if;
    end if;

exception 
    when no_data_found then
        DBMS_OUTPUT.PUT_LINE('No existe el pedido');
        return 0;

    when limite_superado then
        DBMS_OUTPUT.PUT_LINE('Se ha superado el límite');
        return 0;
end;

/*Usando el procedimiento*/
declare 
    v_codigopedido pedidos.codigopedido%type := &codigo;
    v_limite number(8) := &limite;
    v_total number(8);
begin
    v_total := total_pedido_f(v_codigopedido, v_limite);
    DBMS_OUTPUT.PUT_LINE('El pedido es de '|| v_total);
end;

#15. Crea una función a la que le pasaremos como parámetros de entrada: MATRICULA, NUEVO_PRECIO_COMPRA.
La función modificará los datos del coche que tenga la matrícula introducida, actualizando el PRECIO_COMPRA
de la siguiente forma:

    - Si PRECIO_COMPRA es nulo: Hacer un update en el campo PRECIO_COMPRA asignándole el valor de  NUEVO_PRECIO_COMPRA

    - Si no: Hacer un update en el campo precio_compra asignándole el valor de precio_compra+(PRECIO_COMPRA-NUEVO_PRECIO_COMPRA)

La función devolverá el número de filas actualizadas
Crea un bloque anónimo que ejecuta la función anterior y muestre el resultado devuelto por la función


create or replace function actualizaPrecioCoche(
    v_matricula concesionario.coche.matricula%type, 
    v_nuevo_precio_compra coche.precio_compra%type)
return number
as
    v_precio_compra coche.precio_compra%type;
begin

    select precio_compra into v_precio_compra
    from coche where matricula=v_matricula;

    if v_precio_compra is null then
        update coche
        set precio_compra=v_nuevo_precio_compra
        where matricula=v_matricula;
    else
        update coche
        set precio_compra=precio_compra+(precio_compra-v_nuevo_precio_compra)
        where matricula=v_matricula;
    end if;

    return SQL%ROWCOUNT;
end;

/

declare
    v_matricula coche.matricula%type := &matricula;
    v_nuevo_precio_compra coche.precio_compra%type :=&nuevo_precio;
    v_total_filas number(8);
begin
    v_total_filas := actualizaPrecioCoche(v_matricula, v_nuevo_precio_compra);
    DBMS_OUTPUT.PUT_LINE('Se han modificado '||v_total_filas || ' filas');
end


#16. Crea procedimiento que reciba como parámetros de entrada: P_ID_MARCA, P_NUMERO_COCHES. Utiliza un bucle 
para insertar N registros nuevos en la tabla COCHE. El número de registros a insertar viene indicado 
por el parámetro P_NUMEROS_COCHES(CONTADOR) y el bucle empezará en 1, los datos a insertar 
serán:
    - matricula='A00' ||CONTADOR
    - DESCRIPCION=P_ID_MARCA
    - ID_MARCA=P_ID_MARCA
    - precio_compra=nulo

Controlar excepción para cuando exista algún coche en la bbdd

/*Crear el procedimiento*/

create or replace procedure creaCoches(
    p_id_marca coche.id_marca%type, 
    p_numero_coches number)
as

begin
    for contador in 1...p_numero_coches loop
        insert into coche values('A00'||contador, p_id_marca, p_id_marca, null)
    end loop;

exception 
    when dup_val_on_index then
        DBMS_OUTPUT.PUT_LINE('Registro duplicado');
end;

/

declare
    p_id_marca coche.id_marca%type := &id; 
    p_numero_coches number(8) :=&num;
begin
    creaCoches(p_id_marca, p_numero_coches);
end;

/*Parámetros de salida*/
#18. Crea un procedimiento al que le pasaremos el dni_cliente y la matrícula. El procedimiento deberá
controlar en las ventas de los coches(tabla vende) los siguientes supuestos:
    A. Si no existe un registro con ese dni_cliente y esa matrícula saltará a la zona de excepciones y mostrará un mensaje
        "No existe la venta introducida"
    B. Si existe la venta introducida:
        1. Mostrará el precio antiguo
        2. Actualizará el precio subiendo 1000 euros
        3. Devolverá en un parámetro de salida del procedimiento (ps_nuevo_precio) el precio nuevo tras la actualización
    Crea un bloque anónimo que llame al procedimiento anterior y muestre el precio nuevo devuelto por el procedimiento

create or replace procedure actualizaVenta(
    p_dni_cliente vende.dni_cliente%type,
    p_matricula vende.matricula%type,
    ps_nuevo_precio out vende.precio%type
)
as 
    venta vende%rowtype;
begin
    select * into venta
    from vende
    where dni_cliente=p_dni_cliente
    and matricula=p_matricula;

    DBMS_OUTPUT.PUT_LINE('El precio antiguo es '|| venta.precio)

    ps_nuevo_precio=venta.precio+1000;

    update vende 
    set precio =ps_nuevo_precio
    where dni_cliente=p_dni_cliente
    and matricula=p_matricula;
    
exception
    when no_data_found then
     DBMS_OUTPUT.PUT_LINE('No existe la venta introducida');   

end;

declare 
    v_dni_cliente vende.dni_cliente%type :=&dni;
    v_matricula vende.matricula%type :=&matricula;
    v_nuevo_precio out vende.precio%type;
begin
    actualizaVenta(v_dni_cliente, v_matricula, v_nuevo_precio);
    if v_nuevo_precio is not null then
        DBMS_OUTPUT.PUT_LINE('El nuevo precio es '||v_nuevo_precio);   
    end if;
end;

/*Cursores: Para hacer consultas que devuelvan más de un dato*/

#19. Crear un cursor para ver todos los clientes que no hayan hecho pagos. Hazlo con un loop

declare 
    v_nombrecliente clientes.nombrecliente%type;
    cursor clientes_sin_pagos_cursor is 
    select nombrecliente
    from clientes c
    where not exists(select * from pagos where codigocliente=c.codigocliente);

begin

    open clientes_sin_pagos_cursor; /*Se abre y se debe cerrar el cursor*/

        loop
            fetch clientes_sin_pagos_cursor into v_nombrecliente;
            exit when clientes_sin_pagos_cursor%notfound;
            DBMS_OUTPUT.PUT_LINE(v_nombrecliente);   

        end loop;

    close clientes_sin_pagos_cursor;

end;

#20. Crear un cursor para ver todos los clientes que no hayan hecho pagos. Hazlo con un for
/*Con el for se simplifica*/

declare 
    cursor clientes_sin_pagos_cursor is 
    select nombrecliente
    from clientes c
    where not exists(select * from pagos where codigocliente=c.codigocliente);

begin

    for registro in clientes_sin_pagos_cursor loop

        DBMS_OUTPUT.PUT_LINE(registro.nombrecliente);   

    end loop;

end;


#21. Crear un cursor para ver totos los productos pedidos de un pedido. Muestra la cantidad también

create or replace procedure mostrarProductosPedido(p_codigopedido pedidos.codigopedido%type)
as

cursor prod_pedido is
select p.nombre, dp.cantidad
from productos p, detallepedidos dp
where p.codigoproducto=dp.codigoproducto
and dp.codigopedido=p_codigopedido;
begin
    for registro in prod_pedido loop
    DBMS_OUTPUT.PUT_LINE('Se ha pedido del producto llamado'||registro.nombre||': '||registro.cantidad||' unidades');   
    end loop;
end;
/

declare
    p_codigopedido pedidos.codigopedido%type :=&codigo;
begin
    mostrarProductosPedido(p_codigopedido);
end;


#22. Crear un cursor para ver todos los empleados de un jefe

create or replace procedure mostrarEmpleadosJefe(p_codigojefe empleados.codigojefe%type)
as

cursor empleado_jefe is

    select emp.nombre ||' '||emp.apellido1||' '||emp.apellido2 as nombre_empleado
    from empleados emp, empleados jefe
    where emp.codigojefe=jefe.codigoempleado
    and jefe.codigoempleado=p_codigojefe;

v_nombre_jefe varchar2(80);
begin 
select  nombre ||' '||apellido1||' '||apellido2 into v_nombre_jefe
from empleados
where codigoempleado=p_codigojefe;

    DBMS_OUTPUT.PUT_LINE('El jefe llamado '||v_nombre_jefe||' tiene a cargo a los siguientes empleados: ');  
    for registro in empleado_jefe loop
    DBMS_OUTPUT.PUT_LINE(registro.nombre_empleado);   
    end loop;

    exception
    when no_data_found then
            DBMS_OUTPUT.PUT_LINE('No existe ese jefe'); 
end;

  

/

declare
    p_codigojefe empleados.codigojefe%type :=&codigo;
begin
    mostrarEmpleadosJefe(p_codigojefe);
end;

#23. Trigger para actualizar el stock de productos después de insertar en la tabla de detallepedidos


/*Creando el trigger*/
create or replace trigger productos_actualizar_stock
after insert on detallepedidos for each row
declare 

begin
    update productos
    set cantidadenstock= cantidadenstock -:new.cantidad
    where codigoproducto=:new.codigoproducto; 
end;

/*Ejecutar el trigger: Después de insertar en detallepedidos*/

insert into detallepedidos (1, 'FR-4', 10, 10, 6);

#24. Crea un trigger que al actualizar la columna fechaentrega de pedidos la compare con la fechaespera.
Si fechaentrega es menor que fechaespera añadir a los comentarios 'Pedido entregado antes de lo esperado'
Si fechaentrega es mayor que fechaespera añadir a los comentarios 'Pedido entregado con retraso'

create or replace trigger actualizar_comentarios_pedidos
before update of fechaentrega on pedidos FOR EACH ROW

declare
begin
    if :new.fechaentrega is not null then
        if :new.fechaentrega > :old.fechaentregada then 
            :new.comentarios =: old.comentarios || ' Pedido entregado con retraso';
        else
            :new.comentarios =: old.comentarios || ' Pedido entregado antes de lo esperado';
        end if;
    end if;
end;

/

update pedidos set fechaentrega=to_date('01/01/15') where codigopedido =1;