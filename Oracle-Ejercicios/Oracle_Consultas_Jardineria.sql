1. Muestra la ciudad y el código postal de las oficinas de España

select ciudad, codigopostal from oficinas where pais='España';

2. Obtener el nombre y el apellido del jefe de la empresa

select nombre, apellido1, apellido2 from empleados where codigojefe is null;

3. Mostrar el nombre y cargo de los empleados que no sean directores de oficina

select nombre, puesto from empleados where puesto!='Director Oficina';

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



