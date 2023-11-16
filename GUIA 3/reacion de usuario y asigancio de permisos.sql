-- crear un usuario sql server

create login [soporte] with password ='admin123', default_database = [master], check_policy = off

-- consultar usuarios creados

select *
from sys.sql_logins

-- asignar permisos al nuevo usuario creado en sysadmin

exec sp_addsrvrolemember 'soporte', 'sysadmin'

-- consultar permisos asignados, con nombre de usuario y rol asignado

select l.name as login_name, r.name as role_name
from sys.server_principals l
         inner join sys.server_role_members m on l.principal_id = m.member_principal_id
         inner join sys.server_principals r on m.role_principal_id = r.principal_id
-- saber el puerto donde se conecta el sql server




