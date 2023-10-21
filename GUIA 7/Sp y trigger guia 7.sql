-- creacion de triggers para la tabla pasajeros

use aerolinea;
create table auditoriaPasajeros
(
    id int not null,
    nombre varchar(50) not null,
    apellido varchar(50) not null,
    documento varchar(50) not null,
    correo_electronico varchar(80) not null,
);


create trigger ReportePasajeros
on pasajeros
after insert
as
    begin
        -- variables para el trigger
        declare @idT int;
        declare @nombreT varchar(50);
        declare @apellidoT varchar(50);
        declare @documentoT varchar(50);
        declare @correo_electronicoT varchar(80);
        declare @telefonoT varchar(50);

        -- otetener informacion del utlimo registro insertado en la tabla pasajeros
        select top 1
            @idT = id,
            @nombreT = nombre,
            @apellidoT = apellido,
            @documentoT = documento,
            @correo_electronicoT = correo_electronico,
            @telefonoT = telefono
        from inserted


        -- insertar en la tabla de auditoriaPasajeros
        insert into auditoriaPasajeros
        values
        (
            @idT,
            @nombreT,
            @apellidoT,
            @documentoT,
            @correo_electronicoT
        );

        -- notificar que se inserto un nuevo registro en la tabla auditoriaPasajeros
        print 'Se inserto un nuevo registro en la tabla auditoriaPasajeros';
    end

    -- insertar un nuevo registro en la tabla pasajeros
    insert into pasajeros
    (nombre, apellido, documento, correo_electronico, telefono)
    values
    (
        'Juan',
        'Perez',
        '123456789',
        'jp@mail.com',
        '123456789'
    );

-- consultar la tabla auditoriaPasajeros
select * from auditoriaPasajeros;

-- consultar los triggers de la base de datos
select name as TriggerName, object_name(parent_id) as TableName
from sys.triggers;


-- -------------------------------
-- crear un procedimiento almacenado que dispare el trigger auditoriaPasajeros cuando se inserte un nuevo registro en la tabla pasajeros

use aerolinea;

create procedure spInsertarPasajero
(
    @nombre varchar(50),
    @apellido varchar(50),
    @documento varchar(50),
    @correo_electronico varchar(80),
    @telefono varchar(50)
)
as
    begin
        -- insertar un nuevo registro en la tabla pasajeros
        insert into pasajeros
        (nombre, apellido, documento, correo_electronico, telefono)
        values
        (
            @nombre,
            @apellido,
            @documento,
            @correo_electronico,
            @telefono
        );
    end

    --consultar los procedimientos almacenados de la base de datos

    select * from sys.procedures;


    -- ejecutar el procedimiento almacenado
    exec spInsertarPasajero 'Mario', 'Diaz','1234568','md@mail.com' ,'123456789';

    -- consultar la tabla auditoriaPasajeros
    select * from auditoriaPasajeros;