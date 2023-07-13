USE jardineria;
SELECT * FROM empleado;
-- 1. Devuelve un listado con el código de oficina y la ciudad donde hay oficinas.
SELECT codigo_oficina, ciudad FROM oficina;
-- 2. Devuelve un listado con la ciudad y el teléfono de las oficinas de España.
SELECT ciudad, telefono FROM oficina WHERE pais LIKE "España";
-- 3. Devuelve un listado con el nombre, apellidos y email de los empleados cuyo jefe tiene un código de jefe igual a 7.
SELECT nombre, apellido1, apellido2, email FROM empleado WHERE codigo_jefe = 7;
-- 4. Devuelve el nombre del puesto, nombre, apellidos y email del jefe de la empresa.
SELECT puesto, nombre, apellido1, apellido2, email FROM empleado WHERE codigo_jefe is null;
-- 5. Devuelve un listado con el nombre, apellidos y puesto de aquellos empleados que no sean representantes de ventas.
SELECT nombre, apellido1, apellido2, puesto FROM empleado WHERE puesto NOT LIKE "Representante Ventas";
-- 6. Devuelve un listado con el nombre de los todos los clientes españoles.
SELECT nombre_cliente FROM cliente WHERE pais LIKE "Spain";
-- 7. Devuelve un listado con los distintos estados por los que puede pasar un pedido.
SELECT DISTINCT estado FROM pedido;
-- 8. Devuelve un listado con el código de cliente de aquellos clientes que realizaron algún pago en 2008. Tenga en cuenta que deberá eliminar aquellos códigos de cliente que aparezcan
-- repetidos. Resuelva la consulta:
-- Utilizando la función YEAR de MySQL.
-- Utilizando la función DATE_FORMAT de MySQL.
-- Sin utilizar ninguna de las funciones anteriores.
SELECT DISTINCT codigo_cliente FROM pago WHERE fecha_pago BETWEEN '2008-01-01' AND '2008-12-31';
SELECT DISTINCT codigo_cliente FROM pago WHERE YEAR(fecha_pago)=2008;
SELECT DISTINCT codigo_cliente FROM pago WHERE DATE_FORMAT(fecha_pago, '%Y') = "2008"; -- si pongo 'y' minuscula se busca los 2 ultimos digitos del año

-- 9. Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de
-- entrega de los pedidos que no han sido entregados a tiempo.
SELECT * FROM pedido WHERE estado LIKE 'Entregado' HAVING fecha_entrega > fecha_esperada;

-- 10. Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de
-- entrega de los pedidos cuya fecha de entrega ha sido al menos dos días antes de la fecha esperada.
-- Utilizando la función ADDDATE de MySQL.
-- Utilizando la función DATEDIFF de MySQL.
SELECT * FROM pedido WHERE estado LIKE 'Entregado' AND fecha_entrega <= fecha_esperada -2;
SELECT * FROM pedido WHERE estado LIKE 'Entregado' AND ADDDATE(fecha_entrega, interval 2 DAY) <= fecha_esperada;
SELECT * FROM pedido WHERE estado LIKE 'Entregado' AND DATEDIFF(fecha_entrega, fecha_esperada) > 2;
-- 11. Devuelve un listado de todos los pedidos que fueron rechazados en 2009.
SELECT * FROM pedido WHERE estado LIKE 'Rechazado' AND YEAR(fecha_entrega) = 2009;
-- 12. Devuelve un listado de todos los pedidos que han sido entregados en el mes de enero de cualquier año.
SELECT * FROM pedido WHERE estado LIKE 'Entregado' AND date_format(fecha_entrega, '%m') = 01;  -- mayuscula busca con string ej 'enero'
-- 13. Devuelve un listado con todos los pagos que se realizaron en el año 2008 mediante Paypal.
-- Ordene el resultado de mayor a menor.
SELECT * FROM pago WHERE YEAR(fecha_pago) = 2008 AND forma_pago LIKE 'Paypal' ORDER BY total DESC;
-- 14. Devuelve un listado con todas las formas de pago que aparecen en la tabla pago. Tenga en
-- cuenta que no deben aparecer formas de pago repetidas.
SELECT DISTINCT forma_pago FROM pago;
-- 15. Devuelve un listado con todos los productos que pertenecen a la gama Ornamentales y que tienen más de 100 unidades en stock. 
-- El listado deberá estar ordenado por su precio de venta, mostrando en primer lugar los de mayor precio.
SELECT * FROM producto WHERE cantidad_en_stock > 100 AND gama LIKE 'ornamentales' ORDER BY precio_venta DESC;
-- 16. Devuelve un listado con todos los clientes que sean de la ciudad de Madrid y 
-- cuyo representante de ventas tenga el código de empleado 11 o 30.
SELECT * FROM cliente WHERE ciudad LIKE 'Madrid' AND codigo_empleado_rep_ventas in (11,30);

