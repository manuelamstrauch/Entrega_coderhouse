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
    
-- Teniendo en cuenta las evaluaciones de los clientes, se busca poder tener en cuenta la satifaccion de los mismos en cuanto a los productos que se ofrecen en la tienda. 
DROP VIEW 
	IF EXISTS EvaluacionesPorProducto;

CREATE VIEW 
	EvaluacionesPorProducto AS 
SELECT 
    productos.nombre AS 'Nombre del Producto',
    AVG(evaluacion_post_compra.calificacion) AS 'Calificación Promedio',
    COUNT(evaluacion_post_compra.id_evaluacion) AS 'Número de Evaluaciones'
FROM evaluacion_post_compra
JOIN compra 
	ON evaluacion_post_compra.id_compra = compra.id_compra
JOIN productos 
	ON compra.id_producto = productos.id_producto
GROUP BY productos.nombre
ORDER BY 'Calificación Promedio' DESC;

-- Se crea una nueva vista que permite de forma eficiente conocer el historial de comunicaciones con un cliente
DROP VIEW 
	IF EXISTS HistoricoComunicaciones;

CREATE VIEW
	HistoricoComunicaciones AS 
SELECT 
    clientes.id_cliente,
    CONCAT(clientes.nombre, ' ', clientes.apellido) AS 'Nombre Completo',
    comunicaciones.tipo_comunicacion,
    comunicaciones.motivo,
    comunicaciones.fecha_comunicacion
FROM comunicaciones
JOIN clientes 
	ON comunicaciones.id_cliente = clientes.id_cliente
ORDER BY comunicaciones.fecha_comunicacion DESC;

