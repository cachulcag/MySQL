USE tienda;
-- 1. Lista el nombre de todos los productos que hay en la tabla producto.
SELECT nombre FROM producto; 
-- 2. Lista los nombres y los precios de todos los productos de la tabla producto.
SELECT nombre, precio FROM producto;
-- 3. Lista todas las columnas de la tabla producto.
SELECT * FROM producto;
-- 4. Lista los nombres y los precios de todos los productos de la tabla producto, redondeando el valor del precio.
SELECT nombre, round(precio) FROM producto;
-- 5. Lista el código de los fabricantes que tienen productos en la tabla producto.
SELECT fabricante.nombre, codigo_fabricante FROM producto INNER JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo ;
-- 6. Lista el código de los fabricantes que tienen productos en la tabla producto, sin mostrar los repetidos.
SELECT DISTINCT fabricante.nombre, codigo_fabricante FROM producto INNER JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo ;
-- 7. Lista los nombres de los fabricantes ordenados de forma ascendente.
SELECT nombre FROM fabricante ORDER BY nombre ASC;
-- 8. Lista los nombres de los productos ordenados en primer lugar por el nombre de forma ascendente y en segundo lugar por el precio de forma descendente.
SELECT nombre FROM producto ORDER BY nombre ASC;
SELECT nombre, precio FROM producto ORDER BY precio DESC;
-- 9. Devuelve una lista con las 5 primeras filas de la tabla fabricante.
SELECT * FROM fabricante LIMIT 5;
-- 10. Lista el nombre y el precio del producto más barato. (Utilice solamente las cláusulas ORDER BY y LIMIT)
SELECT nombre, precio FROM producto ORDER BY precio ASC LIMIT 1;
-- 11. Lista el nombre y el precio del producto más caro. (Utilice solamente las cláusulas ORDER BY y LIMIT)
SELECT nombre, precio FROM producto ORDER BY precio DESC LIMIT 1;
-- 12. Lista el nombre de los productos que tienen un precio menor o igual a $120.
SELECT nombre, precio FROM producto WHERE precio <= 120;
-- 13. Lista todos los productos que tengan un precio entre $60 y $200. Utilizando el operador BETWEEN.
SELECT * FROM producto WHERE precio BETWEEN 60 AND 200; 
-- 14. Lista todos los productos donde el código de fabricante sea 1, 3 o 5. Utilizando el operador IN.
SELECT * FROM producto WHERE codigo_fabricante IN (1,3,5);
-- 15. Devuelve una lista con el nombre de todos los productos que contienen la cadena Portátil en el nombre.
SELECT nombre FROM producto WHERE nombre LIKE "%Portátil%"; 
## CONSULTA MULTITABLA
-- 1. Devuelve una lista con el código del producto, nombre del producto, código del fabricante y nombre del fabricante, de todos los productos de la base de datos.
SELECT producto.codigo, producto.nombre, codigo_fabricante, fabricante.nombre FROM producto LEFT JOIN fabricante ON producto.codigo_fabricante=fabricante.codigo;
-- 2. Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos
-- los productos de la base de datos. Ordene el resultado por el nombre del fabricante, por orden alfabético.
SELECT producto.nombre, precio, fabricante.nombre FROM producto LEFT JOIN fabricante ON producto.codigo_fabricante=fabricante.codigo ORDER BY fabricante.nombre ASC;
-- 3. Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más barato.
SELECT producto.nombre, precio, fabricante.nombre FROM producto LEFT JOIN fabricante ON producto.codigo_fabricante=fabricante.codigo ORDER BY precio ASC LIMIT 1;
-- 4. Devuelve una lista de todos los productos del fabricante Lenovo.
SELECT * FROM producto INNER JOIN fabricante ON producto.codigo_fabricante=fabricante.codigo WHERE fabricante.nombre LIKE "%LENOVO%";
-- 5. Devuelve una lista de todos los productos del fabricante Crucial que tengan un precio mayor que $200.
SELECT * FROM producto INNER JOIN fabricante ON producto.codigo_fabricante=fabricante.codigo WHERE precio>200 and fabricante.nombre  LIKE "%CRUCIAL%";
-- 6. Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packard. Utilizando el operador IN.
SELECT * FROM producto INNER JOIN fabricante ON producto.codigo_fabricante=fabricante.codigo WHERE fabricante.nombre IN ("Asus", "Hewlett-Packard");
-- 7. Devuelve un listado con el nombre de producto, precio y nombre de fabricante, de todos los productos que tengan un precio mayor o igual a $180. Ordene el resultado en primer
-- lugar por el precio (en orden descendente) y en segundo lugar por el nombre (en orden ascendente)
SELECT producto.nombre precio, fabricante.nombre FROM producto LEFT JOIN fabricante ON producto.codigo_fabricante=fabricante.codigo WHERE precio>=180 ORDER BY precio DESC;
SELECT producto.nombre precio, fabricante.nombre FROM producto LEFT JOIN fabricante ON producto.codigo_fabricante=fabricante.codigo WHERE precio>=180 ORDER BY producto.nombre ASC;
-- 8. Devuelve un listado de todos los fabricantes que existen en la base de datos, junto con los
-- productos que tiene cada uno de ellos. El listado deberá mostrar también aquellos fabricantes que no tienen productos asociados.
SELECT fabricante.nombre, producto.nombre FROM fabricante LEFT JOIN producto ON  producto.codigo_fabricante=fabricante.codigo;
-- 9. Devuelve un listado donde sólo aparezcan aquellos fabricantes que no tienen ningún producto asociado.
SELECT fabricante.nombre, producto.nombre FROM fabricante LEFT JOIN producto ON  producto.codigo_fabricante=fabricante.codigo ;