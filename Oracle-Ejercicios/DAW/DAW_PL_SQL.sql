
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