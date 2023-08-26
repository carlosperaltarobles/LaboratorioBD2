create database Aerolinea;

use Aerolinea;

create table Aviones(
 id int primary key identity(1,1),
 modelo varchar(255),
 capacidad int,
 tipo varchar(255),
);

create table Vuelos(
	id int primary key identity(1,1),
	numero_vuelo varchar(150),
	duracion int,
	id_avion int not null,
	id_salida int not null,
	id_llegada int not null,
	aerolinea varchar(255)
);

create table Salidas(
	id int primary key identity(1,1),
	origen varchar(150),
	destino varchar(150),
	escalas varchar(150),
	fecha_salida date,
	hora_salida time,
);

create table LLegadas(
	id int primary key identity(1,1),
	origen varchar(150),
	destino varchar(150),
	escalas varchar(150),
	fecha_salida date,
	hora_salida time,
);

create table Pasajeros(
	id int primary key identity(1,1),
	nombre varchar(150),
	apellido varchar(150),
	documento varchar(255),
	correo_electronico varchar(150),
	telefono varchar(15)
);

create table Reservaciones(
	id int primary key identity(1,1),
	id_vuelo int not null,
	id_pasajero int not null,
	asiento varchar(25),
	clase varchar(150),
	precio float,
);

alter table Vuelos add foreign key(id_avion)  references Aviones(id);
alter table Vuelos add foreign key(id_salida)  references Salidas(id);
alter table Vuelos add foreign key(id_llegada)  references Llegadas(id)
alter table Reservaciones add foreign key(id_vuelo) references Vuelos(id);
alter table Reservaciones add foreign key(id_pasajero) references Pasajeros(id);

