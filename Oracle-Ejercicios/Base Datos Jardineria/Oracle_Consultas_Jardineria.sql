1. Muestra la ciudad y el código postal de las oficinas de España

select ciudad, codigopostal from oficinas where pais='España';

2. Obtener el nombre y el apellido del jefe de la empresa

select nombre, apellido1, apellido2 from empleados where codigojefe is null;

3. Mostrar el nombre y cargo de los empleados que no sean directores de oficina

select nombre, puesto from empleados where puesto!='Director Oficina';
select nombre, puesto from empleados where puesto NOT IN('Director Oficina');

4. Muestra el número de empleados que hay en la empresa

select count(*) from empleados;

5. Muestra el número de clientes norteamericanos

select count(*) from clientes where pais='USA';

6. Número de clientes por país

select count(*), pais from clientes group by pais;

7. Muestra el nombre del cliente, su apellido y el nombre de su representante de ventas (si lo tiene)

select c.nombrecontacto, c.apellidocontacto, e.nombre
    from clientes c, empleados e
        where c.codigoempleadorepventas=e.codigoempleado;


8. Nombre de los clientes que hayan hecho un pago en 2007

select c.nombrecliente, p.fechapago
    from clientes c, pagos p
        where c.codigocliente=p.codigocliente and p.fechapago like '%07';

9. Los posibles estados de un pedido

select distinct(estado) from pedidos;

10. Muestra el número de pedido, el nombre del cliente, la fecha de entrega y la fecha esperada

select p.codigopedido, c.nombrecliente, p.fechaentrega, p.fechaesperada
    from clientes c, pedidos p
        where c.codigocliente=p.codigocliente order by p.codigopedido asc;

11. Muestra el codigo, nombre y gama de los productos que nunca se han pedido

select p.codigoproducto, p.nombre, p.gama
    from productos p , gamasproductos g
        where p.gama = g.gama
            AND p.codigoproducto not in(select d.codigoproducto from detallepedidos d);

12. Muestra el nombre y apellidos de los empleados que trabajan en Barcelona

select nombre, apellido1, apellido2 
    from empleados 
        where codigooficina in(select codigooficina from oficinas where ciudad='Barcelona');

13. Muestra el código y la cantidad de veces que se ha pedido un producto al menos una vez

select p.codigoproducto, sum(dp.cantidad) "cantidad pedida",count(*)
    from productos p, detallepedidos dp
        where p.codigoproducto=dp.codigoproducto
            group by p.codigoproducto;

14. Muestra el nombre de los clientes de Miami que han realizado algún pedido

select nombrecliente
    from clientes
        where  codigocliente IN(select codigocliente from pedidos) and ciudad='Miami';

15. Mostrar el precio final de cada pedido

select codigopedido, sum(cantidad*preciounidad)
    from detallepedidos group by codigopedido;
        

16. Mostrar lo que ha pagado cada cliente

select codigocliente, sum(cantidad)
    from pagos
        group by codigocliente;

17. Mostrar el número de productos de cada gama

select gama,count(*) "Total"
    from productos
        group by gama;


18. Mostrar el código de los productos donde se haya vendido el producto de la gama 'Aromáticas' más caro

select codigoproducto, gama, precioventa 
    from productos 
        where gama='Aromáticas';



19. Mostrar el código de los pedidos donde se hayan vendido más de 6 productos
    select codigopedido, cantidad
        from detallepedidos
            where cantidad>6
                order by cantidad asc;

20. Mostrar el código de los pedidos donde el precio del pedido sea superior a la media de todos los pedidos 

select codigopedido
    from detallepedidos
        group by codigopedido
            having sum(cantidad*preciounidad)
                >
                    (select avg(sum(cantidad*preciounidad))
                        from detallepedidos
                            group by codigopedido);
        

/*
select pe.codigopedido
    from pedidos pe
        where
            (select sum(dp.cantidad*dp.preciounidad) as total
                    from detallepedidos dp
                        where pe.codigopedido=dp.codigopedido
                           group by dp.codigopedido)
        >(select avg(t.total)
            from (select codigopedido, sum(cantidad*preciounidad) as total
                        from detallepedidos
                            group by codigopedido) t);*/


/*Vistas*/
21. Realiza la vista que muestre los datos de un empleado (nombre, apellidos, ciudad de la oficina) 
y lo mismo para su jefe (en la misma fila)

create or replace view empleadosJefes as
    select e.codigoempleado, e.nombre||' '|| e.apellido1||' '|| e.apellido2 "Nombre completo empleado", oe.ciudad, 
        j.nombre||' '|| j.apellido1||' '||j.apellido2 "Nombre completo jefe", oj.ciudad
            from empleados e, oficinas oe, empleados j, oficinas oj
                where e.codigooficina=oe.codigooficina
                    and e.codigojefe=j.codigoempleado
                        and j.codigooficina=oj.codigooficina ORDER by e.codigoempleado asc;

22. Realiza una vista que muestre el código de pedido y su total en euros

create or replace view pedidos_total as
    select p.codigopedido, sum(dp.cantidad*dp.preciounidad) as total
        from pedidos p, detallepedidos dp
            where p.codigopedido=dp.codigopedido
                group by p.codigopedido;


23. Realiza una vista con la información del pedido
(código, fechapedido, fechaesperada, fechaentrega, nombre cliente y total en euros)

create or replace view info_pedido as
    select p.codigopedido, p.fechapedido, p.fechaesperada, p.fechaentrega, c.nombrecliente, pt.total
        from pedidos p, clientes C, pedidos_total pt
            where p.codigocliente=c.codigocliente
                and pt.codigopedido=p.codigopedido
                    order by pt.total desc;


24. Devolver la gama de productos más vendida. Sin Vistas

select t.gama , t.cantidad
from(
    select sum(dp.cantidad) as cantidad,  p.gama
        from detallepedidos dp, productos p
            where dp.codigoproducto=p.codigoproducto
             group by p.gama 
                    order by cantidad desc) t 
                    where rownum=1;

25. Devolver la gama de productos más vendida. Con Vistas

create or replace view gamas_vendidas as
    select sum(dp.cantidad) as cantidad,  p.gama
        from detallepedidos dp, productos p
            where dp.codigoproducto=p.codigoproducto
             group by p.gama

select gama, cantidad
    from gamas_vendidas
        where cantidad=
                        (select max(cantidad) 
                            from gamas_vendidas);

26. Muestra el país (cliente) donde menos pedidos se hacen. Usando vistas
select pais 
from(select c.pais, count(*)
    from clientes c, info_pedido ip
        where c.nombrecliente=ip.nombrecliente
            group by c.pais order by count(*) asc)
                where rownum=1;


