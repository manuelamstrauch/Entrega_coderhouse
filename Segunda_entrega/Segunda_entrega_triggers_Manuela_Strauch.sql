USE bgreat_db;

DROP TRIGGER 
	IF EXISTS logger_cambio_precio;

DROP TRIGGER 
	IF EXISTS  trigger_disponibilidad;

-- LOGGER
CREATE TABLE logs_historial_precios (
    id INT NOT NULL AUTO_INCREMENT,
    id_producto INT NOT NULL,
    precio_anterior INT,
    precio_nuevo INT,
    fecha_cambio DATETIME,
    PRIMARY KEY (id)
);

DELIMITER //

CREATE TRIGGER logger_cambio_precio
AFTER UPDATE ON productos
FOR EACH ROW
BEGIN
    IF OLD.precio <> NEW.precio THEN
        INSERT INTO logs_historial_precios (id_producto, precio_anterior, precio_nuevo, fecha_cambio)
        VALUES (NEW.id_producto, OLD.precio, NEW.precio, NOW());
    END IF;
END; //

DELIMITER ;


 -- CHECKER 
DROP TRIGGER IF EXISTS trigger_disponibilidad;

DELIMITER //

CREATE TRIGGER trigger_disponibilidad
BEFORE INSERT ON compra
FOR EACH ROW
BEGIN
    DECLARE producto_disponible BOOLEAN;

    SELECT disponibilidad INTO producto_disponible
    FROM productos
    WHERE id_producto = NEW.id_producto;

    IF producto_disponible = FALSE THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El producto no está disponible';
    END IF;
END; //

DELIMITER ;

