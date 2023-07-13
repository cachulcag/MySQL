USE personal;
SELECT * FROM empleados;
SELECT * FROM departamentos;
SELECT nombre_depto FROM departamentos;
-- 4 Obtener el nombre y salario de todos los empleados.
SELECT nombre, sal_emp FROM empleados;
-- 5. Listar todas las comisiones. 
SELECT comision_emp FROM empleados;
-- 6. Obtener los datos de los empleados cuyo cargo sea ‘Secretaria’.
SELECT cargo_emp FROM empleados WHERE cargo_emp LIKE "Secretaria";
-- 7. Obtener los datos de los empleados vendedores, ordenados por nombre alfabéticamente.
SELECT nombre FROM empleados WHERE cargo_emp LIKE "Vendedor" ORDER BY nombre;
-- 8. Obtener el nombre y cargo de todos los empleados, ordenados por salario de menor a mayor.
SELECT nombre, cargo_emp FROM empleados ORDER BY sal_emp DESC;
-- 9. Obtener el nombre de o de los jefes que tengan su departamento situado en la ciudad de “Ciudad Real”
SELECT nombre_jefe_depto FROM departamentos WHERE ciudad LIKE "Ciudad Real";  
-- 10. Elabore un listado donde para cada fila, figure el alias ‘Nombre’ y ‘Cargo’ para las respectivas tablas de empleados.
SELECT nombre AS "Nombre" , cargo_emp AS "Cargo" FROM empleados;
-- 11. Listar los salarios y comisiones de los empleados del departamento 2000, ordenado por comisión de menor a mayor.
SELECT sal_emp, comision_emp FROM empleados WHERE id_depto LIKE "2000" ORDER BY comision_emp DESC;
-- 12. Obtener el valor total a pagar a cada empleado del departamento 3000, que resulta
-- de: sumar el salario y la comisión, más una bonificación de 500. Mostrar el nombre del empleado y el total a pagar, en orden alfabético.
SELECT nombre, (sal_emp + comision_emp + 500) AS "SALARIO_FINAL" FROM empleados WHERE id_depto LIKE "3000" ORDER BY nombre;
-- 13. Muestra los empleados cuyo nombre empiece con la letra J.
SELECT nombre FROM empleados WHERE nombre LIKE "J%";
-- 14. Listar el salario, la comisión, el salario total (salario + comisión) y nombre, de aquellos 
-- empleados que tienen comisión superior a 1000.
SELECT sal_emp, comision_emp, (sal_emp + comision_emp) AS "Salario_Total", nombre FROM empleados WHERE comision_emp >1000;
-- 15. Obtener un listado similar al anterior, pero de aquellos empleados que NO tienen comisión.
SELECT sal_emp, comision_emp, (sal_emp + comision_emp) AS "Salario_Total", nombre FROM empleados WHERE comision_emp =0;
-- 16. Obtener la lista de los empleados que ganan una comisión superior a su sueldo.
SELECT nombre FROM empleados WHERE comision_emp > sal_emp;
-- 17 Listar los empleados cuya comisión es menor o igual que el 30% de su sueldo.
SELECT nombre FROM empleados WHERE comision_emp <= sal_emp * 0.30;
-- 18. Hallar los empleados cuyo nombre no contiene la cadena “MA”
SELECT nombre FROM empleados WHERE nombre NOT LIKE "%MA%";
-- 19. Obtener el nombre del jefe de los departamentos que sean “Ventas”, “Investigación” o ‘Mantenimiento.
SELECT nombre_jefe_depto, nombre_depto FROM departamentos WHERE nombre_depto IN ("Ventas", "Investigación", "Mantenimiento");
-- 20. Ahora obtener el contrario, los nombres de los departamentos que no sean “Ventas” ni “Investigación” ni ‘Mantenimiento.
SELECT nombre_jefe_depto, nombre_depto FROM departamentos WHERE nombre_depto NOT IN ("Ventas", "Investigación", "Mantenimiento");
-- 21. Mostrar el salario más alto de la empresa.
SELECT max(sal_emp) FROM empleados;
-- 22. Mostrar el nombre del último empleado de la lista por orden alfabético.
SELECT max(nombre) FROM empleados ORDER BY nombre ASC;
-- 23. Hallar el salario más alto, el más bajo y la diferencia entre ellos.
SELECT max(sal_emp), min(sal_emp), (max(sal_emp) - min(sal_emp) AS "DIFERENCIA" FROM empleados;