-- Consultas multitabla (Composición interna)
-- Las consultas se deben resolver con INNER JOIN.
-- 1. Obtén un listado con el nombre de cada cliente y el nombre y apellido de su representante de ventas.
SELECT nombre_cliente, concat(nombre," ",apellido1) AS Vendedor FROM cliente INNER JOIN empleado ON codigo_empleado = codigo_empleado_rep_ventas; 

-- 2. Muestra el nombre de los clientes que hayan realizado pagos junto con el nombre de sus representantes de ventas.
SELECT DISTINCT nombre_cliente, concat(nombre," ",apellido1) AS Vendedor FROM cliente 
	INNER JOIN empleado ON codigo_empleado = codigo_empleado_rep_ventas 
	INNER JOIN pago ON pago.codigo_cliente = cliente.codigo_cliente;
-- 3. Muestra el nombre de los clientes que no hayan realizado pagos junto con el nombre de sus representantes de ventas.
SELECT DISTINCT nombre_cliente, concat(nombre," ",apellido1) AS Vendedor FROM cliente 
	INNER JOIN empleado ON codigo_empleado = codigo_empleado_rep_ventas 
	WHERE codigo_cliente NOT IN (SELECT codigo_cliente FROM pago);
-- 4. Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus representantes
-- junto con la ciudad de la oficina a la que pertenece el representante.
SELECT DISTINCT nombre_cliente, concat(nombre," ",apellido1) AS Vendedor, oficina.ciudad FROM cliente 
	INNER JOIN empleado ON codigo_empleado = codigo_empleado_rep_ventas
    INNER JOIN pago ON pago.codigo_cliente = cliente.codigo_cliente
	INNER JOIN oficina ON oficina.codigo_oficina = empleado.codigo_oficina;
-- 5. Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre de sus
-- representantes junto con la ciudad de la oficina a la que pertenece el representante.
SELECT DISTINCT nombre_cliente, concat(nombre," ",apellido1) AS Vendedor, oficina.ciudad FROM cliente
INNER JOIN empleado ON codigo_empleado_rep_ventas = codigo_empleado
INNER JOIN oficina ON oficina.codigo_oficina = empleado.codigo_oficina
WHERE codigo_cliente NOT IN (SELECT codigo_cliente FROM pago);

-- 6. Lista la dirección de las oficinas que tengan clientes en Fuenlabrada.
SELECT DISTINCT concat(oficina.linea_direccion1, " y ", oficina.linea_direccion2) AS Dirección, oficina.ciudad FROM oficina 
	INNER JOIN empleado ON oficina.codigo_oficina = empleado.codigo_oficina
    INNER JOIN cliente ON codigo_empleado_rep_ventas = codigo_empleado
    WHERE cliente.ciudad LIKE 'Fuenlabrada';

SELECT concat(oficina.linea_direccion1, " y ", oficina.linea_direccion2) AS Dirección, oficina.ciudad FROM oficina 
WHERE oficina.ciudad IN (SELECT cliente.ciudad FROM cliente WHERE cliente.ciudad LIKE 'Fuenlabrada');
-- WHERE oficina.ciudad LIKE oficina.ciudad ='Fuenlabrada' AND (SELECT cliente.ciudad FROM cliente WHERE cliente.ciudad LIKE 'Fuenlabrada');

-- 7. Devuelve el nombre de los clientes y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.
SELECT nombre_cliente, concat(nombre," ",apellido1) as Nombre_empleado, oficina.ciudad FROM cliente 
	INNER JOIN empleado ON codigo_empleado =codigo_empleado_rep_ventas
    INNER JOIN oficina ON oficina.codigo_oficina = empleado.codigo_oficina;

-- 8. Devuelve un listado con el nombre de los empleados junto con el nombre de sus jefes.
SELECT concat(empleado.nombre," ",empleado.apellido1) as Jefe, concat(jefe.nombre," ",jefe.apellido1) as Empleado FROM empleado 
	INNER JOIN empleado jefe ON jefe.codigo_jefe = empleado.codigo_empleado; -- investigar porque se igualan esos codigos

-- 9. Devuelve el nombre de los clientes a los que no se les ha entregado a tiempo un pedido.
SELECT nombre_cliente, estado FROM pedido
	INNER JOIN cliente ON pedido.codigo_cliente = cliente.codigo_cliente
    WHERE fecha_esperada<fecha_entrega;

-- 10. Devuelve un listado de las diferentes gamas de producto que ha comprado cada cliente.
SELECT DISTINCT nombre_cliente, gama FROM producto
	INNER JOIN detalle_pedido ON producto.codigo_producto = detalle_pedido.codigo_producto
    INNER JOIN pedido ON detalle_pedido.codigo_pedido = pedido.codigo_pedido
    INNER JOIN cliente ON pedido.codigo_cliente = cliente.codigo_cliente;