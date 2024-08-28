USE bgreat_db;

DROP ROLE 
	IF EXISTS 'rol_admin' , 'rol_mkt';

CREATE ROLE 'rol_admin' , 'rol_mkt';

-- Asignación de permisos al rol ADMIN
GRANT ALL PRIVILEGES ON COMPRA TO rol_admin;
GRANT ALL PRIVILEGES ON INVENTARIO TO rol_admin;
GRANT ALL PRIVILEGES ON PRODUCTOS TO rol_admin;
GRANT ALL PRIVILEGES ON PROVEEDORES TO rol_admin;

-- Asignación de permisos al rol MKT
GRANT SELECT ON CLIENTESLOYAL TO rol_mkt;
GRANT SELECT ON EVALUACIONESPORPRODUCTO TO rol_mkt;
GRANT SELECT ON FACTURACIONMENSUAL TO rol_mkt;
GRANT SELECT ON HISTORICOCOMUNICACIONES TO rol_mkt;
GRANT SELECT ON RANKINGPROVEEDORES TO rol_mkt;

-- Además, crear un superusuario
CREATE USER 
	IF NOT EXISTS 'super_usuario'@'%' IDENTIFIED BY 'soy_dueno123';

-- GRANT ALL a la base de datos
GRANT ALL PRIVILEGES ON bgreat_db.* TO 'super_usuario'@'%' WITH GRANT OPTION;


-- Creo los usuarios y les asigno los roles correspondientes
CREATE USER 
	IF NOT EXISTS 'mkt_user'@'%' IDENTIFIED BY 'soy_mkt123';
	GRANT rol_mkt TO 'mkt_user'@'%';

CREATE USER 
	IF NOT EXISTS 'admin_user'@'%' IDENTIFIED BY 'soy_admin123';
	GRANT rol_admin TO 'admin_user'@'%';

SHOW GRANTS FOR 'admin_user'@'%' ;
SHOW GRANTS FOR 'mkt_user'@'%' ;


