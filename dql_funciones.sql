-- 1 TotalIngresosCliente(ClienteID, Año): Calcula los ingresos generados por un cliente en un año específico.

use sakilacampus;

DELIMITER $$
CREATE FUNCTION totalIngresosCliente(clienteid int , anio year)
RETURNS float(10,2) DETERMINISTIC
BEGIN
    DECLARE ingresos float(10,2);
    SELECT count(p.total)  INTO ingresos
    FROM pago p JOIN cliente c ON c.id_cliente = p.id_cliente
 	WHERE c.id_cliente = 1 and year(p.fecha_pago) = anio ;
  
    RETURN ingresos;
END $$
DELIMITER ;

-- 2 PromedioDuracionAlquiler(PeliculaID): Retorna la duración promedio de alquiler de una película específica.

DELIMITER $$
CREATE FUNCTION PromedioDuracionAlquiler(PeliculaID int )
RETURNS float(10,2) DETERMINISTIC
BEGIN
    DECLARE promedio float(10,2);
    SELECT avg(p.duracion)  INTO promedio
    FROM pelicula p JOIN inventario i ON p.id_pelicula = i.id_pelicula
    	join alquiler a on i.id_inventario = a.id_inventario
 	WHERE p.id_pelicula = 1;
    RETURN promedio;
END $$
DELIMITER ;




-- 3 IngresosPorCategoria(CategoriaID): Calcula los ingresos totales generados por una categoría específica de películas.
SELECT * from pelicula p ;

DELIMITER $$
CREATE FUNCTION IngresosPorCategoria(CategoriaID int )
RETURNS float(10,2) DETERMINISTIC
BEGIN
    DECLARE ingresos float(10,2);
    SELECT sum(pa.total) INTO ingresos
    from categoria c  join pelicula_categoria pc ON  c.id_categoria = pc.id_categoria 
		join pelicula p on p.id_pelicula = pc.id_pelicula 
		join inventario i on p.id_pelicula = i.id_pelicula 
		join alquiler a on i.id_inventario = a.id_inventario
		join pago pa on a.id_alquiler = pa.id_alquiler
 	WHERE c.id_categoria = CategoriaID ;
    RETURN ingresos;
END $$
DELIMITER ;


-- 5 DEsClienteVIP(ClienteID): Verifica si un cliente es "VIP" basándose en la cantidad de alquileres realizados y los ingresos generados.


DELIMITER $$
CREATE FUNCTION DEsClienteVIP(ClienteID int )
RETURNS float(10,2) DETERMINISTIC
BEGIN
    DECLARE ingresos float(10,2);
   	declare alquilerempleado int;
   declare  mensaje varchar(100);
   
    SELECT sum(p.total) INTO ingresos
    from empleado e  join pago p  on e.id_empleado = p.id_empleado
 	WHERE e.id_empleado = ClienteID ;
 
 	SELECT count(a.id_empleado) into alquilerempleado 
 	FROM alquiler a join empleado e2 on e2.id_empleado = a.id_empleado
 	where e2.id_empleado = ClienteID;
 	
 	if ((ingresos > 10) and (alquilerempleado > 2)) then 
 		set mensaje = "VIP";
 		return mensaje;
 		ELSE
 			set mensaje = "Normal";
			RETURN mensaje;
				
		end if;
END $$
DELIMITER ;

















