DROP DATABASE
	IF EXISTS bgreat_db;

CREATE DATABASE 
	IF NOT EXISTS bgreat_db;

USE bgreat_db;

CREATE TABLE zona(
	id_zona INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    precio_envio INT DEFAULT '200',
    PRIMARY KEY (id_zona)
)	COMMENT "TABLA DEFINIDA PARA ZONAS DE ENVIO CON SUS RESPECTIVOS PRECIOS";

CREATE TABLE clientes(
	id_cliente INT NOT NULL,
    nombre VARCHAR(100) DEFAULT 'NOMBRE X',
    apellido VARCHAR(100) DEFAULT 'APELLIDO X',
    celular VARCHAR(20) NOT NULL,
    direccion VARCHAR(255),
    email VARCHAR(100) UNIQUE NOT NULL, 
    id_zona INT,
    PRIMARY KEY (id_cliente)
)	COMMENT "TABLA DEFINIDA PARA REGISTRO DE CLIENTES";

CREATE TABLE tienda(
	id_tienda INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(60) NOT NULL,
    descripcion VARCHAR(100),
    PRIMARY KEY (id_tienda)
)	COMMENT "TABLA DEFINIDA PARA REGISTRO DE LUGARES DONDE SE PUEDE REALIZAR COMPARAS";

CREATE TABLE proveedores(
	id_proveedor INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    PRIMARY KEY (id_proveedor)
)	COMMENT "TABLA DEFINIDA PARA REGISTRO DE PROVEEDORES DE LOS PRODUCTOS";

CREATE TABLE productos(
	id_producto INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    descripcion VARCHAR(200),
    precio INT, 
    id_proveedor INT, 
    PRIMARY KEY (id_producto)
)	COMMENT "TABLA DEFINIDA PARA REGISTRO DE PRODUCTOS Y SU DISPONIBILIDAD";

CREATE TABLE inventario(
	id_producto INT NOT NULL,
    id_proveedor INT,
    cantidad_disponible INT, 
    disponibilidad BOOLEAN
) COMMENT "TABLA DEFINIDA PARA REGISTRO DE DISPONIBILIDAD DE PRODUCTOS";
    
CREATE TABLE compra(
	id_compra INT NOT NULL AUTO_INCREMENT,
    fecha DATETIME DEFAULT (CURRENT_DATE),
    id_cliente INT,
    id_tienda INT, 
    id_producto INT, 
    cantidad INT,
    envio BOOLEAN,
    PRIMARY KEY (id_compra)
)	COMMENT "TABLA DEFINIDA PARA REGISTRO DE LAS TRANSACCIONES DEL NEGOCIO";

CREATE TABLE evaluacion_post_compra (
    id_evaluacion INT NOT NULL AUTO_INCREMENT,
    id_compra INT NOT NULL,
    calificacion INT CHECK (calificacion BETWEEN 1 AND 5),
    comentarios TEXT,
    fecha_evaluacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_evaluacion)
) COMMENT 'TABLA DEFINIDA PARA REGISTRAR LAS EVALUACIONES POST-COMPRA REALIZADAS POR LOS CLIENTES';

CREATE TABLE comunicaciones (
    id_comunicacion INT NOT NULL AUTO_INCREMENT,
    id_cliente INT NOT NULL,
    tipo_comunicacion VARCHAR(50), 
    motivo TEXT,
    fecha_comunicacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_comunicacion)
) COMMENT 'TABLA DEFINIDA PARA REGISTRAR EL HISTORIAL DE COMUNICACIONES CON LOS CLIENTES';

ALTER TABLE clientes
	ADD CONSTRAINT fk_zona_clientes
	FOREIGN KEY (id_zona) REFERENCES zona(id_zona);
   
ALTER TABLE inventario
	ADD CONSTRAINT fk_inventario_proveedor
	FOREIGN KEY (id_proveedor) REFERENCES proveedores(id_proveedor);
    
ALTER TABLE inventario
	ADD CONSTRAINT fk_inventario_productos
	FOREIGN KEY (id_producto) REFERENCES productos(id_producto);
        
ALTER TABLE compra
	ADD CONSTRAINT fk_clientes_compra
	FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente);
	
ALTER TABLE compra
	ADD CONSTRAINT fk_tienda_compra
	FOREIGN KEY (id_tienda) REFERENCES tienda(id_tienda);
	
ALTER TABLE compra
	ADD CONSTRAINT fk_productos_compra
	FOREIGN KEY (id_producto) REFERENCES productos(id_producto);
    
ALTER TABLE evaluacion_post_compra
	ADD CONSTRAINT fk_compra_evaluacion
	FOREIGN KEY (id_compra) REFERENCES compra(id_compra);

ALTER TABLE comunicaciones
	ADD CONSTRAINT fk_clientes_comunicaciones
	FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente);
    