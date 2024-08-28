USE bgreat_db;

DROP PROCEDURE 
	IF EXISTS aplicar_descuento;

DROP PROCEDURE 
	IF EXISTS realizar_compra;

DELIMITER //

CREATE PROCEDURE aplicar_descuento(
  IN porcentaje_descuento FLOAT(5,2)
)
BEGIN
  SET SQL_SAFE_UPDATES = FALSE;
  UPDATE productos
  LEFT JOIN compra 
    ON productos.id_producto = compra.id_producto 
    AND compra.fecha >= DATE_SUB(CURDATE(), INTERVAL 3 MONTH)
  SET productos.precio = productos.precio * (1 - porcentaje_descuento / 100)
  WHERE compra.id_producto IS NULL;

  -- Retorna un mensaje de éxito
  SELECT 'El descuento se actualizó con éxito' AS mensaje_exito;

END; //

DELIMITER ;


DELIMITER //

CREATE PROCEDURE realizar_compra(
	IN fecha_compra DATETIME,
    IN id_cliente_compra INT,
    IN id_tienda_compra INT,
    IN id_producto_compra INT,
    IN cantidad_compra INT,
    IN envio_compra BOOLEAN
)
BEGIN
    DECLARE disponibilidad_variable BOOLEAN;
    DECLARE cantidad_disponible_variable INT;

    SELECT disponibilidad, cantidad_disponible INTO disponibilidad_variable, cantidad_disponible_variable
    FROM inventario
    WHERE id_producto = id_producto_compra;

    IF disponibilidad_variable = FALSE THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No hay stock del producto.';
    ELSEIF cantidad_disponible_variable < cantidad_compra THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No hay suficiente cantidad disponible del producto.';
    ELSE
        INSERT INTO compra (fecha, id_cliente, id_tienda, id_producto, cantidad, envio)
        VALUES (CURRENT_DATE, id_cliente_compra, id_tienda_compra, id_producto_compra, cantidad_compra, envio_compra);
        
        UPDATE inventario
        SET cantidad_disponible = cantidad_disponible - cantidad_compra
        WHERE id_producto = id_producto_compra;
    END IF;
END;
//

DELIMITER ;