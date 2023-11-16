use Aerolinea;

select  a.id, b.numero_vuelo,c.nombre,a.asiento,a.clase,a.precio
from Reservaciones a
inner join Vuelos b on a.id_vuelo = b.id
inner join Pasajeros c on a.id_pasajero = c.id;

-- crear la vista
create view VistaReservaciones as
select  a.id, b.numero_vuelo,c.nombre,a.asiento,a.clase,a.precio
from Reservaciones a
inner join Vuelos b on a.id_vuelo = b.id
inner join Pasajeros c on a.id_pasajero = c.id;

-- consultar la vista
select * from VistaReservaciones;


