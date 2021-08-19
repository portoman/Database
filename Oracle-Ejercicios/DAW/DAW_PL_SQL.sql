
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