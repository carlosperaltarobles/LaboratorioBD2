-- tarea
-- Agregar un procedimiento almacenado que deba agragat un resgistro a culquiera de las tablas de la base de datos
-- Aerolineas
use Aerolinea;
create procedure InsertarPasajero
@Nombre varchar(50),
@Apellido varchar(50),
@documento varchar(50),
@correo_electronico varchar(50),
@telefono varchar(50)
as
begin
insert into Pasajeros
values(@Nombre,@Apellido,@documento,@correo_electronico,@telefono)
end

execute
InsertarPasajero
    'Juan','Perez','123456', 'j@mail.com','1234567';


-- Agreggar un prodecimiento almacenado que permita realizar consulta a cualquiera de las tablas de la base de datos
-- Aerolineas, Multitabla , o subconsulta o join

create procedure ConsultarDatosPasajero
as
begin
    -- realizar una subconsulta donde se seleccione el nombre del pasajero y el numero de vuelo
-- donde la fecha de salida sea un fecha especifica, la columna fecha_salida esta en la tabla salidas
-- y la columna numero_vuelo esta en la tabla vuelos, y la columna nombre esta en la tabla pasajeros

select *
from (select a.id,a.nombre, b.numero_vuelo, c.fecha_salida
      from Pasajeros a,
           Vuelos b,
           Salidas c
      where a.id = (select id_pasajero
                    from Reservaciones
                    where id_pasajero = a.id)
        and b.id = (select id_vuelo
                    from Reservaciones
                    where id_pasajero = a.id)
        and b.id_salida = c.id
        and c.fecha_salida = '2023-09-03') n

end

execute ConsultarDatosPasajero

