use Aerolinea;
--Realizar 5 consultas (normales) que incluya operadores aritm�ticos o l�gicos, obtenci�n
--de datos del sistema, as� como c�lculos aritm�ticos sobre cualquier tabla de la Base de Datos


-- 1- Hacer la sumatoria de todos los precios de la tabla de reservaciones

SELECT 
 COUNT(*) AS Reservaciones, 
 SUM(precio) AS Total_$
 FROM Reservaciones;

-- 2- Vuelos que pasen de $200.00
SELECT * FROM Reservaciones
 WHERE precio >= 200 ;

-- 3- Ver los numero de telefonos que comienzan con el n�mero 25
SELECT * FROM Pasajeros
 WHERE telefono LIKE '25%';

-- 4- Ver la capcidad de pasajeros que puede llevar el avi�n Airbus A380
SELECT 
 modelo, capacidad
 FROM Aviones
 WHERE modelo = 'Airbus A380' AND tipo = 'Comercial';

-- 5- Saber cuales vuelos salen despues de las 11:00 am
SELECT *FROM Salidas
 WHERE hora_salida > '11:00:00';




 -- Realizar 5 consultas de tipo Multitabla, Subconsulta y Joins sobre la Base de Datos.

 -- MULTITABLA
 -- 1- Ver el numero de vuelo con su respectiva salida y la fecha de salida, solo para el 
 --    caso de sonsonate 
SELECT V.numero_vuelo, S.origen, S.fecha_salida
FROM Vuelos AS V
JOIN Salidas AS S ON V.id_salida = S.id
WHERE S.origen = 'Sonsonate';


-- 2- Mostrar la aerolinea y ver cuantas reservaciones tienen respectivamente
SELECT V.Aerolinea, COUNT(*) AS Reservaciones
FROM Vuelos AS V
JOIN Reservaciones AS R ON V.id = R.ID_Vuelo
GROUP BY V.aerolinea;


-- 3- Ver los detalles de la tabla salida pero a su vez ver la aerolinea correspondiente

SELECT S.*, V.aerolinea
FROM Salidas AS S
JOIN Vuelos AS V ON S.id = V.id_salida;


-- 4- Mostrar los tipos de clase de vuelos que hay y cuantos pasajeros van en 
--	  esa clase 
SELECT R.clase, COUNT(R.ID_Pasajero) AS Pasajeros
FROM Reservaciones AS R
GROUP BY R.Clase;


-- 5- Ver los vuelos que hay, la aerol�nea y su respectiva escala 

SELECT V.numero_vuelo, V.aerolinea, S.escalas
FROM Vuelos AS V
JOIN Salidas AS S ON V.id_salida = S.id
WHERE S.escalas IS NOT NULL;
-- consultas con inner join
select a.id,a.modelo,b.numero_vuelo
from Aviones a
inner join Vuelos b
on a.id=b.id_avion
order by a.id;


select a.id,a.nombre, a.apellido,b.id as idReservacion, b.asiento
from Pasajeros a
inner join Reservaciones b
on a.id=b.id_pasajero
order by a.id;

select a.id,a.nombre ,a.apellido,b.clase
from Pasajeros a
inner join Reservaciones b
on a.id=b.id_pasajero 
where b.clase='Turista' 
order by a.id;

select a.id,a.numero_vuelo,b.origen,b.destino 
from Vuelos a
inner join Salidas b
on a.id_llegada=b.id;

select a.id ,b.numero_vuelo,c.modelo
from Reservaciones a
inner join Vuelos b
on a.id_vuelo=b.id 
inner join Aviones c
on b.id_avion=c.id
order by a.id;

-- subconsultas ---------------------------

Select (select *
        from (select a.nombre
              from Pasajeros a
              where id = 2) an)

-- seccionar todo los nombres de los pasajeros en una subconsulta comparando el where , donde se selecione los el id del psajero
-- que coincidda con el id_pasajero de la tabla reservaciones
-- y se seleccione el nombre de la tabla pasajeros

SELECT a.nombre
FROM Pasajeros a
WHERE id = (SELECT id_pasajero
            FROM Reservaciones
            WHERE id_pasajero = a.id)

-- seccionar todo los nombres de los pasajeros, la clase de la tabla reservaciones en una subconsulta comparando el where
-- donde se selecione los el id del psajero que coincidda con el id_pasajero de la tabla reservaciones
-- y se seleccione el nombre de la tabla pasajeros, pero que los resultados no se multipliquen en la subconsulta

SELECT a.nombre, b.clase
FROM Pasajeros a, Reservaciones b
WHERE a.id = (SELECT id_pasajero
              FROM Reservaciones
              WHERE id_pasajero = a.id)
  AND b.id_pasajero = a.id


-- utilizando subconsultas , selecionar los pasajeros que el origen es España , el resultado debe ser el nombre del pasajero
-- y el origen, la columan origen esta en la tabla LLegadas y la columna nombre en la tabla pasajeros

select *
from (select a.id, a.nombre, b.origen
      from Pasajeros a,
           LLegadas b,
           Vuelos c
      where a.id = (select id_pasajero
                    from Reservaciones
                    where id_pasajero = a.id)
        and c.id = (select id_vuelo
                    from Reservaciones
                    where id_pasajero = a.id)
        and c.id_llegada = b.id
        and b.origen = 'España') n

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
