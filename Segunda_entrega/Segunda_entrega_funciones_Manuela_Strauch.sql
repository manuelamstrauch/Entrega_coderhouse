USE bgreat_db;

-- En los días de feriado nacional, se sube la tarifa de envios
DROP FUNCTION 
	IF EXISTS tarifa_envio;

DELIMITER //
CREATE FUNCTION tarifa_envio
(precio FLOAT(6,2), aumento_tarifa VARCHAR(25))
RETURNS VARCHAR(50)
DETERMINISTIC
NO SQL
BEGIN
DECLARE tarifa_nueva VARCHAR(50);
SET tarifa_nueva = CONCAT("$ ", (precio + aumento_tarifa));
RETURN tarifa_nueva;
END; //

DELIMITER ;


-- Calcula el valor total de la compra basada en la combinación de fecha, id_cliente y id_tienda
DROP FUNCTION 
	IF EXISTS valor_total_compra;

DELIMITER //

CREATE FUNCTION valor_total_compra(
    fecha DATE,
    id_cliente INT,
    id_tienda INT
) 
RETURNS FLOAT(10,2)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE valor_total FLOAT(10,2);

	SELECT  SUM(p.precio * c.cantidad) INTO valor_total
    FROM compra c
    JOIN productos p ON c.id_producto = p.id_producto
    WHERE left(c.fecha, 10) = fecha AND c.id_cliente = id_cliente AND c.id_tienda = id_tienda
    GROUP BY c.fecha, id_cliente, id_tienda;

    RETURN valor_total;
END; //

DELIMITER ;






