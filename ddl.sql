use sakilacampus;


create table if not exists sakilacampus.pais(
id_pais smallint unsigned primary key,
nombre varchar(50),
ultima_actualizacion timestamp
);


create table sakilacampus.ciudad(
id_ciudad smallint unsigned primary key,
nombre varchar(50),
id_pais smallint unsigned,
ultima_actualizacion timestamp,
foreign key (id_pais) references sakilacampus.pais(id_pais)
);



create table sakilacampus.direccion(
id_direccion smallint unsigned primary key,
direccion varchar(50),
direccion2 varchar(50),
distrito varchar(20),
id_ciudad smallint unsigned,
codigo_postal varchar(10),
telefono varchar(20),
ultima_actualizacion timestamp,
foreign key (id_ciudad) references sakilacampus.ciudad(id_ciudad)
);


create table sakilacampus.empleado(
id_empleado tinyint unsigned primary key,
nombre varchar(45),
apellidos varchar(45),
id_direccion smallint unsigned,
imagen blob,
email varchar(50),
id_almacen tinyint unsigned,
activo tinyint(1),
username varchar(16),
password varchar(40),
ultima_actualizacion timestamp,
foreign key (id_direccion) references sakilacampus.direccion(id_direccion)
);




create table sakilacampus.almacen(
id_almacen tinyint unsigned primary key,
id_empleado_jefe tinyint unsigned,
id_direccion smallint unsigned,
ultima_actualizacion timestamp,
foreign key (id_empleado_jefe) references sakilacampus.empleado(id_empleado),
foreign key (id_direccion) references sakilacampus.direccion(id_direccion)
);



create table sakilacampus.idioma(
id_idioma tinyint unsigned primary key,
nombre varchar(20),
ultima_actualizacion timestamp
);


SELECT * from ciudad p ;


create table sakilacampus.pelicula(
id_pelicula smallint unsigned primary key,
titulo varchar(225),
descripcion text,
anyo_lanzamiento year,
id_idioma  tinyint unsigned,
id_idioma_original  tinyint unsigned,
duracion_alquiler  tinyint unsigned,
rental_rate decimal(4,2),
duracion smallint unsigned,
replacement_cost decimal(5,2),
clasificacion enum("G","PG","PG-13","R","NC-17"),
caracteristicas_especiales set("Trailers","Commentaries","Deleted Scenes","Behind the Scenes"),
ultima_actualizacion timestamp,
foreign key (id_idioma) references sakilacampus.idioma(id_idioma)
);



create table sakilacampus.actor(
	id_actor smallint unsigned primary key,
	nombre varchar(45),
	apellidos varchar(45),
	ultima_actualizacion timestamp
);


create table sakilacampus.pelicula_actor(
	id_actor smallint unsigned ,
	id_pelicula smallint unsigned,
	ultima_actualizacion timestamp,
	foreign key (id_actor) references sakilacampus.actor(id_actor),
	foreign key (id_pelicula) references sakilacampus.pelicula(id_pelicula)
);




create table sakilacampus.categoria(
	id_categoria tinyint unsigned primary key,
	nombre varchar(25),
	ultima_actualizacion timestamp
);


create table sakilacampus.pelicula_categoria(
	id_pelicula smallint unsigned,
	id_categoria tinyint unsigned ,
	ultima_actualizacion timestamp,
	foreign key (id_pelicula) references sakilacampus.pelicula(id_pelicula),
	foreign key (id_categoria) references sakilacampus.categoria(id_categoria)
);


create table sakilacampus.inventario(
	id_inventario mediumint unsigned primary key,
	id_pelicula smallint unsigned,
	id_almacen tinyint unsigned,
	ultima_actualizacion timestamp,
	foreign key (id_pelicula) references sakilacampus.pelicula(id_pelicula),
	foreign key (id_almacen) references sakilacampus.almacen(id_almacen)
);



create table sakilacampus.cliente(
id_cliente smallint unsigned primary key,
id_almacen tinyint unsigned,
nombre varchar(45),
apellidos varchar(45),
email varchar(50),
id_direccion smallint unsigned,
activo tinyint(1),
fecha_creacion datetime,
ultima_actualizacion timestamp,
foreign key (id_almacen) references sakilacampus.almacen(id_almacen),
foreign key (id_direccion) references sakilacampus.direccion(id_direccion)
);



create table sakilacampus.alquiler(
id_alquiler int primary key,
fecha_alquiler datetime,
id_inventario mediumint unsigned,
id_cliente smallint unsigned,
fecha_devolucion datetime,
id_empleado tinyint unsigned,
ultima_actualizacion timestamp,
foreign key (id_cliente) references sakilacampus.cliente(id_cliente),
foreign key (id_inventario) references sakilacampus.inventario(id_inventario),
foreign key (id_empleado) references sakilacampus.empleado(id_empleado)
);


create table sakilacampus.film_text(
	film_id smallint primary key,
	title varchar(255),
	descripcion text
);



create table sakilacampus.pago(
	id_pago smallint unsigned primary key,
	id_cliente smallint unsigned,
	id_empleado tinyint unsigned,
	id_alquiler int,
	total decimal(5,2),
	fecha_pago datetime,
	ultima_actualizacion timestamp,
	foreign key (id_cliente) references sakilacampus.cliente(id_cliente),
	foreign key (id_empleado) references sakilacampus.empleado(id_empleado),
	foreign key (id_alquiler) references sakilacampus.alquiler(id_alquiler)
);



