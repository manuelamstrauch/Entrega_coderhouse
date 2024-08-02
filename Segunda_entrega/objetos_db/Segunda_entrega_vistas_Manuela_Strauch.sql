USE bgreat_db;

-- crear una vista del ranking de proveedores segÚn la cantidad de productos vendidos
DROP VIEW
	IF EXISTS RankingProveedores;

CREATE VIEW
	RankingProveedores AS 
SELECT  
	proveedores.nombre AS 'Proveedor', 
    SUM(compra.cantidad) AS  'Total Ventas'
FROM 
	compra
JOIN productos
	ON compra.id_producto=productos.id_producto
    JOIN proveedores
		ON productos.id_proveedor=proveedores.id_proveedor
GROUP BY 
	proveedores.nombre
ORDER BY 
	2 DESC;


-- Vista para saber la facturación mensual
DROP VIEW
	IF EXISTS FacturacionMensual;

CREATE VIEW
	FacturacionMensual AS 
SELECT 
	left(fecha, 7) AS AAAAMM, 
    SUM(compra.cantidad * productos.precio) AS 'Facturación mensual'
FROM compra
JOIN productos
	ON compra.id_producto=productos.id_producto
GROUP BY 
	left(fecha, 7)
ORDER BY 
	1 DESC;

-- Clientes loyal: Clientes que en los últmos 3 meses hayan hecho 2 o más compras
DROP VIEW
	IF EXISTS ClientesLoyal;

CREATE VIEW
	ClientesLoyal AS 
SELECT 
	clientes.id_cliente, 
    concat(clientes.nombre, ' ', clientes.apellido) AS 'Nombre Completo', 
    count(compra.id_compra) AS 'Cantidad de compras'
FROM compra
JOIN clientes
	ON compra.id_cliente=clientes.id_cliente
WHERE 
	compra.fecha >= DATE_SUB(CURDATE(), INTERVAL 3 MONTH)
GROUP BY 	
	clientes.id_cliente, 
    concat(clientes.nombre, ' ', clientes.apellido)
HAVING 
    COUNT(compra.id_compra) >= 2;
    




        

