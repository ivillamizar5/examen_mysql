use sakilacampus;

-- 1 Encuentra el cliente que ha realizado la mayor cantidad de alquileres en los últimos 6 meses.



-- 2 Lista las cinco películas más alquiladas durante el último año.

select p.titulo as "Pelicula"
from alquiler a join inventario i on a.id_inventario = i.id_inventario
	 join pelicula p on p.id_pelicula = i.id_pelicula 
order by  year(a.fecha_alquiler ) desc limit 5;


-- 3 Obtén el total de ingresos y la cantidad de alquileres realizados por cada categoría de película.

SELECT sum(p.total) , c.nombre 
from pago p join  alquiler a  on p.id_alquiler = a.id_alquiler
			join inventario i on i.id_inventario = a.id_inventario
			join pelicula p2 on p2.id_pelicula = i.id_pelicula 
			JOIN pelicula_categoria pc on pc.id_pelicula = p2.id_pelicula 
			JOIN categoria c on c.id_categoria = pc.id_categoria 
group by c.id_categoria;


-- 4. Calcula el número total de clientes que han realizado alquileres por cada idioma disponible en un mes específico.

select COUNT(DISTINCT  c.id_cliente), i2.nombre 
from cliente c join alquiler a on c.id_cliente = c.id_cliente
				join inventario i on a.id_inventario = i.id_inventario 
				join pelicula p on p.id_pelicula = i.id_inventario 
				join idioma i2 on i2.id_idioma = p.id_idioma 
WHERE MONTH(a.fecha_alquiler) = 05
GROUP by i2.id_idioma ;


-- 5 


-- 6 

-- 7 Muestra las cinco categorías con menos alquileres registrados en el último año
	select c.nombre , count(DISTINCT p.id_pelicula) as "cantidad alquileres"
	from categoria c  join pelicula_categoria pc ON  c.id_categoria = pc.id_categoria 
		join pelicula p on p.id_pelicula = pc.id_pelicula 
		join inventario i on p.id_pelicula = i.id_pelicula 
		join alquiler a on i.id_inventario = a.id_inventario 
	group by c.nombre
	ORDER by count(DISTINCT p.id_pelicula) LIMIT 5 
	


-- 8 Calcula el promedio de días que un cliente tarda en devolver las películas alquiladas.
	
	SELECT avg(DAY(a.fecha_devolucion))
	from alquiler a join cliente c on c.id_cliente = a.id_alquiler 
	WHERE c.id_cliente = 1;


-- 9. Encuentra los cinco empleados que gestionaron más alquileres en la categoría de Acción.

SELECT c2.nombre, count(a.id_cliente)
from categoria c  join pelicula_categoria pc ON  c.id_categoria = pc.id_categoria 
		join pelicula p on p.id_pelicula = pc.id_pelicula 
		join inventario i on p.id_pelicula = i.id_pelicula 
		join alquiler a on i.id_inventario = a.id_inventario
		join cliente c2 on c2.id_cliente = a.id_cliente
		join empleado e on e.id_empleado = a.id_empleado 
		where c.nombre = "Acción"
	group by c2.nombre
	order by count(a.id_cliente) desc limit 5 

 


























































